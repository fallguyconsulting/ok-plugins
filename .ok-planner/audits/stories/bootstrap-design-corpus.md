---
audit: bootstrap-design-corpus
artifact: story:bootstrap-design-corpus
determination: satisfied
audited: 2026-07-29T00:00:00Z
artifact-hash: sha256:20eb7d79ffe6
---

# Does an owner adopting the suite get the as-is design model extracted autonomously into catalogs plus a queue of judgment questions?

## Confirmation

Satisfied. The capability is realized wholly in prose — `/discover-design` is a
skill prompt, and no code in this repo performs discovery — so the evidence is
the governing text, cited narrowly, and no test is owed.

- **Autonomous.** The skill runs both phases plus the one-shot back-edge with no
  user prompt mid-run; each phase is a producer → reviewer → producer-with-feedback
  loop capped at three cycles, and the final report is the only thing the user
  sees during execution.
- **From an existing codebase, as-is.** Code is ground truth for what the system
  does and project prose is ground truth for what the project thinks its concepts
  mean; discrepancies between the two are recorded as questions, not resolved.
- **Durable catalogs.** Phase 2 writes `concepts/<slug>.md`, `stories/<slug>.md`
  and `decisions/<slug>.md`, and step 7 regenerates the three one-shot-readable
  TOCs (`concepts.md`, `stories.md`, `decisions.md`) beside them. `_discover/` is
  named scaffolding; the three artifact directories are the durable output.
- **A queue of judgment questions.** Each genuine muddiness the extractor finds,
  each reviewer finding still unresolved at the cycle cap, and each reviewer's own
  confessed uncertainty is filed as an issue file under `.ok-planner/issues/` with
  `kind: "discover"`, `status: open`, for the human to rule on.
- **Not documentation from scratch.** A non-empty `concepts/`, `stories/` or
  `decisions/` aborts the run rather than overwriting human-edited artifacts, so
  the owner's own writing is never the thing the pass consumes.

## Referrals

- referral: the owner's design attention lands on genuine ambiguities
  clause: so that my design attention is spent resolving genuine ambiguities instead of writing documentation from scratch
  delivered: every muddiness and every confessed uncertainty is filed as a `kind: "discover"` issue file in the intake for the owner to rule on; whether a filed question is a genuine ambiguity is not settled by any procedure
  discipline: human-review

## Citations

- cite-node: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md#discover-design @ sha256:3a65d6d4243a
- cite-node: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md#discover-design.process @ sha256:fb54e9fbb749
- cite-node: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md#discover-design.where-the-log-lives @ sha256:465d1eadf1ee
- cite-node: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md#discover-design.inputs @ sha256:55f4d3f563ad
- cite: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "Runs end-to-end without user interruption. Each phase has its own"
- cite: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "The skill does not prompt the user mid-run. The final report is the"
