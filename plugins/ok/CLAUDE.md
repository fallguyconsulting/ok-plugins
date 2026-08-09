# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Plugin purpose

`ok` is the suite's front door and sole administrator. It carries the suite's three skill families as payload — `families/{ok-planner,ok-plumbline,ok-workspaces}`, each a self-contained directory of skills, templates, support scripts, and administration and ceremony surfaces — plus the suite's own ceremony layer at `ceremonies/{plan-sprint,certify-work,audit,document}/`, four canonical verb bodies belonging to no family. It ships one skill, `/ok`, that is the whole administration process: install, converge, repair. `/ok` updates the installed user-scoped plugins, discovers integrated families by the integration contract's filesystem markers (current dot-directory or documented pre-migration markers), offers to bootstrap carried-but-unintegrated families in one consent question, converges its own ceremony layer through this plugin's `admin/converge` and `admin/ADMINISTRATION.md`, then administers each family by driving its two conventional surfaces from the payload: the deterministic converge core at `admin/converge` (diagnose / converge / wire-hooks) and the administration document at `admin/ADMINISTRATION.md` for the judgment the core cannot encode. Consent is reserved for genuine collisions, non-suite-owned content, and hook-wiring transcription; a family's own retired layout migrates under converge.

Families are not plugins: nothing family-scoped installs machine-globally, consumers meet a family only through its vendored presence in their project, and the plugin system carries only this front door and the personal conduct. The factoring is the point — everything specific to a family, from converge mechanics to migration judgment, lives in the family's own directory at the contract's conventional surfaces, so the suite grows by adding a conforming family directory, never by rewriting the administrator.

## Constraints

- Never move family knowledge into the administrator, and never into a ceremony body. Migration procedures, config walkthroughs, and conflict handling belong in the family's `admin/ADMINISTRATION.md`; deterministic mechanics belong in its `admin/converge`; what a family contributes to planning, certification, the audit, or documentation belongs in its `ceremony/<verb>.md`. Discovery markers are documented in `docs/integration-contract.md` — the contract, not this skill, is where the convention lives.
- Never install, vendor, or offer `ok-conduct`. It is user-scoped and personal; the only thing `/ok` does with it is update an already-installed copy.
- Never invoke a family or ceremony verb through the Skill tool, and never let `/ok` run work-driving verbs (`audit`, `plan-sprint`, `certify-work`, `open`, `close`) — administration only.
- Never run administration from a hook. It is a user action, always.
- Version stamps derive from this plugin's manifest — the suite version. Families carry no manifests of their own; every stamp their machinery writes reads the front-door manifest.
- The `ok` plugin itself materializes no project estate — it has no dot-directory and is never "integrated"; it acts on whatever project it is run in.
