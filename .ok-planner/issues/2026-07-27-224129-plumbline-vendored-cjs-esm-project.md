---
issue: plumbline-vendored-cjs-esm-project
kind: human
category: other
artifacts:
  - concept:materialized-artifact
  - concept:integration-contract
status: open
opened: 2026-07-27T22:41:29Z
---

# Plumbline's vendored CommonJS binary and hook fail in `"type": "module"` projects

## Problem

ok-plumbline's converge materializes two CommonJS files into the consuming project — the extensionless binary at `.ok-plumbline/bin/plumbline` and the edit hook at `.ok-plumbline/hooks/post-edit.js` — and then sanity-checks with `node .ok-plumbline/bin/plumbline version` (admin/converge line 80). In a project whose root `package.json` declares `"type": "module"`, that check aborts converge with `ERR_UNKNOWN_FILE_EXTENSION` (Node refuses extensionless files in an ESM package context), leaving the family half-converged: config migrated and cheatsheet written, but skills never vendored and no version stamp. The hook would fail identically at fire time, since a `.js` file in that context is parsed as ESM and the hook uses `require()`. Observed administering fgc-gentools (root `package.json` has `"type": "module"`, Node v20.9.0), 2026-07-27.

Verified fix shape: materializing one additional suite-owned file, `.ok-plumbline/package.json` containing `{"type":"commonjs"}`, restores both (nearest `package.json` scopes the module context; confirmed against a copy of the vendored binary under a `"type": "module"` root).

## Candidates

- Converge materializes a scoped `.ok-plumbline/package.json` declaring `"type": "commonjs"` as part of the suite-owned layer, and diagnose checks for it.
- Vendor the binary and hook with `.cjs` extensions, updating every consumer of the current paths (settings wiring, CI guidance, cheatsheet).
