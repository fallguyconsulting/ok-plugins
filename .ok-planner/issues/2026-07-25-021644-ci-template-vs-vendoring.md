---
issue: ci-template-vs-vendoring
kind: discover
category: conflicting
artifacts:
  - decision:per-project-pinning
status: verified
opened: 2026-07-25T02:16:44Z
---

# CI templates reportedly clone the linter while the doctrine wants the vendored copy

## Problem

The CI skill's note says default templates clone the linter from its upstream repository at lint time, while the same skill's preamble argues CI should run the committed vendored binary with no install step; the emitted templates and the vendoring doctrine pull in different directions.

## Candidates

- Amend decision:per-project-pinning Choice to require CI templates to run the vendored copy and align the templates via a sprint

## Discussion

**The question.** Should the CI templates ok-plumbline's `ci` skill emits run
the vendored `.ok-plumbline/bin/plumbline` copy, or clone plumbline from its
upstream repository at lint time? The issue was filed because the skill's own
text seemed to argue both ways at once.

**Where it comes from, re-verified against current code.** The filed
evidence quotes two things inside `plugins/ok-plumbline/skills/ci/SKILL.md`:
a `Run` section preamble that says to prefer the project's vendored binary,
and a trailing note ("The default templates clone plumbline from GitHub at
lint time...") that describes the opposite. Both sentences are still present
verbatim in the file today, so the surface-level observation holds. But the
actual generated output — `CI_TEMPLATES` in `plugins/ok-plumbline/bin/plumbline`
(the `github`, `gitlab`, and `pre-commit` templates) — contains no `git
clone` step in any platform today; every template invokes
`.ok-plumbline/bin/plumbline` directly. `git blame`/`git log -p` on both
files shows why: commit `203382c` ("Release v6.0.0" — the same commit that
introduced binary vendoring into `.ok-plumbline/`) rewrote `CI_TEMPLATES` to
drop the `git clone .../tmp/plumbline` steps and invoke the vendored path
instead, and updated the `Run` section's shell preamble to match. That
commit did not touch the trailing "After the script runs" note, which is a
holdover from before vendoring existed and now describes behavior the code
no longer has. So the "conflict" is real as prose but not as behavior: it is
doc rot inside the skill file, filed the same day the rot was introduced
(this issue's `opened` timestamp is the day after `203382c`), not a live
tension between two things the suite currently does.

**What the corpus says.** decision:per-project-pinning's Choice section is
explicit and already covers this exact artifact class: "Every materialized
artifact — scripts, hooks, cheatsheets, **the vendored lint binary** — is
stamped with the writing plugin's version and executes from the project's
own copy; everything downstream prefers the project copy over the installed
plugin's..." The Rationale adds the CI-specific case directly: "...CI can
lint at the project's pinned version with no plugin installed." concept:
materialized-artifact reinforces the same shape generally (a materialized
artifact is "executable where relevant" and vendoring is "the same act
applied to an executable binary"). Nothing in the corpus contemplates CI
cloning plumbline from upstream at lint time — that would be the "always
execute the installed plugin's copy" alternative decision:per-project-pinning
explicitly rejects, generalized to "always fetch upstream," which is even
further from the doctrine (it doesn't even run the pinned installed copy —
it runs whatever is at the head of the fetched ref). story:see-governing-
versions and decision:lockstep-suite-version are adjacent (version legibility
and suite-wide versioning) but don't bear on which binary CI invokes.

**What the code does today.** As shown above: all three current CI templates
(`github`, `gitlab`, `pre-commit`) invoke the committed
`.ok-plumbline/bin/plumbline` and nothing else — no clone step, no
network fetch, no reference to `CLAUDE_PLUGIN_ROOT` in the emitted output.
The skill's own `Run` script (the part that decides *which* binary generates
the templates, not what the templates contain) already prefers the
project's vendored copy over the plugin-root copy, falling back to the
plugin root only with a printed warning when no vendored copy exists yet.
The generated templates already fully comply with decision:per-project-
pinning. The only artifact still describing the old, pre-`203382c` behavior
is the one sentence of prose at the end of `SKILL.md`.

**Candidates, and what closing this way means for each.** Given the above,
the filed candidate — amend decision:per-project-pinning's Choice to require
CI templates to run the vendored copy — is moot: the decision already says
this, in general terms that already cover the vendored lint binary by name,
and the code already conforms. Amending it would add nothing (there is no
gap in the Choice text to close) and risks the corpus drifting toward
implementation-level enumeration that decision:per-project-pinning currently
avoids. The other shape available — leave the corpus untouched and simply
correct the stale sentence in `plugins/ok-plumbline/skills/ci/SKILL.md` so it
describes what the templates do now (no clone step; pinned-tag or
air-gapped guidance, if wanted, would need to be re-worded around the
vendored-copy reality rather than a `git clone` step that no longer exists)
— is a documentation fix, not a corpus mutation, and doesn't require a
ruling to execute.

**What the ruling must decide.** Whether decision:per-project-pinning's
Choice needs any amendment at all here, or whether this closes with no
corpus change and only a follow-up fix to the stale sentence in
`plugins/ok-plumbline/skills/ci/SKILL.md`.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
