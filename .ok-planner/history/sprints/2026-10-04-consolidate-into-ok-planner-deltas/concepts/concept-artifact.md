---
concept: concept-artifact
aliases:
  - concept
---

# Concept (artifact kind)

## What it is

A concept is the design-corpus artifact kind that defines a load-bearing noun the system traffics in — general and abstract. The bar for existence is that a reviewer reading code which mentions the noun needs a stable definition to know what it means. A concept names what kind of thing exists, what it is for, and where it ends against its neighbors. It defines; it does not guarantee, forbid, or decide, and it says nothing about implementation — no instance, no mechanism, no requirement, no prohibition.

Concepts sit beside stories and above decisions. The stories say what a user needs to do in the absence of any technical choice. The concepts name the kinds of thing those needs are about. Many different sets of decisions could serve both. So a sentence in a concept's definition or boundary stays only when it holds for every product that meets the same stories, whatever decisions that product makes. A sentence that some such product could make false describes this build, and it belongs in a decision or in code. In video-editing software, "a timeline arranges media clips in time" stays; "a timeline is saved as an edit decision list" goes, because a product that saves its timelines another way still meets every story.

## Purpose

Concepts give a project a fixed vocabulary: every agent and reviewer resolves a term to the same definition instead of paraphrasing from prior context. They prevent the drift that occurs when the same noun quietly means different things in different sessions or subsystems.

## Boundaries

A concept owns a definition, its purpose, its boundary against neighboring concepts, and its live aliases. It does NOT own instance enumerations — the specific artifacts that satisfy a concept live in decisions (see also: decision-artifact) or in code. A sentence listing the acts a surface offers, the fields a record holds, or the steps a mechanism takes describes one build, and lives in a decision or in code. Code cites the concept it expresses via annotations (see also: annotation). Concepts sit beside stories, above decisions, inside the design corpus (see also: design-corpus, story-artifact).
