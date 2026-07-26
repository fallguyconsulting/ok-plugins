---
issue: proof-whole-file-ownership
kind: discover
category: proof
artifacts:
  - decision:whole-file-ownership
status: verified
opened: 2026-07-25T02:16:01Z
---

# The ownership rule holds by construction, with nothing that would catch a violation

`decision:whole-file-ownership` — a plugin overwrites only whole files it owns, and never touches a consumer's memory files, rules files it didn't materialize, or anything else at a path outside its declared set — currently holds across all three true-up implementations, each of which writes only a small, hand-enumerable path set. But it holds by construction, not by check: a future edit adding one stray write to a true-up script would violate the suite's most trust-sensitive promise (these scripts run inside consumer repos) with nothing to catch it.

The behavior is deterministic script code, not prompt conduct, so the prompt-executed-checks precedent doesn't cap the proof at text presence. A static check is concretely producible: enumerate each plugin's declared owned-path set and assert its true-up implementation writes nowhere else. The check is worth more here than for most decisions — the blast radius of a violation is a consumer's own files — but it is also real cross-plugin work (three implementations in two languages), and the cheaper text-presence shape (the ownership rule's statements in the contract and each true-up skill) is available as an interim.

## Options

- **Static owned-path check** — a monorepo test asserting each true-up's write targets fall inside its declared set; falsifier = add a stray write, the check reds. Real work, real protection.
- **Text-presence proof only** — cheap and honest about what it checks, but the rule's statements standing in prose would not have caught the violation class that matters (a code edit).
- **Prose-governed permanent** — collides with the decision-artifact rules, as with the shim sibling.

## Ruling

> Recommended ruling (/verify-issues): build the static check — a sprint work item adds a monorepo-level test that extracts each plugin's owned-path set and asserts its true-up implementation writes only within it, and `decision:whole-file-ownership`'s Proof is rewritten to name it.
>
> Rationale: this decision is the suite's contract with consumers about touching their repos — the one place where "holds by construction today" is least acceptable as a permanent answer, because the violation class is a code edit that text-presence proofs can't see. Close call on cost grounds; if the sprint finds the three-implementation extraction disproportionate, the honest fallback recorded here is the text-presence proof with this check as the named upgrade path.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
