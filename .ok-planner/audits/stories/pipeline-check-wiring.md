---
audit: pipeline-check-wiring
artifact: story:pipeline-check-wiring
determination: satisfied
audited: 2026-07-28T22:46:23Z
artifact-hash: sha256:1cef195e81ec
---

# Does an owner asking for pipeline configuration receive, for their platform, working config that runs the lint and the ratchet check?

Re-audit. The standing record read `violated` on the `pre-commit` member: it
carried no ratchet check at all, and its file selector was a multi-tag `types:`
list, which pre-commit ANDs, so the hook selected no file and the lint never
ran. The design artifact's hash has not moved, so the prior reasoning is
precedent; but the bytes the determination rested on have changed (the template
table, the selector, the proof), so this is a whole rewrite rather than a
refresh, and nothing below is carried on the fixer's word.

Refreshed since. The lint binary is unchanged (its whole-file pin still
verifies), and the one stale citation is the whole-file pin on
`ok-plumbline/test/run.sh`, moved by unrelated edits elsewhere in the file
(the `explain-lint-rules` proof's new `brief()` diagnostic helper). Every
span this audit cites inside it — `run_ci_proof` and its five helpers — is
byte-identical and none re-flagged stale. Citation regenerated; nothing
else touched.

The Acceptance is quantified over platforms — "the owner asks for pipeline
configuration **for their platform**" — so the population was re-enumerated
from reality, not from the proof's own listing and not from the fixer's
account: `plumbline ci` with no argument was run and its "available platforms"
block read back, and that listing was traced to the emitting code, where the
listing loop and the emission lookup read the same template table. Population:
`github`, `gitlab`, `pre-commit`. Three members, unchanged in number. All three
were then driven by hand against purpose-built repositories, and the pre-commit
member's file selection was checked against the real `identify` library that
pre-commit uses to assign file-type tags, rather than accepted as plausible.

## Claims

**Title / Story — "As an owner adopting the lint on a project with a pipeline,
I want ready-to-use configuration that runs the committed checks on every
change, so that the rules the project has adopted are enforced on contributions
I never review by hand."** Honored. The verb exists, is in the lint binary's
vendored-skills map (so a converged owner has it without a plugin installed),
takes a platform argument, prints configuration to stdout, and names the
conventional save location per platform. The delivery shape was never the
defect; the content is now right on all three members.

**Acceptance clause 1 — "they receive working configuration that runs the lint,
failing on any violation."** Honored on all three members.

- *github* — the committed binary invoked over `.` as a workflow step; the lint
  exits 2 on any violation, failing the job.
- *gitlab* — the same command as the first `script:` line.
- *pre-commit* — the hook now selects with `types_or`, the OR form, and the tag
  list is no longer a hand-written five. It is computed at emission time by
  walking the lint's own comment-grammar table and mapping each extension
  through a tag table, so the selector is derived from the same structure that
  decides which files the lint understands. Emitted, it is eighteen tags. Each
  was checked against the `identify` library pre-commit uses: all eighteen are
  real tags, and twenty-six of the twenty-seven extensions the lint recognises
  are selected by extension alone. The hook's own command was run the way
  pre-commit runs it — the binary with staged file paths appended — and exits 2
  on a violating file and 0 on a clean one. The AND/OR defect is genuinely gone,
  not relabelled: the emitted YAML was parsed and the selector confirmed to be a
  list of eighteen scalars under `types_or`, with `c#` and `c++` surviving as
  scalars rather than being eaten as comments.

  One residue, stated because it is real and because it is what a future
  tightening of this clause would catch. `identify` assigns `.ksh` a shell tag
  only for executable files, and tags extensionless scripts by shebang only when
  they are executable; the lint reads the shebang regardless of the executable
  bit. So a violation confined to a non-executable `.ksh` file, or to a
  non-executable extensionless script, is selected by neither. It is caught by
  the second hook whenever a baseline exists, since the ratchet counts the whole
  repository including those files. It is not caught at all when no baseline
  exists. This is narrower than the clause's territory rather than outside it,
  and it is a property of pre-commit's own identification model, not of a
  mistake in the emitted config — which is why it is recorded here rather than
  carried as a violation.

**Acceptance clause 2 — "and the ratchet check, failing whenever the recorded
violation count has risen."** Honored on all three members.

- *github* — a budget-check step guarded by a `hashFiles` test over both budget
  paths, so it runs exactly when a recorded count exists.
- *gitlab* — the same, guarded by a shell test over both paths.
- *pre-commit* — this is the substantive addition. The template now carries a
  **second hook**, `plumbline-budget`, whose entry is a guarded shell command
  invoking the budget subcommand, declared `pass_filenames: false` and
  `always_run: true`. The declaration is right for what the check is: a risen
  count is a property of the repository, not of any staged file, so the hook
  must run on every commit and must not be handed filenames. The guard mirrors
  the other two members — no budget file, no recorded count to have risen. The
  emitted entry was extracted and run verbatim against three fixtures: at a held
  count it exits 0, and with one added violating file it exits 2 naming the
  baseline it exceeded. The Falsifier disjunct that previously fired here —
  "it passes while the recorded count has risen" — no longer fires on any
  member.

**Acceptance clause 3 — "the configuration invokes the project's own committed
lint rather than an installed one, so the pipeline enforces the version the
project was converged to."** Honored on all three. Every template invokes the
committed binary by its vendored path; there is no clone, fetch, package
install, or plugin install anywhere in any of the three. The verb's own guidance
says the same and warns when no vendored binary exists. The proof asserts both
halves — committed path present, no install command — for every platform now,
not just one.

**Acceptance clause 4 — "What the owner receives runs as given — it is real
configuration, not an illustration to adapt."** Honored on all three. Each
emitted document was parsed as YAML and is well formed; each yields at least two
executable commands read out of its own `run:` / `script:` / `entry:`
statements, and those commands were executed unmodified against fixtures. The
pre-commit member is where this clause previously failed in its worst form —
config that parses, is accepted, and does nothing — and that is exactly what was
repaired. A minor adaptation burden remains on the pre-commit member for owners
who already have a `.pre-commit-config.yaml`: the emitted document is a complete
top-level `repos:` document, so it is appended by merging hooks into the
existing list rather than by concatenation. That is a merge, not an
illustration; the gitlab member carries the same shape of burden and was
already judged honored on it.

**Falsifier — "The emitted configuration does not run as given; it passes while
a violation is present, or while the recorded count has risen; it invokes a lint
the pipeline does not have …; or the owner must write the wiring themselves from
prose."** No disjunct fires on any of the three members. Each was checked by
execution rather than by reading: clean tree at a held count passes, seeded
violation fails, risen count fails the platform's own ratchet command.

**Proof — "Demo — the emitted configuration for one platform, run unmodified
against a repository with a seeded violation and against one whose recorded
count has risen, failing in both, and passing on a clean tree at a held
count."** Honored, and now materially wider than the field requires — which is
the right direction, because the field's "one platform" was what let the broken
member go unexercised last time.

The harness no longer hardcodes a platform. It reads the platform list back out
of the verb's own no-argument listing, asserts at least one came back, and then
loops: for each platform it extracts that platform's own commands from its own
emitted statements, asserts the committed-binary invocation with no install
step, asserts at least two runnable commands, asserts a ratchet command is among
them, and then runs those commands against three fresh fixtures — clean at
baseline, seeded violation, risen count. Every assertion is per platform and
every one currently passes for all three. The derivation is genuine, not a
literal dressed up: the listing the harness parses is printed by the same
function that keys the emission table, so a platform added to that table appears
in the harness's loop on the next run without anyone editing the harness. The
selector assertion is structural and says so in its own message — it checks the
absence of a multi-tag `types:` and the presence of a non-empty `types_or:`
rather than installing pre-commit and observing selection.

Two limits of the tripwire, worth recording so the next reader knows what it
does not catch. The listing is parsed with a pattern that accepts lowercase
letters and hyphens only, so a platform key containing a digit, a dot, or an
uppercase letter would be dropped from the loop silently rather than failing
loudly; and the count assertion is "at least one", not a cross-check against the
emitting table's size. Separately, nothing in the harness cross-checks that
every extension the lint recognises maps to a tag in the emitted selector — the
mapping table is consulted with a guard that silently skips an unmapped
extension, so a grammar added without a tag would narrow the hook without
failing anything. Neither is a defect in what the proof asserts; both are the
reason the citations below pin the grammar table and the tag table whole.

## Determination

**satisfied.** The two clauses the `pre-commit` member failed are both now met,
and were verified by execution rather than by reading the fix.

The ratchet is present as its own hook, correctly declared for a
repository-level property, correctly guarded on a baseline existing, and it
fails with a risen count when run as emitted. The file selector is the OR form
over eighteen tags derived from the lint's own grammar table, every tag
validated against the library pre-commit actually uses for tagging, and the
hook's command exits 2 on a violating file when handed paths the way pre-commit
hands them. The other two members were sound before and remain sound. The proof
now enumerates the platforms from the verb instead of naming one, and drives
each platform's own commands.

What would have to change for this to stop being true. A fourth platform added
to the emitting template table without both a lint invocation and a guarded
ratchet invocation breaks clauses 1 and 2 for that member — the whole-file pin
on the binary and the span pin on the template table are what force this audit
open when that table moves. An extension added to the comment-grammar table
without a matching entry in the pre-commit tag table silently narrows the hook,
because the derivation skips unmapped extensions rather than failing; both
tables are pinned whole for that reason. Replacing `types_or` with `types`, or
dropping the second hook, restores the original violation exactly. On the proof
side, a platform key that the harness's listing pattern cannot match would drop
that platform out of the loop while every assertion stays green — that is the
one way this determination could go stale without any citation moving, and it is
why the harness's enumeration helper is pinned as its own node.

The residue that does not carry a violation, restated so it is not lost: under
pre-commit, violations confined to a non-executable `.ksh` file or a
non-executable extensionless script are selected by neither hook's file
selector, and are caught only by the ratchet, and only when a baseline exists.
If the Acceptance is ever tightened to quantify over file kinds as well as
platforms, that is where it will fail first.

## Citations

- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline @ sha256:5ae82d9e7276
- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline#parseCitations.ciCmd @ sha256:58e359b54e5d
- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline#parseCitations.budgetCmd @ sha256:94f6e09bf54b
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "const CI_TEMPLATES = {" +55 sha256:bda9add3fdaf
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "  'pre-commit': `repos:" +21 sha256:36ca21c9d75d
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "const PRECOMMIT_TYPE_TAGS = {" +9 sha256:b4443228aad5
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "const COMMENT_GRAMMARS = {" +29 sha256:b564133b2341
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "function precommitTypeTags() {"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "        types_or: [${precommitTypeTags().join(', ')}]"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "      - id: plumbline-budget"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "        if: hashFiles('.ok-plumbline/budget.json', '.plumbline-budget.json') != ''"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "    - if [ -f .ok-plumbline/budget.json ] || [ -f .plumbline-budget.json ]; then node .ok-plumbline/bin/plumbline budget check; fi"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "  ci: 'ci',"
- cite-node: plugins/ok/families/ok-plumbline/skills/ci/SKILL.md @ sha256:df687d58415c
- cite: plugins/ok/families/ok-plumbline/skills/ci/SKILL.md :: "- `pre-commit` — a `.pre-commit-config.yaml` entry for the pre-commit framework"
- cite: plugins/ok/families/ok-plumbline/skills/ci/SKILL.md :: "note: no vendored binary — CI needs one committed; run /ok first"
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh @ sha256:0c4a64e5255e
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#run_ci_proof @ sha256:862bd25a3002
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#ci_platforms @ sha256:34a48862051b
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#ci_commands @ sha256:7a0d678618fe
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#ci_selector_report @ sha256:744388b7ea20
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#ci_run_all @ sha256:f6e5298aa362
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#ci_repo @ sha256:d0ec1772aabf
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "    proof_bad "$p: the emitted pipeline carries no ratchet check at all: $emitted""
