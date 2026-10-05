# Plumbline Coding Rules

Materialized by ok-planner v23.0.0. Suite-owned: overwritten wholesale by the front door's administration (`/ok`); project-specific rules belong in your own files under `.claude/rules/`.

Rules for every agent that writes or fixes code in this project. Each rule names the step to perform and the evidence to leave, so a reviewer can check the step ran. The rules come from about 870 verified defects found in review across 17 certification runs on two projects; each rule names the failure it prevents. The plumbline cheatsheet governs the shape of the code; this file governs the act of changing it.

## 1. Enumerate before you edit

Prevents: a definition changed and some of its callers, siblings, templates, docs, or corpus text left in the old form; helpers, templates, and styles orphaned by a deletion.

1. Before changing a definition (a signature, a constant, a name, a module, a term, a column, a config list), run `rg` for the symbol and for every literal that restates it, across code, templates, static assets, docs examples, config lists, and the design corpus.
2. Write the list of sites into the task note before the first edit.
3. Edit every site on the list in the same change.
4. After deleting a symbol, `rg` for every symbol only it used (helpers, templates, CSS classes, constants, list entries) and delete those too.
5. Close with the list and the count. A close that names one site for a definition with callers is not done.

## 2. Copy the sibling's shape

Prevents: an error handler, event emission, transaction, teardown, or command body written in a shape the package does not use.

1. Before writing an error handler, an event emission, a transaction, a teardown, a lock, a CLI command body, or a retry loop, find the nearest site in the same file or package that does the same job.
2. Match its shape: the exceptions it catches, the wrapper it runs inside, the event it emits, the lock it holds, the order of its steps.
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

Prevents: cleanup skipped on the error branch; a catch that converts, re-emits, or defaults where nothing acts on the error; an owner frame with no catch-all; a caught error that ends in a log line or a silent default.

1. For every function that acquires, opens, mutates, or registers something (a socket, a module path, a temp file, a global, a queue, a subscription), list every exit: each return, each raise, each call that can raise.
2. Cleanup runs on every exit. Use `try/finally`. A cleanup loop attempts every item and raises the first failure after the loop, never abandons the rest on the first raise.
3. Catch an exception only where the catching code does something different because of it. Below an owner frame, a catch stands only where its handler does one of these:
   - retries within a budget;
   - takes a different branch, or returns a value the caller acts on;
   - answers a specific response status or refusal the user acts on;
   - releases what the function acquired, then re-raises with a bare `raise`.

   Where the handler acts on a family, read the callee's source or docs and catch the whole family. One subclass of a family is not the family; a decode error is not an I/O error.
4. Every other exception propagates to the owner frame of its unit of work: a CLI command body, a route handler, a message callback, a thread body, a process main. The owner frame catches the top-level type, the one place that is allowed. It emits one event and maps the raise to a recorded state: rest in error, retry within a budget, or continue. The project's event helper attaches the stack trace to every caught-error event emitted while an exception is in flight, so the owner frame's event names the library, the type, and the line that failed. The project names that helper in its own rules.
5. A boundary wrapper (the frame that dials, queries, reads a file, spawns, or calls foreign code) lets its library's errors propagate to the owner frame. The tree needs no named tuple per library. Write no catch that only converts one exception type to another, only emits and re-raises, or logs and continues with a default. An existing conversion stands where a caller catches the converted type by name; removing it is a change to that caller.
6. A caught error never ends in a bare log line or a silent default. Its handler acts under step 3, or it re-raises.
7. A retry budget covers every failure branch of the loop, not only the branch you first walked.
8. Check a value an end user supplies through the public surface where it enters, and refuse it with a message the user can act on. A raise that reaches the owner frame is not an answer to a user's mistake.
9. In review, a library error escaping a function is not a defect. The defects are an owner frame with no catch-all, and a catch that swallows an error its caller never learns of.

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

## 8. A defect is one instance of a class

Prevents: a fix that closes the named site and leaves its siblings, so the same class returns round after round; a fix that introduces the next defect beside the one it closed.

1. Read the defect as one member of a class. Name the class in the note, enumerate its members with `rg`, and fix all of them in this change.
2. Read the sibling of the site the defect names before editing it (rule 2). The defect's reporter saw the sibling, and the fix must match it.
3. After the fix, apply rules 3 and 4 to your own diff: every exit walked, every shared field under the lock.
4. Do not widen a fix into a new mechanism (a retry loop where a bounded attempt count stood, a renamed idiom across the tree) unless the defect's report asks for it. A fix that changes what the project commits to is a fork, not a fix.
5. Run the project's lint before closing. A standard-library name that reintroduces a retired word is a defect.

## 9. Close with the record

Prevents: untracked files, scratch files left in the tree, derived catalogs left stale, a close the reviewer reopens for missing evidence.

1. Stage every path you touched, by name. `git status` before closing shows nothing untracked that you created.
2. Delete scratch files and probes before closing.
3. Regenerate every derived catalog or index the change affects, and run its check.
4. The task note carries: the enumeration from rule 1 and the sibling cited under rule 2. Where the task tracker takes `--sites`, the enumeration goes there as well, one `path[:locator]` per site.
