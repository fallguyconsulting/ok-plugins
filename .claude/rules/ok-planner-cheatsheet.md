# ok-planner Cheatsheet

Materialized by ok-planner v12.0.0. Suite-owned: overwritten
wholesale by the front door's administration (`/ok`); project-specific rules
belong in your own files under `.claude/rules/`.

The planner's estate lives in `.ok-planner/` (its embedded `CLAUDE.md` carries
the full per-directory rules). The short version every session needs:

## The three content kinds

- **`design/` — source of truth, read freely.** Concepts, stories, decisions:
  the project's durable model, same weight as code. What it *commits to*
  changes only by applying an approved sprint's corpus deltas — never ad
  hoc; how a commitment is *expressed* may be repaired in-cycle by the
  certification fix loop and `/verify-issues` when the rules determine the
  compliant text and no commitment changes, each repair surfaced for
  after-the-fact veto. Code cites it via
  `@concept:` / `@story:` / `@decision:` annotations — and rollout is
  incremental: consult an artifact while working on a file and you leave
  the annotation (kind plus slug, at the load-bearing site) before you
  are done, so the next agent greps instead of re-deriving.
- **`issues/` — the issue intake.** One markdown file per question awaiting
  the owner's judgment. Anyone may file one; `/verify-issues` makes each
  ruling-ready — closing it when the corpus already answers it, repairing
  rules-determined intent-preserving gaps (code- or corpus-side), and
  rewriting the rest as a from-the-top
  narrative ending in a marked generated/recommended ruling the owner
  accepts by silence or overrides. Only a `/plan-sprint` session closes
  one, by **promoting** it into that sprint (file stamped with the
  sprint's name) or **retiring** it. Closed files move to
  `history/issues/`. Unmarked ruling text is the owner's alone.
- **`sprints/`, `sketches/`, `history/` — records, out of context by
  default.** Do not read them to understand the project, do not include them
  in general exploration, do not reconcile them with current code. A sprint
  is in context while you are executing it, not otherwise; `sketches/` is
  speculative future thinking (written by `/sketch`); `history/` is the
  archive — same-named folder per artifact kind, preserved indefinitely.
  Touch records only when the user or an ok-planner skill directs it.

## Lifecycle

`/sketch` captures an idea in `sketches/` (no authorization to build).
`/plan-sprint` produces a sprint in `sprints/` — corpus deltas + work
items + a fixed completion contract — pulling in every ruled issue without
re-discussion, then resolving with the owner the unruled open issues that
bear on the work and promoting them into it. Executing the sprint is an
ordinary working session (or an orchestrator's job — same contract either
way): stage the work items yourself, apply the deltas to `design/`, build,
run the project's own test suites, and finish with `/certify-work`
(change-scoped; its review-fix loop fixes every finding it can — only
architect-confirmed intent forks and the remainders escalated at its
cycle cap land back in `issues/`, made ruling-ready by
`/verify-issues`). Whole-corpus certification is `/certify-all`, run on
the owner's cadence, not per close. The full execution shape is in
`.ok-planner/CLAUDE.md`.
On completion, artifacts move to their same-named folder under `history/`
(a sprint together with its `-completion` report — the durable record
the executor keeps and the certify ceremony finishes and walks).

## Audits and the source graph

Stories and decisions are verified by the **implementation-audit
corpus** under `.ok-planner/audits/{stories,decisions}/` — one
adversarial determination per artifact (`satisfied` | `violated`),
written only by certification's auditor, never by the implementing
session, and never hand-edited. An audit's one job is to identify
where and how the artifact is implemented: for whatever is
implemented in code, it verifies there is a test or tests in the
project's ordinary suites exercising the feature end-to-end and
cites them; for whatever is realized in prose, it simply cites the
relevant prose, narrowly. There are no proof artifacts, and no test
ever checks the existence of static text, code, or prose.

**Verification attaches only to a story's mechanical core.** A story
may legitimately say correct, clear, helpful — that qualitative rim
guides implementer judgment but grounds no determination
and no finding: no procedure can settle it, so the process records it
in the audit's `## Referrals` section (the promised thing, verified to
exist in form; suitability explicitly not opined; the owning
discipline — documentation, UX, human review — named) and moves on.
Never rewrite a story to scrub its qualitative language, and never
cycle a fix loop against it.

The **source graph** under `.ok-planner/graph/` is the committed,
mechanically derived map audits cite: one `.graph` mirror per source
file, nodes for the file and each declared unit (functions, classes,
methods, markdown heading sections) with structural identities
(`path#declaration-chain`) and content hashes, edges from syntactic
reference. `.ok-planner/bin/source-graph build` regenerates it
wholesale (always safe — nothing hand-written lives in it); `check`
flags drift. Audits cite by node — `cite-node:` (identity + recorded
hash; a whole-file identity pins a population source) — with `cite:`
/ `cite-span:` / `cite-file:` as finer or pre-graph anchor forms,
never line numbers, never pasted code. The vendored helper prints
ready-made lines: `.ok-planner/bin/audit-check cite-node <identity>`
(and `cite` / `cite-file`). `.ok-planner/bin/audit-check` verifies
the corpus (exit 2 on findings; `--list-stale` prints the mechanical
re-audit set).

**What triggers a re-audit is two layers, never annotations.**
Mechanical: a changed design artifact, an unresolvable node identity,
a moved node hash, a broken anchor, or a changed population source —
including audits outside a change's delta; a pure move (the same
recorded hash at exactly one new identity) is re-pointed in place by
`audit-check repoint`, never re-audited. Judged: certification's
change inspector reads the diff itself against the graph and the
audit corpus and nominates audits whose claimed territory contains
changed code no citation caught; nominations land as provisional
entries in the inspection registry and the auditor adjudicates
each — promoted into a citation or dismissed with a reason —
recorded adjudications binding later runs unless the cited reality
moves. Audit files carry no notes, no history, and no hypotheticals: an
audit is a plain pass/fail with a terse paragraph or bullets of
reasons plus citations, describing only the project as it stands
at audit time — the citations themselves carry the staleness
intent (reconsider the audit when what they pin changes). Certification also
keeps a **reconciliation ledger**: every hunk of a certified change
is dispositioned (mechanical / adjudicated / residue), residue is
reported to the owner as intake material, and the gate is not clean
while a hunk lacks a disposition. A `violated` audit stands until a
re-audit flips it; certification blocks on stale/missing audits and
on violations not linked to an intake issue. Annotations keep exactly
one job — navigation — and play no part in audit scope or
invalidation.

## Hard rules

- A sprint is a disparate set of work items: no theme, no order. Staging
  it is execution's job — never write a plan document from one.
- The sprint is the source of truth for its work. A promoted issue is settled;
  never read the queue to find out what a sprint "really meant".
- Open issues gate the work they bear on, not all work; the rest stay queued.
- Design docs are current-state only: no changelogs, no roadmaps, no TODOs.
- Suite upkeep is the front door's administration (`/ok`), never a
  ceremony's job and never run from a hook; it is always a user action.
