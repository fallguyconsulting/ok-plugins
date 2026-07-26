---
issue: plumbline-discovery-marker-undocumented
kind: discover
category: conflicting
artifacts:
  - decision:filesystem-discovery-markers
  - concept:integration-contract
status: verified
opened: 2026-07-25T02:16:44Z
---

# Dispatcher honors a discovery marker the contract does not document

## Problem

The contract documents exactly one pre-migration marker for the lint plugin (the root config file), but the dispatcher's discovery step also treats the materialized cheatsheet as a marker — per-plugin knowledge the contract forbids the dispatcher to carry undocumented.

## Candidates

- Amend concept:integration-contract Invariants to require every honored marker be contract-documented, and document the second marker
- Amend decision:filesystem-discovery-markers Choice to drop the undocumented marker from discovery

## Discussion

**The question, plainly.** `/ok`'s dispatcher honors two filesystem
signals as proof that a project integrates ok-plumbline: the current
estate marker (`.plumbline.json` or `.ok-plumbline/`, covered by the
next check) and the materialized cheatsheet
(`.claude/rules/plumbline-cheatsheet.md`). Only the first is written
down in `docs/integration-contract.md`, the file both
concept:integration-contract and decision:filesystem-discovery-markers
say is the one place per-plugin discovery knowledge is allowed to
live. Does the cheatsheet marker get written into the contract, or
does the dispatcher stop honoring it?

**Where this comes from.** Re-verified against the current tree
(plugin source moved since filing, but not this file):
`plugins/ok/skills/ok/SKILL.md:29` reads *"**ok-plumbline** is
integrated iff `.plumbline.json` exists at the root or
`.claude/rules/plumbline-cheatsheet.md` exists"* — and frames this as
drawn *"from the contract's current-conformance section."* But
`docs/integration-contract.md`'s current-conformance entry for
ok-plumbline (lines 178–184) names only one pre-migration marker:
*"Its documented pre-migration marker is a root-level
`.plumbline.json` ... the binary honors that path until true-up
migrates it."* No mention of the cheatsheet there or anywhere else in
the contract. So the dispatcher's own citation of its source is
inaccurate — the contract does not, in fact, document the marker the
dispatcher attributes to it. This exact gap is also independently
recorded in the `_discover` scaffolding
(`.ok-planner/design/_discover/dot-directory-and-discovery.md`
Observations, `.ok-planner/design/_discover/integration-contract.md`
Observations) and is what decision:filesystem-discovery-markers'
own Proof section is referring to: *"one such undocumented marker
already circulates."* No rot: the evidence holds exactly as filed.

**What the corpus says.**
- concept:integration-contract Invariants: *"The contract, not the
  dispatcher, is where per-plugin knowledge is documented."* This
  settles *where* documentation must live if the marker is to be
  honored at all, but doesn't itself say every currently-honored
  signal must already be documented there — it's silent on what to do
  with a signal that's in code but not yet in the contract.
- decision:filesystem-discovery-markers Choice: discovery is
  *"checking for each plugin's committed dot-directory estate ...
  plus documented pre-migration marker locations."* Its own Proof
  section flags this precise situation as open and explicitly defers
  it: *"nothing fails if a plugin's discovery depends on an
  undocumented marker ... Filed to the intake queue for owner
  calibration."* The decision does not answer the question — it is
  the reason this issue exists.
- story:one-command-suite-upkeep Falsifier: *"an integrated plugin
  goes undiscovered"* is a failure condition. Relevant to candidate 2
  below — narrowing discovery must not create a false negative.
- concept:estate: repeats the pre-migration-marker allowance
  ("documented ... locations are honored for discovery") without
  adding detail beyond what's above.

None of the four squarely answers the question; the decision
explicitly punts it here.

**What the code does today.** Functionally, the two signals are not
equivalent. `.plumbline.json` is read by the plugin's own binary
(`plugins/ok-plumbline/bin/plumbline`) as a real fallback config
path — true-up's converge step (`skills/true-up/SKILL.md` §3)
mechanically relocates it into `.ok-plumbline/config.json`, contents
untouched, and the binary honors the old path until that happens. It
is a functioning pre-migration marker in the sense the decision
describes: an artifact from a retired layout that something still
reads.

