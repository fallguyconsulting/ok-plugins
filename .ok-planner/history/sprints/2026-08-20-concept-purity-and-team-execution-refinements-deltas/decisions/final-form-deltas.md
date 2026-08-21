---
decision: final-form-deltas
---

# Corpus edits are resolved fully during planning

## Choice

A corpus delta carries the complete final-form artifact body, resolved fully during the planning ceremony, and execution applies it by copying the body into place or deleting the file; retirement by delta is the only sanctioned way an artifact leaves the live corpus. Applying an approved sprint's deltas is the only act that changes what the corpus commits to. Certification's expression repairs and the administrator's migrations are the only other writers, and neither changes a commitment. A sprint whose delta bodies are large carries them in a sidecar folder beside the sprint file, archived with it. No delta carries a diff, a base pin, or any machine-checked derivation. The corpus's presence is the gate the other planning verbs key on: without one there is nothing to draft a delta against.

## Rationale

Review and fix are part of the sprint, and the suite's design posture is to trust its adversarial reviewers rather than add mechanical constraints beside them. A derivation or base check would hard-stop exactly the sprint where an artifact legitimately needs a change that only became apparent during the work — and the suite already has the two mechanisms for that case: divergences surfaced in the certification presentation for after-the-fact veto, and issue escalation for genuine forks. Whether the applied corpus is coherent with the live corpus is the certification gate's alignment producer's business, which reads rather than pins. Restricting corpus change to the delta is what gives the ceremony's sign-off its weight: text that could also arrive by an ordinary edit would leave the owner approving a subset of the changes. The sidecar keeps a large sprint readable without changing the delta's shape: the body is the same final form, carried in its own file.

## Alternatives

- Revision-bearing amendments — a base stamp, the revision as anchored edits, and a resulting body derived from the two. Reviewable at the size of the change, but it needs a diff derivation both sides trust and halts execution on any base movement, including the legitimate mid-work artifact change.
- A bare base checksum with a halt, no diff — closes the silent-revert case alone, at the same hard-stop cost.
- Diff-only deltas applied at execution — cheapest to author, and it moves interpretation to apply time, where the completion contract's file-equality check stops being a comparison.
