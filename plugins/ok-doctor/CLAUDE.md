# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Plugin purpose

`ok-doctor` is the suite's upkeep dispatcher: one skill that discovers which ok-plugins a project integrates (by the integration contract's dot-directory markers), runs each plugin's own `doctor` verb, and drives affirm-remediable drift back to clean. It is deliberately dumb — it knows the contract's two conventions (discovery markers, uniform verb set) and nothing about any plugin's internals. Its existence is the mechanical check on the suite's integration consistency: a plugin ok-doctor can't drive through those two conventions has integrated wrong.

## Constraints

- Never add per-plugin knowledge. The one legacy exception (ok-standards' `.plumbline.json` marker) is documented in `docs/integration-contract.md` and carries a sunset: delete it from the skill when ok-standards migrates to `.ok-standards/`.
- Never let it invoke work-driving verbs (`audit`, `prove`, `open`, `close`) — plugin upkeep only.
- No scripts, no hooks, no build: this plugin is a single SKILL.md by design. Resist adding machinery; anything it seems to need probably belongs in a plugin's own doctor.
