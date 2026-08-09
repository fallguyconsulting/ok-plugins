# ok-planner — audit ceremony surface

What the suite's periodic audit does about this family's estate. The
ceremony owns the spine — enumerate, determine, judge, check, present,
close out; this file owns everything ok-planner contributes to it.
Materialized into consumer projects at `.ok-planner/ceremony/audit.md`;
the ceremony reads it there when `.ok-planner/` exists.

## Requires

`.ok-planner/design/` at the project root. Without a design corpus
there is nothing here to audit: say so, point at `/discover-design`,
and let the other estates' phases run.

## Layout

`mkdir -p .ok-planner/audits/concepts .ok-planner/audits/stories .ok-planner/audits/decisions .ok-planner/issues .ok-planner/history/issues`.
Estate convergence is the front door's administration (`/ok`), never
this run's.

## Enumerate

Every file under `.ok-planner/design/concepts/`,
`.ok-planner/design/stories/`, and `.ok-planner/design/decisions/` is in
scope — there is no subset. **Concepts are audited like the other two**,
because the compliance axis is a reading of any artifact against its own
authoring rules and a concept has rules of its own: the altitude bar, the
self-containment restrictions, and the no-implementation-enumeration
tightening. Its support axis is its Invariants read against the code,
exactly as a decision's Choice is.

Group the refs **by locality**, so artifacts whose claims rest on the
same code ride in one dispatch and that code is read once: the artifacts
about one subsystem, one surface, one service. Five to ten artifacts per
batch. Say how many artifacts and how many batches before dispatching.

## Determine

One dispatch per batch of `{{IMPLEMENTATION-AUDITOR-PROMPT}}` from
`.claude/skills/_shared/implementation-auditor.md`, with `[AUDIT SET]`
filled with that batch's refs. Each writes its batch's audit files to
`.ok-planner/audits/<bucket>/<slug>.md` and reports one line per
artifact. Never one agent per artifact, and never a subagent inside an
auditor.

Each audit records **two independent axes**, per `{{AUDIT-DEFINITION}}`:
whether the artifact complies with its own authoring rules, and whether
the codebase supports what it claims. They genuinely come apart, and
both are written.

## Judge

Collect every ref the auditors returned as `unsupported` or `unclear`.
None → skip this stage and say so. Otherwise dispatch
`{{AUDIT-JUDGE-PROMPT}}` from the same file with the full escalation
list — each ref, its determination, and its one-line reason, verbatim.
The judge finalizes each: confirmed (issue filed, `unsupported`
stands), overturned (rewritten as `supported`), or undecidable (issue
filed, `unclear` stands). It is terminal; whatever it returns is the
run's answer.

The compliance axis never escalates. A form defect is mechanical by
construction — the rules determine the compliant text — so it is
recorded in the audit, reported to the human, and fixed by whoever
holds the report.

## Sweep

Two checks no per-artifact reading can perform. Both report findings
in-context; neither writes an audit file and neither files anything.

### Cross-artifact consistency

