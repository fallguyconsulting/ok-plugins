---
issue: shared-canonical-text-file-count
kind: audit
category: conflicting
artifacts:
  - decision:single-source-transclusion
status: promoted
sprint: 2026-07-27-mechanical-release-audit-masking.md
opened: 2026-07-27T12:15:24Z
---

# Is the planner's shared canonical text one file, or a directory of canonical files?

`decision:single-source-transclusion` commits to a specific count — all
shared canonical text lives in "one shared definitions file (plus one
shared reviewer prompt)" — and its Rationale argues for that count
("one file to change is what keeps canonical wording canonical"). The
shared layer outgrew the count several releases ago: the planner's shared
directory holds five files, four defining transcludable canonical blocks
(fifteen in the definitions file, one in the reviewer prompt, five in the
certification core, two in the dispatch discipline, one in the auditor
prompt). The artifact's implementation audit stands `violated` (linked to
this issue) until the ruling lands.

What matters causally: nothing about single-sourcing itself is broken.
No canonical block is defined twice, a maintenance check fails the build
if any token used under the planner's skills resolves to anything but
exactly one heading in the shared directory, and the two consumption
modes (transclusion into dispatched prompts; direct reference from the
main loop) work as documented. The drift the Rationale actually targets —
writer, checker, and mutator seeing different wording — cannot occur.
What fails is only the decision's description of *where* the text lives:
the guarantee reality delivers is one place per block, not one file to
change. Because the Rationale argues for the count, correcting it is a
commitment change — which is why this reached the intake instead of the
certification fix loop.

State of play: the factoring is settled, not sprint-drift (two of the
three uncounted files predate this sprint by releases), and every
consumer — the gates, the checks, the vendoring renderer — already
addresses the directory.

## Options

- **Consolidate to match the Choice.** Fold the certification core,
  dispatch discipline, and auditor prompt into the definitions file.
  Cost: a single very large definitions file, an architecture change no
  sprint asked for, and every path reference in skills, checks, and the
  renderer moves.
- **Redescribe the layer as a directory.** Rewrite the Choice to commit
  to one shared directory of canonical files, each block defined exactly
  once and addressed by token; restate the Rationale's guarantee as one
  place per block — the property the token-resolution check enforces.
  Cost: a Choice rewrite, and the file inventory stays uncommitted prose.
- **Make the enumeration normative and enforced.** Rewrite the Choice to
  name the exact permitted file set and add a check failing on a sixth
  file, so adding a shared file requires a corpus delta. Cost: a
  maintenance gate on every legitimate future file, for a property
  (block uniqueness) already enforced at finer grain.

The ruling decides whether the corpus commits to a file count or to
block-level uniqueness.

## Ruling

> Recommended ruling (/verify-issues): redescribe the layer as a
> directory — the next sprint carries a delta rewriting
> `decision:single-source-transclusion`'s Choice to commit to one shared
> directory of canonical files with every block defined exactly once and
> pulled in by token, and its Rationale to claim one place per block as
> the editorial guarantee.
>
> Rationale: block-level uniqueness is the property the project actually
> enforces and the one that prevents the drift the decision exists to
> prevent; the file count was only ever a proxy for it, and consolidation
> would trade working factoring for the proxy. The close alternative is
> the enforced-enumeration option — right if the owner wants shared-layer
> growth to be a deliberate corpus act; the recommendation prefers the
> weaker commitment because the token-resolution check already makes
> silent duplication impossible, which is the failure that matters.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
