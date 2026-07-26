---
story: one-command-suite-upkeep
---

# Keep the whole suite current with one command

## Story

As a project owner, I want a single front-door command that updates my installed suite plugins, discovers which are integrated here, offers to bootstrap the rest in one consent question, and drives each plugin's own converge verb, so that keeping the suite current requires no per-plugin knowledge from me.

## Acceptance

The owner runs the front door → installed suite plugins are updated to the marketplace's current versions with hook-reload consequences reported; integrated plugins are discovered by filesystem markers alone; installed-but-unintegrated plugins are offered bootstrap in exactly one consent question, with decline recorded as a valid state; each integrated or consented plugin's lifecycle verb runs sequentially with its consent questions relayed verbatim and its report relayed uninterpreted; and a fixed summary table closes the run. The dispatcher writes no file itself; all writes happen inside the plugins' own verbs.

## Falsifier

A plugin is bootstrapped or installed without consent; the dispatcher special-cases a plugin's internals or reinterprets its findings; an integrated plugin goes undiscovered; or a missing plugin is silently installed rather than reported with its remedy.

## Proof

Demo — a run on a project with one integrated, one installed-but-unintegrated, and one uninstalled suite plugin, producing the update moves, exactly one bootstrap question, verbatim relayed true-up reports, and a table a third party can reconcile against the project's filesystem markers.
