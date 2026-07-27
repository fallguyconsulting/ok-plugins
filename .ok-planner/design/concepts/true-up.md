---
concept: true-up
---

# True-up

## What it is

True-up is the suite's uniform lifecycle verb: the idempotent converge of a project's integrated-plugin presence — estate, cheatsheet, vendored skills, and hook wiring — toward what the installed plugins declare. It has three phases — diagnose (read-only comparison of reality against declaration, on project drift and version drift), consent (only when something not plugin-owned needs migrating, resolving, or transcribing), and converge (deterministic materialization of the plugin-owned layer from committed declarations and the installed copies).

## Purpose

Because every true-up is an idempotent installer — materializing a missing presence the same way it repairs a drifted one — the front door needs no per-plugin install knowledge, and a compliant project is a silent no-op. In a project it is one merged verb: converging the whole integrated set is a single act, which is what the front door drives and what keeps every upgrade, migration, and bootstrap deliberate per project.

## Boundaries

True-up owns the plugin-owned layer — estate, cheatsheet, vendored skills — and the mechanics of retired-layout migration; it never validates artifact contents (that is the compliance verbs' job) and never edits owner-declared configuration except as transcription of explicit answers, hook wiring in the project's committed harness settings included (see also: estate, stack-profile, whole-file-ownership under decisions). Other skills lean on it as plumbing so the layout exists before they write. It is always a user or user-directed action — nothing in the suite runs it from a hook.

## Invariants

- Idempotent: re-running on a compliant project leaves the working tree unchanged.
- Converge is driven by committed declarations and the installed plugins' canonical copies, never re-inferred at use time.
- Migration moves files and never rewrites their bodies; archived records keep their old wording.
- Invoking the verb is itself the authorization to migrate the plugin's own retired layout; consent is reserved for genuine collisions, for content the plugin does not own, and for transcription into owner-declared configuration.
