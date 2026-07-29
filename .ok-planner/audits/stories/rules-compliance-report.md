---
audit: rules-compliance-report
artifact: story:rules-compliance-report
determination: satisfied
audited: 2026-07-29T12:30:00Z
artifact-hash: sha256:ffb61129a8aa
---

# Each family ships a read-only compliance report that splits mechanical fixes from judgment calls

## Confirmation

Satisfied. The suite carries three skill families (the contract's conformance
section is the enumeration), and each vendors an `audit` verb that reports drift
from that family's declared rules, writes nothing, and classifies every finding
mechanical or judgment.

- **ok-plumbline** — the verb runs the project's pinned lint over the whole
  project and prints the total, the breakdown by check code, and the worst
  files; its reporting section then requires the findings be presented split
  into *mechanical* (residue, dividers, TODOs, commented-out code, a slug a
  typo away from resolving) and *judgment* (a comment naming a real constraint,
  a docstring that may warrant the opt-in marker, a citation whose artifact may
  need creating), with remediation withheld until the owner authorizes a scope.
- **ok-workspaces** — the verb sweeps the four mechanical rules the discipline
  admits against the committed profile and reports findings with file:line
  evidence; its output section carries the same two classes with a stated
  tie-break (unclear ⇒ judgment) and the instruction to report and stop.
- **ok-planner** — the corpus verb is read-only against corpus and code, writes
  nothing, returns findings in-context, and classifies each finding mechanical
  or judgment.
- **Read-only, remediation at the owner's direction.** The plumbline verb is
  exercised end to end in the adoption run: it is invoked through its own
  `## Run` block over a seeded backlog, its category and file groupings are
  asserted against the seeded defects, and the working tree is compared before
  and after to assert the run mutated nothing. The classification and the
  proposal dialogue are prompt-realized in the verbs' documents, cited above.

## Referrals

- referral: whether findings are classified correctly and the report reads
    clearly enough for an owner to authorize a scope
  clause: "grouped so I can tell mechanical fixes from structural questions"
  delivered: an explicit two-class taxonomy with per-class examples in each
    family's audit verb, plus a fixed report shape — cited below
  discipline: human-review

## Citations

- cite-node: docs/integration-contract.md#the-ok-suite-integration-contract.current-conformance @ sha256:377e6fd4d22b
- cite-node: plugins/ok/families/ok-plumbline/skills/audit/SKILL.md#ok-plumbline-audit.run @ sha256:b608d4655b00
- cite-node: plugins/ok/families/ok-plumbline/skills/audit/SKILL.md#ok-plumbline-audit.reporting-to-the-user @ sha256:2926dca0c818
- cite-node: plugins/ok/families/ok-workspaces/skills/audit/SKILL.md#audit-workspace-discipline-compliance.checks @ sha256:4a2c86c59d43
- cite-node: plugins/ok/families/ok-workspaces/skills/audit/SKILL.md#audit-workspace-discipline-compliance.output @ sha256:b7728b51fef5
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "This is ok-planner's `audit` verb in the ok-plugins integration contract: read-only against the corpus and the code, writing nothing — its findings return in-context to the caller. It is invoked by the `/certify-all` gate as a producer, and by humans ad hoc."
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#run_adoption_proof @ sha256:74f88c33a7bd
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#skill_run_block @ sha256:920cc884266d
