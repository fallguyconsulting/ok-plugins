# Completion report: Generated release documents

Sprint: `2026-08-15-generated-release-documents.md`

## Stages

1. **Corpus deltas** — done. Copied all 15 sidecar bodies into
   `.ok-planner/design/` verbatim (5 new: story
   `ship-release-documents`; concept `document-type`; decisions
   `documentation-walk-in-composed-audit`,
   `documents-generated-per-type-and-placed`,
   `placed-documents-are-records`; 10 amendments). Regenerated the
   three catalog TOCs by the discover-design rule (first body
   sentence, 117 chars + `...`).

2. **Reconciliation: `checks/materialized-standalone`** — done.
   Dropped the three deleted payload entries (`audit-check`,
   `document-check`, `surface-reconcile`); the check passes.

3. **`checks/ceremony-surfaces`** — done. `PHASES["audit"]` now
   matches the audit spine (`Sweep`, `Check` dropped; `Report`
   admitted; `Present` after `Close-out`); `PHASES["document"]` now
   matches the document spine (`Synthesize`, `Check` dropped; `Walk`
   after `Audit`, `Generate` after `Distill` admitted). Annotations
   updated to the new decisions and story. The check passes.

4. **Audit ceremony (`plugins/ok/ceremonies/audit/SKILL.md`)** —
   done. Description, orchestrator preamble, determination 1, spine
   step 3, "what the run leaves behind", the close-out commit list
   and currency rule, and the "asks the owner" boundary all admit
   the documentation walk when `/document` invoked the run — right
   after the extractor returns, before Enumerate — and say an à la
   carte run does not run it.

5. **ok-planner audit contribution (`ceremony/audit.md`)** — done.
   Layout adds `surface/documents`; Surface gains the third
   sub-stage "The documentation walk (composed runs only)" pointing
   at the walk body under Walk in `ceremony/document.md`, with the
   `/document` goal handoff after it; the à la carte goal-handoff
   paragraph says so; the close-out commits the types a composed
   walk landed and the currency rule's output paths widen from
   `surface/surface.md` to `surface/`; the "one owner walk"
   sentences are qualified. The `## Synthesize, then measure the
   assumptions` heading is demoted to `###` under Determine (it was
   a heading the ceremony never read; the check flagged it).

6. **Document ceremony (`plugins/ok/ceremonies/document/SKILL.md`)**
   — done. Description; opening (two tiers); "three drivers" (types
   drive documents); vantage split (documents outside the citation
   regime); spine: **Walk** (step 3, reused-audit only, goal handoff
   after it), **Generate** (step 7), Close-out commits placed
   documents; presentation gains a Documents line; NOT-list amended
   (walk is the one owner conversation; places in tree, does not
   publish outside the repo; writer verification is not a warrant;
   documents cite nothing).

7. **ok-planner document contribution (`ceremony/document.md`)** —
   done. Requires names the types; Layout adds
   `documentation/documents` and `surface/documents` and states the
   record discipline for placed documents; new **Walk** section (the
   document-type file shape — frontmatter `document:`/`target:`,
   body `## Purpose`/`## Covers`; inputs; deltas — uncovered classes,
   empty types, nothing; starter set on an empty type set; the
   one-message ask; unsettled → left out + intake issue per
   `{{ISSUE-FILE-FORMAT}}`; goal handoff); new **Generate** section
   (leaf-agent writer brief; placement to `documents/` and the
   target; folder targets replaced whole; `docs/CLAUDE.md` text
   verbatim); Present gains Walk and Documents lines; Distill's
   "files nothing" note now names the walk's one filing path;
   Boundaries updated.

8. **Goal files** — done. `document-goal.md`: guard clause covers
   the intent stage and the walk; goal rule adds a document per
   declared type at `documents/` and at its target, stamped,
   `docs/CLAUDE.md` when any type targets `docs/`; not-met and
   too-early updated. `audit-goal.md`: notes the composed run's walk
   precedes the hands-free portion.

