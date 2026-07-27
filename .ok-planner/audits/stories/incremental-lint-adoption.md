---
audit: incremental-lint-adoption
artifact: story:incremental-lint-adoption
determination: satisfied
audited: 2026-07-27T13:00:38Z
artifact-hash: sha256:a6dfca540c0b
---

# Can an owner survey, cluster, plan and ratchet a legacy backlog without stopping work and without moving backward — with every proposal verb read-only?

## Claims

**1. Acceptance conjunct — "a whole-repo report groups violations by check and
by file."** The family's compliance verb runs the lint over the whole project
and prints two groupings: a `by category:` block (counts per rule code) and a
`top files:` block (counts per path). Proven against a seeded backlog: the
report is asserted to contain `by category:`, `top files:`,
`plumbline/comment-hygiene` and the specific seeded file `src/c.js`, so a third
party can reconcile it line by line against the defects that were planted.
Honored.
`cite: … skills/audit/SKILL.md 'echo "by category:"'`,
`cite: … skills/audit/SKILL.md 'echo "top files:"'`,
`cite-span: … test/run.sh "run_adoption_proof() {" +98`.

**2. Acceptance conjunct — "clusters of similar violations surface as single
proposed bulk fixes."** The `patterns` verb buckets every violation by a
derived shape signature — `divider`, `license-fragment`, `todo-marker`,
`commented-out-code`, `doc-residue`, `disallowed-prose` for hygiene findings,
`tag:@…` for citation findings — and prints each cluster once, with a count and
up to three samples, sorted by size. The port plan then attaches one fix
instruction per cluster ("sample 3-5, confirm the shape, bulk delete"), which
is what makes a cluster a *single proposed fix* rather than a listing. Proven:
against a backlog seeded with two prose comments and two TODOs, the clustered
report is asserted to contain `cluster(s)`, `todo-marker` and
`disallowed-prose` — the two distinct shapes, not four line items. Honored.
`cite-span: … bin/plumbline "function patternsCmd(target) {" +29`,
`cite-span: … test/run.sh "run_adoption_proof() {" +98`.

**3. Acceptance conjunct — "a port plan enumerates the passes to zero."** The
port verb runs diagnose, the lint, and patterns, then emits a numbered
phase-by-phase plan: an Adopt pass when diagnosis is not healthy, one pass per
non-zero check with that check's cluster listing inlined, and always a final
Maintain pass describing the steady state. Its stated contract is that
executing it leaves the lint clean. Proven: the harness executes the verb's own
`## Run` block against the seeded repo and asserts the output carries
`# Plumbline port plan`, `comment-hygiene`, and `Maintain (steady state)` —
i.e. a plan whose passes actually reach the terminal state. Honored.
`cite-span: … test/run.sh "run_adoption_proof() {" +98`.

**4. Acceptance conjunct — "a recorded baseline makes any change that
increases the count fail in CI while any that holds or decreases it passes."**
`budget save` writes `{count, by_check}` into the estate; `budget check`
exits 2 on an increase (printing the per-check overage), exits 0 on a hold
("at baseline") and on a decrease ("below baseline"). The emitted CI templates
carry the budget check as its own pipeline step. The ratchet is one-way in code
too: `save` refuses to raise an existing baseline. All four dispositions are
proven in sequence on one seeded repo — baseline recorded, +1 → fails, hold →
passes, reduce → passes and is reported below baseline, raise-attempt → refused
with "refusing to raise the baseline". Honored.
`cite-span: … bin/plumbline "function budgetCmd(action, target) {" +73`,
`cite: … bin/plumbline "        run: node .ok-plumbline/bin/plumbline budget check"`,
`cite-span: … test/run.sh "run_adoption_proof() {" +98`.

**5. Acceptance conjunct — "a starter proposal shapes the config from detected
repo signals for the owner to confirm."** The starter verb probes for a Go
module, a Node package, an `.ok-planner/` sibling, and generated-code
directories anywhere in the tree, and emits a config carrying the citation
entries and ignore paths those signals imply — to **stdout**, with the
save-this-yourself instruction and the detected-signals line on stderr.
Confirmation is the owner's act; the verb has no write path. Verified by direct
execution at audit time in a scratch project seeded with `go.mod`,
`package.json`, `.ok-planner/` and `gen/`: the proposed config appeared on
stdout with the three ok-planner citation tags and five ignore entries, the
banner read `Detected: Go module Node package ok-planner`, and the directory
listing was byte-for-byte unchanged afterwards. Honored.
`cite-span: … bin/plumbline "function starterCmd(target) {" +44`,
`cite: … skills/starter/SKILL.md "Both checks — comment hygiene and citation resolution — always run…"`.

