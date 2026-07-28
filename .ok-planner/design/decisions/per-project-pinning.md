---
decision: per-project-pinning
---

# Projects run what they were converged to

## Choice

Every materialized artifact — vendored skills, scripts, hooks, cheatsheets, the vendored lint binary — is stamped with the suite version that wrote it and executes from the project's own copy, the one exception being a fixed-content artifact, whose bytes never vary across suite versions and which is therefore verified by exact content rather than by a stamp; everything downstream prefers the project copy over the front door's carried payload. Exactly two classes legitimately run from the payload: the administration process itself (diagnosis, bootstrap, and converge, which run before or while the project copies are being written), and read-only advisory verbs — and an advisory verb falling back to the payload copy announces the fallback in its output. Updating the front-door plugin changes nothing in any project until its owner converges deliberately.

## Rationale

Reproducibility over freshness: an audit must report what this project was trued up to, a ratchet baseline is only comparable against the version that produced it, and CI can lint at the project's pinned version with nothing installed. The pinning rule guards enforcement reproducibility; read-only advisory verbs are exploration tools, most useful before adoption, so they may read the payload copy — the announced fallback preserves the owner's ability to notice an unpinned answer. The stamp makes version drift mechanically checkable, and the gap between pinned and carried is itself the useful signal.

## Alternatives

- Always execute the payload's copy — every front-door update silently changes every project's behavior and breaks baseline comparability.
- Pin by lockfile reference rather than materialized copies — leaves projects unable to run the machinery without the plugin present.
- Forcing advisory verbs through the pinning gate — makes pre-adoption exploration impossible, serving the letter against the reason.
