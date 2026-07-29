# Porting an existing codebase to Plumbline

This guide is for project maintainers who have an existing codebase and want to adopt Plumbline. It describes the typical migration arc and is meant to be consumable by a planner (human or orchestrator like ok-planner) as the structural input to a port plan.

For methodology, read the [Manifesto](./plumbline-manifesto.md). For day-to-day rules, read the [Style Guide](./plumbline-style-guide.md). This document is specifically about the **trajectory** from "we just decided to adopt Plumbline" to "Plumbline is enforced on every change."

---

## The trajectory in one paragraph

Plumbline adoption goes through four phases. **Adopt**: install the plugin, materialize the cheatsheet, generate a project-shaped `.plumbline.json` (with citation entries if the project uses a design system like ok-planner). **Audit**: enable both checks, see how big the backlog is per check, record the numbers. **Sweep**: drive both checks to zero — `citation-unresolved` violations are mechanical (each is a slug that should fix, a missing artifact to create, or a stale citation to remove); `comment-hygiene` is the larger backlog on most mature codebases, cleared by deleting residue with a small minority converted to code. **Maintain**: the `PostToolUse` hook catches new violations in flight; CI runs the lint on every PR. Projects that cannot do the full `comment-hygiene` sweep at once can use the budget ratchet as a one-way slope down.

The rest of this document expands each phase, names the tool sequence, identifies the decision points, and provides a plan template a planner can use to generate concrete tasks.

---

## Phase 0: Adopt

**Goal**: Plumbline is installed in the project, sessions read the cheatsheet, the config reflects the project's actual shape.

**Tasks** (one commit per task; can be combined):

1. **Install the plugin.** From a Claude Code session in the project:
   ```
   /plugin marketplace add fallguyconsulting/plumbline
   /plugin install plumbline@fallguy
   ```
   For local development of plumbline itself, point the marketplace at a local path.

2. **Materialize the cheatsheet.** Run `/ok` — the suite front door converges the family, writing `.claude/rules/plumbline-cheatsheet.md`. Commit it. (The committed copy is what contributors without anything installed will read.)

3. **Generate the project config.** Run `/starter`. It scans the repo (detects Go module, Node package, ok-planner sibling, generated dirs) and emits a plumbline config to stdout. Review with the user, save as `.ok-plumbline/config.json`, commit. Both `comment_hygiene` and `citation_resolution` always run; there is no switch that disables either. If `.ok-planner/` is present, the starter emits the canonical `@concept:` / `@story:` / `@decision:` citation entries resolving against `.ok-planner/design/{concepts,stories,decisions}/{slug}.md`.

4. **Record the decision.** Add an `as-is` decision artifact stating that this project uses Plumbline as its coding methodology. If the project uses ok-planner, this is a `decision:` slug; if it uses some other system, follow that system's convention. The decision body should name the plugin, the materialized cheatsheet path, and the citation set — not the methodology's rules themselves (those live in the plugin, not the project).

**Decision points in this phase**:
- *Does the project track any design artifacts the code should cite?* If yes (ok-planner concepts, ADRs, RFCs), declare them in the plumbline config's `citations` with `file_template` entries pointing at the artifact directories. `/starter` handles the ok-planner case automatically.
- *Should generated directories be in the ignore list?* Yes, always. The starter detects common ones (`gen/`, `proto/gen/`, `.next/`, etc.); add anything specific to your build.
- *Are any source files genuinely public-API surfaces?* Those will eventually want the `@plumbline:allow-docstrings` opt-in marker. Identify the surfaces during the sweep phase; the marker is added per-file as needed, not project-wide.

**Phase 0 exit criteria**:
- the administration's diagnose reports clean.
- `.ok-plumbline/config.json` is committed.
- `.claude/rules/plumbline-cheatsheet.md` is committed.
- The methodology decision is recorded.

---

## Phase 1: Audit

**Goal**: Know the size of each check's backlog before deciding how to attack it.

**Tasks**:

1. **Run the lint** with both checks on (the default). `plumbline .` reports every violation. Capture the per-check totals:
   ```bash
   plumbline . > /tmp/audit.out 2>&1
   grep -oE "plumbline/[a-z-]+" /tmp/audit.out | sort | uniq -c | sort -rn
   ```

2. **Cluster the violations.** Run `/patterns`. This groups violations by shape:
   - `citation-unresolved` clusters by tag (`tag:@concept:`, `tag:@story:`, ...).
   - `comment-hygiene` clusters by shape (`divider`, `license-fragment`, `todo-marker`, `commented-out-code`, `doc-residue`, `disallowed-prose`).
   The cluster sizes tell you which sweep is the bulk of the work.

3. **Record the numbers.** Put the per-check baseline counts somewhere the planner will see — a checklist file, a tracking issue, or a `## Migration backlog` section in the project's CLAUDE.md / readme.

**Decision points in this phase**:
- *Are any `citation-unresolved` clusters surprisingly large?* That can signal a path rename (artifacts moved without updating citations), a slug-naming convention change, or stale citations that should be removed wholesale. Investigate before sweeping.
- *Are any `comment-hygiene` clusters dominated by `doc-residue`?* Those are JSDoc/GoDoc-shaped comments in files without the opt-in marker. The fix is per-file: add the marker if the file is a public-API surface, otherwise delete the docstrings.

**Phase 1 exit criteria**:
- Per-check violation counts are recorded.
- Pattern clusters are reviewed; large surprises are understood.
- The plan for clearing each check (sweep now vs. ratchet over time) is decided.

---

## Phase 2: Sweep

**Goal**: Drive both checks to zero (or set the ratchet for `comment-hygiene` if the count is too large to sweep at once).

