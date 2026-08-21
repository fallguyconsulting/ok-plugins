---
decision: open-refuses-an-occupied-workspace
---

# Opening a workspace refuses an occupied name and carries only ignored local files

## Choice

Opening a workspace stops and reports when the job's directory or its
branch already exists; it never reuses or clobbers one. The only files
that cross from the main checkout into the new workspace are the local
environment files the repository ignores, and the run lists what it
copied. The tracked tree arrives with the checkout itself.

## Rationale

A workspace is one job's isolated place of work, so reusing an occupied
name merges two jobs into one tree — the collision the whole discipline
exists to prevent. Refusing is the only response that leaves the
earlier job's work intact. Copying only ignored files keeps the
carry-over honest: a tracked file copied across would overwrite the new
branch's version with another branch's, and the files worth carrying
are the ones no branch holds. Listing them keeps a silent copy from
becoming a surprise.

## Alternatives

- Reuse an existing worktree for the same job slug — convenient when a
  job resumes, and indistinguishable from two jobs colliding on one
  name.
- Delete and recreate an occupied workspace — always yields a clean
  tree, and destroys uncommitted work whose owner never asked for that.
- Carry the whole main checkout's working state, tracked edits included
  — the new workspace starts where the owner was, and it starts with
  another branch's edits presented as its own.
