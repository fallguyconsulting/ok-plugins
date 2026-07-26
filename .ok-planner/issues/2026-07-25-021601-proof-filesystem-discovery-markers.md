---
issue: proof-filesystem-discovery-markers
kind: discover
category: proof
artifacts:
  - decision:filesystem-discovery-markers
status: verified
opened: 2026-07-25T02:16:01Z
---

# Discovery-marker discipline has no conformance check

## Problem

Nothing fails when discovery comes to depend on a marker the contract does not document; one undocumented marker is already in live use (see plumbline-discovery-marker-undocumented).

## Candidates

- Amend decision:filesystem-discovery-markers Proof to name a marker-conformance check once one exists
- Accept contract-prose governance and record that in the decision

## Discussion

**The question.** decision:filesystem-discovery-markers currently carries no
enforcing proof — its own Proof field says so. Should the corpus keep this as
an open gap awaiting a mechanical marker-conformance check, or formally accept
that the choice is governed by contract prose alone (owner/reviewer discipline,
not a check) and record that as the decision's permanent Proof position?

**Where this comes from, re-verified against current code.** The Problem cites
a sibling issue, `plumbline-discovery-marker-undocumented`
(`.ok-planner/issues/2026-07-25-021644-plumbline-discovery-marker-undocumented.md`,
still open), as an existing instance of exactly this failure mode. That
citation still holds today:

- `plugins/ok/skills/ok/SKILL.md` (the dispatcher, `/ok`) states its discovery
  rule for ok-plumbline explicitly: *"ok-plumbline is integrated iff
  `.plumbline.json` exists at the root or
  `.claude/rules/plumbline-cheatsheet.md` exists"* — two markers, the second
  being the materialized cheatsheet.
- `docs/integration-contract.md`'s "Current conformance" section — the place
  `concept:integration-contract`'s invariant ("The contract, not the
  dispatcher, is where per-plugin knowledge is documented") says this
  knowledge must live — documents only **one** pre-migration marker for
  ok-plumbline: *"Its documented pre-migration marker is a root-level
  `.plumbline.json`"*. The cheatsheet path is not listed as a marker there.
- `plugins/ok-plumbline/bin/plumbline` (the plugin's own diagnose/true-up
  logic) also only ever treats `.plumbline.json` as the pre-migration config
  location (`bin/plumbline:101,145,1084-1091`); it does not treat the
  cheatsheet as a discovery marker either.

So the drift is real and current, not something that has since been fixed:
the dispatcher's own discovery logic carries a marker the normative contract
document does not list, and no mechanical check would catch a future
recurrence of the same shape (a new plugin's dispatcher entry growing an
undocumented marker) even if this specific instance were resolved. Nothing
about this rotted since filing; the evidence still points where it did.

**What the corpus says.** `decision:filesystem-discovery-markers` Choice
states discovery is "solely" filesystem markers "plus documented
pre-migration marker locations," and its Proof field is explicit that no
enforcing check exists and the question is filed for owner calibration —
this issue is that filing, not something the corpus already resolves.
`concept:integration-contract`'s Invariants state "the contract, not the
dispatcher, is where per-plugin knowledge is documented" and "whether a
project uses a plugin is a filesystem check, never an inference" — both
already true of the design's *intent*, but neither is itself an enforcement
mechanism, and neither says whether that documentation discipline must be
backed by a mechanical check or may rest on prose alone.
`concept:proof`'s Invariants require "every live story and decision has at
least one annotated proof" — this decision does not have one today, which is
exactly the gap under discussion. Nothing in the corpus decides *how* to
close that gap.

Worth noting for calibration context (not something to resolve here): this is
not an isolated case. `decision:hook-shims`, `decision:lockstep-suite-version`,
and at least one more decision in `.ok-planner/design/decisions/` carry the
identical "no enforcing check exists today ... filed to the intake queue for
owner calibration" Proof text, each with its own sibling issue in this
batch (`proof-hook-shims`, `proof-lockstep-suite-version`, etc.). A ruling
here may be read as a template for how the others get decided, though each
is a separate issue file and this Discussion does not speak for them.

**What the code does today.** Discovery is implemented exactly once, in the
dispatcher (`plugins/ok/skills/ok/SKILL.md`), as a hand-written per-plugin
marker list — the current marker (`.ok-<name>/`) plus documented
pre-migration markers named ad hoc in the skill's prose. There is no script,
lint rule, or test anywhere in the repo (`@decision:filesystem-discovery-markers`
appears nowhere in code) that cross-checks the dispatcher's marker list
against `docs/integration-contract.md`'s "Current conformance" section, or
against what each plugin's own true-up/diagnose logic actually treats as a
marker. The three surfaces (dispatcher prose, contract doc prose, per-plugin
binary/skill logic) can independently drift, and nothing fails when they do.

**Candidates.**

- *Amend the Proof field to name a marker-conformance check once one exists.*
  This keeps the decision's proof requirement live and unmet-for-now: a
  future check would need to enumerate every integrable plugin (currently
  three: ok-planner, ok-plumbline, ok-workspaces — a "quantifies over a
  population" proof per `concept:proof`'s invariant, so it would need to
  enumerate that population rather than pass vacuously on one plugin) and
  fail if any marker referenced by the dispatcher, by a plugin's own
  true-up/diagnose logic, or actually present on disk is absent from
  `docs/integration-contract.md`'s conformance list (or vice versa). This
  is buildable — it would look like plumbline's own citation-resolution
  check, generalized to markers — but is unbuilt work, and until it exists
  the decision continues to read as an acknowledged gap.
- *Accept contract-prose governance and record that in the decision.* This
  treats "the contract, not the dispatcher, is where per-plugin knowledge is
  documented" (already an invariant) plus ordinary review discipline as
  sufficient, and rewrites the Proof field to say so plainly instead of
  leaving it as an open "no enforcing check exists" flag. Per the shared
  artifact contract's own rule for decisions, one with no nameable
  violation-detecting check is "either really a default (delete it) or an
  unenforced intention" (filed as an issue) — this candidate is the "accept
  it as an unenforced intention, on purpose, permanently" reading, made
  explicit in the artifact rather than left dangling as a standing gap.

Both candidates leave the sibling issue (`plumbline-discovery-marker-undocumented`)
to be resolved on its own terms — neither one, by itself, fixes the current
dispatcher/contract-doc mismatch; that fix is that issue's business.

**What the ruling needs to decide.** Does `decision:filesystem-discovery-markers`
get a mechanical marker-conformance check (and if so, is building one
in scope now or deferred), or does the corpus formally accept contract-prose
governance as this decision's permanent Proof position?

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