### 2a: `citation-unresolved` sweep

These violations are mechanical and almost always sweep cleanly in one pass.

1. **Cluster by tag.** `/patterns` groups by tag — `tag:@concept:`, `tag:@story:`, etc.
2. **Per cluster, list unique slugs.** Most projects have a few dozen unique slugs across many citation sites; the work shape is "per unique slug, decide the action."
3. **Per slug, choose**:
   - **Correct the slug.** If the citation is a typo or stale rename, sed the corrected slug across all sites.
   - **Create the artifact.** If the slug names a real design fact that was never written down, create the file at the resolved path.
   - **Remove the citation.** If the link no longer matters, delete the citation comment from every site.
4. **Verify**: `plumbline .` reports zero `citation-unresolved` violations.
5. **Commit.**

### 2b: `comment-hygiene` sweep

Most violations are residue and clear by deletion. A small minority name a real constraint and want conversion to code.

1. **Per cluster shape, decide the standard action:**
   - `disallowed-prose` / `todo-marker` / `divider` / `commented-out-code` — bulk delete.
   - `doc-residue` — per file: add `@plumbline:allow-docstrings` if it's a public-API surface, otherwise delete.
   - `license-fragment` — reformat so the license header opens with `SPDX-License-Identifier:` or `Copyright`, or delete the residue.
2. **Walk `/suggest` output** for the per-violation proposals. Comments matching `must` / `always` / `requires` are flagged for assertion-conversion; comments matching `deliberate` / `on purpose` are flagged for test-name encoding. Both shapes warrant a code change, not a tag.
3. **Sweep.** For most clusters this is a bulk `sed` deletion or a per-file edit pass.
4. **Convert the load-bearing minority.** For each `must`-style comment that names a real constraint, write the assertion with a message at the enforcement site and the test that pins it. For each `deliberate`-style comment, write the test that fails when the obvious alternative is substituted, or rename a variable/function to carry the intent.
5. **Verify**: `plumbline .` reports zero `comment-hygiene` violations.
6. **Commit.**

**Decision points in Phase 2**:
- *What if the `comment-hygiene` backlog is too large to sweep at once?* Use the budget ratchet (Phase 3 below). The check stays on; CI enforces a one-way-down baseline instead of a clean exit.
- *What if a `doc-residue` cluster contains real documentation worth keeping?* Add `@plumbline:allow-docstrings` to those files. The marker is per-file; not every file in the project will (or should) carry it.

**Phase 2 exit criteria** (full sweep):
- `plumbline .` exits 0 with both checks on.

---

## Phase 3: Ratchet (fallback path for too-large backlogs)

If the `comment-hygiene` count is too large to sweep at once, set the ratchet instead.

1. **Save the baseline**:
   ```
   /budget save
   ```
   This writes `.ok-plumbline/budget.json` with the current violation count + per-check breakdown.
2. **Commit** the budget file.
3. **Begin incremental cleanup**. Contributors clean comments as they touch them; periodically run `/budget save` to ratchet the baseline down. The ratchet converges as long as PRs don't regress.
4. **Once the baseline reaches 0**: remove `.ok-plumbline/budget.json`; commit.

The ratchet is a fallback; the sweep is the preferred path. The methodology's rule is uniform regardless — comments are not permitted; the ratchet just controls how aggressively the historical backlog is forced down.

---

## Phase 4: Maintain

**Goal**: New code can't regress.

This phase is structural, not task-based. Two mechanisms are in place:

- The `PostToolUse` hook runs `plumbline` on every edit and blocks (exit 2) on violations — the agent sees the message and fixes in the same turn.
- CI runs `plumbline .` on every PR — full lint (with budget check if `.ok-plumbline/budget.json` is present).

---

## Plan template

A planner generating a plumbline-port plan can use this template directly. Numbers in `<>` get filled in from a `/port` run; the structure is invariant.

```
# Plumbline adoption plan

## Pass 1 — Adopt
- Install plumbline plugin
- Run /ok; commit .claude/rules/plumbline-cheatsheet.md
- Run /starter; review; save .ok-plumbline/config.json; commit (includes citation entries if .ok-planner/ detected)
- Record decision: coding methodology is Plumbline

## Pass 2 — Audit
- Run plumbline . with both checks
- Record per-check baselines: comment_hygiene=<N>, citation_resolution=<M>
- Cluster via /patterns

## Pass 3 — citation-unresolved sweep
- Per tag cluster, list unique slugs
- Per slug: correct, create artifact, or remove citation
- Verify clean; commit

## Pass 4 — comment-hygiene sweep
- Per cluster shape, decide the standard action (bulk delete dominates)
- Convert the load-bearing minority to assertions + tests
- Add @plumbline:allow-docstrings to public-API files
- Verify clean; commit

## Pass 5 — Maintain
- Hook + CI now defend against regression
```

Adapt the per-pass detail to your orchestrator's task shape. For ok-planner: each pass above is one `## Pass N` in a plan file under `.ok-planner/plans/`. The `## Design changes` section captures the coding-style decision and the citation entries added to the plumbline config.

---

## Reference: tool-by-tool quick map

When you need to... | Use this tool
:--- | :---
Install the rules into a project | `/ok`
Generate a starter config from a repo scan | `/starter`
Check installation state | `/ok` (the administration's diagnose)
Look up what a check or config concept means | `/explain <topic>`
See full lint output | `/ok-plumbline-audit` (or plain `plumbline .`)
Group violations by shape for bulk action | `/patterns`
Get per-violation fix proposals | `/suggest`
Set the budget baseline | `/budget save`
Enforce the budget in CI | `/budget check`
Generate a full port plan | `/port`
