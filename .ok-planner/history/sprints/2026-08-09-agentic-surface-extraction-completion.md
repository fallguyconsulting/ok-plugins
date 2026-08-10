# Completion report: Agentic surface extraction

Execution record for `2026-08-09-agentic-surface-extraction.md`.

## Work done

- **Corpus deltas applied verbatim** (both inline in the sprint):
  amended concept `surface-declaration` and decision
  `owner-guided-surface-partition` in `.ok-planner/design/`. Both
  TOC one-liners unchanged — each amendment left its artifact's
  first sentence intact.
- **Audit ceremony surface amended**
  (`plugins/ok/families/ok-planner/ceremony/audit.md`): the Requires
  shape now shows the two declaration fields (`"derivation":
  "agentic"`, `"reads"`) with a marked example kind and pins the
  members-file home (`.ok-planner/surface/members/<kind>`, one member
  per line); the Surface phase gains the per-run re-derivation step
  (re-derive each marked kind from what `reads` names, diff against
  the committed list, walk drift with the owner exactly as unclaimed
  elements, update the list only from that walk) and the settle-time
  identification step (a new or changed kind with no mechanical
  source is marked, its members derived and committed); the Present
  template's Surface block reports the agentic inventory beside the
  partition counts.
- **surface-reconcile extended**
  (`plugins/ok/families/ok-planner/scripts/surface-reconcile`):
  parses and validates the two fields — a marked kind without a
  one-line `reads` fails loudly, as does an unmarked kind carrying
  either field or a `derivation` value other than `agentic`; the
  enumeration contract is unchanged; the agentic inventory line
  prints on every run including settled ones ("agentic kinds: 1 of
  2 — config-keys (reads the config parser)", "agentic kinds: 0 of
  2" when none are marked). USAGE text updated.
- **Harness fixtures added**
  (`plugins/ok/families/ok-planner/test/surface-reconcile.sh`): a
  marked kind reading its members file settles at exit 0, the
  inventory line prints on that settled run and in the zero-marked
  form, missing-`reads` and unmarked-with-`reads` each exit 1. The
  harness is now 15 cases, all passing.
- **Teaching docs**: the cheatsheet template's public-surface
  section, the estate template's surface section
  (`scripts/ok-planner-CLAUDE.md`), and the family CLAUDE.md's
  surface-reconcile layout row each carry the agentic-derivation
  shape — marked kinds, the committed member list as the mechanical
  face, re-derivation and diff at the audit's opening, the inventory
  as the owner's optimization worklist.

## Verification

All suites covering the change pass: `checks/run` (7 checks),
planner `test/run.sh`, `test/document-check.sh`,
`test/surface-reconcile.sh` (15 cases), `test/stories.sh`, and
`plugins/ok/test/administration.sh`.

## Divergences

None from the sprint's stated outcomes. One in-flight correction:
annotation comments first placed inside `surface-reconcile` itself
failed the `materialized-standalone` check (the tool is vendored
verbatim into consumers, where comment hygiene rejects them) and were
moved to the repo-local harness header, which the harness's own
preamble names as where the payload's corpus navigation lives.

## Calls made where the sprint was silent

- The inventory line's zero form prints as "agentic kinds: 0 of N",
  keeping "printed on every run" literal when nothing is marked; the
  ceremony's Present block says "agentic kinds: none" in the report
  prose.
- A `derivation` value other than `"agentic"` is a loud declaration
  error, matching the tool's existing malformed-declaration contract.
- The ceremony surface orders re-derivation before the reconciler's
  exit code is read as settled (the reconciler can only see the
  committed lists, not whether they still match reality), and routes
  members newly added by a drift walk through the ordinary unclaimed
  classification walk.
- This repo's materialized copies (`.ok-planner/ceremony/audit.md`,
  `.ok-planner/bin/surface-reconcile`, the rules-layer cheatsheet,
  `.ok-planner/CLAUDE.md`) remain behind the payload; converging them
  is `/ok`, an owner act — the standing note from the prior sprint's
  close.

## Certification

# Certification — Agentic surface extraction

Status: certified clean

## Outcomes delivered

- `owner-guided-surface-partition` (amended): extraction is agentic
  exactly where it must be — a kind no mechanical source can
  enumerate is marked in the declaration, its members are derived and
  committed as the list its enumerator reads, every audit run
  re-derives and diffs the marked kinds and walks drift with the
  owner, and the marked set is reported as a standing inventory the
  owner can inspect and retire.
- `surface-declaration` (amended): the declaration schema carries the
  marking (`"derivation": "agentic"` + `"reads"`), the reconciler
  validates the pairing both ways and reports the inventory on every
  run including settled ones, and the members-file home
  (`.ok-planner/surface/members/<kind>`) is pinned in the ceremony
  surface with the settle-time and per-run agentic steps.
- The teaching layer (cheatsheet template, estate template, family
  CLAUDE.md) carries the shape in a sentence or two each.

## Divergences

- Annotation placement (executor call): navigation annotations for
  the new work live in the repo-local harness header, not the
  vendored-verbatim tool — an in-flight correction after the
  `materialized-standalone` check rejected comments in the payload.
- Fixer call: the suite-level ceremony body
  (`plugins/ok/ceremonies/audit/SKILL.md`) was aligned to the widened
  output-path enumeration ("the opening walk's transcriptions into
  each estate's surface inputs"), since it restated the narrower
  path set the findings corrected in the family surface.
- Executor calls where the sprint was silent (detailed above): the
  inventory line's zero form; unknown `derivation` values fail
  loudly; re-derivation ordered before the reconciler's exit is read
  as settled; this repo's materialized copies stay behind the
  payload pending `/ok`.
- No corpus edits were made in-cycle; both deltas stand verbatim.

## Findings fixed

- Sprint alignment: 2 findings, fixed (ceremony surface's staleness
  path list and Layout `mkdir` extended for
  `.ok-planner/surface/members/`); re-review clean.
- Code review: 4 findings, fixed (Boundaries carve-out for
  settle-time declaration writes; Close-out commit list extended;
  staleness path list widened to include `surface.json`; the
  reconciler's inert validation boolean now threaded through
  `enumerate_kind`); re-review clean.
- Test suites: clean on first pass and re-run green after the fixes
  (`checks/run`, planner `run.sh`, `document-check.sh`,
  `surface-reconcile.sh` — 15 cases, `stories.sh`,
  `administration.sh`).
- Mechanical floor (annotation integrity): clean both passes — the
  four harness-header annotations all resolve to live artifacts.

## Issues promoted

None — no kickbacks reached the architect, nothing was escalated,
and the intake was empty before and after the run.
