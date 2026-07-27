---
audit: single-source-transclusion
artifact: decision:single-source-transclusion
determination: satisfied
audited: 2026-07-27T00:00:00Z
artifact-hash: sha256:a7816b62a9dd
---

# Whether the planner's canonical rule text lives once in one shared directory, transcluded by token, with no block defined twice

## Claims

**Title — "Canonical rule text lives once and is transcluded into prompts."**
Holds as a description of the tree as it stands: 24 canonical blocks, each
defined by exactly one `### {{TOKEN}}` heading, all under one directory, pulled
into skill prompts by token.

**Choice clause 1 — "Every canonical definition, template, and rule the planner's
skills share is defined exactly once, in one shared directory of canonical files
— the artifact definitions, the shared reviewer prompt, the certification core,
the dispatch discipline, the implementation-auditor prompt."** Honored, with the
population enumerated from reality by listing the directory rather than trusting
the artifact. `skills/_shared/` holds exactly five `.md` files and nothing else,
and they are exactly the five the Choice names: `artifact-definitions.md` (15
blocks), `design-doc-compliance-reviewer.md` (1), `certification-core.md` (5),
`dispatch-discipline.md` (2), `implementation-auditor.md` (1). Counting
`### {{TOKEN}}` headings across the directory yields 24 occurrences and 24
distinct names — so each occurs exactly once, checked by count rather than by
eye. All five are pinned below, so a sixth file or a moved block re-opens this
audit. The vendored rendering in `.claude/skills/_shared/` carries the same five
files. Honored.

**Choice clause 2 — "skill prompts pull each block in by named double-braced
token, replaced at dispatch-assembly time by the running model."** Honored. The
definitions file documents the convention ("Each `###` heading is a token name;
the body under it is what gets inlined"), the skills embed the tokens, and the
auditor prompt, both certify gates, and `plan-sprint`'s reviewer all transclude
by token.

**Choice clause 3 — "skills running in the main loop reference the shared files
directly instead of restating them."** Honored. The definitions file states the
two consumption modes explicitly, and the certification core repeats the split
for its own blocks (the fix loop and the presentation are read-and-apply; the
fixer, architect, and code-review blocks are dispatches); `certify-work` states
that everything that is not scope is shared verbatim with `certify-all` and
defined once in that file.

**Choice clause 4 — "Definitions are never restated inline in a skill, and no
block is defined in more than one place."** Honored, and — unlike at the last
audit — now backed by a mechanism rather than by authoring discipline alone.
`checks/token-resolution` no longer collects heading names into a set that
discards multiplicity; it accumulates every definition site into
`defined.setdefault(m.group(1), []).append(...)` and then fails on any token with
more than one site, naming each site. Verified by construction rather than by
reading: on a scratch copy of `checks/` and `skills/` with a second
`### {{LEAF-AGENT-RULE}}` heading appended to `artifact-definitions.md`, the
check exits 1 and prints "{{LEAF-AGENT-RULE}} is defined 2 times in
skills/_shared/", naming both files and line numbers. On the tree as it stands it
exits 0. The negative direction is unchanged and still holds: a token used with
no heading anywhere fails. The check's header comment now states both directions
accurately — "an unresolved token and a duplicated block both fail" — and it
carries this decision's `@decision:` annotation.

The one honest limit, recorded rather than charged: the check globs
`plugins/ok/families/ok-planner/skills/**`, so it governs the family source and
not the vendored rendering under `.claude/skills/_shared/`. That is the right
scope for a Choice about "the planner's skills", since the vendored copy is a
derived artifact the converge core overwrites wholesale, but it does mean a
duplicate introduced by hand into a consumer's vendored copy would not be caught
by this check — it would be caught by the converge core's fidelity comparison
instead. Nothing in the artifact claims otherwise.

**Rationale — "The writer, the checker, and the mutator of the same artifact kind
each see only their own dispatched prompt; defining the rules once and
transcluding keeps the wording from drifting between the agent that writes and
the agent that checks."** Holds as a property: the writer (`plan-sprint`,
`discover-design`), the checker (the compliance reviewer, the implementation
auditor), and the mutator (the fixer) all draw the same blocks from the same
files, so the targeted drift cannot occur.

**Rationale — "Editorially, one place per block is what keeps canonical wording
canonical: a second definition of the same block is a second thing to remember to
edit, and the copy nobody remembers is the one that ships."** Honored, and this
is the sentence that replaced the prior audit's violation ground. It is now an
editorial argument for the Choice rather than a capability claim about the build,
so there is no enforcement property left in it to refute — and the enforcement it
no longer claims is in fact there, which is the sound direction for the two to
diverge.

**Alternatives — restate per skill; build-time template assembly; one monolithic
definitions file.** All three are genuine roads not taken. The third is
additionally consistent with what shipped: the corpus chose five files plus a
per-block uniqueness check over one file, and that check now exists, so the
alternative's stated reason for rejection ("buying nothing the per-block
uniqueness check does not already guarantee") is true rather than aspirational.

## Determination

**satisfied.** The Choice is an accurate description of the shared layer — the
five named files are exactly the five that exist, and all 24 blocks are singly
defined, verified by counting occurrences against distinct names. Both defects
prior audits recorded are closed: the file-count mismatch was fixed by an earlier
rewrite, and the enforcement gap is fixed here — `checks/token-resolution` counts
definition sites and fails on more than one, demonstrated on a scratch copy where
a duplicated canonical heading exits 1 with both sites named. The Rationale no
longer asserts an enforcement property at all, so the corpus credits no tripwire
it does not have; the tripwire exists anyway.

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
- cite: plugins/ok/families/ok-planner/skills/_shared/dispatch-discipline.md :: "### {{LEAF-AGENT-RULE}}"
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "### {{IMPLEMENTATION-AUDITOR-PROMPT}}"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "Everything that is not scope is shared verbatim with"
- cite-file: checks/token-resolution @ sha256:0b5f17a4fab5
- cite-file: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md @ sha256:92f03876cba6
- cite-file: plugins/ok/families/ok-planner/skills/_shared/certification-core.md @ sha256:190f0836cf08
- cite-file: plugins/ok/families/ok-planner/skills/_shared/dispatch-discipline.md @ sha256:48a74bca5d08
- cite-file: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md @ sha256:d503b15a874e
- cite-file: plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md @ sha256:7082b4647db9
