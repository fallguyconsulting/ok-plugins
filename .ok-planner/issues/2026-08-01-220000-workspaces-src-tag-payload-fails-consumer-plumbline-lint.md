---
issue: workspaces-src-tag-payload-fails-consumer-plumbline-lint
kind: human
category: other
artifacts:
  - decision:content-addressed-src-tag
status: open
opened: 2026-08-01T22:00:00Z
---

# The workspaces src-tag payload fails the plumbline lint in consumer projects

Report from a consumer project (rimsky-core, which vendors both ok-workspaces and ok-plumbline at v14.1.0). The two suites' canonical payloads conflict when installed together:

- ok-workspaces ships `tools/image-src-tag.sh` as a suite-owned file, overwritten wholesale on every converge.
- ok-plumbline's comment-hygiene lint runs project-wide in the consumer, and the shipped script fails it twice: it carries prose header comments the lint forbids, and a `@decision: content-addressed-src-tag` citation tag. That tag resolves in this monorepo's own decision catalog, but in a consumer project it dangles — the consumer never authored that decision, so the plumbline `citation_resolution` check fails on a file the consumer cannot edit (the next converge would overwrite any hand fix).

The consumer-side workaround currently in place: rimsky-core added the script to the plumbline lint's ignore list (`.ok-plumbline/config.json`) as an explicitly temporary bridge, with a ruling on record to remove the entry when a lint-clean payload ships. Nothing in the consumer's corpus sanctions the carve-out as permanent policy.

Only the suites' common maintainer can close the gap, e.g. by making the workspaces payload lint-clean under the plumbline rules (no prose comments, no citation tag that cannot resolve outside this monorepo), or by having the workspaces converge write the plumbline ignore entry itself, making the exemption suite-declared rather than consumer-improvised.

## Options

- Ship a lint-clean `image-src-tag.sh` payload (strip the prose header to the machine-required lines; drop or relocate the citation tag into this monorepo's own sources).
- Make the workspaces converge declare the exemption: write the plumbline ignore entry for its own payload files, so consumers never hold an unsanctioned carve-out.
- Declare suite-owned files outside project lint jurisdiction in the suites' contract, and have plumbline's lint honor that boundary mechanically.
