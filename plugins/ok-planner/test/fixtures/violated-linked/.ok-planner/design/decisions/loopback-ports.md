---
decision: loopback-ports
---

# Substrate ports bind loopback

## Choice

Every substrate service publishes on loopback only.

## Rationale

Keeps stores unreachable from outside the host.

## Alternatives

- Publish on all interfaces: simpler, exposed.
