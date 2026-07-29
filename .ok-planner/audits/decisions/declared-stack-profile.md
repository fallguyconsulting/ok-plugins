---
audit: declared-stack-profile
artifact: decision:declared-stack-profile
determination: satisfied
audited: 2026-07-29T13:21:47Z
artifact-hash: sha256:155ca3622d66
---

# Detect → declare → materialize: the scan proposes, the committed profile decides, converge materializes, and a mismatch is diagnosed drift

## Confirmation

Satisfied. One family varies its discipline by stack — the contract's
stack-tailoring section names ok-workspaces and its conformance section
names no other — and all three stages plus the drift rule are exercised
end to end in that family's own harness.

- **Detection proposes from repo signals.** `detect.js` is run over four
  sandbox repositories carrying real marker files, and its proposal is
  asserted field by field: `go.mod` beside a compose file yields
  `go,docker` with the `docker-compose` runtime, the repository's own
  name as the compose prefix, the compose file named, and no dev-server
  block; a `package.json` with a `dev` script yields `node`,
  `dev-server`, the base port, block size and port env vars, and no
  compose block; `Cargo.toml` beside a Python manifest yields
  `python,rust` with runtime `none` and neither runtime block; and a bare
  `Dockerfile` is required to make the stack `docker` and to outrank a
  dev script in the proposed runtime.
- **The committed profile decides, and converge never re-infers.** A
  sandbox declaring `stacks: ["python"], runtime: "none"` over a repo
  that detection reads as `go,node` / `dev-server` is converged and
  required to materialize the declaration: no port-block allocator is
  written and the cheatsheet states the declared runtime. The two runtime
  materializations are exercised in their own sandboxes — a dev-server
  profile whose cheatsheet sends the workspace to the materialized
  allocator and states no compose namespace, and a docker-compose profile
  whose cheatsheet's `COMPOSE_PROJECT_NAME` template is derived from the
  profile's prefix and varies per workspace.
- **No declaration, no materialization.** The converge core is run in a
  repo with no profile and required to exit 2, to name the missing
  `.ok-workspaces/config.json`, to instruct the owner to run detection
  and commit the reviewed proposal, and to leave neither `.claude/` nor
  `.ok-workspaces/` behind.
- **A scan/declaration mismatch is diagnosed drift, reconciled by the
  owner.** Diagnose on that disagreeing sandbox is required to exit 2, to
  name both sides of each disagreement ("declared [python] but detected
  [go,node]", "declared none but detected dev-server"), and to put
  reconciling `config.json` on the owner.
- **Written as transcription of the owner's answers, one confirmation
  when detection is unambiguous.** No program: the contract's
  stack-tailoring section and the family's administration document state
  the walkthrough — detection held in conversation, a single yes/no when
  every field has one natural answer, questions spent only on genuinely
  ambiguous fields, answers transcribed verbatim, and a proposal file as
  the hand-editing fallback.

## Citations

- cite-node: docs/integration-contract.md#the-ok-suite-integration-contract.stack-tailoring-detect-declare-materialize @ sha256:f83d82ab27c1
- cite-node: docs/integration-contract.md#the-ok-suite-integration-contract.current-conformance @ sha256:377e6fd4d22b
- cite-node: plugins/ok/families/ok-workspaces/admin/ADMINISTRATION.md#ok-workspaces-administration.declare-a-profile-in-conversation @ sha256:4ddc0801b093
- cite-node: plugins/ok/families/ok-workspaces/admin/ADMINISTRATION.md#ok-workspaces-administration.resolve-profile-drift @ sha256:9145bb5f8e71
- cite-node: plugins/ok/families/ok-workspaces/scripts/detect.js @ sha256:361f52db19b7
- cite-node: plugins/ok/families/ok-workspaces/scripts/converge.js @ sha256:86092f273c39
- cite: plugins/ok/families/ok-workspaces/scripts/converge.js :: "if (!fs.existsSync(configPath)) {"
- cite-node: plugins/ok/families/ok-workspaces/scripts/diagnose.js @ sha256:28bef14ec895
- cite-node: plugins/ok/families/ok-workspaces/test/demo.sh @ sha256:de713b342666
- cite: plugins/ok/families/ok-workspaces/test/demo.sh :: "    || fail "detection did not propose the docker-compose runtime from a compose file""
- cite: plugins/ok/families/ok-workspaces/test/demo.sh :: "    || fail "detection did not propose the dev-server runtime from a dev script""
- cite: plugins/ok/families/ok-workspaces/test/demo.sh :: "    || fail "converge materialized the detected runtime instead of the declared one""
- cite: plugins/ok/families/ok-workspaces/test/demo.sh :: "    || fail "diagnose does not name both sides of the stacks disagreement""
- cite: plugins/ok/families/ok-workspaces/test/demo.sh :: "    || fail "diagnose does not put reconciling the declaration on the owner""
- cite: plugins/ok/families/ok-workspaces/test/demo.sh :: "    || fail "the refusal does not instruct the owner to declare a profile: $refusal""
- cite-span: plugins/ok/test/administration.sh :: "cat > "$two/.ok-workspaces/config.json" <<'JSON'" +9 sha256:aefebff6412b
