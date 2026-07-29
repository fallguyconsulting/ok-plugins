---
audit: single-source-transclusion
artifact: decision:single-source-transclusion
determination: satisfied
audited: 2026-07-28T00:00:00Z
artifact-hash: sha256:a7816b62a9dd
---

# Whether the planner's canonical rule text lives once in one shared directory, transcluded by token, with no block defined twice

Amended. The design artifact's hash is unchanged. All five whole-file
pins moved this pass, because the Release v11.2.0 commit added four more
canonical blocks to the same five files: `READ-ONLY-REVIEWER-RULE` in
`dispatch-discipline.md`, `SPRINT-ALIGNMENT-PROMPT` in
`certification-core.md`, and `DECIDABILITY-BOUNDARY` and
`INSPECTION-REGISTRY-FORMAT` in `artifact-definitions.md` (re-derived by
grepping `^### {{` across the directory rather than assumed from the
diff). The block count moves 25 → 29: `artifact-definitions.md` 15 → 17,
`dispatch-discipline.md` 2 → 3, `certification-core.md` 6 → 7,
`design-doc-compliance-reviewer.md` and `implementation-auditor.md`
unchanged at 1 each. The directory still holds exactly the same five
files — no sixth appeared — and every new block landed inside a file the
Choice already names, not a new one, so clause 1's file-level enumeration
is unaffected. `checks/token-resolution` was re-run rather than trusted:
it exits 0 on the tree as it stands, so all 29 occurrences are 29
distinct names with no token defined twice and no token used with no
definition — clause 4's uniqueness invariant re-verified mechanically,
not by re-deriving the count by eye. The vendored rendering under
`.claude/skills/_shared/` was independently re-counted too and carries the
same 29 distinct headings. Nothing about clauses 2 or 3 (token-pull
convention, main-loop reference-not-restate) is touched by an addition of
new blocks to existing files. Determination and reasoning stand; the
numeric claims naming "25" are updated to "29" below and citations
regenerated.

Refreshed. The two whole-file pins on `artifact-definitions.md` and
`certification-core.md` moved again this cycle from the same fix loop's
prose edits (the two-path intake wording, inspector step 4b's base-ref
addition); re-counting `^### {{` across the directory still finds 29
occurrences and 29 distinct names, no sixth file appeared, and
`checks/token-resolution` exits 0. No block moved between files and none
was added or removed. Citations regenerated; nothing else touched.

Refreshed again. The design artifact's hash is unchanged. The one whole-file
pin on `certification-core.md` moved this pass from the owner-ratified
rewording of the review-fix loop's cycle cap (the exit rule and the "Two
paths reach the intake" paragraph) — prose inside the existing
`{{CERTIFY-REVIEW-FIX-LOOP}}` block, not a new heading. Re-counted directly:
`^### {{` across the directory still finds 29 occurrences and 29 distinct
names, no sixth file appeared, and `checks/token-resolution` exits 0. No
block moved, was added, or was removed. Citation regenerated; nothing else
touched.

## Claims

**Title — "Canonical rule text lives once and is transcluded into prompts."**
Holds as a description of the tree as it stands: 25 canonical blocks, each
defined by exactly one `### {{TOKEN}}` heading, all under one directory, pulled
into skill prompts by token.

**Choice clause 1 — "Every canonical definition, template, and rule the planner's
skills share is defined exactly once, in one shared directory of canonical files
— the artifact definitions, the shared reviewer prompt, the certification core,
the dispatch discipline, the implementation-auditor prompt."** Honored, with the
population enumerated from reality by listing the directory rather than trusting
the artifact. `skills/_shared/` holds exactly five `.md` files and nothing else,
and they are exactly the five the Choice names: `artifact-definitions.md` (17
blocks), `design-doc-compliance-reviewer.md` (1), `certification-core.md` (7),
`dispatch-discipline.md` (3), `implementation-auditor.md` (1). Counting
`### {{TOKEN}}` headings across the directory yields 29 occurrences and 29
distinct names — so each occurs exactly once, checked by count rather than by
eye. All five are pinned below, so a sixth file or a moved block re-opens this
audit. The vendored rendering in `.claude/skills/_shared/` carries the same five
files and the same 29 distinct headings.

