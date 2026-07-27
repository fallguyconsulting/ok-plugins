---
audit: loopback-ports
artifact: decision:loopback-ports
determination: satisfied
audited: 2026-07-27T00:00:00Z
artifact-hash: sha256:160004d00eb6
---

# Loopback binding holds for every published substrate port

## Claims

Every substrate service in the composition binds loopback; the
population is the compose file, pinned below.

## Determination

Satisfied: the one substrate service publishes on 127.0.0.1 only.

## Citations

- cite: src/compose.yaml :: "ports: ["127.0.0.1:8081:8081"]"
- cite-file: src/compose.yaml @ sha256:bb77a6c11999
