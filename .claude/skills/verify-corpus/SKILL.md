---
name: verify-corpus
description: "ONLY activated by explicit /verify-corpus slash command. Never auto-triggered by conversation content. The periodic implementation audit: re-reads every live story and decision against the codebase, records a one-paragraph supported/unsupported/unclear determination per artifact, hands everything it could not call supported to a second-opinion judge that finalizes it or files an issue, then commits the corpus and stamps the commit. Two stages, no loop; run on the owner's cadence, never per sprint."
---

# Verify the Corpus (the periodic audit)

The audit runs on the owner's cadence, not at every close. Sprint certification does not touch audits at all: `/certify-work` runs the tests, the sprint-alignment judge, and code review, and says nothing about whether the corpus's claims still hold. This verb is where that question gets asked, over the whole corpus, and answered.

Two stages, and the run ends:

1. **Audit** — every live story and decision, batched to auditors that read carefully and write a one-paragraph determination.
2. **Judge** — everything the auditors could not call `supported`, read independently by one second opinion that either finalizes it or files an issue.

There is no fix loop, no re-audit, no staleness computation, and no third stage. The judge's third outcome is filing an issue, so nothing can come back for another pass. What the run leaves behind is a corpus of current determinations, a commit that names itself, and — where gaps are real — issues in the intake for the owner to rule on.

## What an audit is here

A determination about a **named commit**, in one sentence to one paragraph, per `{{AUDIT-DEFINITION}}` and `{{AUDIT-FILE-FORMAT}}` in `../_shared/artifact-definitions.md`. No citations, no hashes, no line numbers. Every universal the artifact claims comes back as a count plus the population it was taken from, because that is the one form of precision a reader can refute in seconds. Asking whether an audit still holds is a git question — how far HEAD has moved since the commit it names — not a computation.

## Process

1. **Ensure the layout.** Run `mkdir -p .ok-planner/issues .ok-planner/history/issues` and, where `.ok-planner/design/` exists, `mkdir -p .ok-planner/audits/stories .ok-planner/audits/decisions`. Estate convergence is the front door's administration (`/ok`), never this run's.

2. **Resolve the subject.** The run audits the project as it stands. Read `git status`; if the tree is dirty, say so in one line and audit the working tree as it is — the audits name the commit they are recorded in, which is the honest anchor either way. If `.ok-planner/design/` does not exist, tell the caller to run `/discover-design` first and stop.

3. **Enumerate the corpus and batch it.** Every file under `.ok-planner/design/stories/` and `.ok-planner/design/decisions/` is in scope — there is no subset. Group the refs **by locality**, so artifacts whose claims rest on the same code ride in one dispatch and that code is read once: the artifacts about one subsystem, one surface, one service. Five to ten artifacts per batch. Say how many artifacts and how many batches before dispatching.

4. **Dispatch the auditors, in parallel.** One dispatch per batch of `{{IMPLEMENTATION-AUDITOR-PROMPT}}` from `../_shared/implementation-auditor.md`, with `[AUDIT SET]` filled with that batch's refs. Each writes its batch's audit files and reports one line per artifact. Never one agent per artifact, and never a subagent inside an auditor.

5. **Dispatch the judge, once.** Collect every ref the auditors returned as `unsupported` or `unclear`. None → skip this stage and say so. Otherwise dispatch `{{AUDIT-JUDGE-PROMPT}}` from the same file with the full escalation list — each ref, its determination, and its one-line reason, verbatim. The judge finalizes each: confirmed (issue filed, `unsupported` stands), overturned (rewritten as `supported`), or undecidable (issue filed, `unclear` stands). It is terminal; whatever it returns is the run's answer.

6. **Verify the mechanical floor.** One invariant, and it is a grep rather than a checker: no audit may say `unsupported` or `unclear` without an `issue:` slug. Run `.ok-planner/bin/audit-check` — it validates the audit files' shape and that one rule, and nothing else. A finding means the judge left something unfinished; re-dispatch it for those refs rather than editing an audit by hand.

7. **Verify the issues are ruling-ready.** If the judge filed any, invoke `verify-issues`; it makes each one ruling-ready per its own process. Zero filings → skip, silently.

8. **Present** (see **The presentation**), then **commit and stamp** (see **The close-out**).

## The presentation

Compose it in full — it is a report, so it is delivered whole rather than paced:

```
# Audit — <project> at <short sha or "working tree">

Status: all supported | N unsupported, M unclear

## Determinations
<Counts first: supported / unsupported / unclear out of the total, and
the batch count that produced them. Then, one line each, every artifact
NOT supported: the ref, the one-sentence reason, and its issue slug.
Supported artifacts are a count, not a list — the corpus is where they
live.>

## Overturned by the judge
<Every determination the judge flipped to supported, one line each: the
ref and what the auditor missed. This is the run's own error rate, and
it belongs in front of the owner. "None" if the judge confirmed
everything it was handed.>

## Referrals
<The subjective promises the auditors referred out, enumerated from the
audits' Referrals sections: per referral, the promise, what was
established in form, and the discipline that owns the judgment. These
are artifacts of completion, not work items. Omit when there are none.>

## Issues filed
<Every issue this run created, by path, with the verify pass's outcome
per issue: answered by the corpus and closed with the citation, or
verified and awaiting the owner's ruling. These are the next planning
ceremony's business, not this run's.>
```

## The close-out

The run commits its own output — that is what makes an audit a statement about a commit rather than about a moment. Two commits, both this verb's own act:

1. Commit the audit corpus and any issue files, with a message naming the run and its counts.
2. Stamp that commit's short sha into every audit's `commit:` field and make one small follow-on commit. Each audit then names the commit whose tree holds both the code it describes and the audit itself — the same shape the sprint close-out's `closed:` stamp uses.

Archive nothing and offer nothing else: this run has no sprint, and the issues it filed stay in the intake until a planning ceremony closes them.

## What this skill does NOT do

- Does not fix anything. A real gap becomes an issue for the owner to rule on and a sprint to close; there is no fixer, no architect, and no cycle cap, because there is no loop.
- Does not run the project's test suites, build it, or execute its stack. It judges whether the code and tests exist and cover what the artifact claims; whether they pass is `/certify-work`'s business.
- Does not compute staleness, maintain a re-audit set, or track what changed. Every artifact is read every run.
- Does not touch `.ok-planner/design/`. The corpus's claims are the subject under audit, never the thing edited to make an audit pass.
- Does not read `.ok-planner/sprints/` or `history/`. Project records are out of context.
- Does not ask the owner anything mid-run. It audits, judges, files, presents, and commits.

<!-- Materialized by ok-planner v14.4.0 — suite-owned; overwritten on converge; do not hand-edit. -->
