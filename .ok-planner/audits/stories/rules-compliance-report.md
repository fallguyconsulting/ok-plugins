---
audit: rules-compliance-report
artifact: story:rules-compliance-report
determination: satisfied
audited: 2026-07-27T13:00:38Z
artifact-hash: sha256:e607b3a97c95
---

# Does every rules-bearing family deliver a read-only, grouped, mechanical-vs-judgment drift report over its own rulebook, modifying nothing?

## Claims

**1. Acceptance conjunct — "violations and residue are reported grouped by
rule and location."** Checked per family. ok-plumbline: the verb prints a
`by category:` block (counts per rule code) and a `top files:` block (counts
per path). ok-workspaces: its output format is one finding heading per
`<check> — <file>:<line>`, i.e. rule and location on the finding itself.
ok-planner: findings return per pass, each carrying the rule it fails and the
artifact or `file:line` evidence, with the deterministic `audit-check` output
folded in verbatim. Proven for the family with deterministic machinery: over a
seeded repo, the report is asserted to contain `by category:`, `top files:`,
`plumbline/comment-hygiene` and the seeded file `src/c.js` — reconcilable
against the planted defects. Honored.
`cite: … ok-plumbline/skills/audit/SKILL.md 'echo "by category:"'`,
`cite: … ok-plumbline/skills/audit/SKILL.md 'echo "top files:"'`,
`cite: … ok-workspaces/skills/audit/SKILL.md "### <check> — <file>:<line> — [mechanical | judgment]"`,
`cite-span: … test/run.sh "run_adoption_proof() {" +98`.

**2. Acceptance conjunct — "with a remediation view distinguishing what is
mechanically fixable from what needs judgment."** All three verbs carry the
split as a named section, not as an aside. ok-plumbline: a Reporting section
with explicit **mechanical** and **judgment** bullets and worked examples of
each. ok-workspaces: a Remediation block with per-check mechanical/judgment
assignment and the instruction that an unclear class is judgment.
ok-planner: every finding from every pass is classified per the shared
mechanical-vs-judgment rule, which is transcluded into each dispatch. Proven
across the whole population: for each of the three families the roster proof
reads the verb's text and asserts it mentions both `mechanical` and
`judgment`. Honored.
`cite: … ok-plumbline/skills/audit/SKILL.md "  - **mechanical** — the fix is fully determined …"`,
`cite: … ok-workspaces/skills/audit/SKILL.md "### <check> — <file>:<line> — [mechanical | judgment]"`,
`cite-span: … test/run.sh "run_roster_proof() {" +30`.

**3. Acceptance conjunct — "the verb proposes and stops — nothing in the
project is modified."** ok-plumbline: the `## Run` block only reads
(`node "$bin" .` plus text processing), and the prompt ends "Do not begin
applying fixes until the user authorizes a specific category or file scope";
the frontmatter states read-only outright. ok-workspaces: "Read-only sweep …
fixes nothing (the caller fixes and re-runs)" and "Read-only: report and stop.
Do not edit files." ok-planner: "Create nothing … it does not even ensure its
own layout", "Does not fix anything — not even mechanical findings", "Does not
touch the issue intake". Proven three ways: the seeded compliance run is
bracketed by `git status --porcelain` before and after and asserted identical;
the roster proof asserts each of the three verbs declares itself read-only;
and it separately asserts ok-planner's verb contains no `mkdir -p .ok-planner`
— the one write a reporter is most tempted to make. Honored.
`cite: … ok-planner/skills/audit/SKILL.md "- Does not fix anything — not even mechanical findings. …"`,
`cite: … ok-workspaces/skills/audit/SKILL.md "Read-only sweep of the project against the mechanical rules …"`,
`cite: … ok-plumbline/skills/audit/SKILL.md "Do not begin applying fixes until the user authorizes …"`,
`cite-span: … test/run.sh "run_roster_proof() {" +30`,
`cite-span: … test/run.sh "run_adoption_proof() {" +98`.

**4. Acceptance conjunct — "Each rules-bearing family delivers this over its
own rulebook with its real checking machinery."** Quantifier. I enumerated the
population from reality — `ls plugins/ok/families/` — not from the corpus:
`ok-planner`, `ok-plumbline`, `ok-workspaces`, three directories, no others.
All three are rules-bearing (design-corpus authoring rules; the comment and
citation lint; the three workspace-discipline rules) and all three ship
`skills/audit/SKILL.md`. Each reports over *its own* rulebook: ok-plumbline
over comment hygiene and citation resolution, ok-planner over the design-doc
compliance rules plus proof coverage, annotation integrity, cross-artifact
consistency and surface inventory, ok-workspaces over mutable tags in
verification paths, runtime-isolation parameterization, worktree naming and
src-tag consumption. Each uses real machinery rather than a description of one:
ok-plumbline executes its own binary; ok-planner runs the vendored
deterministic `audit-check` and dispatches reviewer subagents; ok-workspaces
runs named `rg` and `git worktree`/`git branch` probes gated on the committed
profile. The harness walks the same three-family roster and asserts the
read-only and mechanical-vs-judgment properties on each. Honored.
`cite-file: … test/run.sh` (population pin — the in-repo roster enumeration),
`cite: … plugins/ok/CLAUDE.md "\`ok\` is the suite's front door and sole administrator. …"` (payload roster),
`cite: … ok-planner/skills/audit/SKILL.md "     Run the vendored checker — \`.ok-planner/bin/audit-check\`. If the"`,
`cite-span: … test/run.sh "run_roster_proof() {" +30`.

