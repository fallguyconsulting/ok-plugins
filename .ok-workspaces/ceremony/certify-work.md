# ok-workspaces — certification ceremony contribution

What the suite's certification gate does about this family's estate.
Materialized into consumer projects at
`.ok-workspaces/ceremony/certify-work.md`; the ceremony reads it there
when `.ok-workspaces/` exists.

## Requires

`.ok-workspaces/config.json` — the committed stack profile. The profile
decides which of this family's checks apply, so without it the
contribution adds nothing and says so in one line.

## Producers

One, at change scope: the discipline sweep below, run over the changed
files only. It is the same sweep the audit runs whole; here it reads
just what the change touched, so a pre-existing violation in an
untouched file is not this gate's finding.

Read `.ok-workspaces/config.json` first — the profile decides which
checks apply — then run each applicable check from
`.ok-workspaces/ceremony/audit.md` against the
changed set — its checks live under that contribution's **Determine**
stage.
Every hit is an ordinary finding for the ceremony's loop,
carrying its remediation class as advisory context.

One check is change-shaped rather than sweep-shaped and belongs only
here: a change that introduces a build artifact reference into a
verification path must resolve it through the run's own tag — the one
the profile's run-tag script minted for the run — not a mutable tag and
not a tag from an earlier run. The change is where that is cheap to fix
and obvious to see.

## Standing producers

None. This family's discipline sweep is change-shaped and runs once, cold, at the terminal gate.

## Boundaries

- Routes nothing. This family holds no intake; its findings drain
  through the ceremony's loop like every other producer's.
- Offers nothing at close-out: it has no artifact to archive.
- Never tears down a worktree, and never touches a checkout the change
  did not create.

<!-- Materialized by ok-workspaces v19.3.0 — suite-owned; overwritten on converge; do not hand-edit. -->
