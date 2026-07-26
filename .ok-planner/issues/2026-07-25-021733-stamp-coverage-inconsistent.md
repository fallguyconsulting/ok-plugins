---
issue: stamp-coverage-inconsistent
kind: discover
category: inconsistent
artifacts:
  - concept:materialized-artifact
  - decision:per-project-pinning
status: verified
opened: 2026-07-25T02:17:33Z
---

# One materialized artifact carries no version stamp, and the corpus claims they all do

`concept:materialized-artifact` states an unconditional invariant: "every materialized artifact records the version of the plugin that wrote it" — and names the cheatsheet as a materialized-artifact example. But ok-plumbline's cheatsheet is materialized by pure byte-copy (`cmp -s` against the canonical doc) with no version stamp anywhere in the file, while the very same skill stamps the vendored binary and hook two steps later via the plugin's own `{{OK_PLUMBLINE_VERSION}}` placeholder convention. Every other plugin stamps its materialized files. So the invariant is currently violated by exactly one artifact — arguably a rules-determined repair, except that fixing it quietly would pre-empt the broader question the issue actually asks.

That broader question: the suite genuinely runs a *mixed* fidelity model — version stamps for most artifacts, deliberate byte-identity for src-tag (whose derivation must never silently vary, a stricter bar for a stated reason) — and `decision:per-project-pinning`'s Proof already names both. The original filed claim of a "no content comparison" doctrine turned out to be scaffolding prose, not corpus text; no live artifact asserts it. What no artifact does is *explain* the mixed model: which artifacts get which check, and why.

## Options

- **Stamp the outlier and document the mixed model** — the plumbline cheatsheet gains a stamp (its plugin's existing placeholder pattern), and `concept:materialized-artifact`'s invariants gain one sentence: stamps are the norm; byte-identity applies where derivation itself is the guarantee (src-tag). Both surfaces become true.
- **Document only** — name the unstamped cheatsheet as an accepted exception. Ratifies an inconsistency one `sed` line away from not existing.
- **Standardize harder** — force one fidelity mechanism everywhere; loses src-tag's deliberate stricter bar or weakens it with a stamp it doesn't need.

The ruling decides: stamp-and-document, or ratify the gap, or flatten the model.

## Ruling

> Recommended ruling (/verify-issues): stamp and document — a sprint work item adds the version stamp to ok-plumbline's materialized cheatsheet via its existing `{{OK_PLUMBLINE_VERSION}}` convention, and a delta adds the mixed-model sentence to `concept:materialized-artifact` (stamps as the norm, byte-identity where derivation is the guarantee).
>
> Rationale: the invariant already decides the cheatsheet half — one artifact violating a stated "every" is a gap to close, not an exception to canonize — and the src-tag strictness is a real, reasoned difference the corpus should say out loud rather than leave as trivia in a Proof field.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
