---
audit: declared-stack-profile
artifact: decision:declared-stack-profile
determination: satisfied
audited: 2026-07-27T13:20:17Z
artifact-hash: sha256:155ca3622d66
---

# Is stack tailoring really split into detect / declare / materialize, with the committed profile authoritative?

## Claims

**1. Quantifier: "Plugins whose discipline varies by stack split the pipeline into three."**
Population enumerated from reality, not from memory. The marketplace distributes two
plugins (`ok`, `ok-conduct`); `ok` is the front door and carries three skill families as
payload — its own statement of what it carries is the enumeration source, pinned by
cite-file, and I confirmed the directory listing matches it. The membership test comes
from the Choice itself: a plugin qualifies when converge **materializes rules and scripts
from** a committed stack description. Applying it to each:
`ok-workspaces` is in — its declared stacks and runtime select the cheatsheet's runtime
rule, the worktree and branch naming, the tag script's path, and whether the port
allocator is materialized at all; I watched all four vary across sandboxes.
`ok-planner` is out: it declares no stack profile and runs no detection.
`ok-plumbline` is the boundary case and it falls out on my own reading of its converge
core: that core materializes its cheatsheet, its binary, and its hook by version
substitution alone, and it touches its config only to migrate the file's *location*,
never to open its contents; what that config carries is project shape (ignore paths,
budgets, citation tags), not a stack description, and its binary reads it at lint time,
not at materialize time. Reading a *declaration* at use time is not what the Choice's
"never re-inferring" forbids anyway — so plumbline is safe under either membership call.
The quantifier therefore ranges over one family, and that family splits the pipeline
into three.
Honored.

**2. "a detection scan proposes a profile from repo signals."**
The detection script is read-only by construction: I swept it for every write primitive
(`writeFileSync`, `appendFile`, `openSync`, `mkdirSync`, `unlinkSync`, `rmSync`) and it
carries none — it reads the repo, assembles a profile object, and writes it to stdout as
JSON. Its header states the split in its own words: detection proposes, the committed
file decides.
Honored.

**3. "the committed profile in the estate is authoritative."**
Converge refuses to run without it, exiting non-zero with the instruction to run
detection, review the proposal, and commit it — nothing is materialized from a
detected-but-undeclared profile — and that gate carries the
`@decision: declared-stack-profile` annotation, so the enforcement point is navigable.
Downstream consumers read the committed file and never a scan: the port allocator exits
non-zero without it, and the open verb's first step is to read the profile.
Honored.

**4. "written only as transcription of the owner's explicit answers (a single confirmation when detection is unambiguous)."**
Quantifier "only". Population: every write the family's deterministic half performs,
enumerated from the converge script (its only writing module — detect, diagnose, and the
allocator hold no write primitive at all) and independently pinned by the repository's
own ownership conformance check, which fixes the permitted write targets by pattern and
fails any other. The profile path is not among them, so the deterministic half cannot
author the profile; I checked every write in converge against that allowlist myself. The
judgment half's rule is stated in the administration document ("administration writes
`config.json` only as transcription of the owner's explicit in-conversation answers,
never a field they didn't confirm, never silently"), and its shape is exactly the
Choice's parenthetical: one yes/no when every field has a natural answer, field-scoped
questions only where the repo genuinely supports more than one, and a proposal-file
fallback for owners who prefer hand-editing.
Honored.

**5. "converge materializes rules and scripts from the profile, never re-inferring at use time."**
Converge's `require` set is `fs`, `path`, `child_process`, and its own vendored-skill
renderer — it never invokes the detection script; the converge file is pinned by
cite-file as the population source for that claim. I falsified the alternative rather
than reading for it: in a sandbox whose `package.json` makes detection report
`node`/`dev-server`, a profile declaring `runtime: "none"` converged to the
no-shared-runtime cheatsheet with **no** port allocator materialized. Materialization
follows the declaration even when the repo shouts otherwise.
Honored.

**6. "A scan/declaration mismatch is diagnosed drift whose reconciliation is the owner's act."**
Diagnose is the only surface that re-runs detection, and it does so purely to compare.
In the same disagreeing sandbox it reported `[DRIFT] stacks declared [] but detected
[node]` and `[DRIFT] runtime declared none but detected dev-server`, exited 2, and wrote
nothing (it holds no write primitive). Its remedy line points at the converge core
"after reconciling config.json"; the administration document carries the matching
judgment procedure under its own heading — present the disagreement with a recommended
resolution, ask one question, transcribe the owner's answer, then converge. Nothing in
the tooling resolves the mismatch itself.
Honored.

