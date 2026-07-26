---
decision: per-project-pinning
---

# Projects run what they were converged to

## Choice

Every materialized artifact — scripts, hooks, cheatsheets, the vendored lint binary — is stamped with the writing plugin's version and executes from the project's own copy; everything downstream prefers the project copy over the installed plugin's, and only the lifecycle verb's entry point and pre-estate bootstrap verbs legitimately run from the plugin root. Updating the installed plugin changes nothing in any project until its owner converges deliberately.

## Rationale

Reproducibility over freshness: an audit must report what this project was trued up to, a ratchet baseline is only comparable against the version that produced it, and CI can lint at the project's pinned version with no plugin installed. The stamp makes version drift mechanically checkable, and the gap between pinned and installed is itself the useful signal.

## Alternatives

- Always execute the installed plugin's copy — every plugin update silently changes every project's behavior and breaks baseline comparability.
- Pin by lockfile reference rather than materialized copies — leaves projects unable to run the machinery without the plugin present.

## Proof

Each plugin's diagnose phase fails on divergence between project copies and the installed plugin's canonicals — stamp comparison and byte-identity checks — and vendoring proves the copied binary executes; deleting a stamp, editing a materialized file, or breaking the vendored binary turns diagnosis red.
