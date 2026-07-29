---
audit: isolated-parallel-workspaces
artifact: story:isolated-parallel-workspaces
determination: satisfied
audited: 2026-07-29T13:13:38Z
artifact-hash: sha256:5385e2a82864
---

# Each parallel job is opened in its own checkout, on its own branch, with its own namespaced runtime

## Confirmation

Satisfied.

- **Own checkout, own branch.** The `open` verb creates the job's worktree
  from the profile's naming (`<dirPrefix><job>` on `-b <branchPrefix><job>`)
  and refuses rather than reuse an existing directory or branch. `demo.sh`
  opens two jobs side by side and asserts each is on its own branch, that
  their repository toplevels differ, and that a second open of an existing
  job name fails instead of clobbering.
- **Own namespaced runtime, over the whole population of runtime modes.**
  The runtime modes are enumerated from `converge.js`, which is the single
  place the per-workspace runtime rule is derived from the committed
  profile: `docker-compose`, `dev-server`, `none` — the same three the
  `open` verb's step 4 provisions. `demo.sh` exercises all three that carry
  an isolation surface: for `dev-server` it runs the materialized allocator
  for two jobs and asserts the printed blocks are non-overlapping, one line
  per declared port env var, and that allocating the second job's block left
  the first job's env byte-identical; for `docker-compose` it converges a
  second sandbox and reads the compose namespace back out of the
  materialized cheatsheet, asserting it is `<profile prefix>-<job>` and
  varies per workspace. `none` declares no shared runtime, so there is
  nothing to namespace.
- **No collision on files, containers, volumes, or ports.** Files: the
  checkouts are disjoint (asserted). Ports: the blocks are disjoint
  (asserted), and `port-block` is the one computed statement of the
  arithmetic, indexing each job among the profile-prefixed worktrees.
  Containers and volumes: the compose project name is what scopes container
  names, networks and volumes, and it is derived per workspace from the
  profile prefix (asserted through the materialized cheatsheet).
- **Never the main checkout.** Realized in the `open` verb's prose — the
  workspace report names the worktree as where work happens, and the verb
  states it does not modify the main checkout beyond `git worktree add`'s
  bookkeeping.

## Citations

- cite-node: plugins/ok/families/ok-workspaces/skills/open/SKILL.md#open-a-workspace.steps @ sha256:ca63c28cff05
- cite: plugins/ok/families/ok-workspaces/skills/open/SKILL.md :: "- Does not modify the main checkout, beyond `git worktree add`'s bookkeeping."
- cite-node: plugins/ok/families/ok-workspaces/scripts/converge.js @ sha256:86092f273c39
- cite-node: plugins/ok/families/ok-workspaces/scripts/port-block @ sha256:5c15c8febb77
- cite-node: plugins/ok/families/ok-workspaces/test/demo.sh @ sha256:de713b342666
