---
issue: converge-removes-hand-edited-workspaces-profile
kind: audit
category: product-intent
artifacts:
  - story:converge-project-estate
  - decision:whole-file-ownership
status: verified
triage: question
opened: 2026-10-04T23:34:00Z
---

# Converge deletes the retired workspaces profile without asking, even when the owner added keys to it

The suite used to ship a separate workspaces family. Its estate, `.ok-workspaces/`, held a profile, `.ok-workspaces/config.json`, that the family's `resolve` step wrote from the owner's answers about the project (its stacks and runtime). The owner could also add keys by hand. The suite has since retired that family into ok-planner. When an owner runs `/ok` on a project that still carries the old estate, the converge core removes the estate. It deletes a committed profile with `git rm`, asks nothing, and prints one line: `removed: .ok-workspaces/config.json (git rm; staged)`. This holds even when the owner edited the profile. The content survives only in git history.

story:converge-project-estate promises that "upgrading the suite never costs me work I wrote". Whether a deletion that git can undo costs the owner work is the question.

## Mechanism

`workspaces_plan` in `plugins/ok/families/ok-planner/admin/converge` lists `config.json` among the retired estate's top-level names. Every file under such a name becomes a removal candidate. The core turns a candidate into a cleanup offer only when the file carries uncommitted changes or sits behind a symbolic link. Otherwise it removes the file. The core judges owner content by git state alone, never by what the file holds. It keeps the profile only while an old `port-block` script that reads it stays, or while the profile names a `run-tag` path outside the estate. Nothing else reads the profile now.

The product's administration document already describes this behavior (`plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`, "The ok-workspaces estate retires", step 3): the profile goes "with `git rm` where git tracks them, so each is recoverable", and an uncommitted or symlinked one is an `estate-edits` offer instead.

The plumbline migration in the same core treats the same kind of file differently. The retired `/budget` ratchet left a baseline file, `budget.json`, that nothing reads now. The core does not remove it; it makes a `retired-file` offer whose fix deletes it. The plumbline migration also offers every file it does not recognize (`estate-leftover`) and every unstamped suite file (`estate-edits`), and it asks about a lint config that collides with the new one (`config-conflict`).

A driver in sprint certification run converge-2026-10-04T060800 reproduced the removal (drive failure i25). It declared the profile through v23.0.0's `resolve`, set `stacks` to `["node"]`, added an owner key `cpeOwnerKey`, committed, and ran the current core. Diagnose reported the five estate files as a pending removal, and converge removed the profile with `git rm`.

## The corpus allows two readings

decision:whole-file-ownership makes the suite's own retired-layout content "suite territory, migrated mechanically under the administration's own authorization", and its Alternatives reject consent-gating that migration, which "stalls every legacy project's first converge on a question with one sensible answer". The same decision says owner-declared configuration "is written only as transcription of explicit answers", and that anything else at a path the suite cares about "is presented for the owner's decision". decision:administration-is-a-user-act reserves consent inside the run "for content the suite does not own, and for transcription into owner-declared configuration". Neither decision says whether a retired estate's owner-declared configuration counts as the suite's retired-layout content.

The harm is narrow. An owner's hand-added key leaves the working tree with one report line as notice, and `git rm` keeps it recoverable. No accept-list entry needs to cover a judgment issue; A2 (cleanup reaches something it did not create) is the nearest.

## Options

1. Amend story:converge-project-estate or decision:whole-file-ownership to say converge removes a retired estate's owner-declared configuration whole, recoverable from version history, and names each removed file in its report. Cost: an owner's hand-added keys leave with only a report line; the code and the administration document already match.
2. Amend decision:whole-file-ownership to say owner-declared configuration in a retired estate, edited or not, reaches the owner as a cleanup offer before converge removes it, as the `/budget` baseline already does. Cost: a code change in `workspaces_plan`, an administration-document change, and one more question on the first converge of every project that used the workspaces family.
3. Offer the profile only when it holds content beyond what the retired `resolve` would write, and remove a profile the suite could have regenerated. Cost: the core must carry the retired profile's schema and defaults to compare against, and the corpus still needs a sentence saying edited owner configuration in a retired estate is offered.

The ruling decides whether owner-declared configuration in a retired estate is the suite's to delete or the owner's to release.

## Ruling

Option 1. A retired family's state files (the workspaces profile, the plumbline `/budget` baseline) are skill-family state, not owner work: where nothing reads them after converge, converge removes them whole on its own authority, recoverable from version history, and names each removed file in its report. Amend decision:whole-file-ownership to say so. The `/budget` baseline's `retired-file` offer becomes the same silent removal, so both retired state files take one path. A profile a kept old script still reads stays, as today.