**6. Acceptance conjunct — "All proposal verbs are read-only — nothing is
applied without the owner."** Quantifier. Population enumerated from reality —
the family's vendored skill roster and the binary's subcommand table — then
partitioned: the verbs that survey the project and propose are `audit`,
`patterns`, `port`, `starter`, `suggest`. `patterns`, `suggest` and `starter`
reach `console.log`/`console.error` only and contain no filesystem write.
`audit` is a read-only script plus a reporting prompt that ends "Do not begin
applying fixes until the user authorizes". `port` writes only when the owner
names an output path in the invocation. (The remaining subcommands that do
write — `budget save`, `vendor-skills`, `wire-hooks` — are not proposal verbs;
they are the owner's or the administration's explicit acts.) Proven for the one
proposal verb that *can* write: the port run is asserted to leave
`plumbline-port-plan.md` absent, and a second run naming `./plan.md` is
asserted to create exactly that file. Honored.
`cite-span: … bin/plumbline "function patternsCmd(target) {" +29`,
`cite-span: … bin/plumbline "function starterCmd(target) {" +44`,
`cite: … skills/port/SKILL.md "Like every proposal verb in this family, it is **read-only** …"`,
`cite: … skills/audit/SKILL.md "Do not begin applying fixes until the user authorizes …"`,
`cite-span: … test/run.sh "run_adoption_proof() {" +98`.

**7. Proof field — "Demo — on a repo with a seeded backlog: a baseline
recorded, a change adding one violation failing the ratchet check while a
reducing change passes, and a clustered report plus port plan a third party can
follow to drive one cluster to zero."** The annotated harness
(`@story: incremental-lint-adoption` at the top of the file and above the
adoption demo) builds a git repo, vendors the binary into
`.ok-plumbline/bin/`, seeds four violations of two shapes across `src/`, and
then exhibits each demo clause in order. Run in full at audit time: green,
exit 0. Honored.
`cite-span: … test/run.sh "run_adoption_proof() {" +98`,
`cite-file: … test/run.sh` (population pin for which conjuncts the harness
exercises).

## Determination

**satisfied.** All five Acceptance conjuncts are implemented and the annotated
proof spans the Proof field completely, on a genuinely seeded backlog rather
than on fixtures: the baseline is recorded, an increase fails, a hold and a
decrease pass, a raise is refused, the clustered report names the two seeded
shapes, and the port verb's own `## Run` block is executed to produce a plan
containing the passes to zero. The falsifier is closed clause by clause — the
count cannot rise without a failure (claim 4), proposals are not bulk-applied
(claim 6, with the port read-only/named-path pair proven both ways), the
backlog is not violation-by-violation only (claims 2 and 3), and adoption does
not require disabling the checks (both checks run unconditionally and the
config exposes no switch).

One honest gap in coverage, unchanged in shape from the prior cycle and worth
recording: the harness exercises `budget`, `patterns`, `port` and the
compliance verb, but not `starter`. The Proof field does not name starter, so
the proof still spans its canonical intent statement; the conjunct is instead
verified in this audit by direct execution (claim 5), which confirmed both the
detection behavior and the absence of any write. A reader should treat that one
conjunct as auditor-verified rather than harness-verified.

This stops holding if: `budget check`'s three-way disposition changes or `save`
loses its refuse-to-raise guard; `patternsCmd` stops bucketing (a per-violation
listing would fail the "clustering or plan" falsifier); the port verb starts
writing without an owner-named path, or `starterCmd`/`suggestCmd`/`patternsCmd`
acquire a filesystem write; the compliance verb's `by category:` / `top files:`
groupings disappear; or the harness's adoption demo stops driving the real
verbs (e.g. asserting on canned text instead of executing the skills' `## Run`
blocks).

## Citations

- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function budgetCmd(action, target) {" +73 sha256:bc1df8e3883d
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function patternsCmd(target) {" +29 sha256:b3de8aafff4e
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function starterCmd(target) {" +44 sha256:bf6272e67732
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "        run: node .ok-plumbline/bin/plumbline budget check"
- cite: plugins/ok/families/ok-plumbline/skills/audit/SKILL.md :: "echo "by category:""
- cite: plugins/ok/families/ok-plumbline/skills/audit/SKILL.md :: "echo "top files:""
- cite: plugins/ok/families/ok-plumbline/skills/audit/SKILL.md :: "Do not begin applying fixes until the user authorizes a specific category or file scope."
- cite: plugins/ok/families/ok-plumbline/skills/port/SKILL.md :: "Like every proposal verb in this family, it is **read-only**: the plan is printed for the owner to read, and nothing is written into the project unless the owner names an output path in the invocation. Nothing is applied either way."
- cite: plugins/ok/families/ok-plumbline/skills/starter/SKILL.md :: "Both checks — comment hygiene and citation resolution — always run; the config exposes no switch that disables one. Plumbline's rule is strict by default (no comments except machine directives, configured citations, or docstrings in opt-in files); there is no "soft start" with checks disabled."
- cite-file: plugins/ok/families/ok-plumbline/test/run.sh @ sha256:c144bbb9094b
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_adoption_proof() {" +98 sha256:289e348afb4d