**7. Rationale: "letting the scan decide would silently rewrite project behavior on every converge" / "keeps materialization deterministic."**
Consistent with the mechanism I exercised: converge's only inputs are the committed
profile and the carried suite version, so repeated converges on an unchanged profile
produce identical bytes — which is exactly what diagnose's byte-fidelity comparisons
(src-tag, allocator, vendored skills) rely on, and they reported clean on re-run.
Honored.

## Determination

**satisfied.** The three phases exist as three separately invocable surfaces with the
authority ordering the Choice describes: a read-only scan that only prints, a committed
profile without which converge refuses to act, and a materializer that never re-infers —
verified by converging and diagnosing sandbox projects, including one built specifically
so detection and declaration disagree, rather than by reading comments. The
transcription-only clause is not merely asserted in prose: the deterministic half's
writable set is pinned by a repository conformance check that excludes the profile path,
so silent authorship is blocked mechanically. Drift is reported and never resolved by
the tooling; resolution is explicitly the owner's act, with the procedure written down.
The quantifier ranges over the one family whose materialization is actually driven by a
declared stack description.

Two things I checked that could have broken this and did not. First, converge now
*refuses* one profile value outright — a `worktrees.dirPrefix` resolving to the
repository root — and diagnose reports that as a `profile` DRIFT. Refusing an
unrealizable declaration is not re-inference and does not demote the profile from
authoritative: nothing is derived from repo signals in its place, no default is silently
substituted, and the message hands reconciliation back to the owner. Nor does it narrow
claim 6, whose sentence says a scan/declaration mismatch *is* diagnosed drift, not that
only such mismatches are. Second, the residual the previous audit recorded here — one
profile field, the tag script's path, used verbatim as a write target, so a
self-defeating declaration could have converge overwrite an existing file — still
stands. It takes an owner hand-writing a path at an existing file to reach, the
declaration is the owner's own, and it does not disturb the authority ordering the
Choice states.

This stops holding if: converge begins invoking detection, or otherwise derives behavior
from repo signals at materialize time; the profile path enters the family's writable set,
or the conformance check stops covering converge; the administration document's
transcription-only rule or its one-question shape is loosened; diagnose stops comparing
detection against the declaration, or starts writing; or a second family acquires a
stack-driven profile — most plausibly `ok-plumbline`, if its converge ever began
materializing from its config's contents, at which point its diagnose's lack of any
scan-versus-declaration comparison would become a real gap under claim 6.

## Citations

- cite: plugins/ok/families/ok-workspaces/scripts/detect.js :: "// Detection PROPOSES; the committed .ok-workspaces/config.json DECIDES."
- cite: plugins/ok/families/ok-workspaces/scripts/detect.js :: "process.stdout.write(JSON.stringify(profile, null, 2) + '\n');"
- cite: plugins/ok/families/ok-workspaces/scripts/converge.js :: "// @decision: declared-stack-profile"
- cite-span: plugins/ok/families/ok-workspaces/scripts/converge.js :: "if (!fs.existsSync(configPath)) {" +7 sha256:c99f11ec8400
- cite-node: plugins/ok/families/ok-workspaces/scripts/converge.js @ sha256:86092f273c39
- cite-span: plugins/ok/families/ok-workspaces/scripts/diagnose.js :: "  const detected = JSON.parse(" +6 sha256:7aec720fe3d0
- cite: plugins/ok/families/ok-workspaces/scripts/diagnose.js :: "    detected.runtime === cfg.runtime ? cfg.runtime : `declared ${cfg.runtime} but detected ${detected.runtime}`"
- cite-node: plugins/ok/families/ok-workspaces/scripts/diagnose.js @ sha256:28bef14ec895
- cite: plugins/ok/families/ok-workspaces/scripts/port-block :: "  console.error('port-block: no committed profile at .ok-workspaces/config.json');"
- cite: plugins/ok/families/ok-workspaces/admin/ADMINISTRATION.md :: "administration writes `config.json` only as transcription of the"
- cite: plugins/ok/families/ok-workspaces/admin/ADMINISTRATION.md :: "## Resolve profile drift"
- cite-span: checks/owned-paths :: "def check_workspaces():" +22 sha256:35ee44ab9b6d
- cite-node: checks/owned-paths @ sha256:12cd569528fb
- cite: plugins/ok/families/ok-plumbline/admin/converge :: "sed "s/{{OK_PLUMBLINE_VERSION}}/${SUITE_VERSION}/g" "$canonical" > .claude/rules/plumbline-cheatsheet.md"
- cite-node: plugins/ok/CLAUDE.md#claude-md.plugin-purpose @ sha256:dc2479c49a6b
