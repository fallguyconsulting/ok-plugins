---
audit: stamped-tooling
artifact: decision:stamped-tooling
determination: satisfied
audited: 2026-07-27T00:00:00Z
artifact-hash: sha256:c62a49ba2434
---

# Materialized tooling carries the suite stamps

## Claims

The cheatsheet carries the materialization stamp line, the session hook
banners the governing version, the vendored script headers its own, the
executable assigns VERSION, and the plugin manifest carries a version
field. This audit was recorded at suite version 1.0.0; the citations
below must survive a release that bumps every stamp and nothing else,
and must break on any other edit to the same lines.

## Determination

Satisfied: all five stamp surfaces are present and mechanically
rewritten by the release.

## Citations

- cite: rules/cheatsheet.md :: "Materialized by ok-planner v1.0.0. Suite-owned: overwritten on converge."
- cite: hooks/session-start :: "ok-planner v1.0.0 is materialized in this project."
- cite-span: bin/src-tag :: "# ok-workspaces canonical src-tag script v1.0.0." +3 sha256:7841c0ec2c00
- cite-span: src/bin/tool :: "#!/usr/bin/env python3" +6 sha256:75c9cd6a9a76
- cite-file: rules/cheatsheet.md @ sha256:5e4027371ed3
- cite-file: .claude-plugin/plugin.json @ sha256:e69190d00c4e