```
Agent (general-purpose, model: sonnet-5):
  ## Cross-artifact consistency audit

  ### Your job

  Find pairs (or small groups) of live design artifacts under
  `.ok-planner/design/` that contradict each other. Each artifact
  may be internally valid; the finding is the *conflict between*
  them. You resolve nothing yourself — you classify each
  contradiction per {{MECHANICAL-VS-JUDGMENT-RULE}} (transcluded
  below) and report it.

  {{MECHANICAL-VS-JUDGMENT-RULE}}

  {{LEAF-AGENT-RULE}}

  ### What counts as a conflict

  - Two decisions that mandate incompatible mechanisms for the
    same concern — e.g. one decision requires a component the
    deployment another decision mandates cannot run.
  - A decision whose Choice negates another decision's Choice.
  - An invariant one concept states that another artifact's body
    contradicts.
  - A decision or concept that forecloses a user-outcome a story
    promises.

  ### How to work

  Read every live concept, story, and decision.
  For each, note what it *requires* and what it *forbids*. Then
  look for a second artifact whose requirement collides with the
  first's — the collision is the finding. Read the code where
  deciding whether two claims actually collide depends on what the
  code does.

  ### Output format

  Status line first: `Status: Consistent | Conflicts Found`.
  Then one entry per conflicting pair/group: the artifact slugs,
  the specific claim in each that collides, and why they cannot
  both hold. Classify each: when the code and one artifact agree
  and the other's colliding text is a stale rendering of the
  same commitment — nothing the project commits to changes by
  aligning it — class `mechanical`, stating the determined fix
  (align the stale text to the commitment the code and the
  counterpart artifact share). When both readings are live
  possibilities, the code sides with neither, or any alignment
  would change what the project commits to, class `judgment`,
  category `conflicting` — only the owner resolves a real
  contradiction. Read the code before classing: whether a
  collision is stale prose or a live disagreement is a fact
  about the code, not an opinion.

  ### Anti-padding

  - A conflict is a genuine contradiction, not a tension or a
    neighbor-boundary blur (that is `muddy-boundary`, and only
    when real). Two artifacts on the same topic conflict only if
    both cannot hold.
  - Don't grade severity. Don't propose the resolution for a
    `judgment` finding — that is the owner's; a `mechanical`
    finding states its determined fix, which is not a proposal.
  - Report only contradictions between live artifacts.
```

### Surface inventory

The inverse of every other pass: the others read the corpus and ask
whether the code honors it; this one reads *reality* and asks whether
the corpus claims it. It is the only pass that catches an artifact
whose text honestly under-claims — a decision scoped to one transport
while a second transport ships, an entry point no invariant governs —
because every corpus-anchored check inherits the corpus's own blind
spot.

```
Agent (general-purpose, model: sonnet-5):
  ## Surface-inventory audit

  ### Your job

  Enumerate the project's externally reachable surfaces from the
  code and deployment configuration alone — never from the design
  corpus — then check each against the corpus. Classify findings
  per {{MECHANICAL-VS-JUDGMENT-RULE}} (transcluded below).

  {{MECHANICAL-VS-JUDGMENT-RULE}}

  {{LEAF-AGENT-RULE}}

  ### Build the inventory (from reality only)

  Read the deployment composition (compose files, deploy
  manifests, service definitions) and the code's listener/route
  registrations. List every surface an outside party can reach:
  published ports and what answers on them, HTTP routes and
  their authentication posture, message-broker listeners and
  their transport security, scheduled or event-driven entry
  points. For each, record: surface, transport, authentication
  observed in code/config (not assumed), and the file:line
  evidence.

  ### Check the inventory against the corpus

  For each surface, find the live concepts, stories, and
  decisions whose text governs it (read the corpus only AFTER
  the inventory is built, so the corpus cannot shape what you
  look for). Verdicts per surface:

  - **claimed and consistent** — some artifact governs it and
    the observed posture matches the text. No finding.
  - **claimed and contradicted** — an artifact's text asserts a
    posture the observed surface violates (an "every surface
    authenticates" Choice beside an unauthenticated published
    port). Class `judgment`, category `conflicting`: quote the
    claim and the evidence.
  - **unclaimed** — no artifact's text reaches this surface at
    all. Class `judgment`, category `unspecified`: the corpus
    has a hole exactly the shape of this surface. Record what
    the surface does and which artifacts come closest.

  ### Anti-padding

  - Internal-only surfaces (private-network listeners, in-
    composition addresses) are in scope only when an artifact
    claims a property about them; never file "internal service
    is internal".
  - One finding per surface, not per artifact it collides with.
  - Don't grade severity. Don't propose resolutions for
    judgment findings.
```

## Check

One mechanical floor, and it is deterministic: run
`.ok-planner/bin/audit-check`. If the project has not converged, fall
back to the payload's `scripts/audit-check` and **announce the fallback
verbatim in the report**, on its own line, before the findings:
`note: no vendored checker — using the payload's copy; /ok pins one to
this project`. An unpinned verdict is never delivered silently.

