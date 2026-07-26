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

# The two session-start hooks fire on different occasions, with no stated intent

ok-planner's SessionStart hook declares the matcher `startup|clear|compact`; ok-workspaces' SessionStart entry declares no matcher at all, which under the harness's hook semantics means it also fires on session *resume* — the one occasion ok-planner's regex deliberately excludes. Nothing anywhere says whether the asymmetry is intended, so a reader can't tell which plugin is the bug.

The mechanics of why the sets might legitimately differ: a resumed session still has its earlier context, including whatever was injected at startup — firing again on resume duplicates the injection. That reasoning applies equally to both plugins' hooks, which do the same kind of work (inject the plugin's session briefing from the materialized estate copy). Neither cited artifact reaches the question: `decision:hook-shims` covers only the shim mechanic (resolve root, exec the materialized hook, exit silently when absent), and `story:session-awareness`'s acceptance — "any session opens in a converged project → the briefing is injected" — is compatible with either matcher. The corpus is silent, not conflicted.

## Options

- **Unify on `startup|clear|compact`** — add the matcher to ok-workspaces' hooks.json and record the injection-occasion choice (and its resume rationale) in `decision:hook-shims`. One-line code fix plus one corpus sentence.
- **Unify on no matcher (include resume)** — drop ok-planner's matcher instead. Re-injects into sessions that already carry the content.
- **Declare the matchers plugin-specific** — state a per-plugin rationale in the corpus. But no such rationale exists in evidence; both hooks carry the same kind of briefing, so this would document a difference nobody chose.

The ruling decides: one shared set of injection occasions (and which), or per-plugin matchers with stated rationale.

## Ruling

> Recommended ruling (/verify-issues): unify on `startup|clear|compact` — add the matcher to ok-workspaces' SessionStart declaration, and record the injection occasions and the resume-exclusion rationale in `decision:hook-shims`.
>
> Rationale: a resumed session already holds its startup injection; re-firing duplicates context for no benefit, which is presumably why ok-planner's matcher was written — the asymmetry has the shape of an omission in ok-workspaces, not a choice. Unifying costs one line; a per-plugin rationale would document a difference with no evidenced reason.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
