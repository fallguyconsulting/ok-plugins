---
issue: prove-scope-clause-mismatch
kind: discover
category: inconsistent
artifacts:
  - concept:completion-contract
  - story:corpus-proof
status: promoted
opened: 2026-07-25T02:16:44Z
sprint: 2026-07-25-ruled-intake-drain.md
---

# The contract promises touched-only proof; the prove verb claims whole-corpus

When a sprint closes, is the completion contract's proof step satisfied by `/prove` clean over the stories and decisions the sprint touched, or over the entire live corpus? The two surfaces an executor actually reads disagree. The boilerplate baked into every sprint says "`/prove` returns clean over all new and touched stories and decisions" — touched-only. But `/prove`'s own Scope section says "the completion-contract invocation runs whole-corpus: touched artifacts must pass, and untouched artifacts must not have regressed." An executor who trusts the sprint (which the suite's own doctrine says is the whole brief) does less than the prove verb claims the contract demands.

The landscape shifted under this issue since filing, and in one direction: suite v9.0.0 split certification into `/certify-work` (the everyday close — proves *touched* stories and decisions only, change-scoped corpus checks) and `/certify-all` (whole-corpus, run on the owner's cadence, not per close). The old single `/certify` that ran whole-corpus prove on every close is gone. So the system has already voted for the narrow reading everywhere except one sentence: `prove/SKILL.md`'s Scope clause still asserts the whole-corpus contract semantics that v9 retired. Meanwhile `concept:completion-contract` says "clean over the **affected** stories and decisions" — wording genuinely ambiguous between both readings — while its invariant "executors owe the contract and nothing else" caps obligation at what the sprint text promises.

## Options

- **Canonicalize touched-only** — amend `concept:completion-contract` to say "new and touched" explicitly, and reword `/prove`'s Scope clause so whole-corpus is `/certify-all`'s explicit widening, not a property of contract invocations. Aligns the last dissenting sentence with the v9 split.
- **Canonicalize whole-corpus** — reword the sprint boilerplate to promise whole-corpus proof at every close. Reverses the v9 split's cost model; every small sprint pays for the whole corpus again.
- **Fix only the skill files, leave "affected" ambiguous** — cheapest, but the concept's wording regenerates this exact issue at the next audit.

The ruling decides: touched-only or whole-corpus as the contract's proof scope, and whether `concept:completion-contract` states it explicitly.

## Ruling

> Recommended ruling (/verify-issues): canonicalize touched-only — amend `concept:completion-contract` to replace "affected" with "new and touched" and to name whole-corpus proof as `/certify-all`'s cadence-scoped business, and reword `/prove`'s Scope section to drop the "completion-contract invocation runs whole-corpus" clause.
>
> Rationale: the v9 certify split already decided this — the owner adopted a change-scoped everyday close precisely because whole-corpus-per-close blew past usage limits, and the prove clause is the one surviving sentence of the old model. Choosing whole-corpus here would silently reverse a decision made deliberately two days ago; choosing ambiguity re-files this issue.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
