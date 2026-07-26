---
issue: budget-baseline-outside-estate
kind: discover
category: inconsistent
artifacts:
  - decision:ratchet-over-soft-start
  - concept:estate
status: verified
opened: 2026-07-25T02:16:44Z
---

# The ratchet baseline lives at repo root, outside the estate, with no migration path

Plumbline's budget ratchet records its violation-count baseline in `.plumbline-budget.json` at the consumer repo's root — outside `.ok-plumbline/`, the dot-directory the integration contract says holds a plugin's project-side presence. The corpus's estate boundary (`concept:estate`) names exactly one sanctioned file outside the estate: the cheatsheet. Read literally, the baseline file is unsanctioned, and unlike the old root-level `.plumbline.json` config — which true-up mechanically migrates into the estate — the baseline has no migration path at all: true-up's diagnose step *reports* it, but its converge step never moves it.

The asymmetry is real and current: `budget save`/`check` write and read the root path, the CI templates and porting guide reference it, and no code path exists that would relocate it. The bearing decision (`decision:ratchet-over-soft-start`) fully specifies the ratchet's mechanism but never says where the record lives; `story:incremental-lint-adoption` requires "a recorded baseline" but not a location; `decision:per-project-pinning` doesn't reach it (the baseline is project-produced data, not a plugin-materialized artifact). The corpus is silent on the question.

## Options

- **Move it into the estate, with a true-up migration** — name `.ok-plumbline/budget.json` in the ratchet decision; add a converge step mirroring the config migration (`git mv` when the destination is absent); update `budget`, `ci`, and the porting guide in lockstep. Restores the estate boundary to literal truth. Cost: a migration to build, and already-emitted CI workflows referencing the old path need regenerating (or a transition-period dual read).
- **Sanction it as a second root-level exception** — amend `concept:estate` to name the baseline alongside the cheatsheet, on the rationale that root visibility serves non-Claude tooling. No code change, but the boundary decays from a rule into a maintained list.
- **Document today's path as legacy, design future formats into the estate** — no code now, honest boundary, but merely postpones the first two options.

The ruling decides: does the baseline belong inside `.ok-plumbline/`, or is the root a sanctioned second exception?

## Ruling

> Recommended ruling (/verify-issues): move the baseline into the estate — amend `decision:ratchet-over-soft-start` to name `.ok-plumbline/budget.json` as its home, and add the true-up migration mirroring the config's `git mv`, updating `budget`, `ci`, and the porting guide in the same sprint.
>
> Rationale: the estate boundary's strength is that it is a rule, not a list — every exception added makes discovery and ownership fuzzier, and the config file already establishes the exact migration pattern this needs. The cheatsheet exception exists because that file must reach sessions *without* the plugin; the baseline has no such reader — everything that consumes it (the binary, the hook, generated CI) can be pointed at the estate in one sprint.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
