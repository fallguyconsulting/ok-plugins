---
issue: plumbline-estate-dogfood-gap
kind: discover
category: vestigial
artifacts:
  - concept:estate
  - decision:per-project-pinning
status: verified
opened: 2026-07-25T02:17:33Z
---

# Plumbline's current estate layout has zero instances in its own repo

The layout ok-plumbline tells every consumer is canonical — config at `.ok-plumbline/config.json` inside the estate — exists nowhere in the plugin's own tree. The plugin's own self-lint config is a root-level `.plumbline.json` (the *legacy* location true-up migrates consumers away from), and all twelve test fixtures use the legacy path too; there is no `.ok-plumbline/` directory anywhere in the plugin. The result: the current layout has zero in-repo coverage, and the plugin's own house runs the arrangement it deprecates.

The corpus doesn't force a fix — `concept:estate`'s invariants describe consumer-project semantics, not a plugin's dogfooding obligations, and `decision:per-project-pinning` is about execution source, not config location. But the coverage asymmetry is real: every test exercises the fallback path, none exercises the primary one, so a regression in current-layout handling would ship silently while the legacy path stays well-guarded.

## Options

- **Split migration** — move the plugin's own self-config into `.ok-plumbline/config.json`, convert most fixtures to the current layout, and keep one or two fixtures deliberately on the legacy path, named as migration-coverage. Primary path gets real coverage; legacy handling keeps a guard.
- **Blanket migration** — everything to the current layout; legacy-path coverage disappears exactly while consumers still carry legacy configs.
- **Record the all-legacy state as deliberate compatibility coverage** — cheapest, but can't explain the plugin's own self-config being legacy, and leaves the primary path untested.

The ruling decides: migrate (and how much legacy coverage to keep), or ratify the status quo.

## Ruling

> Recommended ruling (/verify-issues): split migration — a sprint work item moves the plugin's self-config into `.ok-plumbline/config.json`, converts the fixtures to the current layout except one or two explicitly named as legacy-migration coverage, and adjusts `test/run.sh` accordingly.
>
> Rationale: the primary path deserves the bulk of the coverage and the plugin should live in its own current layout — but the legacy path is still real in the field, so keeping a marked fixture for it converts accidental coverage into deliberate coverage instead of deleting it.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
