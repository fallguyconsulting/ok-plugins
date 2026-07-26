---
issue: retired-layout-migration-consent
kind: discover
category: conflicting
artifacts:
  - concept:true-up
  - decision:whole-file-ownership
status: verified
opened: 2026-07-25T02:16:44Z
---

# Does retired-layout migration need consent? Three surfaces disagree

When true-up finds an estate in a retired layout (pre-4.0 kinds, `backlogs/` or `specs/` instead of `sprints/`, a legacy `issues.jsonl`), does migrating it require an explicit owner consent step, or is invoking the verb itself the permission? The code has one answer and the prose has both. `true-up`'s skill text says "run the migration for whatever the script reported — no consent prompt" (only a genuine old-vs-new collision stops for the owner), and the front door agrees: "a true-up should never stop to ask permission to migrate its own retired layout — running `/ok` is that permission." But the same front-door file describes each true-up as "proposing any migration ... for the owner's consent" a few lines earlier, and the ok plugin's CLAUDE.md frames every cycle generically as "diagnose → consent → converge."

The corpus splits the same way. `concept:true-up` puts consent "only when something not plugin-owned needs migrating or resolving" — compatible with silent migration if retired-layout content counts as plugin territory. `decision:whole-file-ownership` cuts the other way: its Choice names "earlier-version estates" explicitly among things "presented for the owner's decision." The two artifacts conflict independent of code. The code itself is consistent: no prompt anywhere, migration mechanical (files move, contents untouched, nothing deleted), collisions stop.

The stakes: skills key on the current layout and misbehave against a retired one, so a half-migrated estate is worse than a migrated one — the design rationale for the current no-prompt behavior. A consent gate would protect against unwanted mechanical moves at the cost of stalling every legacy project's first true-up on a question with only one sensible answer.

## Options

- **Silent-converge is canonical** — keep `concept:true-up`'s phase model; narrow `decision:whole-file-ownership`'s "earlier-version estates" clause to the cases that genuinely stop the skill today (hand-written overlaps, preexisting guidance, collisions); fix the front door's "proposes ... for consent" line to match. Text-only.
- **Consent is canonical** — amend true-up's skill and the front door to present retired-layout migration for an explicit yes. Matches whole-file-ownership's letter; reintroduces a stall the current design deliberately removed.
- **One canonical consent rule in `concept:true-up` Invariants** — either way, write the rule once so the surfaces stop drifting.

The ruling decides: is retired-layout migration silent-converge territory, and which artifact's wording yields?

## Ruling

> Recommended ruling (/verify-issues): silent-converge is canonical — state the consent rule once in `concept:true-up`'s Invariants (invoking the verb authorizes migration of the plugin's own retired layout; consent is for collisions and non-plugin-owned content), narrow `decision:whole-file-ownership`'s "earlier-version estates" example accordingly, and align the front door's one stray "for the owner's consent" line.
>
> Rationale: the code's behavior is recent and deliberate — the current true-up text argues the position ("leaving the estate half-migrated is worse than migrating it") rather than merely exhibiting it, and migration is mechanical and preserving by construction. The decision's letter should follow the reasoned, shipped intent, not the other way around.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
