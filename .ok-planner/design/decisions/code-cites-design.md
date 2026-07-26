---
decision: code-cites-design
---

# Code cites design; design never cites code

## Choice

The direction of reference between code and the design corpus is fixed one-way: code carries kind-plus-slug annotations at load-bearing sites, while corpus bodies are self-contained — no file paths, no symbol citations, no quoted code, with slugs and invariant IDs the only sanctioned citation forms. Rollout is incremental: whoever consults an artifact while working on a file leaves the annotation; there is no bulk pass.

## Rationale

Durability under motion: a refactor that moves files cannot invalidate the design, and a doc that moves repos cannot orphan an artifact. The annotation grep plus the generated catalogs replace an external index, and a code path diverging from a stated boundary becomes a defect rather than an ambiguity.

## Alternatives

- Design docs cite code locations — every refactor rots the corpus, and staleness is undetectable until read.
- A maintained external index mapping artifacts to sites — a second source of truth that drifts from both.

## Proof

The corpus audit's annotation-integrity sweep fails on any annotation whose slug resolves to no live artifact or to the wrong kind, and its compliance pass fails corpus bodies carrying path citations; a paraphrased slug or a pasted file path in an artifact body turns a finding red. Projects declaring the citation-tag bridge get the same integrity enforced mechanically by the lint on every edit.
