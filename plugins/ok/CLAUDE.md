# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Plugin purpose

`ok` is the suite's front door: it declares the integrable ok-plugins as manifest dependencies (so `claude plugin install ok@ok-plugins` installs the integrable suite — never the personal `ok-conduct`) and ships one skill, `/ok`, that updates the installed suite plugins, offers to bootstrap any installed-but-unintegrated ones (one consent question; each true-up is an idempotent installer that handles its own empty-project case), and drives the project's merged `true-up` verb once — discovery by the integration contract's markers (current dot-directory or documented pre-migration markers), then the merged verb's diagnose → consent → converge over the whole integrated set (consent is reserved for genuine collisions, non-plugin-owned content, and hook-wiring transcription; a plugin's own retired layout migrates under converge). It is deliberately dumb — it knows the contract's two conventions (discovery markers, the uniform lifecycle verb) and nothing about any plugin's internals. Its existence is the mechanical check on the suite's integration consistency: a plugin `/ok` can't drive through those two conventions has integrated wrong.

## Constraints

- Never add per-plugin knowledge. Every discovery marker `/ok` honors — including ok-plumbline's pre-migration root `.plumbline.json` and materialized-cheatsheet markers — is documented in `docs/integration-contract.md`; the contract, not this plugin, is where per-plugin knowledge lives.
- Never install, vendor, or offer `ok-conduct`. It is user-scoped and personal; the only thing `/ok` does with it is update an already-installed copy.
- Never let it invoke work-driving verbs (`audit`, `prove`, `open`, `close`) — plugin upkeep only.
- Never run `true-up` (or any converge) from a hook. True-up is a user action, always.
- Update, never install: step 1 updates installed ok-plugins; a missing plugin is reported with its install command, not installed. Bootstrapping an *estate* is different — offered for installed plugins with no markers, gated on one explicit consent question, and performed by the plugin's own true-up, never by `/ok` directly.
- No scripts, no hooks, no build: this plugin is a single SKILL.md plus its dependency manifest by design. Resist adding machinery; anything it seems to need probably belongs in a plugin's own true-up.
