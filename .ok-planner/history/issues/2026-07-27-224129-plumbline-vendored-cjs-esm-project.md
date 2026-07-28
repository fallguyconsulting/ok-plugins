---
issue: plumbline-vendored-cjs-esm-project
kind: human
category: other
artifacts:
  - concept:materialized-artifact
  - concept:integration-contract
status: promoted
sprint: 2026-07-27-plumbline-esm-scope.md
opened: 2026-07-27T22:41:29Z
---

# Plumbline cannot converge into `"type": "module"` projects

ok-plumbline's converge copies two Node CommonJS files into every consumer
project — the lint binary at `.ok-plumbline/bin/plumbline` (no file
extension) and the edit hook at `.ok-plumbline/hooks/post-edit.js` — and in
any project whose root `package.json` declares `"type": "module"`, both are
dead on arrival. Node decides how to parse a file by walking up from it to
the nearest `package.json` and reading its `"type"` field: under an ESM
root, the extensionless binary is refused outright
(`ERR_UNKNOWN_FILE_EXTENSION`) and the `.js` hook would be parsed as an ES
module and die at its first `require()` (`bin/plumbline:5-6`,
`scripts/hooks/post-edit.js:6-8`). Since ESM-first roots are the norm in
modern Node projects, this locks plumbline out of a large class of
consumers. Observed live on fgc-gentools (Node v20.9.0), 2026-07-27; the
evidence re-verifies clean against the current family source.

The failure surfaces at converge's own sanity check — `node
.ok-plumbline/bin/plumbline version` (`admin/converge:80`) — which aborts
the run. That check is doing its job: the materialized-artifact concept
holds that a vendored executable is proven to run at materialization time,
and one that cannot run is worse than none. So the abort is correct
behavior guarding a real defect: the vendored files carry no module-type
marker of their own and silently inherit whatever the consumer's root
declares — exactly the "assume a specific consumer project" dependence the
integration contract forbids. The half-converged wreckage (config migrated
and cheatsheet written, but no skills vendored and no version stamp) is the
abort landing mid-sequence, and any fix that makes the check pass makes it
moot.

The corpus indicts the status quo but is silent on the remedy: no artifact
addresses module-format or extension conventions for vendored executables.
The filer verified one fix shape against a live reproduction: a
`package.json` containing `{"type":"commonjs"}` placed at
`.ok-plumbline/package.json` scopes the module context for everything under
that directory, restoring both files, because Node's nearest-ancestor walk
stops there before reaching the project root.

## Options

1. **Materialize a scoped `.ok-plumbline/package.json` declaring
   `"type": "commonjs"`.** Additive only: converge writes it before the
   sanity check, diagnose checks for it, the administration document lists
   it as suite-owned. No renames, nothing breaks for already-converged
   consumers. Cost: one more suite-owned file in the estate, and it cannot
   carry the usual version-stamp comment (JSON has no comments), so it is
   either stamped via an extra key or left unstamped as fixed content.
2. **Vendor the binary and hook with `.cjs` extensions.** The standard Node
   idiom — a `.cjs` file is CommonJS regardless of any ancestor
   `package.json`. Cost: a wide, breaking rename. Nine skill files hardcode
   the binary path, the binary's own emitted CI templates reference it
   (`bin/plumbline:951-971`), the hook-wiring constant transcribed into
   consumers' `.claude/settings.json` points at the `.js` path
   (`bin/plumbline:1331`), and already-converged consumers hold committed CI
   YAML and hook entries at the old paths — so this needs a migration pass,
   not just a converge.

## What the ruling decides

Which remedy converge adopts: the additive scoped `package.json`, or the
`.cjs` rename with its consumer migration.

## Ruling

> Recommended ruling (/verify-issues): converge materializes
> `.ok-plumbline/package.json` with `{"type":"commonjs"}` as part of the
> suite-owned layer, written before the sanity check; diagnose reports its
> absence or drift; the administration document lists it with the other
> suite-owned files. Carried as a work item — the corpus needs no delta,
> since the integration contract already supplies the commitment this
> restores.
>
> Rationale: it fixes the same defect as the rename at none of its blast
> radius — no path changes in nine skills, no re-emitted CI templates, no
> settings re-wiring, no migration for consumers already converged — and it
> is the one shape already verified against a live reproduction. The
> `.cjs` idiom is the purer marker, but purity is not worth a breaking
> migration when a one-file scope achieves the identical guarantee; the
> suite can still adopt `.cjs` later in a major, unforced.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
