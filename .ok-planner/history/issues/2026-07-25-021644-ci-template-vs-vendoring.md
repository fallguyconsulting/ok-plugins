---
issue: ci-template-vs-vendoring
kind: discover
category: conflicting
artifacts:
  - decision:per-project-pinning
status: repaired
opened: 2026-07-25T02:16:44Z
---

# CI templates reportedly clone the linter while the doctrine wants the vendored copy

## Question

Should the CI templates `ok-plumbline:ci` emits run the vendored
`.ok-plumbline/bin/plumbline` copy, or clone plumbline from its upstream
repository at lint time — as one trailing sentence in the skill's own doc
claimed?

## Rule that determined the fix

`decision:per-project-pinning`'s Choice already states this generally and by
name: "Every materialized artifact — scripts, hooks, cheatsheets, **the
vendored lint binary** — is stamped with the writing plugin's version and
executes from the project's own copy... CI can lint at the project's pinned
version with no plugin installed." The generated `CI_TEMPLATES` in
`plugins/ok-plumbline/bin/plumbline` (github/gitlab/pre-commit) already
invoke `.ok-plumbline/bin/plumbline` directly with no clone step — this has
been true since commit `203382c` introduced binary vendoring. The decision
left no other compliant end state, and the code already conformed; the only
thing not conforming was one stale sentence of prose in
`plugins/ok-plumbline/skills/ci/SKILL.md` ("The default templates clone
plumbline from GitHub at lint time...") left over from before vendoring
existed. No `design/` change was needed or made.

## What changed

`plugins/ok-plumbline/skills/ci/SKILL.md`, the "After the script runs"
section's trailing sentence, rewritten to describe what the emitted
templates actually do: invoke the committed vendored binary directly, no
clone/network/install step, with version pinning controlled by when the
project re-runs `/ok-plumbline:true-up`.

## Verified

Re-read the rewritten `SKILL.md` against `CI_TEMPLATES` in
`plugins/ok-plumbline/bin/plumbline` (github/gitlab/pre-commit templates,
lines ~845-888) — all three still invoke `.ok-plumbline/bin/plumbline`
directly with no clone step; the doc no longer describes behavior the code
doesn't have. No test runner or build for this markdown-only change.