Re-derived this cycle rather than carried, because the sprint under certification
added canonical blocks a second time running. The block count moved 24 → 25 → 29:
the latest four — `{{READ-ONLY-REVIEWER-RULE}}`, `{{SPRINT-ALIGNMENT-PROMPT}}`,
`{{DECIDABILITY-BOUNDARY}}` and `{{INSPECTION-REGISTRY-FORMAT}}` — each landed
inside one of the same five named files (`dispatch-discipline.md`,
`certification-core.md` once, `artifact-definitions.md` twice), never in a
sixth. The file count is unchanged at five, and the Choice's enumeration is of
files, not blocks, so a new block inside a named file does not widen it. The
clause's most refutable reading — that the shared directory could grow a sixth
file the Choice never names — was checked directly (a directory listing) and
does not obtain. Honored.

**Choice clause 2 — "skill prompts pull each block in by named double-braced
token, replaced at dispatch-assembly time by the running model."** Honored. The
definitions file documents the convention ("Each `###` heading is a token name;
the body under it is what gets inlined"), the skills embed the tokens, and the
auditor prompt, both certify gates, and `plan-sprint`'s reviewer all transclude
by token. The rebuilt auditor prompt is a live instance rather than a legacy one:
its own body carries `{{AUDIT-DEFINITION}}` and `{{AUDIT-FILE-FORMAT}}` as
placeholders and states that they transclude from the definitions file — it does
not restate the audit format it just gained a new `## Notes` section for.

**Choice clause 3 — "skills running in the main loop reference the shared files
directly instead of restating them."** Honored. The definitions file states the
two consumption modes explicitly, and the certification core repeats the split
for its own blocks (the fix loop and the presentation are read-and-apply; the
inspector, fixer, architect, and code-review blocks are dispatches);
`certify-work` states that everything that is not scope is shared verbatim with
`certify-all` and defined once in that file.

**Choice clause 4 — "Definitions are never restated inline in a skill, and no
block is defined in more than one place."** Honored, and backed by a mechanism
rather than by authoring discipline alone. `checks/token-resolution` accumulates
every definition site into `defined.setdefault(m.group(1), []).append(...)` and
then fails on any token with more than one site, naming each site; the negative
direction — a token used with no heading anywhere — fails too. Both directions
were exercised on the tree as it stands: the check exits 0. The check carries
this decision's `@decision:` annotation.

The one honest limit, recorded rather than charged: the check globs
`plugins/ok/families/ok-planner/skills/**`, so it governs the family source and
not the vendored rendering under `.claude/skills/_shared/`. That is the right
scope for a Choice about "the planner's skills", since the vendored copy is a
derived artifact the converge core overwrites wholesale, but it does mean a
duplicate introduced by hand into a consumer's vendored copy would not be caught
by this check — it would be caught by the converge core's fidelity comparison
instead. Nothing in the artifact claims otherwise. The vendored copy was
independently counted this cycle and carries the same 25 distinct headings.

**Rationale — "The writer, the checker, and the mutator of the same artifact kind
each see only their own dispatched prompt; defining the rules once and
transcluding keeps the wording from drifting between the agent that writes and
the agent that checks."** Holds as a property: the writer (`plan-sprint`,
`discover-design`), the checker (the compliance reviewer, the implementation
auditor), and the mutator (the fixer) all draw the same blocks from the same
files, so the targeted drift cannot occur. This cycle's audit-format change is
the property working: the `## Notes` ledger was added once, in
`{{AUDIT-FILE-FORMAT}}`, and reaches the auditor and every other consumer through
the token rather than through parallel edits.

**Rationale — "Editorially, one place per block is what keeps canonical wording
canonical: a second definition of the same block is a second thing to remember to
edit, and the copy nobody remembers is the one that ships."** Honored. It is an
editorial argument for the Choice rather than a capability claim about the build,
so there is no enforcement property in it to refute — and the enforcement it does
not claim exists anyway, which is the sound direction for the two to diverge.

