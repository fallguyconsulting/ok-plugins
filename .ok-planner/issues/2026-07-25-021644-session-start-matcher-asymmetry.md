---
issue: session-start-matcher-asymmetry
kind: discover
category: unclear
artifacts:
  - decision:hook-shims
  - story:session-awareness
status: verified
opened: 2026-07-25T02:16:44Z
---

# Session-start hooks fire on different matchers per plugin with no stated intent

## Problem

The planner's session-start declaration matches startup|clear|compact while the workspaces plugin declares no matcher, so the latter also fires on resume; no prose says whether the asymmetry is intended.

## Candidates

- Amend story:session-awareness Acceptance to state the intended injection occasions uniformly
- Add the matcher choice to decision:hook-shims with its rationale

## Discussion

The question: is it intended that ok-planner's session-start hook fires only on `startup|clear|compact` while ok-workspaces' session-start hook has no matcher (and therefore also fires on session resume), or is one of the two a bug relative to a shared intended set of injection occasions?

Where it comes from: filed against decision:hook-shims and story:session-awareness. Re-verified against current code: `plugins/ok-planner/hooks/hooks.json` declares `"matcher": "startup|clear|compact"` on its SessionStart hook entry. `plugins/ok-workspaces`'s SessionStart hooks.json entry carries no `matcher` key at all, which under Claude Code's hook-matching semantics means it fires on every SessionStart source, including `resume` — the one occasion ok-planner's regex excludes. The asymmetry the issue reports is present unchanged in current code.

What the corpus says: decision:hook-shims' Choice describes only the shim mechanic itself — "resolve the project root, exec the same-named materialized hook inside the plugin's project-side estate, and exit silently when that file is absent" — and its Rationale argues for per-project hook versions and safe plugin development. It says nothing about which SessionStart sources should trigger injection; the matcher value is outside its scope as written. story:session-awareness' Acceptance says "Any session opens in a converged project → the plugin's skills briefing and ... the concept catalog's table of contents are injected automatically", which states that injection should happen but not on which of `startup` / `resume` / `clear` / `compact` — "any session opens" is compatible with either matcher choice literally, and doesn't single out resume. Both cited artifacts are silent on the specific question, not in conflict with each other or with either plugin's current matcher.

What the code does today: two different-shaped SessionStart declarations across the two plugins that both carry session-awareness content — ok-planner's narrower, excluding resume; ok-workspaces' unrestricted, including resume.

Candidates as filed: amend story:session-awareness' Acceptance to state the intended injection occasions uniformly; add the matcher choice to decision:hook-shims with its rationale. A third shape: since the two plugins' hooks inject different kinds of content (ok-planner's is a corpus/skills briefing that arguably should re-anchor after `resume` too, since context may have rolled off; ok-workspaces' briefing may be cheaper or less context-sensitive), the two matchers could be a deliberate, plugin-specific choice rather than a shared invariant — in which case the fix is stating per-plugin rationale (in session-awareness, scoped per plugin, or in each plugin's own hook text) rather than forcing one shared matcher value.

What the ruling must decide: whether every plugin's SessionStart hook should fire on the same fixed set of sources (and if so, which set — including or excluding `resume`), or whether the matcher is legitimately plugin-specific and the corpus should say so explicitly instead of staying silent.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
