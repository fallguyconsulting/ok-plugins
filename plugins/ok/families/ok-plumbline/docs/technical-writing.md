# Technical writing: the standard

Every document, report, comment, and commit message in this project
is technical writing, and this standard governs all of it. One test
decides whether a sentence belongs: a reader who knows the system
parses it once and can act on it. Nothing else makes a sentence
good — not variety, not elegance, not the sound of authority.

## The philosophy

Prose is a window onto the system. The writer looks at something
real, sees it clearly, and shows it to the reader (Thomas & Turner
call this classic style). The writing succeeds when the reader sees
the thing; it fails when the reader sees the writing.

The main obstacle is the curse of knowledge (Pinker): you know what
you meant, so every phrasing looks clear to you. You cannot check
your own clarity by rereading. Check it by mechanism instead — the
rules below are all mechanical.

## The spine: actors and actions

Readers parse a sentence by looking for an actor in the subject and
its action in the verb (Williams). Every sentence you write names a
real thing in the system doing a real thing: the operator retires
the stream; the converge writes the file; the checker rejects the
heading.

Wrong: "In practice retirement follows quiet."
Right: "By the time an operator retires a stream, the stream has
usually stopped receiving payloads."

The wrong version turns two events into abstract nouns and relates
the nouns. No one does anything, so the reader must reconstruct who
does what — the work the writer was supposed to do.

## The ban list

Each entry names a vice. The name matters: an agent told to "write
plainly" believes it already does; an agent told "no elegant
variation" can check.

1. **Elegant variation** (Fowler). Calling the stream "the
   discarded remainder" because "the stream" was just used. One
   name per thing, chosen once, repeated forever. Repeating a term
   of art is correct, not clumsy. A fresh description is a new
   puzzle for the reader — and it drifts: "the discarded remainder
   is empty" is nonsense the writer never noticed because the
   writer was watching the words, not the stream.

2. **Abstractitis** (Gowers). Nominalizing actions into event nouns
   — "retirement", "convergence", "the projection" — and then
   writing about the nouns. The actor disappears. Convert the noun
   back to a verb and give it its subject.

3. **Decorative examples.** An example pair set off with dashes —
   like the gem's "a decommissioned fleet, a finished experiment" —
   that illustrates nothing the sentence needs. Every example makes
   the reader stop and check whether it narrows or widens the
   claim. Include an example only where the reader would otherwise
   have to ask "like what?"

4. **Braided sentences.** Cause, condition, and consequence woven
   into one sentence with "so" and "which". One claim per
   sentence. Let sentences be short; the period is free.

5. **Metaphor without a picture.** "Retirement follows quiet" is a
   metaphor the writer never visualized; that is why it broke.
   Use a metaphor only when it carries load a literal sentence
   cannot, and hold it consistent while it lasts (Orwell).

6. **Throat-clearing.** "In practice", "essentially", "of course",
   "it is worth noting". If deleting the phrase changes nothing,
   delete it.

## The fix procedure

Lanham's paramedic method, adapted. When a sentence smells wrong:

1. Find the real action. It is usually hiding in an abstract noun.
2. Find the real actor. Ask: who is doing this to what?
3. Make the actor the subject and the action the verb.
4. Delete what remains that no longer has a job.

Applied to the gem: the actions are *retire* and *stop receiving*;
the actors are the operator and the stream. "Streams have usually
stopped receiving payloads by the time an operator retires them."
Everything else in the original sentence fails step 4.

## Order within the sentence

Readers expect the start of a sentence to name what they already
know and the end to carry the news (Gopen). Start from the
established term; put the payload last. If a sentence buries its
point in the middle, the reader assigns emphasis to the wrong
words no matter how plain they are.

## Acceptance tests

Run both before keeping a paragraph:

- **The one-pass test.** A reader who knows the system parses each
  sentence in one pass. If you suspect a sentence needs two, it
  does.
- **The whiteboard test.** Say the sentence aloud to a colleague at
  a whiteboard. If you would not say it — you would never say "in
  practice retirement follows quiet" — do not write it.

## The dispatch rule

The paragraph below is the portable form of this standard. Embed it
verbatim in any prompt that directs an agent to write prose a human
will read.

> Write technical prose, not literary prose. Every sentence names a
> concrete actor as its subject and its action as the verb. One
> name per thing: pick the established term and repeat it; never
> re-describe a thing in fresh words. One claim per sentence. No
> examples unless the sentence is unclear without one. No metaphor,
> no "in practice"/"essentially" padding. Test: a reader who knows
> the system must parse each sentence in one pass, and you would
> say the sentence aloud to a colleague. When in doubt, write the
> short obvious sentence.