**Alternatives — restate per skill; build-time template assembly; one monolithic
definitions file.** All three are genuine roads not taken. The third is
additionally consistent with what shipped: the corpus chose five files plus a
per-block uniqueness check over one file, and that check exists, so the
alternative's stated reason for rejection ("buying nothing the per-block
uniqueness check does not already guarantee") is true rather than aspirational.

## Determination

**satisfied.** The Choice is an accurate description of the shared layer — the
five named files are exactly the five that exist, and all 29 blocks are singly
defined, verified by counting occurrences against distinct names in both the
family source and the vendored rendering. The uniqueness check counts definition
sites and fails on more than one; it exits 0 on the tree as it stands.

Re-derived, not carried: this audit went stale because all five whole-file
pins moved this pass. Four new canonical blocks landed across three files
(`READ-ONLY-REVIEWER-RULE` in `dispatch-discipline.md`,
`SPRINT-ALIGNMENT-PROMPT` in `certification-core.md`, `DECIDABILITY-BOUNDARY`
and `INSPECTION-REGISTRY-FORMAT` in `artifact-definitions.md`), and the
remaining two — `design-doc-compliance-reviewer.md` and
`implementation-auditor.md` — moved not because they gained a block, but
because both added new `{{...}}` token *references* to blocks the sprint
added elsewhere (`{{READ-ONLY-REVIEWER-RULE}}`, `{{DECIDABILITY-BOUNDARY}}`),
read directly rather than assumed: neither restates a definition inline —
each pulls it in by token exactly as clause 2 requires, which is this
decision's own mechanism working, not a threat to it. The change that
actually bore on the claim was the four new blocks, and each was checked
directly: every one lives inside a file the Choice already names, the
directory is still five files, and the block count moved from 25 to 29 with
no name defined twice (`checks/token-resolution` re-run, exits 0). Nothing
about the decision moved.

This stops holding if: the duplicate-detection loop is removed or weakened back to
a membership test (the `cite-span` over `for token, sites in sorted(defined.items())`
and the anchor on the `setdefault` accumulation both break); the resolvability
test is removed (its `cite-span` breaks); the shared directory gains a sixth file,
loses one, or a block moves between them (all five whole-file pins and the pin on
the check break); a definition is restated inline in a skill body, which nothing
mechanical catches — the maintenance assertion covers only the sentence forbidding
it; or the check's glob stops covering the planner's skills.

## Citations

- cite: checks/token-resolution :: "# @decision: single-source-transclusion"
- cite: checks/token-resolution :: "defined.setdefault(m.group(1), []).append"
- cite-span: checks/token-resolution :: "for token, sites in sorted(defined.items()):" +6 sha256:68b9708322ac
- cite-span: checks/token-resolution :: "            if token not in defined and token not in META:" +3 sha256:1fb1a8651f47
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "This file is the single source of truth."
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "Each `###` heading is a token name; the body under it is what gets inlined"
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "it does NOT restate the definitions inline"
- cite: plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md :: "### {{DESIGN-DOC-COMPLIANCE-REVIEWER-PROMPT}}"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "### {{CERTIFY-REVIEW-FIX-LOOP}}"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "### {{CHANGE-INSPECTOR-PROMPT}}"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "Defining the machinery once here is what keeps the gates from drifting apart"
- cite: plugins/ok/families/ok-planner/skills/_shared/dispatch-discipline.md :: "### {{LEAF-AGENT-RULE}}"
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "### {{IMPLEMENTATION-AUDITOR-PROMPT}}"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "Everything that is not scope is shared verbatim with"
- cite-node: checks/token-resolution @ sha256:0b5f17a4fab5
- cite-node: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md @ sha256:4d1c78ea8291
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md @ sha256:f42b50f44a66
- cite-node: plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md @ sha256:1f25d28d4ffa
- cite-node: plugins/ok/families/ok-planner/skills/_shared/dispatch-discipline.md @ sha256:acb7a2417dd3
- cite-node: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md @ sha256:049ea0635856
