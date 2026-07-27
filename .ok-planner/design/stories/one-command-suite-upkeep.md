---
story: one-command-suite-upkeep
---

# Keep the whole suite current with one command

## Story

As a project owner, I want my project's whole suite presence brought current in one consolidated act, so that suite upkeep requires no per-plugin knowledge from me.

## Acceptance

The owner runs the front door → installed suite plugins are updated to the marketplace's current versions; integrated plugins are discovered by filesystem markers alone; installed-but-unintegrated integrable plugins are offered bootstrap in exactly one consent question, with decline recorded as a valid state; the project's merged lifecycle verb runs once over the integrated set (bootstrap runs the installed plugin's own entry point, which materializes the merged verb), with its consent questions relayed verbatim and its report relayed uninterpreted; and a fixed summary table closes the run. The dispatcher writes no file itself; all writes happen inside the lifecycle verb. The personal conduct plugin is never installed, vendored, or offered by the front door.

## Falsifier

A plugin is bootstrapped or installed without consent; the dispatcher special-cases a plugin's internals or reinterprets its findings; an integrated plugin goes undiscovered; a missing plugin is silently installed rather than reported with its remedy; or the front door installs or offers the conduct.

## Proof

Demo — a run on a project with one integrated, one installed-but-unintegrated, and one uninstalled suite plugin, producing the update moves, exactly one bootstrap question, a verbatim relayed lifecycle report, and a table a third party can reconcile against the project's filesystem markers.