The checker validates, across every estate that carries a corpus: audit
coverage, the audit files' shape on both axes, one-paragraph brevity,
the rule that a non-supported determination names its issue, the
coverage shape's counts agreeing with the determination, and — the
backstop `concept:catalog-toc` names — that each catalog's table of
contents lists exactly its collection's live slugs. Nothing else. A
finding means the judge left something unfinished; re-dispatch it for
those refs rather than editing an audit by hand. Do not re-derive its checks by reading; its output is
authoritative.

**Annotation integrity** rides here too:
`rg -n '@(concept|story|decision):\s*\S+'` across the codebase; every
(kind, slug) pair must resolve to
`.ok-planner/design/<collection>/<slug>.md`. Dangling and kind-mismatched
annotations are mechanical findings — repoint to the renamed slug,
correct the kind prefix, or remove one pointing at a retired artifact.

## Verify

If the judge filed any, invoke `verify-issues`; it makes each one
ruling-ready per its own process. Zero filings → skip, silently.

## Present

```
## ok-planner

Status: all supported | N unsupported, M unclear
Compliance: all compliant | N noncompliant

### Determinations
<Counts first: supported / unsupported / unclear out of the total, and
the batch count that produced them. Then, one line each, every artifact
NOT supported: the ref, the one-sentence reason, and its issue slug.
Supported artifacts are a count, not a list — the corpus is where they
live.>

### Compliance
<One line per noncompliant artifact: the ref, the rule its body breaks,
and the compliant text. These are mechanical and yours to fix; the run
recorded them and fixed nothing. "All compliant" when there are none.>

### Overturned by the judge
<Every determination the judge flipped to supported, one line each: the
ref and what the auditor missed. This is the run's own error rate, and
it belongs in front of the owner. "None" if the judge confirmed
everything it was handed.>

### Cross-artifact and surface findings
<Every finding from the two whole-corpus passes, each carrying its
advisory mechanical/judgment class. These are reported, never recorded
and never filed. Omit when both passes came back clean.>

### Referrals
<The subjective promises the auditors referred out, enumerated from the
audits' Referrals sections: per referral, the promise, what was
established in form, and the discipline that owns the judgment. These
are artifacts of completion, not work items. Omit when there are none.>
```

## Close-out

The run commits its own output — that is what makes an audit a
statement about a commit rather than about a moment. Two commits, both
the ceremony's own act, covering every estate's audits together:

1. Commit the audit corpora and any issue files, with a message naming
   the run and its counts.
2. Stamp that commit's short sha into every audit's `commit:` field and
   make one small follow-on commit. Each audit then names the commit
   whose tree holds both the code it describes and the audit itself —
   the same shape the sprint close-out's `closed:` stamp uses.

Archive nothing and offer nothing else: this run has no sprint, and the
issues it filed stay in the intake until a planning ceremony closes
them.

## Boundaries

- Does not fix anything. A real gap becomes an issue for the owner to
  rule on and a sprint to close; a form defect is recorded and reported
  for whoever holds the report. There is no fixer, no architect, and no
  cycle cap, because there is no loop.
- Does not run the project's test suites, build it, or execute its
  stack. It judges whether the code and tests exist and cover what the
  artifact claims; whether they pass is `/certify-work`'s business.
- Does not compute staleness, maintain a re-audit set, or track what
  changed. Every artifact is read every run.
- Does not touch `.ok-planner/design/`. The corpus's claims are the
  subject under audit, never the thing edited to make an audit pass.
- Does not read `.ok-planner/sprints/` or `history/`. Project records
  are out of context.
- Does not ask the owner anything mid-run. It audits, judges, files,
  presents, and commits.

<!-- Materialized by ok-planner v15.1.1 — suite-owned; overwritten on converge; do not hand-edit. -->