The cheatsheet, by contrast, is inert: nothing in ok-plumbline reads
`.claude/rules/plumbline-cheatsheet.md` back — true-up only writes it
(§4), byte-comparing against the plugin's canonical copy to decide
whether to overwrite. It exists once true-up has run at least once,
which in the current true-up ordering (§3 converge-estate before §4
cheatsheet) means `.ok-plumbline/` (or `.plumbline.json`, on an
unmigrated project) is essentially always present alongside it too —
today's true-up gives no path to a project with the cheatsheet but
neither estate form. A state where the cheatsheet marker fires and
the other two don't would have to come from something outside
current true-up: a hand-copied cheatsheet, a manually deleted estate,
or (unverifiable from the repo, but the likely original reason the
check was written) a pre-`.plumbline.json` layout old enough that
only the cheatsheet was ever materialized — the plugin was renamed
from ok-standards partway through its history (git history:
`eba51a7 Rename ok-standards to ok-plumbline`), and an even earlier
config-free layout is plausible but not evidenced by anything
currently in the repo.

**Candidates.**

1. **Document the second marker in the contract** (as filed) —
   amend concept:integration-contract's Invariants to require every
   marker the dispatcher honors to be contract-documented (closing
   the general gap the decision's Proof flags, not just this
   instance), and add the cheatsheet path to
   docs/integration-contract.md's ok-plumbline current-conformance
   entry alongside `.plumbline.json`. Corpus changes: both the
   concept and the contract prose gain a line each; decision:
   filesystem-discovery-markers' Proof note becomes resolved.
   Code/prose change: none — `/ok`'s SKILL.md already matches this
   shape; only `docs/integration-contract.md` needs the addition.
   Tradeoff: keeps the current, more permissive discovery (catches
   any leftover-cheatsheet state, however it arose) at the cost of
   codifying a marker that nothing else in ok-plumbline treats as
   meaningful — the contract would describe a signal that is, by the
   plugin's own binary, not actually load-bearing.

2. **Drop the undocumented marker from discovery** (as filed) —
   amend decision:filesystem-discovery-markers' Choice to scope
   pre-migration markers to ones a plugin's own logic still reads
   (i.e., `.plumbline.json` only for ok-plumbline), and edit
   `plugins/ok/skills/ok/SKILL.md:29` to drop the `or
   .claude/rules/plumbline-cheatsheet.md` clause. Tradeoff: tighter
   alignment between "marker" and "something still functionally
   honors this path," but risks the story:one-command-suite-upkeep
   falsifier ("an integrated plugin goes undiscovered") in the one
   edge case above — a project whose `.ok-plumbline/` or
   `.plumbline.json` is gone (deleted, gitignored and never
   committed, or from a layout older than either) but whose
   cheatsheet survived would stop being offered as "already
   integrated" and would instead surface as an uninstalled/bootstrap
   candidate. Whether that edge case is real enough to matter is a
   judgment call the corpus has no evidence to make either way.

3. **A narrower version of candidate 1** — document the cheatsheet
   marker in the contract's current-conformance section only,
   without adding a blanket Invariant that every honored marker must
   be contract-documented. Fixes this specific citation gap without
   committing the contract to policing all future markers the same
   way. Tradeoff against candidate 1: leaves the general failure mode
   the decision's Proof describes ("nothing fails if a plugin's
   discovery depends on an undocumented marker") unaddressed for the
   next plugin that adds one, at the benefit of a smaller, more
   contained change.

**What the ruling must decide.** Should
`.claude/rules/plumbline-cheatsheet.md` remain an honored ok-plumbline
discovery marker (and be added to the contract, narrowly or via a
general documented-markers Invariant), or should discovery narrow to
drop it, keeping only `.plumbline.json` as ok-plumbline's pre-migration
marker?

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
