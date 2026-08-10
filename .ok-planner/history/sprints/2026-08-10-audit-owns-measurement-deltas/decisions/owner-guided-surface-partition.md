---
decision: owner-guided-surface-partition
---

# The public surface is a total, owner-guided partition

## Choice

The public surface is a total partition ruled by owner guidance: the
extraction produces the complete candidate population, every element
is classified public or private by applying the guidance prose, and
no default exists — an element the guidance cannot settle stops the
run and reaches the owner, whose answer returns as guidance. The
audit opens with this determination, and it is the run's one
interactive moment: unratified guidance changes, unsettled elements,
and member drift are walked with the owner up front, then the run
proceeds autonomously on a settled partition; a settled partition
passes the opening silently.

Extraction is agentic, hierarchical, and purpose-bound to the ruling:
agents walk the project coarse-to-fine — code and deployment
configuration, never the design corpus — and go no deeper than
classification requires. A container the guidance already marks
internal is a pruning notation: it is classified at its boundary and
never descended into. What reaches the owner is novelty — a module,
service, protocol, or surface kind the guidance does not cover — and
the owner's answer lands in the guidance as a new rule or notation,
so the next run passes that spot silently. Each declared kind's
members are committed as a member list; every run re-derives the
members, diffs against the committed list, and walks drift like any
unsettled element. No kind carries a mechanical enumerator command:
the committed member list is the mechanical face, and the agentic
derivation is the enumerator. A corpus contradiction the extraction
turns up — an artifact asserting a posture the observed element
violates — is not the walk's business: it escalates to the run's
second-opinion judge like any other determination the run could not
call supported. Planning participates predictively: work that would
introduce surface the guidance cannot classify is settled during
sprint planning, and the answer rides the sprint as a guidance edit.

## Rationale

"Private unless declared public" makes invisibility the default
outcome of forgetting: an element nobody declared is an element nobody
documents, checks, or answers absence about. The total partition
inverts that — forgetting is a loud gap the run cannot proceed past.
Guidance prose is the classification form an owner will actually
maintain, rules at the altitude they think at with exceptions where
the rules run out, and deriving every classification from it keeps
judgment exercised once and applied mechanically ever after — the
pruning notations are the same economy applied to extraction depth,
which is what keeps an agentic pass affordable: most of a codebase
sits behind an internal notation and is never walked. Mechanical
enumerator commands were retired because an enumerator is itself
unaudited software: it drifts as the project's idioms move, and it
misses exactly what was added out-of-practice by design or accident —
the blind spot the partition exists to close, reintroduced as a
script. Determinism was never the load-bearing property; the
committed member list and the per-run diff are — an agent-derived
population anchored to a diff the owner walks is refutable in the
same way a mechanical one was, without trusting a parser nobody
re-reads. The interactive moment sits at the audit's opening because
the partition is the first thing every downstream determination
depends on, and it is the one question that cannot be answered
without the owner; putting candidate-kind discovery in the same
opening is what lets detection inform the ruling it used to trail.

## Alternatives

- Public-only declaration with inferred private: the previous shape;
  new elements land invisible by default, which is the failure this
  decision exists to remove.
- Mechanical enumerator commands as the norm, agentic derivation as a
  marked fallback to be retired: the prior shape — the enumerators
  themselves drift unaudited, the marked set pointed the retirement
  direction backwards, and its first outing settled four kinds while
  three whole populations went undetected.
- A late reality-read sweeping for undeclared surface after the
  determination: detection lands after the ruling it should inform,
  and its findings survive only as report prose — the ordering defect
  this decision's opening-time discovery removes.
- Language-native visibility as the classification: many surface kinds
  have no such notion, and where one exists it encodes the compiler's
  boundary, not the owner's.
- A per-member registry: total, but unmaintainable — every addition is
  a manual entry, and the rationale for the boundary lives nowhere.
- Member lists inline in the declaration: fewer files, but every
  re-derivation churns the owner's own declaration, and the derived
  content blurs into the declared.
- Agentic extraction at run time with no committed list: always
  fresh, but the partition's domain becomes nondeterministic between
  runs and nothing records what the judgment was.
