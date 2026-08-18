---
decision: event-kinds-as-conventioned-strings
---

# Event kinds are dotted-namespace strings, inventoried and never linted

## Choice

The suite carries one events standard beside the testing standard,
materialized in the plumbline estate with a cheatsheet section as its
ambient copy. Code emits a structured event at every state
transition, every branch taken on external input, every boundary
crossed (I/O, RPC, process), every retry, and every error caught. An
event is a kind plus structured fields; prose lives in a field, never
in the kind. A kind is a raw string literal in one fixed convention —
dotted namespaces in one case, `SUBSYSTEM.NOUN.VERB` — declared
nowhere else and unique in meaning; a test waits on a kind by the
same literal the product emits. Internal pure computation that
touches no state, no boundary, and no error emits nothing.

The reviewer enforces coverage and uniqueness of meaning with the
code open, under the certification code-review brief. The one
mechanical instrument is a read-only inventory, `/events`. It lists
every kind in the tree with its sites, split by the project's
test-path convention. It checks the format. It calls out a kind
referenced only from test files as an orphan. It hands over the kinds
no test waits on as a pruning list, never as a finding. Library,
transport, levels, sampling, and wire format are the project's own.

## Rationale

The literal is the wire value. A declaration adds a second name and a
hop, and an enum list grows and needs its own pruning. A convention
makes the literal itself the declaration, findable with one regex in
any language. Coverage at the named sites is what makes the testing
standard achievable: a test waits only on what the code emits. A
caught error that emits nothing is the failure that costs most later.

Uniqueness of meaning is not lintable. An inventory gives the
reviewer the population before it adds a kind, and the owner the
pruning list, without a verdict a lint would get wrong. Operators
consume events outside the tree, so a kind no test waits on is not
unused. The inventory hands that list over and files nothing.

## Alternatives

- Enums or constants per module — a second name for the wire value;
  the list itself needs pruning.
- A lint enforcing coverage per path — language-specific, and
  "meaningful path" is not mechanically decidable.
- Free-form log lines — unfilterable; tests grep prose and a watchdog
  mistakes output for progress.
- Prescribing the library or transport — a universal rule made
  stack-specific.
