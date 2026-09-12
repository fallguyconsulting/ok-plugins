# Plumbline Coding Rules

Materialized by ok-plumbline v{{OK_PLUMBLINE_VERSION}}. Suite-owned: overwritten wholesale by the front door's administration (`/ok`); project-specific rules belong in your own files under `.claude/rules/`.

Rules for every agent that writes or fixes code in this project. Each rule names the step to perform and the evidence to leave, so a reviewer can check the step ran. The rules come from about 870 verified review findings across 17 certification runs on two projects; each rule names the failure it prevents. The plumbline cheatsheet governs the shape of the code; this file governs the act of changing it.

## 1. Enumerate before you edit

Prevents: a definition changed and some of its callers, siblings, templates, docs, or corpus text left in the old form; helpers, templates, and styles orphaned by a deletion.

1. Before changing a definition (a signature, a constant, a name, a module, a term, a column, a config list), run `rg` for the symbol and for every literal that restates it, across code, templates, static assets, docs examples, config lists, and the design corpus.
2. Write the list of sites into the task note before the first edit.
3. Edit every site on the list in the same change.
4. After deleting a symbol, `rg` for every symbol only it used (helpers, templates, CSS classes, constants, list entries) and delete those too.
5. Close with the list and the count. A close that names one site for a definition with callers is not done.

## 2. Copy the sibling's shape

Prevents: an error handler, event emission, transaction, teardown, or command body written in a shape the package does not use; a guard placed outside the wrapper that owns the error contract.

1. Before writing an error handler, an event emission, a transaction, a teardown, a lock, a CLI command body, or a retry loop, find the nearest site in the same file or package that does the same job.
2. Match its shape: the exception tuple it catches, the wrapper it runs inside, the event it emits, the lock it holds, the order of its steps.
3. Where no sibling exists in the package, find one in the tree and cite it in the note.
4. Where you depart from the sibling's shape, say why in the note.

## 3. One state change, one transaction

Prevents: writes split across transactions; check-then-write races; a second thread added to shared state with no lock; teardown races.

1. A change that writes more than one row, file, or resource runs inside one transaction or one atomic replace (write to a temp path, then rename). Never a sequence of separately committed calls.
2. Every check-then-write holds a row lock or reads the affected-row count of the write and raises on zero. Never a plain read followed by a conditional write.
3. A value the write records (a digest, a timestamp, a position) is read inside the transaction that writes it, never passed in from an earlier read.
4. When you add a thread, list every field the threads share and name the lock that guards each read and each write of it, the error branch included. Every read that decides a write, and every emit that reports the state, sits inside the lock.
5. A flag that guards teardown is set under a lock; a check-then-set on a bare event is a race.
6. Elapsed time is computed from one clock, never a timestamp from one clock subtracted from a timestamp from another.
7. A mark another writer may set is cleared conditionally on the value you acted on, never unconditionally.

## 4. Walk every exit of a function that holds state

Prevents: cleanup skipped on the error branch; an exception class too narrow or too broad; a caught error that ends in a log line or a silent default.

1. For every function that acquires, opens, mutates, or registers something (a socket, a module path, a temp file, a global, a queue, a subscription), list every exit: each return, each raise, each call that can raise.
2. Cleanup runs on every exit. Use `try/finally`. A cleanup loop attempts every item and raises the first failure after the loop, never abandons the rest on the first raise.
3. Enumerate what the callee can raise by reading its source or docs, then catch the class that covers the whole family. One subclass of a family is not the family; a decode error is not an I/O error. The cheatsheet's rule against catching a bare top-level type holds everywhere but one place: a thread that must always signal it left wraps its body in `try/finally` so the signal runs on every exit, and re-raises what it caught.
4. A caught error never ends in a bare log line or a silent default. It emits a structured event or re-raises. A branch taken on external input emits.
5. A retry budget covers every failure branch of the loop, not only the branch you first walked.
6. An operation that converts errors for a caller runs inside the wrapper that does the converting. Raising the caller's error type outside the wrapper is the same as not converting.

## 5. Before you delete, list what it alone provides

Prevents: removing the named route or column writer and, with it, the only write path or the only proof of a capability the design still claims.

1. Before deleting a route, verb, or column writer, list what it alone provides: the only writer of a column, the only site that realizes a story or decision (read the citation annotations on what you delete), the only surface for a capability.
2. Where the deletion removes the only writer or the only site that realizes something the design corpus still claims, stop the deletion at that point and record a fork.
3. After the deletion, `rg` the design corpus for the retired term and the retired mechanism, and fix every sentence that still describes it, titles included.

## 6. Import, never copy

Prevents: logic and constants copied into a second module; two copies kept in agreement instead of collapsed.

1. Before writing a function, `rg` for its name, its constants, and its distinctive expressions. Where it exists, import it.
2. Where a dependency-split rule seems to block the import, read what the module actually imports before assuming. An empty package init and a module of standard-library imports is not a heavy dependency.
3. Where two copies disagree, delete one copy. Making two copies agree is not a fix.

## 7. Enumerate the inputs a command accepts

Prevents: exclusive flags accepted silently; numeric-looking text coerced to a number; a bound the previous code enforced dropped; a status missing from the set that decides the exit code.

1. List every flag and every pair of flags. Refuse mutually exclusive combinations up front; never take the first branch and drop the rest silently.
2. When replacing a validator or a typed option, list what the old one refused (a minimum, a length bound, a type) and keep each refusal.
3. Coerce user text by the declared type of the parameter, never by what the text looks like.
4. A set that decides an exit code or a state transition names every member; when adding a state, add it to the set.
5. The message the command prints names the action taken on that branch, not the action taken on the common branch.
6. Every predicate that filters live rows names the liveness column. Every filter runs in the query before the limit, never in application code after it.

## 8. A finding is one instance of a class

Prevents: a fix that closes the named site and leaves its siblings, so the same class returns round after round; a fix that introduces the next defect beside the one it closed.

1. Read the finding as one member of a class. Name the class in the note, enumerate its members with `rg`, and fix all of them in this change.
2. Read the sibling of the site the finding names before editing it (rule 2). The finding's author saw the sibling, and the fix must match it.
3. After the fix, apply rules 3 and 4 to your own diff: every exit walked, every shared field under the lock.
4. Do not widen a fix into a new mechanism (a retry loop where a bounded attempt count stood, a renamed idiom across the tree) unless the finding asks for it. A fix that changes what the project commits to is a fork, not a fix.
5. Run the project's lint before closing. A standard-library name that reintroduces a retired word is a finding.

## 9. Close with the record

Prevents: untracked files, scratch files left in the tree, derived catalogs left stale, a close the reviewer reopens for missing evidence.

1. Stage every path you touched, by name. `git status` before closing shows nothing untracked that you created.
2. Delete scratch files and probes before closing.
3. Regenerate every derived catalog or index the change affects, and run its check.
4. The task note carries: the enumeration from rule 1 and the sibling cited under rule 2. Where the task tracker takes `--sites`, the enumeration goes there as well, one `path[:locator]` per site.
