---
audit: local-web-surface
artifact: decision:local-web-surface
determination: satisfied
audited: 2026-07-29T13:57:39Z
artifact-hash: sha256:cea5dcae3a74
---

# The corpus view is a read-only local web application served over loopback

## Confirmation

Satisfied.

- **A program the project runs on demand, over loopback.** `corpus-view`
  binds a `ThreadingHTTPServer` on `127.0.0.1`; the `/browse` verb's Run
  block starts it in the background and hands the owner the address and the
  pid to kill. The suite runs that block verbatim in a real project and
  asserts on its output, and drives the service on ephemeral loopback ports.
- **A web application, not just data routes.** The root serves the built
  bundle (`200 text/html` carrying the app mount and an asset reference), the
  asset itself is served and is the compiled `browser/src/` frontend — it
  carries the `/api/artifacts`, `/api/source` and `/api/inspection` routes —
  a deep link the frontend routes itself falls back to the page rather than
  404, an encoded path escaping the bundle is refused 403 by the containment
  guard, and a project with no placed build gets the `NO_BUNDLE_PAGE`
  fallback while the data routes still answer.
- **Lateral movement in both directions, within one invocation.** One
  long-lived process answers `/api/artifacts` (both live kinds with their
  audit determinations), `/api/artifact/{kind}/{slug}` (the cited code
  excerpted per citation, with the region set and declared-unit chain),
  `/api/source?path=` (the same regions marked in the file, the claiming
  artifact named, an unclaimed region present, a whole-file pin kept
  file-level), `/api/sources` (a file nothing claims as its own row),
  `/api/meta` and `/api/inspection` — and the two directions are asserted to
  agree on a multi-hit anchor. The same process is asked again after a graph
  is built and after a citation is broken under it, and answers from the
  current tree both times.
- **A process, not an artifact — nothing left behind.** `corpus-view` has no
  write path, and the claim is held to account: the pinned fixture's tree is
  hashed before the service answers its first request and again after every
  route it declares has been driven, and the two manifests match; the
  advisory verb likewise leaves no estate in the project it read.

## Referrals

- referral: the cited excerpts are held open inline beside the list they were reached from
  clause: "with the cited excerpts held open inline beside the list they were reached from"
  delivered: ArtifactDetail.svelte renders each citation as an open `<details>` carrying its excerpt table nested inside the file group it was reached from, and SourceView.svelte renders the gutter marks and claim table beside the file's own lines; whether that reads as "held open beside" to a person is not opined on here
  discipline: ux

## Citations

- cite-node: plugins/ok/families/ok-planner/scripts/corpus-view @ sha256:0904adb8b491
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "httpd = ThreadingHTTPServer(("127.0.0.1", args.port), Handler)"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "def _static(self, view, path):"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "return self._json({"error": "outside the bundle"}, 403)"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "NO_BUNDLE_PAGE = "
- cite-node: plugins/ok/families/ok-planner/skills/browse/SKILL.md#browse-the-corpus.run @ sha256:a887dc9e38e0
- cite-node: plugins/ok/families/ok-planner/browser/src/views/ArtifactDetail.svelte @ sha256:d16c5f5b6628
- cite-node: plugins/ok/families/ok-planner/browser/src/views/SourceView.svelte @ sha256:668c4c1edbda
- cite-node: plugins/ok/families/ok-planner/test/stories.sh @ sha256:16ddb66851bc
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: the root serves the built page, not just the data routes"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: the served bundle is the frontend that drives both directions and the residue panel"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: a deep link the frontend routes itself is answered with the page"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: a path escaping the bundle is refused, not served"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: a project with no placed build serves the no-build page and says so, while the data routes still answer"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: driving every route leaves the project byte-for-byte as it was"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "trace-corpus-to-code: opening a story excerpts the code its audit cites"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "trace-corpus-to-code: every occurrence a multi-hit anchor reaches is claimed"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "trace-corpus-to-code: a source nothing claims is listed as its own row, not left implicit"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "per-project-pinning: the browse verb run for real falls back to the payload copy and announces the fallback"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "per-project-pinning: the advisory verb wrote nothing into the project it read"
