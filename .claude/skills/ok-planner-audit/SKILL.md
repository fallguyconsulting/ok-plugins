---
name: ok-planner-audit
description: "ONLY activated by explicit /ok-planner-audit slash command or by the /certify-all gate, which runs it as a producer. A pure reporter: findings return in-context, nothing is written. Never auto-triggered by conversation content."
---

# Audit the Design Corpus

Whole-corpus audit of the project's durable design docs under `.ok-planner/design/`. Audit is a **pure reporter** — the corpus-side reviewer, the exact peer of a code reviewer: it classifies every finding `mechanical` or `judgment` per `{{MECHANICAL-VS-JUDGMENT-RULE}}` in `../_shared/artifact-definitions.md` (the line is intent, not file surface; the class is advisory context for whoever consumes the report, never routing), returns everything in-context, and writes nothing. Inside certification it is a producer feeding the review-fix loop, whose architect alone promotes genuine forks to the issue intake; run standalone, its report goes to the human who invoked it, who decides what to fix and what to file.

This is ok-planner's `audit` verb in the ok-plugins integration contract: read-only against the corpus and the code, writing nothing — its findings return in-context to the caller. It is invoked by the `/certify-all` gate as a producer, and by humans ad hoc.

## Process

1. Create nothing. This verb is read-only against the project — it does not even ensure its own layout: if `.ok-planner/issues/` or `.ok-planner/history/issues/` is absent, report that in the findings (the front door's administration materializes the layout) and carry on. (When assembling the dispatches below, `{{LEAF-AGENT-RULE}}` transcludes from `../_shared/dispatch-discipline.md`; the other tokens from `../_shared/artifact-definitions.md`.)
2. Verify `.ok-planner/design/concepts/` exists. If not, tell the caller to run `/discover-design` first and stop.

3. **Pass 1 — compliance.** Read `../_shared/design-doc-compliance-reviewer.md` and dispatch the `{{DESIGN-DOC-COMPLIANCE-REVIEWER-PROMPT}}` block as a subagent in whole-corpus mode (the scope block is given verbatim in that file). The reviewer classifies each finding `mechanical` or `judgment`.

4. **Pass 2 — coverage + intent-drift + annotation integrity.** Dispatch a second subagent:

   ```
   Agent (general-purpose, model: sonnet-5):
     ## Proof coverage + intent-drift audit

     ### Your job

     Audit the project for proof coverage of every live story, for
     intent drift in existing proofs, and for the mechanical health
     of the implementation-audit corpus,
     per the canonical {{PROOF-PROTECTION-RULE}}, {{AUDIT-DEFINITION}} and
     {{ANNOTATION-INTEGRITY-RULE}} in
     `../_shared/artifact-definitions.md` (transcluded below).
     Classify each finding `mechanical` or `judgment` per
     {{MECHANICAL-VS-JUDGMENT-RULE}} (transcluded below): the line
     is intent, not file surface — a corpus-side fix is mechanical
     when the compliant text is determined and no commitment
     changes.

     {{PROOF-PROTECTION-RULE}}

     {{AUDIT-DEFINITION}}

     {{ANNOTATION-INTEGRITY-RULE}}

     {{MECHANICAL-VS-JUDGMENT-RULE}}

     {{LEAF-AGENT-RULE}}

     ### Coverage check (cheap, mechanical to detect; judgment to resolve)

     For every `.md` file directly under `.ok-planner/design/stories/`
     (live stories only), read the slug. Run `rg -n '@story:\s*<slug>'`
     across the codebase (excluding `.ok-planner/`, `.git/`, build
     outputs, vendored dependencies).

     - Zero matches: **coverage gap** — class `judgment` (only the
       owner can decide restore-vs-deprecate). Record the slug, the
       story's `Proof:` field text, and both candidates.
     - One or more matches: list the files for the drift check.

     Decisions carry no proofs; their verification is the
     implementation-audit corpus, checked next.

     ### Audit-corpus health (mechanical floor)

     Run the vendored checker — `.ok-planner/bin/audit-check`. If the
     project has not converged, fall back to the payload's
     `scripts/audit-check` and **announce the fallback verbatim in
     your report**, on its own line, before the findings:
     `note: no vendored checker — using the payload's copy; /ok pins
     one to this project`. An unpinned verdict is never delivered
     silently. Fold the checker's findings in verbatim, class
     `mechanical` for malformed/stale/missing entries (the fix is
     determined: re-audit) and class `judgment` for
     `violated-unlinked` (a standing violation needs fixing or an
     owner ruling). Do not re-derive its checks by reading; it is
     deterministic and its output is authoritative. Your judgment
     layer sits above it: whether a satisfied audit's citations
     actually support its determination is the certification
     auditor's job, not yours — flag only audits whose Claims
     section visibly does not address every normative sentence of
     its artifact (a quantifier in the artifact with no claim line
     enumerating its population is the tell).

     ### Intent-drift check (judgment)

     For every annotated story-proof file found: read it in full,
     then read the story's `Proof:` field (and Acceptance /
     Falsifier for context). Verdict:

     - **satisfies** — no finding.
     - **does not satisfy** — class `judgment`: record the proof path,
       what the Proof field requires, what the proof actually
       exhibits, and the candidates (update the proof to restore
       intent | mutate the story's Proof field at next sprint).
     - **uncertain** — class `judgment`, for human adjudication.

     ### Annotation integrity (mechanical)

     `rg -n '@(concept|story|decision):\s*\S+'` across the codebase.
     Every (kind, slug) pair must resolve to
     `.ok-planner/design/<kind>s/<slug>.md`.
     Dangling and kind-mismatched annotations are class `mechanical`
     when the fix is evident (repoint to the renamed slug / correct
     the kind prefix / remove for a retired artifact); `judgment`
     only if which artifact was meant is genuinely undecidable.

     ### Output format

     One entry per finding: heading, class, evidence, and for
     judgment findings the candidates. Status line first:
     `Status: Approved | Issues Found`.

     ### Anti-padding

     - Don't flag proofs that satisfy their Proof field.
     - Don't grade severity.
     - Don't propose new stories or decisions; this audit is
       coverage-only, not discovery.
   ```

5. **Pass 3 — cross-artifact consistency.** Dispatch a third subagent. This is the pass no per-artifact check can perform: a contradiction between two artifacts is invisible to a check that reads each one alone, so a decision that mandates a mechanism another decision forbids passes coverage, drift, and compliance while the corpus quietly disagrees with itself.

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
     - A decision or concept that forecloses a user-outcome a story's
       Acceptance or Falsifier promises.
     - A `Proof:` field whose stated check would fail against another
       live artifact's mandated state.

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

6. **Pass 4 — surface inventory.** Dispatch a fourth subagent. This is the inverse of every other pass: the others read the corpus and ask whether the code honors it; this one reads *reality* and asks whether the corpus claims it. It is the only pass that catches an artifact whose text honestly under-claims — a decision scoped to one transport while a second transport ships, an entry point no invariant governs — because every corpus-anchored check inherits the corpus's own blind spot.

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

7. **Report to the caller** — machine-readable, in-context:

   ```
   Status: clean | findings

   ## Findings
   <every finding entry from every pass, verbatim, each carrying its
   advisory mechanical/judgment class and, for judgment findings,
   the candidates>
   ```

   The caller decides what happens next; the audit routes nothing. Inside certification, every finding enters the review-fix loop — the fixer fixes (rules-determined, intent-preserving corpus repairs included, each surfaced in the presentation's Divergences), and only the architect's confirmed forks are promoted to `.ok-planner/issues/`. A human running `/ok-planner-audit` standalone fixes what they choose and files what they judge fork-worthy themselves. Either way, re-run `/ok-planner-audit` after fixes until it reports clean.

## What this skill does NOT do

- Does not audit code quality. It audits the corpus and the code↔corpus links only.
- Does not read `.ok-planner/sprints/` or `.ok-planner/history/` — project records are out of context; consult them only when the human explicitly directs it.
- Does not fix anything — not even mechanical findings. The caller fixes; the audit re-verifies.
- Does not execute proofs — that's `/prove`. The intent-drift check reads; it never runs.
- Does not touch the issue intake — no filing, no editing, no closing. Promotion to the intake is the certification architect's act (or a human's); verification is `/verify-issues`; closure is `/plan-sprint`.

<!-- Materialized by ok-planner v11.1.0 — suite-owned; overwritten on converge; do not hand-edit. -->
