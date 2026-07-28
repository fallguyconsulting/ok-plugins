---
audit: node-pin
artifact: decision:node-pin
determination: satisfied
audited: 2026-07-27T00:00:00Z
artifact-hash: sha256:ba00ba57833b
---

# The doubling path is the only transform — audited

## Claims

The doubling transform exists and is the export surface's only
numeric transform beside the increment helper (cited by node).

## Determination

Satisfied. This stops holding if the doubling body changes or a new
transform lands in the module.

## Citations

- cite-node: src/app.js#go @ sha256:5d4be43637e0
- cite-node: src/app.js @ sha256:67342fde14cc
