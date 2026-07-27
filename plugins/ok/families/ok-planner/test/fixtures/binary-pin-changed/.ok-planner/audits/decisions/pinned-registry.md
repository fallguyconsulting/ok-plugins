---
audit: pinned-registry
artifact: decision:pinned-registry
determination: satisfied
audited: 2026-07-27T00:00:00Z
artifact-hash: sha256:c40be162c00b
---

# The registry population is pinned whole

## Claims

The quantifier ("every member the gateway enumerates") is enumerated
from the compiled registry, pinned below. The pin is over the file's
bytes: this artifact is not UTF-8, and the two byte sequences it
differs by here are both invalid UTF-8 — a lossy decode would map them
to the same replacement characters and the change would pass unseen.

## Determination

Satisfied at the pinned population; any change to the registry re-opens
this audit.

## Citations

- cite-file: src/registry.bin @ sha256:5896c8ee873b
