---
audit: local-web-surface
artifact: decision:local-web-surface
determination: satisfied
audited: 2026-07-28T23:00:00Z
artifact-hash: sha256:cea5dcae3a74
---

# Is the corpus view really a read-only page served over loopback by a program the project runs on demand?

Amended. The design artifact's hash is unchanged. Four citations moved this
pass — the whole-file pins on `corpus-view`, `browse/SKILL.md`, and
`ArtifactDetail.svelte`, and the `find_bundle` span — each re-derived below
rather than assumed harmless. `corpus-view` gained a citation-model rewrite
(a `regions` list replacing single-line `hits`, so a claim can name several
non-contiguous ranges) and a `payload_dir()` bug fix inside `find_bundle`;
`browse/SKILL.md`'s and `ArtifactDetail.svelte`'s whole-file hashes moved
only because both are new files relative to this audit's prior read (the
family shipped `/browse` and the corpus view's frontend this cycle) — their
cited anchors and the nesting behavior C5/C6 rest on are unchanged. None of
this touches C1 (read-only), C2 (loopback bind), or C4's negative half (no
network client); each was re-checked against the current file rather than
assumed.

## Claims

**C1 — "delivered as a read-only local web application."** Read-only is
enforced by absence, which is the strongest form here: the request
handler defines `do_GET` and nothing else, so every other method falls
through to the standard library's 501. Inside the program there is no
filesystem write at all — the only `.write(` in the whole file is the
socket write that emits a response body, and there is no `open(..., "w")`,
no `makedirs`, no `shutil`, no `remove`. The corpus builder's own
docstring states the stance ("It never writes. Every route is a read of
the working tree"), and the vendored verb repeats it. **Honored.**

**C2 — "a page served over loopback."** The server binds
`("127.0.0.1", args.port)`. The host is not configurable — only the port
is — so there is no argument shape that exposes the surface off the
loopback interface. **Honored.**

**C3 — "by a program the project runs on demand."** The verb starts the
service, preferring the project's own materialized copy at
`.ok-planner/bin/corpus-view` and falling back to the payload's with a
printed note. It is started per invocation, not resident. **Honored.**

**C4 — "rather than as terminal output or an editor extension."** There
is no per-editor integration anywhere in the family, and the verb's
deliverable is a URL rather than a report: the skill instructs the agent
to hand over the address and the announced version and then stop, with
"Do not summarize the corpus for them: the page is the deliverable."
**Honored.**

**C5 — "lateral movement in any direction, artifact to code and code
back to the artifacts claiming it."** Both directions are present as
links, not as separate reports. From an artifact: each cited file group
carries an "open in code" link into that file's view. From code: the
source page's line-claims table and its whole-file population block each
link back to the claiming artifact, and the code list links every source
row into its file view. **Honored.**

**C6 — "with the cited excerpts held open inline beside the list they
were reached from."** The artifact detail nests each citation's excerpt
inside the file group it belongs to and opens both levels by default
(the group when it has line-scoped citations, the citation
unconditionally), so the excerpt is visible in place rather than behind
a navigation step. **Honored.**

**C7 — "all within one invocation the owner starts and closes."** One
process serves every route; the verb prints its pid together with the
command that stops it, and the service loop runs until interrupted.
Nothing about the reader's navigation costs another invocation.
**Honored.**

**C8 — Rationale: "A local page is the cheapest surface that carries
both halves at once."** The two halves are C5's directions, and both are
delivered by the one running process. **Honored.**

**C9 — Rationale: "unlike a committed static site it is a process rather
than an artifact — nothing is left behind in the consumer's repository
when the owner closes it."** Nothing the view produces is materialized:
excerpts, resolutions and coverage are computed per request and never
written (C1). The two things that do land in a consumer estate are placed
by the suite's administration, not by the view or its closing — the
service script, which is ordinary vendored tooling, and the frontend
build, which converge writes into `.ok-planner/browser/` and the estate's
own ignore file keeps out of the repository. So the sentence's operative
comparison holds: the generated view content that a committed static site
would deposit in every consumer repository is not deposited here.
**Honored.**

**C10 — the alternatives are real.** A terminal report per artifact, a
per-editor extension, and a committed generated static site are each a
choice the project could plausibly have made, and each is refused for a
stated cost. This is a decision, not a default. **Honored.**

## Determination

**satisfied.** The surface is exactly what the Choice describes: one
on-demand process, bound to loopback, serving a page whose only verbs
are reads, carrying artifact-to-code and code-to-artifact movement with
excerpts opened in place, started and stopped by the owner in a single
invocation.

**What would have to change for this to stop holding.** Any of: a write
path appearing in the serving program (a cache file, an export, a
recorded preference); a second HTTP method on the handler; the bind
address becoming configurable or moving off `127.0.0.1`; the excerpt
nesting collapsing so that reading a citation costs a navigation away
from the list; the removal of either direction's links, which would
reduce the page to a fancier terminal report; or the view beginning to
emit generated content into the consumer tree, which is the property C9
distinguishes it from a committed static site by.

Two facts deliberately *not* treated as counter-evidence, recorded so a
later auditor does not relitigate them: the estate gains a vendored copy
of the serving program and an untracked frontend build, both placed by
the administration pass rather than by the view, and neither produced by
a reader opening or closing the page.

## Citations

- cite-node: plugins/ok/families/ok-planner/scripts/corpus-view @ sha256:2482b9ac2fed
- cite-span: plugins/ok/families/ok-planner/scripts/corpus-view :: "def do_GET(self):" +10 sha256:f3c6da72486b
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "httpd = ThreadingHTTPServer(("127.0.0.1", args.port), Handler)"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "if cand and os.path.isfile(os.path.join(cand, "index.html")):"
- cite-span: plugins/ok/families/ok-planner/scripts/corpus-view :: "def find_bundle(root, override):" +10 sha256:9851185cbd73
- cite-node: plugins/ok/families/ok-planner/skills/browse/SKILL.md @ sha256:772c8b604d8a
- cite: plugins/ok/families/ok-planner/skills/browse/SKILL.md :: "bin=".ok-planner/bin/corpus-view""
- cite: plugins/ok/families/ok-planner/skills/browse/SKILL.md :: "nohup python3 "$bin" --port "$port" > "$log" 2>&1 &"
- cite-node: plugins/ok/families/ok-planner/browser/src/views/ArtifactDetail.svelte @ sha256:d16c5f5b6628
- cite-node: plugins/ok/families/ok-planner/browser/src/views/SourceView.svelte @ sha256:668c4c1edbda
- cite-node: plugins/ok/families/ok-planner/browser/src/views/SourceList.svelte @ sha256:538a2fda26a0
- cite: plugins/ok/families/ok-planner/browser/src/views/SourceView.svelte :: "That is a claim over the file, not over each of its lines: no line"
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-gitignore :: "browser/"
