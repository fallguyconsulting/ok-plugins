---
audit: built-bundle-fetched-at-pin
artifact: decision:built-bundle-fetched-at-pin
determination: satisfied
audited: 2026-07-29T18:40:00Z
artifact-hash: sha256:8882717e6d56
---

# The corpus view's build is placed by converge at the project's pinned version, ignored by git, and is the build that project serves

## Confirmation

Satisfied. Placement in the stamping pass, exclusion from repository
content, drift detection, the preference for the placed build over the
front door's carried one, and the view retrieving nothing are each
exercised end to end.

- **Placed at the pin, in the stamping pass.** The planner's converge
  copies the carried `browser/dist` into `.ok-planner/browser/` and
  writes a `.build-stamp` beside it carrying the suite version and a
  digest over every byte placed, in the same run that stamps the estate.
  `administration.sh` asserts, against a real bootstrap, that the build
  landed, that the stamp names the version the estate was stamped with,
  and that the stamp carries a `build-sha256` over the placement.
- **Ignored, never repository content.** The estate gitignore template
  carries `browser/`; the same harness asks git itself
  (`git check-ignore`) and then asserts the placement never appears in
  `git status --untracked-files=all`, deliberately before any `git add`,
  so a commit cannot mask the answer.
- **The stamp discriminates, and converge repairs.** All four diagnose
  findings are driven against the converged estate by mutating it —
  absent build, unstamped placement, a well-formed stamp naming another
  suite version, a byte corrupted in place under an intact stamp — each
  required as its own DRIFT text with a non-zero exit, and each required
  to clear on an ordinary converge.
- **The build a project serves is the one its convergence placed.** A
  project is converged for real, then its own
  `.ok-planner/bin/corpus-view` is started under a `CLAUDE_PLUGIN_ROOT`
  naming a front door whose carried `browser/dist` is a different,
  marked build. `stories.sh` asserts the bytes returned from `/` are
  byte-identical to the placed build and carry none of the carried
  build's marker, and that `/api/meta` reports `bundle_source` as
  `project`, a bundle path under the project's own `.ok-planner/browser`
  and not the front door's, at the version the estate is stamped with.
  The reverse is asserted in the same project with only the placed build
  moved aside: the carried build is then served and the fallback
  announced — so the preference is a live choice between two reachable
  builds, not one candidate being invisible. `find_bundle` is the
  implementing preference: explicit override, then the placed build,
  then the payload's `dist`.
- **Nothing is retrieved when a reader opens the page.** `find_bundle`
  consults only those three candidates and fetches nothing; `stories.sh`
  drives every route the view declares against a project and compares a
  content-hash manifest of the whole tree taken before the first
  request, so a view that fetched or wrote a build would move it.
- **Built once per release, and earlier versions keep their own.** The
  `/release` skill removes `dist/` and rebuilds it, fails the release if
  `dist/index.html` is absent afterwards, and commits it with the
  release; `dist/` is tracked payload. Enumerating this repository's
  release tags, every tag cut since the view existed — `v11.2.0`,
  `v12.0.0` — carries its own `browser/dist`. Realized in the release
  procedure's prose plus committed payload; no program asserts it.

## Citations

- cite-node: plugins/ok/families/ok-planner/admin/converge#browser_stamp @ sha256:06f4f53d83d6
- cite: plugins/ok/families/ok-planner/admin/converge :: "    cp -R "${BROWSER_BUILD}/." "${OK_DIR}/browser/""
- cite-node: plugins/ok/families/ok-planner/scripts/ok-planner-gitignore @ sha256:4bf05805efe4
- cite-node: plugins/ok/families/ok-planner/scripts/corpus-view @ sha256:0904adb8b491
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "def find_bundle(root, override):"
- cite-node: plugins/ok/test/administration.sh @ sha256:65b93a0be43c
- cite: plugins/ok/test/administration.sh :: "  || bad "the corpus view's build was not placed at .ok-planner/browser/""
- cite: plugins/ok/test/administration.sh :: "  ok "the placed build never appears in git status — excluded from repository content""
- cite: plugins/ok/test/administration.sh :: "build_finding "drifted: .ok-planner/browser/ no longer matches the build stamp it was placed with" drifted"
- cite-node: plugins/ok/families/ok-planner/test/stories.sh @ sha256:16ddb66851bc
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "built-bundle-fetched-at-pin: converging the project placed a stamped build in its estate"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "built-bundle-fetched-at-pin: the page served is byte-for-byte the build convergence placed, not the front door's carried one"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "built-bundle-fetched-at-pin: the view reports the served build as the project's own, at the version its estate is stamped with"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "built-bundle-fetched-at-pin: with the placed build removed the same project serves the carried one and announces the fallback"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: driving every route leaves the project byte-for-byte as it was — the view is a process, not an artifact"
- cite-node: .claude/skills/release/SKILL.md#release-cut-an-ok-plugins-suite-release.procedure.5a-build-the-corpus-view-s-frontend-do-not-skip @ sha256:65f45c50bf1c
- cite-node: README.md#ok-plugins.verification-audits-over-ordinary-tests @ sha256:f11ff5a26947
