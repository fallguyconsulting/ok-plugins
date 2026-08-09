---
name: audit
description: "ONLY activated by explicit /audit slash command. Never auto-triggered by conversation content. The suite's periodic audit, covering every estate this project has: re-reads every live artifact against its own authoring rules and against the codebase, records both axes as a per-artifact determination, hands everything it could not call supported to a second-opinion judge that finalizes it or files an issue, then commits the audit corpora and stamps the commit. Two stages, no loop; run on the owner's cadence, never per sprint."
---

# Audit (the periodic run)

The audit runs on the owner's cadence, not at every close. Certification
does not touch audits at all: `/certify-work` runs the tests, the
alignment producers, and code review, and says nothing about whether a
corpus's claims still hold. This verb is where that question gets asked,
over every corpus the project has, and answered.

This is a **suite verb**, not any one family's. One canonical body
covers whichever skill families the project integrates, and which those
are is read from the filesystem when the verb runs — never fixed when
it was vendored.

Two stages, and the run ends:

1. **Determine** — every live artifact, batched to auditors that read
   carefully and write a determination.
2. **Judge** — everything the auditors could not call `supported`, read
   independently by one second opinion that either finalizes it or
   files an issue.

There is no fix loop, no re-audit, no staleness computation, and no
third stage. The judge's third outcome is filing an issue, so nothing
can come back for another pass. What the run leaves behind is a corpus
of current determinations, a commit that names itself, and — where gaps
are real — issues in the intake for the owner to rule on.

## The two axes

Every determination answers two independent questions about one
artifact: **does it comply with its own authoring rules?** and **does
the codebase support what it claims, at this commit?** Both are
recorded, because they genuinely come apart — a malformed artifact may
be accurately implemented, and a well-formed one may be implemented
nowhere. Only the support axis escalates to the judge; a compliance
defect is mechanical by construction, so it is recorded and reported
for whoever holds the report to fix.

The canonical shape is `{{AUDIT-DEFINITION}}` and
`{{AUDIT-FILE-FORMAT}}` in `../_shared/artifact-definitions.md`. No
citations, no hashes, no line numbers. Every universal an artifact
claims comes back as a count plus the population it was taken from,
because that is the one form of precision a reader can refute in
seconds. Asking whether an audit still holds is a git question — how
far HEAD has moved since the commit it names — not a computation.

## Resolve the estates

Every family's presence is a filesystem check at the project root
(nearest `.git` ancestor), never an inference:

| estate | family |
|---|---|
| `.ok-planner/` | ok-planner |
| `.ok-plumbline/` | ok-plumbline |
| `.ok-workspaces/` | ok-workspaces |

For each estate present, read `<estate>/ceremony/audit.md` — the
family's **ceremony surface**. That file, not this one, says which
collection the family exposes, how its determinations are shaped, and
what else it checks; this body never carries family-specific
instructions and never improvises them. A surface that is missing where
its estate exists is a conformance defect: report it and carry on with
the rest.

No estate at all → say so and stop; there is nothing to audit.

**`.ok-planner/` is required for this verb.** The audit definition and
file format this body transcludes, the auditor and judge prompts, the
issue-file format the judge files by, and the `audit-check` binary the
Check phase runs are all vendored or materialized by the planner
estate's converge. Without it, say so and stop — a run that cannot
record a determination or file a confirmed gap is not an audit.

Tell the owner which estates are in scope, and how many artifacts each
contributes, before dispatching anything.

## The spine

1. **Layout** — each family ensures its own directories exist. Estate
   convergence is the front door's administration (`/ok`), never this
   run's.
2. **Resolve the subject.** The run audits the project as it stands.
   Read `git status`; if the tree is dirty, say so in one line and
   audit the working tree as it is — the audits name the commit they
   are recorded in, which is the honest anchor either way.
3. **Enumerate** — each surface names its live artifacts and how to
   batch them. Group by locality so artifacts whose claims rest on the
   same code ride in one dispatch and that code is read once.
4. **Determine** — dispatch the auditors in parallel, one per batch,
   per each surface's instructions. Never one agent per artifact, and
   never a subagent inside an auditor.
5. **Judge** — collect every escalation from every estate and dispatch
   **one** judge over the lot. One judge per run, not one per family:
   its independence is what the stage buys, and splitting it by estate
   buys nothing and costs a read.
6. **Sweep** — the whole-corpus passes each surface declares. These
   report findings in-context; they write no determination and file
   nothing.
7. **Check** — the mechanical floor. Run the vendored audit checker,
   which validates every estate's audit files in one pass. A finding
   means the judge left something unfinished; re-dispatch it for those
   refs rather than editing an audit by hand.
8. **Verify** — if the judge filed any issues, each surface's
   post-filing step makes them ruling-ready. Zero filings → skip,
   silently.
9. **Present** — the report below.
10. **Close-out** — commit, then stamp.

## The presentation

Compose it in full — it is a report, so it is delivered whole rather
than paced:

```
# Audit — <project> at <short sha or "working tree">

Estates: <the ones in scope, and the artifact count each contributed>

<Then, per estate, the section its ceremony surface defines.>

## Issues filed
<Every issue this run created, by path, with the verify pass's outcome
per issue: answered by the corpus and closed with the citation, or
verified and awaiting the owner's ruling. These are the next planning
ceremony's business, not this run's.>
```

## The close-out

The run commits its own output — that is what makes an audit a
statement about a commit rather than about a moment. Two commits, both
this verb's own act, covering every estate's audits together:

1. Commit the audit corpora and any issue files, with a message naming
   the run and its counts.
2. Stamp that commit's short sha into every audit's `commit:` field and
   make one small follow-on commit. Each audit then names the commit
   whose tree holds both the code it describes and the audit itself.

Archive nothing and offer nothing else: this run has no sprint, and the
issues it filed stay in the intake until a planning ceremony closes
them.

## What this skill does NOT do

- Does not carry family knowledge. Everything family-specific comes
  from the ceremony surfaces in the estates present, and nothing else.
- Does not fix anything. A real gap becomes an issue for the owner to
  rule on and a sprint to close; a form defect is recorded and
  reported. There is no fixer, no architect, and no cycle cap, because
  there is no loop.
- Does not run the project's test suites, build it, or execute its
  stack. It judges whether the code and tests exist and cover what an
  artifact claims; whether they pass is `/certify-work`'s business.
- Does not compute staleness, maintain a re-audit set, or track what
  changed. Every artifact is read every run.
- Does not edit any corpus. The corpora's claims are the subject under
  audit, never the thing edited to make an audit pass.
- Does not read project records — sprints, sketches, history. Those are
  out of context.
- Does not ask the owner anything mid-run. It audits, judges, files,
  presents, and commits.
- Does not converge an estate, materialize a file, or repair a family's
  presence. That is `/ok`, always a user action.

<!-- Materialized by ok v15.0.0 — suite-owned; overwritten on converge; do not hand-edit. -->
