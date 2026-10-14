---
decision: drive-serves-the-tree-page-build
---

# A dashboard drive serves the page the tree's source builds

## Choice

A drive that certifies the dashboard builds the page from the tree's
source into scratch space outside the tree, and serves that build from
its scratch project in place of the committed release build. The
committed build stays the release's artifact.

## Rationale

A sprint that changes the page source changes a page no release has
built yet. A drive of the committed build then tries the old page and
fails on a change no fixer can act on. A build from the tree's source
drives the page the sprint changed. The build lives and dies in
scratch space, so the release still builds the page once (see also:
pinned-build-placed-at-true-up), and the driver still writes nothing
in the project tree (see also: drive-tries-each-story-as-a-user). The
cost: every dashboard drive needs the page's build tools and network
access to install its dependencies, and the drive repeats the
release's build steps.

## Alternatives

- Commit the page build with every change to the page source — the
  drive serves the committed build, and every such sprint commits a
  regenerated bundle in place of one build per release.
- Drive the committed build and accept the gap — no build in the
  drive, and the page a sprint changed goes undriven until a release
  builds it.
- Mark page stories as not driveable while the page source differs
  from the committed build's source — names the gap without spending a
  fixer, and gives up the same page coverage.
