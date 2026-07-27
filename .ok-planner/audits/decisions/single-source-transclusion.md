---
audit: single-source-transclusion
artifact: decision:single-source-transclusion
determination: violated
audited: 2026-07-27T11:28:54Z
artifact-hash: sha256:4cfcf664e9ea
issue: shared-canonical-text-file-count
---

# Whether the planner's shared canonical text really lives in one definitions file plus one reviewer prompt, transcluded by token

## Claims

**Title — "Canonical rule text lives once and is transcluded into prompts."**
The "lives once" principle holds — no canonical block is duplicated across
files, and a maintenance check proves every token in use resolves to exactly one
`###` heading in the shared directory. The title itself is not what fails.

**"Every canonical definition, template, and rule the planner's skills share
lives in one shared definitions file (plus one shared reviewer prompt)." — NOT
HONORED.** Population enumerated from reality, by listing the shared directory
rather than trusting the artifact: `skills/_shared/` holds **five** files, and
four of them define transcludable canonical blocks:

- `artifact-definitions.md` — fifteen blocks (the definitions file the Choice names).
- `design-doc-compliance-reviewer.md` — one block (the reviewer prompt the Choice names).
- `certification-core.md` — five blocks: the review-fix loop and its veto test, the fixer prompt, the architect prompt, the code-review prompt, and the presentation. Shared verbatim by both certify gates; `certify-work`'s own body states that everything that is not scope is shared with `certify-all` and defined once in that file.
- `dispatch-discipline.md` — two blocks: the leaf-agent rule and the dispatch discipline, transcluded by the auditor prompt, both certify gates, and `plan-sprint`'s out-of-band reviewer.
- `implementation-auditor.md` — one block: the adversarial auditor prompt, dispatched by both gates.

Three of these five are neither "the shared definitions file" nor "the shared
reviewer prompt", and each carries canonical rules and templates that the
planner's skills share. The Choice's enumeration is therefore false as a count
and as a description of where shared rule text lives. The project's own checker
concedes the plurality: it globs `_shared/*.md` for token definitions rather
than reading one named file.

**"skill prompts pull them in by named double-braced token blocks replaced at
dispatch-assembly time by the running model."** Honored. Both shared files
document the same `{{TOKEN}}` convention and the dispatch-assembly substitution
rule, the skills embed the tokens, and `checks/token-resolution` fails the build
if any `{{TOKEN}}` used anywhere under the planner's skills resolves to no `###`
heading in the shared directory.

**"skills running in the main loop reference the file directly instead of
restating it."** Honored. The definitions file states the two consumption modes
explicitly (transclusion into subagent dispatches; direct reference from a
skill's own body), and the certification core repeats the split for its own
blocks (fix loop and presentation are read-and-apply; fixer and code-review are
dispatches).

**"Definitions are never restated inline in a skill."** Honored on the evidence
available: skills reference the canonical blocks by token and by file path
rather than reproducing their bodies, and no skill body was found carrying a
duplicate of a canonical definition. Note that nothing mechanical enforces this
— `checks/token-resolution` verifies that used tokens resolve, not that
definitions are absent from skill bodies — so this clause rests on authoring
discipline alone.

**Rationale — "The writer, the checker, and the mutator of the same artifact
kind each see only their own dispatched prompt; defining the rules once and
transcluding keeps the wording from drifting between the agent that writes and
the agent that checks."** Holds as a property: the writer (`plan-sprint`,
`discover-design`), the checker (the compliance reviewer, the implementation
auditor), and the mutator (the fixer) all draw the same blocks from the same
files, so the drift the rationale targets cannot occur.

**Rationale — "Editorially, one file to change is what keeps canonical wording
canonical." — NOT HONORED as stated.** There is no single file to change. An
editor changing the audit definition edits `artifact-definitions.md`; the
auditor's method, `implementation-auditor.md`; the fix loop or presentation,
`certification-core.md`; the dispatch rules, `dispatch-discipline.md`. Each block
still lives once, so the *drift* property survives — but the "one file"
property the rationale sells does not exist.

## Determination

**violated.** The decision's principle is implemented; its Choice, as written,
is not. The Choice makes a specific, checkable count — canonical shared text
lives in one definitions file plus one reviewer prompt — and the shared
directory holds five files, of which three (`certification-core.md`,
`dispatch-discipline.md`, `implementation-auditor.md`) carry eight further
canonical blocks that the planner's skills share. The accompanying rationale's
"one file to change" restates the same false count. This is precisely the
quantified-claim failure the audit regime exists to catch: an enumeration taken
from the artifact's own framing rather than from the directory as it stands.

Nothing about single-sourcing or transclusion is broken — token resolution is
machine-checked, no block is duplicated, and the two consumption modes are
documented. The violation is confined to the Choice's and Rationale's
description of where the shared text lives.

The determination flips when the Choice is rewritten to describe the shared
layer as it actually is (a set of shared canonical files under one directory,
each block defined exactly once and addressed by token) — an intent-level rewrite
of a Choice, so a sprint's act, not a repair — or when the additional shared
files are genuinely folded back into the two the Choice names. The whole-file
pins on `certification-core.md` and `dispatch-discipline.md` below will re-open
this audit if either is consolidated away or grows further blocks.

## Citations

- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "This file is the single source of truth."
- cite: plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md :: "### {{DESIGN-DOC-COMPLIANCE-REVIEWER-PROMPT}}"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "### {{CERTIFY-REVIEW-FIX-LOOP}}"
- cite: plugins/ok/families/ok-planner/skills/_shared/dispatch-discipline.md :: "### {{LEAF-AGENT-RULE}}"
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "### {{IMPLEMENTATION-AUDITOR-PROMPT}}"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "Everything that is not scope is shared verbatim with"
- cite-span: checks/token-resolution :: "for path in glob.glob(os.path.join(SKILLS, "_shared", "*.md")):" +4 sha256:c0eaa41ba33f
- cite-file: plugins/ok/families/ok-planner/skills/_shared/certification-core.md @ sha256:190f0836cf08
- cite-file: plugins/ok/families/ok-planner/skills/_shared/dispatch-discipline.md @ sha256:48a74bca5d08
