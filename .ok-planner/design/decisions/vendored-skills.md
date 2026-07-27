---
decision: vendored-skills
---

# Project-scoped behavior is vendored into the project

## Choice

Everything project-scoped the suite delivers — skill files, hook implementations, support scripts, context payloads, cheatsheets — reaches a consumer project as committed, version-stamped files materialized from the front-door plugin's carried family payload by its administration, and the harness is pointed at them project-side: skills live in the project's committed skills directory under the contract's collision rule, and hooks are declared in the project's committed harness settings by consented transcription, every session-start entry carrying the startup-clear-compact matcher and never firing on resume. The plugin system delivers only the user-scoped plugins — the front door carrying the families, and the conduct. A converged project is self-contained for running the suite: cloning it yields the working skills with nothing installed; converging needs only the front door.

## Rationale

The harness scopes plugin enablement per project but plugin content per machine: one installed copy serves every project, updating or editing it changes all of them at once, and no project has a version of its own. Committing the behavioral surface to the project makes the version a property of the repo — updates arrive as reviewable diffs, contributors get everything by cloning, and the machine-shared layer shrinks to the two things that are genuinely personal: the administrator and the conduct.

## Alternatives

- Distributing each family as its own installable plugin with per-family lifecycle verbs — the vendor source then lives in N machine-global installs, the marketplace distributes things that are not really plugins, and administration text is duplicated per family.
- Plugin-root hooks as shims to materialized copies, with skills machine-global — hooks would be pinned, but the skills and their governing text would still move under every project at once.
- A suite checkout committed per project and registered as a local marketplace — pins source, but the harness registry and installed state stay machine-global, so projects still contend for one registration.
- Staying fully on the plugin system — forfeits per-project versions entirely.
