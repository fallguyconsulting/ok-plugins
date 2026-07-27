---
concept: falsifier
---

# Falsifier

## What it is

A falsifier is the declared statement of what failure would look like: the user-observable absence that would prove a story is not delivered — the user acts and the promised result never appears, the result is unrelated to their input, the value-delivering component turns out to be synthetic. It is prose in the story artifact, not machinery: a story's `Falsifier` section states it explicitly.

## Purpose

The falsifier keeps both of a story's verifiers honest about what they are protecting. The proof author reads it to know what the integration test must be capable of detecting; the implementation auditor reads it to know what to hunt for adversarially — the specific way this claim would be false if it were false. A claim whose falsifier nobody can state is not a claim; it is a mood, and writing the falsifier at authoring time is what surfaces that early.

## Boundaries

The falsifier belongs to the story artifact (see also: story-artifact); decisions state no separate falsifier — what would violate a Choice is derived by its audit from the Choice itself (see also: decision-artifact). Exercising functionality against the falsifier's scenario belongs to the story's proof; adversarially determining whether the claim holds belongs to the implementation audit, which decomposes every normative sentence, enumerates quantified populations from reality, and records its determination with content-anchored citations (see also: proof; the audit rules live in the artifact definitions).

## Invariants

- Every story states its falsifier as a user-observable absence, in the story's own terms, never as a mechanism.
- A falsifier names what would be observed if the story were undelivered — something a third party could watch fail, not an internal state.
