---
decision: vendored-skills
---

# Project-scoped behavior is vendored into the project

## Choice

Everything project-scoped the suite delivers — skill files, agent profiles, hook implementations, support scripts, context payloads, rules files — reaches a consumer project as committed, version-stamped files materialized by the front door's administration from the one family it carries (`decision:one-vendored-family`), and the harness is pointed at them project-side: skills live in the project's committed skills directory, and hooks are declared in the project's committed harness settings by consented transcription, every session-start entry carrying the startup-clear-compact matcher and never firing on resume. The administration verifies that a vendored executable runs at the moment it writes it. The plugin system delivers only the user-scoped plugins — the front door carrying the family, the conduct, and the web setup skills; nothing activates the conduct automatically, and no skill depends on it being active. A converged project is self-contained for running the suite: cloning it yields the working skills with nothing installed; converging needs only the front door.

## Rationale

The harness scopes plugin enablement per project but plugin content per machine: one installed copy serves every project, updating or editing it changes all of them at once, and no project has a version of its own. Committing the behavioral surface to the project makes the version a property of the repo — updates arrive as reviewable diffs, contributors get everything by cloning, and the machine-shared layer shrinks to what no project needs vendored: the administrator, the conduct, and the web setup skills. Checking an executable as it lands puts the failure in front of the administrator rather than in the session that needed it. The conduct stays inert for the same reason it is never vendored: one user chose it, and a skill that depended on it would break for everyone who did not.

## Alternatives

- Distributing the project-scoped layer as installable plugins with their own lifecycle verbs — the vendor source then lives in machine-global installs, the marketplace distributes things that are not really plugins, and administration text is duplicated per plugin.
- Plugin-root hooks as shims to materialized copies, with skills machine-global — hooks would be pinned, but the skills and their governing text would still move under every project at once.
- A suite checkout committed per project and registered as a local marketplace — pins source, but the harness registry and installed state stay machine-global, so projects still contend for one registration.
- Staying fully on the plugin system — forfeits per-project versions entirely.