9. **Cheatsheet, estate rules, family CLAUDE.md** — done. Cheatsheet
   template: record-discipline sentence covers placed documents;
   Lifecycle and Documentation passages name types, walk, Generate.
   `scripts/ok-planner-CLAUDE.md`: `surface/documents/` rule; the
   documentation corpus section gains the documents tier and the
   placed-document discipline; the "no downstream owner walk"
   sentence carries the composed-run exception; lifecycle summary
   updated. Family `CLAUDE.md`: the same exception and the
   `/document` sentence.

10. **README** — done. The verification passage now describes
    `text:` (`compliant` | `noncompliant`) beside `implementation:`
    (`supported` | `unsupported`), the surface intent + extraction,
    four determinations, no checker; a new "Documentation" passage
    names the document types, the walk, Generate, placement, and
    the record rule.

11. **Annotations** — `checks/ceremony-surfaces` carries
    `@decision:` / `@story:` for the artifacts it enforces. Markdown
    payloads cite in the backtick form (`decision:<slug>`) the
    materialized-standalone check requires.

12. **Tests** — `bash checks/run`: every check passes, including
    `vendored-layer` (see divergences).
    `plugins/ok/families/ok-planner/test/stories.sh`,
    `plugins/ok/test/administration.sh`,
    `plugins/ok/families/ok-plumbline/test/run.sh`,
    `plugins/ok/families/ok-workspaces/test/tags.sh`,
    `plugins/ok/families/ok-workspaces/test/demo.sh` pass. The new
    story `ship-release-documents` is realized in prose (ceremony
    markdown), so it carries no test.

13. **`/certify-work`** — run with this sprint as its argument;
    estates ok-planner and ok-plumbline in scope. Four review-fix
    cycles: cycle 1 fixed 14 findings (alignment 8, code review 4,
    lint 9 violations as one, suites 1); cycle 2 fixed 4 (alignment
    1, code review 3); cycle 3 fixed 2 (code review); the cap was
    reached with one code-review finding remaining; the owner chose
    another cycle; cycle 4 fixed it and re-review returned clean. No
    kickbacks, no dissolutions, nothing promoted. Presentation below.

## Divergences and calls

- **TOC refresh touched four lines the sprint did not name**
  (`surface-intent`, `surface-extraction`,
  `adversarial-implementation-audits`,
  `owner-guided-surface-partition`): the TOC is auto-generated and
  the rule determines the text — a mechanical catch-up with
  artifacts earlier sprints amended, not a corpus change.
- **`checks/ceremony-surfaces` was already failing at HEAD** on
  `## Report` (a spine step the map lacked), `## Synthesize, then
  measure the assumptions` (planner audit contribution), and
  `## Lint` (plumbline audit contribution). Fixing the map per the
  work item required resolving all three: `Report` admitted; the two
  sub-stage headings demoted to `###` under Determine (the plumbline
  `Lint` block moved from after Judge to under Determine, where its
  own text says it runs; a pure move, no words changed).
