---
issue: plumbline-ci-emission-ungoverned
kind: audit
category: unspecified
artifacts:
  - story:incremental-lint-adoption
  - decision:ratchet-over-soft-start
  - decision:per-project-pinning
status: verified
opened: 2026-07-28T10:12:59Z
---

# CI wiring is emitted for consumers, but only its outcome is promised

The suite ships `/ok-plumbline:ci` into every consumer project: it emits
ready-to-use CI configuration — GitHub Actions, GitLab CI, or pre-commit —
wiring two gates into the consumer's pipeline: a lint gate that fails on any
violation, and the budget ratchet (fail when the violation count goes up,
pass when it holds or drops). The corpus reaches the CI *outcome* twice — the
adoption story commits that "a recorded baseline makes any change that
increases the count fail in CI" (`story:incremental-lint-adoption`), and the
ratchet decision's Choice says the same (`decision:ratchet-over-soft-start`)
— but nothing commits to the product *producing* that configuration, to the
platforms it must produce it for, or to what the emitted config contains. The
whole-corpus certification's surface inventory found the hole and will
re-file it every run until the owner rules.

Two forks are stacked, and the second survives the first. First, whether the
emission verb is owed at all: the outcome is claimed, but under the corpus's
own convention — every other vendored verb answers to a clause naming its
outcome — the emitter is unclaimed, and readings differ on whether the
ratchet's "fail in CI" already reaches it. Second, even after "document":
which platform set the corpus commits to, and whether the emitted lint gate's
fail-on-any-violation posture becomes a committed CI-time claim — today the
only committed blocking is at edit time (`story:edit-time-lint-enforcement`),
so the pipeline gate is additive behavior that ships without ever having been
decided.

State of play: the verb is live and vendored, the emitted templates name
three platforms and both gates, and the pinning decision's rationale ("CI can
lint at the project's pinned version with nothing installed" —
`decision:per-project-pinning`) presumes CI wiring exists without ever
claiming its production.

## Options

- **Add a story** committing the product to ready-to-use CI wiring for the
  lint and the ratchet, platform set left as mechanism — cost: a proof
  obligation, and the acceptance must decide the fail-on-any posture to be
  honest.
- **Widen `story:incremental-lint-adoption`'s acceptance** to cover the
  wiring — cost: not actually cheaper than a new story (same sprint-level
  commitment change), and it burdens a story about adoption with an emission
  claim.
- **Record a decision fixing the platform set and emitted-config contract** —
  cost: commits to a named platform list the suite must then track.
- **Extend `decision:ratchet-over-soft-start`'s Choice** to state the CI is
  delivered as emitted configuration — cost: same commitment, carried without
  a proof.
- **Retire the verb** — cost: consumers hand-write the wiring the corpus
  already promises as an outcome.
- **Record a class decision** that CI wiring is ordinary mechanism — cost:
  weakest here of the three sibling issues, because the emitted template
  embeds a behavioral claim (fail-on-any-violation in the pipeline) that
  would then ship forever undecided.

## Ruling

> Recommended ruling (/verify-issues): add a story committing the product to
> ready-to-use CI wiring for the committed checks — acceptance stating that a
> consumer receives working pipeline configuration gating on the ratchet's
> committed semantics and on a fail-on-any-violation lint pass, with a
> falsifier and proof intent — leaving the platform set as mechanism outside
> the story body.
>
> Rationale: the outcome is already committed twice, so the emitter is how
> consumers actually receive a promise the corpus has already made — the
> "nothing is owed" reading leaves a committed outcome with no committed
> delivery. Naming the fail-on-any posture in the acceptance is the honest
> documentation of what the template already ships; leaving the platform set
> as mechanism keeps the story durable while platforms churn. If the owner
> instead wants the platform list itself to be a commitment (consumers
> depending on GitLab support staying), the companion decision fixing the set
> is the right addition, not a replacement.

<!-- Owner: this is a recommendation, not your decision. Leave it as-is to
accept — the next /plan-sprint carries it, naming the recommended batch at
sign-off. Edit the text to redirect, empty the section to discuss live, or
delete this note to adopt the ruling as your own. -->
