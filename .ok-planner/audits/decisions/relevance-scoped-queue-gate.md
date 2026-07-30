---
audit: relevance-scoped-queue-gate
artifact: decision:relevance-scoped-queue-gate
determination: satisfied
audited: 2026-07-29T13:57:39Z
artifact-hash: sha256:3a4799b8ddc2
---

# Does the intake gate planning by relevance rather than at the door?

## Confirmation

Satisfied. Every clause of the Choice is delivered — the gate's shape in the
`/plan-sprint` ceremony's prose, its one coded clause by the corpus surfacer,
which the story-level suite exercises.

- **Draft first, then split.** A feature-work session goes §2 → §3 and
  consults the unruled issues only at §4; the §1 sweep pulls ruled issues
  straight in without discussion.
- **A dedicated relevance reviewer.** §4 dispatches a reviewer whose one job
  is bearing-vs-independent, explicitly forbidden to resolve, propose
  resolutions, grade severity, or critique the sprint; only what it returns
  as bearing is walked.
- **One at a time, corpus first.** The walk presents each in-scope issue
  singly, never as a wall, and runs
  `.ok-planner/scripts/surface-corpus` on the issue file before presenting
  it. That surfacer is a program: explicit `artifacts:` refs at maximum
  score, plus rare-token matches weighted by inverse document frequency
  across the corpus, capped at ten ranked lines, with empty output defined as
  its own signal to the walker. The suite runs it against a fixture corpus
  and asserts each property — the named artifact ranked first, an artifact
  reached only by a rare token surfaced with the tokens that reached it, a
  corpus-wide token dragging in nothing, an issue nothing bears on printing
  nothing, and the shortlist capped at ten however many artifacts an issue
  names.
- **The count is information, not a gate.** The ceremony reports the ruled
  and unruled counts and states the count is not a gate; the owner may widen
  scope but never has to.
- **The tiebreak is fixed toward walking.** The reviewer prompt ends its test
  with "When you cannot tell, answer BEARS," on the stated ground that a
  needless owner conversation costs a minute and a silently decided design
  question costs a rewrite.
- **Intake-drain sessions invert it.** For that session kind the scope is
  every unruled open issue (or the named batch), the walk runs first with no
  relevance pass, and §3 drafts from what the resolutions imply.

## Referrals

- referral: the reviewer's split of unruled open issues into bearing and independent
  clause: "a dedicated relevance reviewer then splits the unruled open issues into bearing and independent"
  delivered: the §4 relevance-pass dispatch block exists with a fixed four-part bearing test, an independence test, the BEARS tiebreak, a fixed status-line-plus-one-line-per-issue output, and anti-padding limits; whether a given split is the right one is an agent judgment no procedure settles, and this audit does not opine on it
  discipline: human-review

## Citations

- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md#sprint-planning.process.1-frame-the-session @ sha256:253bb51b8d56
- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md#sprint-planning.process.4-the-issue-intake @ sha256:201f635142f0
- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md#sprint-planning.process.4-the-issue-intake.relevance-pass-feature-work-sprints @ sha256:ae3b8a00bf44
- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md#sprint-planning.process.4-the-issue-intake.the-issue-walk @ sha256:0f44a8fef2d8
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "  When you cannot tell, answer BEARS. A needless owner conversation"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "  python3 .ok-planner/scripts/surface-corpus .ok-planner/issues/<file>.md"
- cite-node: plugins/ok/families/ok-planner/scripts/surface-corpus @ sha256:a515d283e033
- cite-file: .ok-planner/scripts/surface-corpus @ sha256:7c83a3ab6c04
- cite-node: plugins/ok/families/ok-planner/test/stories.sh @ sha256:f8717649820e
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "relevance-scoped-queue-gate: the artifact the issue names is surfaced first, at maximum score"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "relevance-scoped-queue-gate: an artifact reached only by a rare token is surfaced with the tokens that reached it"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "relevance-scoped-queue-gate: a token common across the corpus (converge) surfaces nothing on its own"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "relevance-scoped-queue-gate: an issue no artifact bears on surfaces nothing"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "relevance-scoped-queue-gate: the shortlist is capped at ten however many artifacts an issue names"
