---
topic: ok-dispatcher
kind: boundary
---

# The ok plugin: pure dispatcher, forbidden knowledge

## Description

`/ok` is one command that "brings the whole ok-* suite current in this project": (1) update every *installed* ok-plugin to the marketplace's current version (`claude plugin list --json`, `claude plugin update <name>@ok-plugins`), recording moves and noting that hooks need `/reload-plugins`; (2) discover integrated plugins by filesystem markers (current dot-directory or documented pre-migration markers); (3) offer — in **one** consent question — to bootstrap installed-but-unintegrated plugins (all, a subset, or none; a decline is a valid state re-asked no sooner than the next run); (4) drive each integrated or consented plugin's `true-up` via the Skill tool, sequentially, relaying consent questions verbatim and never reinterpreting findings ("The plugin's true-up is the authority on its own estate"); (5) report as a fixed table plus each true-up report verbatim.

The boundary is the point. `ok` is "deliberately dumb": it knows the contract's two conventions — discovery markers and the uniform true-up verb — "and **nothing about any plugin's internals**. If driving a plugin ever seems to require a special case, the plugin's integration is wrong, not this skill; report that instead of accommodating it." Its CLAUDE.md constraints: never add per-plugin knowledge (the one documented exception: ok-plumbline's pre-migration marker); never invoke work-driving verbs (`audit`, `prove`, `open`, `close`) — "plugin upkeep only"; never run true-up from a hook; **update, never install** ("presence of a plugin is the user's choice; presence of an integration is the project's" — a missing plugin is reported with its install command); no scripts, no hooks, no build ("anything it seems to need probably belongs in a plugin's own true-up").

The bootstrap offer works only because of the idempotent-installer property of every true-up: "on an empty project it bootstraps the plugin's estate, on an existing one it repairs and converges — so `/ok` never needs to know which case it's in." If a plugin's skill is unavailable, `/ok` records `not-installed` with the remedy command and does "not attempt any substitute check of your own." It never edits any file itself — "All writes happen inside the plugins' own true-up verbs."

## Code surface

- `plugins/ok/skills/ok/SKILL.md` — the whole behavior (68 lines).
- `plugins/ok/.claude-plugin/plugin.json` — the `dependencies` array (the suite-install mechanism).
- `plugins/ok/CLAUDE.md` — the constraints list.

## Prose surface

- `docs/integration-contract.md` "The ok plugin" — the normative statement; `README.md` plugin table ("Suite front door").

## Adjacent topics

- `integration-contract`, `dot-directory-and-discovery`, `true-up-verb`, `plugin` (dependencies), `marketplace-monorepo`.

## Observations

- Git history: the plugin began life as `ok-doctor` ("suite upkeep dispatcher", commit 19bdfb5) with a "doctor" verb; the current name is `ok` and the verb is `true-up`. The 19bdfb5 message also refers to "re-affirms affirm-remediable drift" — `affirm` is an earlier name for the converge verb that survives nowhere in live text.
- `/ok`'s example report table includes an `ok-example` row ("bootstrapped (estate created by true-up)") — a fictional plugin used purely as documentation.
- The pre-migration-marker list in `/ok` (step 2) is broader than the contract's (see `dot-directory-and-discovery` / `integration-contract` observations).
- "Never installing an absent one" and "offers to bootstrap" describe two different absences (plugin vs estate) that the prose takes care to keep distinct — a vocabulary distinction that would be easy to blur in a rewrite.
