---
decision: code-cites-design
---

# Code cites design; design never cites code

## Choice

The direction of reference between code and the design corpus is fixed one-way: code carries kind-plus-slug annotations at load-bearing sites, while corpus bodies are self-contained — no file paths, no symbol citations, no quoted code, with slugs and invariant IDs the only sanctioned citation forms. Every annotation resolves to a live artifact of the named kind, and the slug is that artifact's exact filename basename. A paraphrase dangles; a slug carried at another kind mismatches. Both failures are mechanical, and whoever finds one fixes it in-cycle. Rollout is incremental: whoever consults an artifact while working on a file leaves the annotation; there is no bulk pass, and the corpus bootstrap introduces no annotations.

## Rationale

Durability under motion: a refactor that moves files cannot invalidate the design, and a doc that moves repos cannot orphan an artifact. The annotation grep replaces an external index, and a code path diverging from a stated boundary becomes a defect rather than an ambiguity. The grep indexes only literal slugs, so the exact basename is the one form that resolves. A near-miss is a defect, not a variant. The bootstrap leaves no annotations, so every mark records an artifact someone actually consulted.

## Alternatives

- Design docs cite code locations — every refactor rots the corpus, and staleness is undetectable until read.
- A maintained external index mapping artifacts to sites — a second source of truth that drifts from both.
