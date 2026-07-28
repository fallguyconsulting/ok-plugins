---
audit: node-pin
artifact: decision:node-pin
determination: satisfied
audited: 2026-07-27T00:00:00Z
artifact-hash: sha256:ba00ba57833b
---

# The doubling path is the only transform — audited

## Claims

The stamped banner mechanism is present (cited by node); the stamp
line is release-mutable and masked, so only substantive edits move
the pinned hash.

## Determination

Satisfied. This stops holding if the banner mechanism itself changes.

## Citations

- cite-node: src/banner.js#banner @ sha256:5483ee789e4b
