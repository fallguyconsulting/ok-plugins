---
topic: current-state-only-rule
kind: invariant
---

# The current-state-only rule (no journals, no roadmaps)

## Description

`{{CURRENT-STATE-ONLY-RULE}}`: "Concept, story, and decision bodies describe the project **as it stands today**. They are not journals and they are not roadmaps." Two named failure modes:

**Historical content** — "'changed on YYYY-MM-DD', 'previously called X', 'used to live in foo/bar.go', ... or any audit-trail line whose subject is *what changed* rather than *what is*. Git already records what changed ... **There is no `## Notes` / `## History` / `## Changelog` section on any concept, story, or decision file.** If you find one ... strip it."

**Forward-looking content** — "'we plan to', 'will be replaced by', 'TODO: tighten this', 'out of scope for now', 'deferred to V2', 'open question for later'. A design doc that names work not yet done invites implementing agents to defer against it. Open ambiguities go in the intake queue, where they sit as explicitly unresolved; intended future changes go in a sprint, not the design doc. Nothing in the durable model is aspirational."

The stated exception is `_discover/` — "explicitly point-in-time; the durable model is not." The mutation protocol follows: "When a sprint changes a concept / story / decision, its delta rewrites the affected section in place to reflect the new state. The git commit carries the lineage. Do not paste a dated entry into the artifact body." A subtle boundary is drawn for decisions: the Alternatives section "is the list of options the project *could* have taken — that's not forward-looking; it's the as-is shape of the choice. But 'we may switch to alternative X' or 'the chosen option was formerly Y' violates the rule" (phase-2 reviewer).

Related consequences elsewhere: aliases must be live names only ("not retired names"); the archive (`history/`) absorbs everything historical; the cheatsheet compresses the rule to "Design docs are current-state only: no changelogs, no roadmaps, no TODOs."

## Code surface

- `artifact-definitions.md` `{{CURRENT-STATE-ONLY-RULE}}`; transcluded into the shared compliance reviewer, phase-2 extractor/reviewer, and back-edge extractor.
- Reviewer checks: "Concept body is current-state only", "Story body is current-state only", "Decision body is current-state only" bullets in the phase-2 reviewer; the compliance reviewer's mechanical class ("a forbidden section to strip").

## Prose surface

- `scripts/ok-planner-cheatsheet.md` Hard rules; anti-padding lists ("Don't add forward-looking content").

## Adjacent topics

- `self-containment-rule` (the twin), `issue-queue` (where open ambiguity goes instead), `sprint` (where intended change goes instead), `context-discipline` (history/ as the historical sink).

## Observations

- The rule's rationale sentence — "A design doc that names work not yet done invites implementing agents to defer against it" — connects to the completeness-contract design note's diagnosis (deferral hatches); the rule is an anti-deferral device as much as a hygiene rule.
- `status: as-is` is the only frontmatter status value that appears anywhere in templates; no other status is defined, which makes the field look vestigial or reserved (issue candidate for phase 2: what other values, if any, are legal?).