- **`checks/vendored-layer` failed at HEAD; the pin list now
  enumerates the layer.** This repo's `.claude/skills/` carried eight
  vendored skills the `PINNED` tuple never named — `budget`,
  `document`, `explain`, `patterns`, `port`, `starter`, `suggest`,
  `version` (seven from the ok-plumbline family, `document` from the
  suite's ceremony verbs). All eight exist and are committed at HEAD,
  so pinning them records the layer as it stands, which is what the
  check asks for; `/ok`'s post-close converge refreshes their
  *content*, a separate act the pin does not touch.
- **Audit currency rule widened** from `surface/surface.md` to
  `surface/` (audit ceremony and planner contribution), and the
  audit's first close-out commit now includes the document types a
  composed walk landed. Without this a composed run would leave the
  types uncommitted and the next currency check would find the
  audit behind on a path the run itself wrote. Overshoot by the
  necessity test.
- **`/document` goal handoff placed after the walk** at both call
  sites (document ceremony step 3; planner audit contribution's walk
  sub-stage; planner document contribution's Walk section). The
  sprint's audit-goal item implied a composed run's handoff is
  `/document`'s; nothing named where `/document` hands its own line,
  and the walk's landing is the only point at which every owner
  conversation is over.
- **The sprint's "Estate rules" item names
  `plugins/ok/families/ok-planner/CLAUDE.md` as the file carrying the
  per-directory estate rules; that prose lives in
  `scripts/ok-planner-CLAUDE.md`.** Both outcomes landed: the
  `surface/documents/` and `documentation/documents/` rules in
  `scripts/ok-planner-CLAUDE.md`, the composed-run exception to the
  "no downstream owner walk" sentence in both files. The sprint text
  names one path; the work realized the outcome at the accurate one.
- **The repo now declares the design citation tags** in a new
  `.ok-plumbline/config.json` (`@concept:`, `@story:`, `@decision:`
  resolving against `.ok-planner/design/`). The sprint's Annotations
  item requires the checks to carry these annotations, and the lint
  rejects an undeclared tag as an ordinary comment; declaring the
  tags is the prerequisite the plumbline rule names. The declaration
  resolves every annotation in the repo and adds no failure.
- **Prose comments removed from the three `checks/` files this change
  touched** — `ceremony-surfaces`, `materialized-standalone`,
  `vendored-layer` — per the plumbline comment rule; the shebang and
  the `@concept:`/`@decision:` citation lines stay. The known limit
  the `materialized-standalone` header described in prose — a
  citation inside the ok-workspaces cheatsheet template literal ships
  unseen — is now a check over that literal rather than a warning.
  The other four checks and the test scripts keep their headers.
- **Three design artifacts repaired to current vocabulary**: the
  story `rule-the-public-surface` (retired ruling/guidance apparatus
  reworded to the owner's stated intent), and the decisions
  `affirmative-warrant-ladder` and `user-vantage-story-audits`
  ("ruled public surface" → "the public surface the extraction
  records"). Two catalog TOC lines regenerated to match. The same
  rename swept the two carried shared files the audit and document
  dispatches transclude — `skills/_shared/artifact-definitions.md`
  and `skills/_shared/implementation-auditor.md`.
- The vendored copies in this repo (`.claude/skills/{audit,document}`,
  `.ok-planner/ceremony/*.md`, `.ok-planner/CLAUDE.md`,
  `.claude/rules/ok-planner-cheatsheet.md`) are unchanged: `/ok`'s
  to refresh, per the sprint.

---

# Certification — Generated release documents

Status: certified clean

## Outcomes delivered

- **`ship-release-documents`** (new story) — the release run now
  generates the documents a project ships from owner-declared
  document types and places them where readers expect them:
  `/document`'s Generate step writes one self-contained document per
  type into `.ok-planner/documentation/documents/` and copies it to
  the type's target in the tree with a provenance stamp, beside a
  `docs/CLAUDE.md` carrying the record rule when any type targets
  `docs/`.
- **`document-type`** (new concept) — one owner-authored file per
  document at `.ok-planner/surface/documents/<slug>.md`: purpose,
  covered classes of public surface, target path. The shape and its
  rules live in the ok-planner document contribution and the estate
  `CLAUDE.md`.
- **`documentation-walk-in-composed-audit`** (new decision) — the walk
  is one body under Walk in the ok-planner document contribution with
  two call sites: the audit runs it right after its extractor returns
  when `/document` invoked the audit (audit ceremony determination 1
  and spine step 3; planner audit contribution's third surface
  sub-stage); `/document` runs it as its own Walk step against a
  reused audit's extraction. An à la carte `/audit` never runs it.
  The `/document` goal line is handed once the walk lands.
- **`documents-generated-per-type-and-placed`** (new decision) — the
  writer brief (type, extraction's public side, records as
  orientation, tree at the stamp; verify, self-contained, no record
  citations, provenance stamp first), placement to the corpus and the
  target, folder targets replaced only over stamped files, only
  declared targets written, `docs/CLAUDE.md` written and retracted
  with the last `docs/` type.
- **`placed-documents-are-records`** (new decision) — the record rule
  for placed documents is carried in `docs/CLAUDE.md`, the provenance
  stamp, the ok-planner cheatsheet, and the estate `CLAUDE.md`:
  out of context by default, read only when directed, staleness files
  nothing and marks nothing.
- **Amended**: `documentation-corpus` (records tier + documents tier),
  `surface-intent`, `estate`, `experiment`, `assumption`,
  `document-composes-audit`, `owner-guided-surface-partition`,
  `audit-audience-split`, `documentation-citations-are-product`,
  `adversarial-implementation-audits` — all applied verbatim; the
  ceremonies, contributions, goal files, cheatsheet, estate rules,
  README, and `checks/ceremony-surfaces` now say what they say.
- **Reconciliation**: `checks/materialized-standalone` no longer lists
  the three deleted payloads; the README describes the current audit
  model (`implementation:` beside `text:`, intent + extraction, no
  checker) and the documentation model.

## Divergences

- Audit currency rule widened from `surface/surface.md` to `surface/`,
  and the audit's first close-out commit includes the document types a
  composed walk landed (overshoot by the necessity test).
- `/document` goal handoff placed after the walk at both call sites
  (the sprint named no site).
- The "Estate rules" item's per-directory rules landed in
  `scripts/ok-planner-CLAUDE.md` (the file that holds them), with the
  composed-run exception also in `plugins/ok/families/ok-planner/CLAUDE.md`
  as named.
- `checks/ceremony-surfaces` was failing at HEAD; fixing the map
  required admitting `Report` and demoting two sub-stage headings to
  `###` (planner `Synthesize…`; plumbline `Lint`, moved under
  Determine — a pure move).
- `checks/vendored-layer` was failing at HEAD; the fixer pinned the
  eight vendored skills present in `.claude/skills/` (`budget`,
  `document`, `explain`, `patterns`, `port`, `starter`, `suggest`,
  `version`).
- The fixer created `.ok-plumbline/config.json` declaring `@concept:`,
  `@story:`, `@decision:` against `.ok-planner/design/` — the
  prerequisite for the checks' annotations to pass the lint. Note:
  the plumbline certify contribution says the gate never edits that
  file and that citation tags are transcribed by `/ok` on an explicit
  yes; this one is yours to veto.
- Prose comments removed from the three touched `checks/` files
  (`ceremony-surfaces`, `materialized-standalone`, `vendored-layer`);
  the `materialized-standalone` header's "known limit" became a scan
  over the ok-workspaces cheatsheet template literal.
- Corpus repairs under `.ok-planner/design/` (rules-determined,
  intent-preserving): `stories/rule-the-public-surface.md` retitled
  "Classify the public surface by the owner's intent" and reworded
  from the retired ruling/guidance apparatus (benefit clause
  unchanged, slug unchanged); `decisions/affirmative-warrant-ladder.md`
  and `decisions/user-vantage-story-audits.md` "ruled public surface"
  → "the public surface the extraction records"; two TOC lines
  regenerated. The same rename swept
  `skills/_shared/artifact-definitions.md` and
  `skills/_shared/implementation-auditor.md`. The initial TOC
  regeneration also refreshed four stale summary lines
  (`surface-intent`, `surface-extraction`,
  `adversarial-implementation-audits`,
  `owner-guided-surface-partition`).
- Fixer calls: `docs/CLAUDE.md` retraction detects a prior run's file
  by its `Materialized by /document` line; a `docs/` folder target
  counts as "a path under `docs/`"; unstamped files under a folder
  target are left in place and named on the presentation's Documents
  line; the converge retirement message naming `ruling.json` was left
  as is (it names the retired artifact).
- Vendored copies under `.claude/` and `.ok-planner/ceremony/` are
  untouched, per the sprint — `/ok`'s to refresh.

## Findings fixed

- Sprint alignment: 9 (cycle 1: four missing citations, one sprint
  path inaccuracy recorded, three stale-vocabulary artifacts; cycle
  2: the two shared prompt files).
- Code review: 8 (cycle 1: folder-target wipe, absolute "no mid-run
  walk" claim, stale vocabulary at two sites, unqualified "one owner
  walk"; cycle 2: opener-line scan gap, silent missing marker,
  `docs/CLAUDE.md` retraction; cycle 3: closer on the opener line and
  the `docs/` folder-target ambiguity; cycle 4: closer mid-line on a
  continuation line).
- ok-plumbline lint: 9 comment-hygiene violations across two `checks/`
  files, fixed in cycle 1.
- Test suites: `checks/vendored-layer` failing, fixed in cycle 1.
- Mechanical floor (annotation integrity, catalog TOC): clean on
  first pass. Practice citation: no citation config for practices;
  contributes nothing.

## Issues promoted

None.
