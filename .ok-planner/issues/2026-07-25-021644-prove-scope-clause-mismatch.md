---
issue: prove-scope-clause-mismatch
kind: discover
category: inconsistent
artifacts:
  - concept:completion-contract
  - story:corpus-proof
status: verified
opened: 2026-07-25T02:16:44Z
---

# Contract clause names touched artifacts; the proof verb runs whole-corpus

## Problem

The completion contract's clause reads 'clean over all new and touched stories and decisions' while the proof verb's own text says the completion-contract invocation runs whole-corpus with untouched artifacts checked for regression; certification resolves in practice by running whole-corpus.

## Candidates

- Amend concept:completion-contract to state the whole-corpus scope canonically
- Amend concept:completion-contract to state the narrow scope and record whole-corpus as the certification gate's widening

## Discussion

**The question, restated plainly.** When a sprint closes, does the
completion contract's proof step require `/prove` clean over only the
stories and decisions the sprint touched, or over the entire live
corpus? Two artifacts baked into the workflow give opposite answers, and
the ruling is which one is canonical — and where that canonical answer
needs to be written down so the other stops contradicting it.

**Where this comes from, re-verified.** The issue predates the intake
migration (`issues.jsonl` → one file per issue) and a rewording of the
plan-sprint completion-contract boilerplate; both are noted in the task
context as possible sources of rot. Re-checked directly against current
code and both are clean — the evidence still holds verbatim:

- `plugins/ok-planner/skills/plan-sprint/SKILL.md`, the "Completion
  contract" boilerplate that is copied verbatim into every sprint
  document, reads today: *"`/prove` returns clean over all new and
  touched stories and decisions: every proof present, passing, and
  non-vacuous."* (lines 142–143) — narrow, touched-only scope, word for
  word what the issue quotes.
- `plugins/ok-planner/skills/prove/SKILL.md`, the "Scope" section, reads:
  *"Default: every live story ... and every live decision ... The
  caller may narrow with an argument ... but the completion-contract
  invocation runs whole-corpus: touched artifacts must pass, and
  untouched artifacts must not have regressed."* (line 16) — explicitly
  overrides any narrowing for a completion-contract invocation.
- `plugins/ok-planner/skills/certify/SKILL.md` step 4 confirms this is
  not just aspirational text: *"Invoke `ok-planner:prove` then
  `ok-planner:audit`, **whole-corpus**."* (line 34) — certify, the
  recommended way to discharge the contract, does in fact call `/prove`
  with no scope argument, i.e. whole-corpus.

So the rot check comes back negative: the mismatch the issue names is
present in code today, unchanged in substance by the two intervening
edits.

**What the corpus says.** `concept:completion-contract` does not use
either of the two phrasings verbatim. Its own text (`## What it is`):
*"the proof run returns clean over the **affected** stories and
decisions."* "Affected" is genuinely ambiguous between "the ones the
sprint touched" and "the ones the change could have affected, i.e.
everything" — it doesn't squarely resolve the question either way, which
is why this doesn't close as `answered`. The concept's own Invariants
add a real tension on the narrow side: *"The contract text is included
verbatim in every sprint; executors owe the contract and nothing
else."* If the contract text an executor actually reads (the plan-sprint
boilerplate) says touched-only, that invariant reads as capping
obligation at touched-only — yet the recommended closer, `/certify`,
does more than the contract it is discharging asks for.
`decision:prove-audit-audience-split` and `story:corpus-proof` are both
silent on scope — they describe verdicts, channels, and non-vacuity, not
which artifacts are in scope for a given invocation.

**What the code does today.** Unambiguous and consistent within itself:
`/certify` (the documented, recommended closing path) always invokes
`/prove` whole-corpus, and `/prove`'s own Scope section says this is
deliberate — a completion-contract invocation is defined to run
whole-corpus regardless of caller narrowing. The only place that
disagrees is the sentence baked into every sprint document via the
plan-sprint boilerplate, which promises touched-only. An executor who
reads only the sprint (which `sprint`'s own invariants and
`.ok-planner/CLAUDE.md` say should be sufficient — "the sprint is the
whole brief") would believe a touched-only `/prove` run satisfies the
contract, then find `/certify` silently doing more.

**Candidates.**

- **Filed A — canonicalize whole-corpus.** Amend
  `concept:completion-contract` to state whole-corpus as the contract's
  actual scope. To make this land in the artifact executors actually
  read, this also requires rewording the plan-sprint boilerplate clause
  itself (not just the concept) from "all new and touched" to
  whole-corpus, so a sprint's baked-in contract text stops promising
  something narrower than what `/certify`/`/prove` deliver. Simplifies
  the mental model to one number; costs the "cheap to verify a small
  sprint" framing — every sprint closing, however small, pays a
  whole-corpus proof run.
- **Filed B — canonicalize narrow, record whole-corpus as certify's
  widening.** Keep the contract itself scoped to touched artifacts;
  amend the concept to say so explicitly, and reword `/prove`'s Scope
  section so it no longer claims the completion-contract invocation
  itself is whole-corpus — instead, whole-corpus becomes something
  `/certify` deliberately layers on top (a regression check, distinct
  from discharging the contract's own proof clause). This keeps the
  contract cheap and matches the "executors owe the contract and
  nothing else" invariant, but means `/certify` is doing provably more
  than the contract requires — which is arguably fine (it already runs
  code review and design-doc compliance beyond the bare contract) but
  should be said outright rather than left implicit in "whole-corpus"
  phrasing that currently reads as if it belongs to the contract itself.
- **New — leave the concept's "affected" wording alone, fix only the
  two skill files.** The concept text is vague enough to already be
  compatible with either reading, so it may not need to change at all;
  the actual, concrete contradiction is narrowly between two skill
  files: `plan-sprint/SKILL.md`'s boilerplate clause ("touched") and
  `prove/SKILL.md`'s Scope section plus `certify/SKILL.md` step 4
  ("whole-corpus"). This candidate reconciles those two directly —
  pick one scope and reword whichever skill disagrees — without
  touching `design/` at all. Cheapest fix, but leaves the concept's
  "affected" language just as ambiguous for the next reader as it is
  today, so the same question could resurface in a future audit.

**What the ruling must decide.** Is the completion contract's `/prove`
step scoped to the sprint's touched stories and decisions, or to the
whole live corpus — and does that answer belong in
`concept:completion-contract`'s own text, or only in the skill files
that currently disagree?

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
