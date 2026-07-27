---
decision: per-project-pinning
---

# Projects run what they were converged to

## Choice

Every materialized artifact — vendored skills, scripts, hooks, cheatsheets, the vendored lint binary — is stamped with the writing plugin's version and executes from the project's own copy; everything downstream prefers the project copy over the installed plugin's. Exactly three classes legitimately run from the installed plugin copy: the lifecycle verb's entry point, pre-estate bootstrap verbs, and read-only advisory verbs — and an advisory verb falling back to the installed copy announces the fallback in its output. Updating the installed plugin changes nothing in any project until its owner converges deliberately.

## Rationale

Reproducibility over freshness: an audit must report what this project was trued up to, a ratchet baseline is only comparable against the version that produced it, and CI can lint at the project's pinned version with no plugin installed. The pinning rule guards enforcement reproducibility; read-only advisory verbs are exploration tools, most useful before adoption, so they may read the installed copy — the announced fallback preserves the owner's ability to notice an unpinned answer. The stamp makes version drift mechanically checkable, and the gap between pinned and installed is itself the useful signal.

## Alternatives

- Always execute the installed plugin's copy — every plugin update silently changes every project's behavior and breaks baseline comparability.
- Pin by lockfile reference rather than materialized copies — leaves projects unable to run the machinery without the plugin present.
- Forcing advisory verbs through the pinning gate — makes pre-adoption exploration impossible, serving the letter against the reason.

## Proof

Each plugin's diagnose phase fails on divergence between project copies and the installed plugin's canonicals — stamp comparison and byte-identity checks — and vendoring proves the copied binary executes; deleting a stamp, editing a materialized file, or breaking the vendored binary turns diagnosis red. The advisory-fallback announcement stands as a declared text-presence check over the advisory verbs' governing text; its falsifier is the announcement line deleted — declared as presence, not behavior.