**5. Proof field — "Demo — a compliance run over a project seeded with known
violations of the family's rules, producing a grouped report a third party can
reconcile against the seeded defects, with the working tree unchanged."** The
annotated harness (`@story: rules-compliance-report` at the top of the file,
above the adoption demo, and above the roster proof) seeds a git repo with four
known violations across `src/`, executes the ok-plumbline compliance verb's own
`## Run` block from inside that repo, and asserts exit 0, the two groupings,
the rule code, and one specific seeded path — then asserts the porcelain status
is unchanged. Run in full at audit time: green, exit 0. Honored.
`cite-span: … test/run.sh "run_adoption_proof() {" +98`,
`cite-file: … test/run.sh`.

## Determination

**satisfied.** The story's two Acceptance sentences both hold. The first is
exhibited end-to-end for the family whose machinery is deterministic: a real
compliance run over a seeded project produces a report grouped by rule and by
file, split into mechanical and judgment remediation, and leaves the working
tree byte-identical. The second — the quantifier over rules-bearing
families — was checked against the population enumerated from the filesystem
rather than from the corpus: all three families exist, all three ship a
compliance verb over their own rulebook, and each verb's checks are concrete
commands or dispatches rather than prose about checking. The falsifier is
closed: the report does not mutate the project (before/after porcelain), real
drift is reported (the seeded defects appear by rule and by path), and no fix
is applied without the owner.

Two boundaries worth naming. First, two of the three verbs are prompt-realized:
ok-planner's and ok-workspaces' reports are produced by an agent following the
skill text, so the roster proof necessarily asserts on the verb's declared
properties (read-only, mechanical-vs-judgment) rather than on a captured
report, while the deterministic conjuncts — grouping, reconcilability,
tree-unchanged — are exercised for real against ok-plumbline. That is the
correct division for a prompt-realized surface, and the harness says which is
which. Second, the population pin is the harness's own roster loop plus the
front door's payload roster; a fourth family added without touching either
would not mechanically trip a re-audit, so a reader adding one should re-derive
this claim by hand.

This stops holding if: a family is added to `plugins/ok/families/` without a
compliance verb over its own rulebook; any of the three verbs loses its
read-only declaration or gains a write (ok-planner re-acquiring a `mkdir -p`
for its own layout is the specific regression the harness watches for); the
mechanical-vs-judgment remediation view is dropped from any verb; the
ok-plumbline verb's `by category:` / `top files:` groupings disappear; or the
harness stops executing the verb's real `## Run` block against a seeded repo
and stops bracketing it with the porcelain comparison.

## Citations

- cite: plugins/ok/families/ok-plumbline/skills/audit/SKILL.md :: "echo "by category:""
- cite: plugins/ok/families/ok-plumbline/skills/audit/SKILL.md :: "echo "top files:""
- cite: plugins/ok/families/ok-plumbline/skills/audit/SKILL.md :: "  - **mechanical** — the fix is fully determined and changes no decision: residue, restatement, dividers, commented-out code, TODO markers (delete), and citations whose slug is a typo or a rename away from resolving (repoint)."
- cite: plugins/ok/families/ok-plumbline/skills/audit/SKILL.md :: "Do not begin applying fixes until the user authorizes a specific category or file scope."
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "- Does not fix anything — not even mechanical findings. The caller fixes; the audit re-verifies."
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "     Run the vendored checker — `.ok-planner/bin/audit-check`. If the"
- cite: plugins/ok/families/ok-workspaces/skills/audit/SKILL.md :: "Read-only sweep of the project against the mechanical rules the discipline admits. Reports findings with file:line evidence; fixes nothing (the caller fixes and re-runs). Read `.ok-workspaces/config.json` first — the profile decides which checks apply."
- cite: plugins/ok/families/ok-workspaces/skills/audit/SKILL.md :: "### <check> — <file>:<line> — [mechanical | judgment]"
- cite: plugins/ok/CLAUDE.md :: "`ok` is the suite's front door and sole administrator. It carries the suite's three skill families as payload — `families/{ok-planner,ok-plumbline,ok-workspaces}`, each a self-contained directory of skills, templates, support scripts, and administration surfaces — and ships one skill, `/ok`, that is the whole administration process: install, converge, repair. `/ok` updates the installed user-scoped plugins, discovers integrated families by the integration contract's filesystem markers (current dot-directory or documented pre-migration markers), offers to bootstrap carried-but-unintegrated families in one consent question, then administers each family by driving its two conventional surfaces from the payload: the deterministic converge core at `admin/converge` (diagnose / converge / wire-hooks) and the administration document at `admin/ADMINISTRATION.md` for the judgment the core cannot encode. Consent is reserved for genuine collisions, non-suite-owned content, and hook-wiring transcription; a family's own retired layout migrates under converge."
- cite-file: plugins/ok/families/ok-plumbline/test/run.sh @ sha256:c144bbb9094b
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_roster_proof() {" +30 sha256:1fb51885f4a8
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_adoption_proof() {" +98 sha256:289e348afb4d
