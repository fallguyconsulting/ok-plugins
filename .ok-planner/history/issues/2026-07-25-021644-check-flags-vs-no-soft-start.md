---
issue: check-flags-vs-no-soft-start
kind: discover
category: conflicting
artifacts:
  - decision:comments-forbidden-by-default
  - decision:ratchet-over-soft-start
status: promoted
opened: 2026-07-25T02:16:44Z
sprint: 2026-07-25-ruled-intake-drain.md
---

# The config can disable checks the doctrine says have no soft start

Plumbline's config schema accepts `checks.comment_hygiene` and `checks.citation_resolution` as booleans, and setting either `false` fully skips that check — the lint binary gates each check's entire violation loop on the flag (`loadConfig` merges the override; `runLint` honors it; nothing validates against `false`). Meanwhile `decision:ratchet-over-soft-start` says checks "stay strict from day one; there is no soft start," and its Alternatives section explicitly names and rejects "disable checks until the backlog is cleared." The schema ships the exact capability the decision rejects.

No shipped surface ever sets the flags `false`: the starter always emits both `true` and says so, and the porting guide's whole adoption path (with the budget ratchet as the backlog valve) keeps both checks on. So the flags are a bare capability reachable only by hand-editing the config — and their existence makes `story:incremental-lint-adoption`'s falsifier ("adoption requires disabling the checks") exhibitable today by any owner who flips them. The story's guarantee currently rests on nobody doing so, not on anything preventing it. The other cited decision (`comments-forbidden-by-default`) governs which comment *forms* are exempt, not whether a check runs at all — silent here.

## Options

- **Retire the flags** — remove `checks.*` disabling from the schema via a sprint (reject or ignore `false`, run both checks unconditionally), with a true-up note for any stray config carrying the dead key. Doctrine and mechanism converge because the mechanism ceases to exist. Cost: forecloses hypothetical legitimate uses — none of which is evidenced anywhere.
- **Sanction the flags with stated limits** — document them as an escape in a fitting decision. But no fitting decision exists (`comments-forbidden-by-default` is a scope mismatch), and "stated limits" is undefined: the owner would have to invent a purpose for a knob nothing has ever needed.
- **Scope "no soft start" to adoption only** — reserve the flags for a named non-adoption purpose. Proposes relief for a problem never observed.

The ruling decides: retire the flags, or keep them under a documented, limited sanction?

## Ruling

> Recommended ruling (/verify-issues): retire the flags — a sprint work item removes `checks.comment_hygiene` / `checks.citation_resolution` disabling from the schema and the binary, both checks run unconditionally, and `decision:ratchet-over-soft-start`'s Alternatives records the flags as retired; true-up flags any config still carrying the dead key.
>
> Rationale: the decision already rejected this exact alternative in writing — the flags are the rejected road left paved. Every sanctioned easing need is served by the budget ratchet, which was built precisely so checks never turn off; keeping an undocumented override alongside it maintains a standing exhibit of the adoption story's falsifier for no evidenced benefit.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
