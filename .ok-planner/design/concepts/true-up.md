---
concept: true-up
---

# True-up

## What it is

True-up is the suite's uniform lifecycle verb: the idempotent converge of a plugin's project-side estate toward what the installed plugin declares. It has three phases — diagnose (read-only comparison of reality against declaration, on project drift and version drift), consent (only when something not plugin-owned needs migrating or resolving), and converge (deterministic materialization of the plugin-owned layer from committed declarations).

## Purpose

Because every true-up is an idempotent installer — materializing a missing estate the same way it repairs a drifted one — the front door needs no per-plugin install knowledge, and a compliant project is a silent no-op. The verb is the single place upgrades, migrations, and bootstraps happen, which is what makes convergence deliberate.

## Boundaries

True-up owns the plugin-owned layer of the estate and the mechanics of retired-layout migration; it never validates artifact contents (that is the compliance verbs' job) and never edits owner-declared configuration except as transcription of explicit answers (see also: estate, stack-profile, ownership under decisions: whole-file-ownership). Other skills lean on it as plumbing so the layout exists before they write. It is always a user or user-directed action — nothing in the suite runs it from a hook.

## Invariants

- Idempotent: re-running on a compliant project leaves the working tree unchanged.
- Converge is driven by committed declarations, never re-inferred at use time.
- Migration moves files and never rewrites their bodies; archived records keep their old wording.
- Invoking the verb is itself the authorization to migrate the plugin's own retired layout; consent is reserved for genuine collisions and for content the plugin does not own.
