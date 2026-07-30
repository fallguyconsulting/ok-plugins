---
audit: local-web-surface
artifact: decision:local-web-surface
determination: satisfied
audited: 2026-07-30T00:31:21Z
artifact-hash: sha256:2d3237f7a3df
---

# The corpus view is a read-only local web application the owner starts and closes over loopback

## Confirmation

Satisfied.

- **A page served over loopback by a program the project runs on demand.**
  `corpus-view` binds a `ThreadingHTTPServer` on `127.0.0.1` and prints the
  address it is serving. The project's own `.ok-planner/bin/browse up` is what
  runs it: it launches the sibling `corpus-view` with `--port 0` (the OS hands
  out any free loopback port), parses the address out of the view's own
  announcement, and opens the system browser on it. The suite runs the real
  script against a converged-shaped fixture and asserts the server answers on
  the port the script recorded, and that the script relays the view's pinned
  version line.
- **A web application, not just data routes.** The root serves the built
  bundle (`200 text/html` carrying the app mount and an asset reference); the
  asset itself is served and is the compiled `browser/src/` frontend, carrying
  the `/api/artifacts`, `/api/source` and `/api/inspection` routes; a deep link
  the frontend routes itself falls back to the page rather than 404; an encoded
  path escaping the bundle is refused 403 by the containment guard; and a
  project with no placed build gets the `NO_BUNDLE_PAGE` fallback while the
  data routes still answer.
- **Lateral movement in any direction, within one invocation.** One long-lived
  process answers `/api/artifacts` (both live kinds with their audit
  determinations), `/api/artifact/{kind}/{slug}` (the cited code excerpted per
  citation, with the region set and declared-unit chain), `/api/source?path=`
  (the same regions marked in the file, the claiming artifact named, an
  unclaimed region present, a whole-file pin kept file-level), `/api/sources`
  (a file nothing claims as its own row), `/api/meta` and `/api/inspection` —
  and the two directions are asserted to agree on a multi-hit anchor. The same
  process is asked again after a graph is built and after a citation is broken
  under it, and answers from the current tree both times.
- **Started and closed by the owner.** `browse up`/`browse down` are the whole
  lifecycle and the whole cycle is exercised for real: `up` leaves an answering
  view and a `pid port` record under the estate's `run/`; a second `up` reuses
  the live view rather than doubling it; `down` kills the recorded process and
  removes the record; and a second `down` is a no-op. All four ways a record
  can be wrong are driven end to end and each reported as what it is: a pid
  that died behind the script's back is cleaned up and replaced, a live view
  that has stopped answering on its recorded port is terminated and replaced, a
  pid the OS has recycled for an unrelated process is dropped without ever
  being signalled — `reused_or_gone` is what keeps those two apart — and an
  unreadable record is announced and removed by both verbs. Identity is
  confirmed from the process table before any signal, so a reused pid is never
  killed on the record's say-so.
- **A process, not a committed artifact.** `corpus-view` has no write path, and
  the claim is held to account: the pinned fixture's tree is hashed before the
  service answers its first request and again after every route it declares has
  been driven, and the two manifests match. The one thing `browse` does write —
  the pid/port record and its log — lands under `.ok-planner/run/`, which the
  estate's own ignore file covers; both harnesses ask git itself
  (`git check-ignore`) whether that path is repository content and require the
  answer to be no.

## Referrals

- referral: the cited excerpts are held open inline beside the list they were reached from
  clause: "with the cited excerpts held open inline beside the list they were reached from"
  delivered: ArtifactDetail.svelte renders each citation as an open `<details>` carrying its excerpt table nested inside the file group it was reached from, and SourceView.svelte renders the gutter marks and claim table beside the file's own lines; whether that reads as "held open beside" to a person is not opined on here
  discipline: ux
- referral: a local page is the cheapest surface that carries both halves at once
  clause: "A local page is the cheapest surface that carries both halves at once"
  delivered: both halves are served by one process and exercised over its real HTTP surface; the comparative cost against a terminal report and a per-editor extension is not opined on here
  discipline: human-review

## Citations

- cite-node: plugins/ok/families/ok-planner/scripts/corpus-view @ sha256:d1eeb56156a6
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "httpd = ThreadingHTTPServer(("127.0.0.1", args.port), Handler)"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "def _static(self, view, path):"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "return self._json({"error": "outside the bundle"}, 403)"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "NO_BUNDLE_PAGE = "
- cite-node: plugins/ok/families/ok-planner/scripts/browse @ sha256:bcccb3435f43
- cite: plugins/ok/families/ok-planner/scripts/browse :: "def up(root):"
- cite: plugins/ok/families/ok-planner/scripts/browse :: "def down(root):"
- cite: plugins/ok/families/ok-planner/scripts/browse :: "[sys.executable, view, "--port", "0"],"
- cite: plugins/ok/families/ok-planner/scripts/browse :: "def is_corpus_view(pid):"
- cite: plugins/ok/families/ok-planner/scripts/browse :: "def reused_or_gone(pid):"
- cite-node: plugins/ok/families/ok-planner/scripts/ok-planner-gitignore @ sha256:1957abde8932
- cite-node: plugins/ok/families/ok-planner/browser/src/views/ArtifactDetail.svelte @ sha256:d16c5f5b6628
- cite-node: plugins/ok/families/ok-planner/browser/src/views/SourceView.svelte @ sha256:668c4c1edbda
- cite-node: plugins/ok/families/ok-planner/test/stories.sh @ sha256:f8717649820e
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: the root serves the built page, not just the data routes"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: the served bundle is the frontend that drives both directions and the residue panel"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: a deep link the frontend routes itself is answered with the page"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: a path escaping the bundle is refused, not served"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: a project with no placed build serves the no-build page and says so, while the data routes still answer"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: driving every route leaves the project byte-for-byte as it was"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "per-project-pinning: browse up starts the estate's own view on a free port and the server answers on the recorded port"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: browse up relays the view's own version announcement"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: the recorded pid/port is git-ignored — run state never becomes repository content"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: a second up is idempotent — the live view is reused, not doubled"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: browse down stops the recorded process and removes the run record"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: a second down is a no-op, not an error"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: a stale record is tolerated — up reports the cleanup and starts fresh"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: a recorded view that has stopped answering is terminated and replaced by a working one"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: down drops a recycled pid's record without signalling the unrelated process, and says which case it is"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: up starts a fresh view beside a recycled pid's unrelated process, leaving it running"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: down announces and removes a malformed run record"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: up announces a malformed run record too, then starts fresh"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "trace-corpus-to-code: opening a story excerpts the code its audit cites"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "trace-corpus-to-code: every occurrence a multi-hit anchor reaches is claimed"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "trace-corpus-to-code: a source nothing claims is listed as its own row, not left implicit"
- cite-node: plugins/ok/test/administration.sh @ sha256:d184587f1c50
- cite: plugins/ok/test/administration.sh :: "the estate's .gitignore covers run/ — recorded pid/port never become repository content"
