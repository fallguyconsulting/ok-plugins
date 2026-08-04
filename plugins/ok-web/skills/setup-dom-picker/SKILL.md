---
name: setup-dom-picker
description: "ONLY activated by explicit /setup-dom-picker slash command. Never auto-triggered by conversation content. One-pass, idempotent converge of the dev-only DOM picker — the human-to-agent pointing channel — into every web frontend found in the project: implements it where missing, repairs divergence from the contract, enforces dev-only gating, and converges the one-paragraph agent usage note into the project's rules. Never ships to production builds."
---

# setup-dom-picker — Human-to-Agent Pointing

The DOM picker closes the loop that screenshots and snapshots cannot: the
human clicks an element in the shared visible browser, and the agent reads
exactly which element was meant. This skill converges the picker into every
web frontend the project has — implement where missing, repair where
diverged, no-op where compliant — plus the standing one-paragraph note that
tells future agent sessions how to use it.

## The contract

Converge each frontend to this behavior, not to byte-identical source:

- **Globals** — `window.__domPicker.start()` begins picking (hover
  highlight follows the pointer), `.stop()` and Esc cancel, `.active`
  reports state. Importing the picker module installs it; nothing starts
  automatically.
- **Selection** — clicking an element stamps it
  `data-claude-selected="true"` (clearing any previous stamp), writes a
  descriptor to `window.__claudeSelected`, and deactivates the picker. The
  click is swallowed (capture phase, `preventDefault`), so picking never
  triggers the app.
- **Descriptor** — tag, id, classes, trimmed text (≤200 chars), all
  attributes, bounding rect, a synthesized unique CSS selector (id
  short-circuit, up to three classes, `:nth-child` disambiguation), and
  computed `fontSize`/`color`/`backgroundColor`.
- **Dev-only** — the module loads behind the bundler's dev flag (Vite:
  `if (import.meta.env.DEV) import('./dom-picker')`), so production builds
  exclude it entirely. An unconditional import is a defect this skill
  repairs, not a variant it tolerates.

The reference implementation is `reference/dom-picker.ts` beside this file:
framework-agnostic vanilla TypeScript, no dependencies, no framework hooks —
it works unchanged under React, Vue, Svelte, or plain pages. Copy it in and
wire the gated import; only adapt (e.g. to `.js`) when the frontend has no
TypeScript pipeline.

## Process

### 1. Discover frontends

A frontend is a directory that builds a browser bundle: a `package.json`
whose scripts or dependencies name a bundler or framework (vite, webpack,
next, svelte, …), or an `index.html` entry with a script module. Search the
project root and its immediate workspaces; list what was found and what was
skipped.

### 2. Converge each frontend

- **Missing** → copy the reference to a dev-adjacent path in the source
  tree (e.g. `src/dev/dom-picker.ts`), and add the dev-gated import to the
  frontend's entry module.
- **Present but diverged** — a hand-rolled or older picker (e.g. a React
  component stamping `data-claude-selected`) → repair toward the contract:
  the globals, descriptor, and gating above must hold; framework-specific
  packaging that already satisfies them is a compliant variant, not
  divergence. In particular, add `window.__claudeSelected` where a legacy
  picker only stamps the attribute, and add the dev gate where the import
  is unconditional.
- **Compliant** → no-op, reported as such.

### 3. Converge the agent usage note

Write (or repair) `.claude/rules/dom-picker.md` in the project — a note of
a few lines, no more:

> When the user says "look at this" (or similar pointing language), run
> `evaluate_script(() => { window.__domPicker.start(); })`, tell them the
> picker is live, and after they click, read
> `evaluate_script(() => window.__claudeSelected)`. Requires the dev build
> in the browser.

### 4. Report

Per frontend: implemented, repaired (what specifically), or already
compliant — plus the rules-note outcome. Remind the owner that the picker
appears on next dev-server start, and that verifying it is one round trip:
start the picker, click anything, read `window.__claudeSelected`.

## Boundaries

- Dev-only, always: the skill never leaves a production-reachable picker
  behind — enforcing the gate is in scope even when everything else is
  compliant.
- Touches only the picker module, the one gated import line, and the rules
  note; never restructures app code around them.
- Setup only: the skill never drives the picker it installs.
