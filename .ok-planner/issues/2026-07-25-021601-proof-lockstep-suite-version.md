---
issue: proof-lockstep-suite-version
kind: discover
category: proof
artifacts:
  - decision:lockstep-suite-version
status: verified
opened: 2026-07-25T02:16:01Z
---

# Lockstep versioning is enforced by convergence, not by any check

`decision:lockstep-suite-version` — all four plugins carry the same version, bumped together — has no enforcing check. The release skill *converges* rather than rejects: when manifests disagree it takes the highest and stamps everything (that exact path ran in the v9.0.0 release, converging a hand-bumped 8.1.0 against three 8.0.0s). Between releases, nothing notices drift at all; there is no CI in this repo. Meanwhile `concept:plugin`'s invariants assert the lockstep guarantee unconditionally — stronger than anything the code enforces — which is corpus-vs-reality drift worth fixing in the same pass.

Four-way equality of a JSON field is the most trivially checkable claim in this whole batch, and it isn't prompt behavior, so the text-presence precedent doesn't cap it. The real question is *when* the check runs and what it means: mid-cycle drift is arguably legitimate working state (a hand-bump before a release), so the honest invariant is "equal at every release," not "equal at every commit."

## Options

- **Release-time equality verification** — the release skill gains an explicit post-bump assertion that all four manifests carry the new version (and the tag-side verification already reads them); the Proof names that step, and the "filed to intake" placeholder goes away. Convergence remains the mechanism; the check proves it happened.
- **Reject drift instead of converging** — makes `/release` fail on unequal manifests. A Choice change, not a Proof fix, and it turns a benign hand-bump into a release blocker.
- **Keep the gap, drop the stale "filed" language** — honest but proves nothing.

## Ruling

> Recommended ruling (/verify-issues): release-time verification — the sprint adds the explicit four-way equality assertion to the release skill's post-bump steps, rewrites `decision:lockstep-suite-version`'s Proof to name it (falsifier = hand-edit one manifest after the bump, the release fails verification), and softens `concept:plugin`'s unconditional lockstep claim to the release-time invariant the suite actually maintains.
>
> Rationale: convergence-at-release is the shipped, deliberate semantics — the version is an update key, so equal-at-release is what consumers actually depend on; rejecting mid-cycle drift would break the legitimate hand-bump workflow the last release used. The check makes the real guarantee provable instead of promoting a stricter one nobody enforces.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
