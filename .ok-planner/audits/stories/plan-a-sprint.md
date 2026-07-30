---
audit: plan-a-sprint
artifact: story:plan-a-sprint
determination: satisfied
audited: 2026-07-29T00:00:00Z
artifact-hash: sha256:e40f6a7869f6
---

# Does the owner get an interactive ceremony that turns goals, bearing open questions and unreconciled work into a signed-off, self-sufficient sprint?

## Confirmation

Satisfied. The ceremony is realized wholly in the `/plan-sprint` skill prompt;
none of the story's decidable content is delivered by code, so the evidence is
that text, cited narrowly, and no test is owed.

- **Interactive, over the owner's goals.** §2 is a prose dialogue in which the
  owner brings goals and every tradeoff is surfaced rather than resolved on the
  owner's behalf; a story- or decision-intent change is put to the owner as three
  named options and the owner picks.
- **The open design questions that bear on the goals.** §4 dispatches a dedicated
  relevance reviewer over the drafted sprint and the unruled open issues, and only
  the ones it returns as bearing are walked with the owner, one at a time; each
  ends as a promotion (the owner's decision transcribed and carried into the
  sprint in final form) or a retirement. Issues out of scope are left untouched in
  the intake.
- **The unreconciled work that bears on them.** §1b resolves the baseline from the
  newest archived sprint's `closed:` stamp, computes the window as
  `git log --oneline <closed>..HEAD` plus the uncommitted tree, filters it through
  a dedicated out-of-band reviewer that answers BEARING or AMBIENT, and walks only
  the bearing set with the owner — corpus catches up, code catches up, or record
  and defer.
- **Signed-off.** §5 runs the compliance reviewer in draft mode to clean, then the
  sprint is presented for sign-off and is not final until the owner approves; §6
  is terminal at the approved file, with promotions stamped only after sign-off.
- **Self-sufficient, for any executor.** §3's "How to execute this sprint" and
  "Completion contract" sections are fixed boilerplate included verbatim in every
  sprint — read the sprint whole, stage the work yourself, apply the deltas, build
  and test, close with `/certify-work` — and the skill states the sprint is the
  source of truth for execution, with an executing agent never reading an issue
  file to interpret it.
- **Without deciding the owner's open questions.** The gate's whole justification
  is that building over an open issue decides it silently, so a bearing issue is
  resolved by the owner before the work is built; a written ruling is the owner's
  and is never re-litigated.

## Referrals

- referral: an executor can realize the owner's intent from the sprint alone
  clause: so that any executor can realize my intent without re-deriving it or deciding my open questions for me
  delivered: every sprint carries the fixed execution boilerplate and completion contract verbatim, and the skill requires each promoted resolution's whole substance to land in the deltas and work items; whether a given drafted sprint is in fact sufficient for an arbitrary executor is a reading judgment
  discipline: human-review

## Citations

- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md#sprint-planning @ sha256:bf0f412f8aa8
- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md#sprint-planning.process.1b-reconcile-out-of-band-work @ sha256:6be9954f105f
- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md#sprint-planning.process.1b-reconcile-out-of-band-work.out-of-band-reviewer @ sha256:bc4c5fb14636
- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md#sprint-planning.process.2-intake-dialogue @ sha256:c4c111e6a195
- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md#sprint-planning.process.3-draft-the-sprint @ sha256:28d74a6ee343
- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md#sprint-planning.process.4-the-issue-intake @ sha256:201f635142f0
- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md#sprint-planning.process.5-sign-off-review @ sha256:333a255e4804
- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md#sprint-planning.process.6-terminal @ sha256:ab1b99517d5b
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Then present the sprint to the owner for sign-off. It is not final until they approve."
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "The **How to execute this sprint** and **Completion contract** sections are fixed boilerplate — include both verbatim in every sprint. Together they make the sprint self-driving: the how frames the executor's approach, the contract is the stop condition; `/certify-work` discharges the contract. This is what lets a sprint be handed directly to `/goal`, to an orchestrator, or picked up inline — every executor works from the same brief."
