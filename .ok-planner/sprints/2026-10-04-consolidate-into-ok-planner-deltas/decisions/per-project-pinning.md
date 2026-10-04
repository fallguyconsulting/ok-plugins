---
decision: per-project-pinning
---

# Projects run what they were converged to

## Choice

Every materialized artifact — vendored skills, scripts, hooks, rules files, the vendored lint binary — is stamped with the suite version that wrote it and executes from the project's own copy, the one exception being a fixed-content artifact, whose bytes never vary across suite versions and which is therefore verified by exact content rather than by a stamp; everything downstream prefers the project copy over the front door's carried payload. Exactly one class legitimately runs from the payload: the administration process itself — diagnosis, bootstrap, and converge, which run before or while the project copies are being written. Updating the front-door plugin changes nothing in any project until its owner converges deliberately.

## Rationale

Reproducibility over freshness: an audit must report what this project was trued up to, and CI can lint at the project's pinned version with nothing installed. Administration is the one exception because it is the act that writes the project copies; it cannot run from copies that do not exist yet. The stamp makes version drift mechanically checkable, and the gap between pinned and carried is itself the useful signal.

## Alternatives

- Always execute the payload's copy — every front-door update silently changes every project's behavior.
- Pin by lockfile reference rather than materialized copies — leaves projects unable to run the machinery without the plugin present.
- Let read-only verbs fall back to the payload copy and announce it — useful for exploring before adoption, at the cost of answers given at a version the project was never converged to.
