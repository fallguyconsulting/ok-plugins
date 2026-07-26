# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Plugin purpose

`ok` is the suite's front door: it declares the other ok-plugins as manifest dependencies (so `claude plugin install ok@ok-plugins` installs the whole suite) and ships one skill, `/ok`, that updates the installed suite plugins, offers to bootstrap any installed-but-unintegrated ones (one consent question; each true-up is an idempotent installer that handles its own empty-project case), and drives each integrated or consented plugin's `true-up` verb — discovery by the integration contract's markers (current dot-directory or documented pre-migration markers), then the plugin's own diagnose → converge cycle (consent is reserved for genuine collisions and non-plugin-owned content; a plugin's own retired layout migrates under converge). It is deliberately dumb — it knows the contract's two conventions (discovery markers, the uniform `true-up` verb) and nothing about any plugin's internals. Its existence is the mechanical check on the suite's integration consistency: a plugin `/ok` can't drive through those two conventions has integrated wrong.

## Constraints

- Never add per-plugin knowledge. The one pre-migration exception (ok-plumbline's root `.plumbline.json` marker) is documented in `docs/integration-contract.md`; it exists so not-yet-migrated projects are still discovered and offered the move to `.ok-plumbline/config.json`.
- Never let it invoke work-driving verbs (`audit`, `prove`, `open`, `close`) — plugin upkeep only.
- Never run `true-up` (or any converge) from a hook. True-up is a user action, always.
- Update, never install: step 1 updates installed ok-plugins; a missing plugin is reported with its install command, not installed. Bootstrapping an *estate* is different — offered for installed plugins with no markers, gated on one explicit consent question, and performed by the plugin's own true-up, never by `/ok` directly.
- No scripts, no hooks, no build: this plugin is a single SKILL.md plus its dependency manifest by design. Resist adding machinery; anything it seems to need probably belongs in a plugin's own true-up.
