<script>
  import {
    issue, rule, comment, markRead, editMessage, removeMessage, unrule, flag,
    isNew, isTriage, isOwn, untouched, isUnread, readOnly,
  } from '../lib/api.js';
  import { rendered, resolveLink, projectLinkAt } from '../lib/markdown.js';
  import FileModal from './FileModal.svelte';
  import { wordDiff } from '../lib/diff.js';
  import { onKeys, submits, cancels } from '../lib/keys.js';

  let { id, opened, onchange } = $props();

  let record = $state(null);
  let failure = $state(null);
  let notice = $state(null);
  let fresh = $state(new Set());
  let composing = $state(null);
  let draft = $state('');
  let busy = $state(false);
  let box = $state(null);
  let viewing = $state(null);
  let openDiffs = $state(new Set());
  let token = 0;

  let locked = $derived(record === null || readOnly(record));
  let accepted = $derived(
    record !== null && record.ruling !== null && record.recommendation !== null &&
      record.ruling.text === record.recommendation.text,
  );
  let acceptable = $derived(!locked && record.recommendation !== null && !accepted);

  async function open(target, at) {
    const mine = ++token;
    record = null;
    failure = null;
    notice = null;
    composing = null;
    draft = '';
    let view;
    try {
      view = await issue(target, at);
    } catch (e) {
      console.error('DASHBOARD.ISSUE.FAILED', { id: target, opened: at, error: e.name, message: e.message, stack: e.stack });
      if (mine === token) failure = e.message;
      return;
    }
    if (mine !== token) return;
    record = view;
    fresh = new Set(view.messages.filter(isNew).map((m) => m.n));
    if (!isUnread(view)) return;
    try {
      await markRead(view.id, view.opened);
      if (mine === token) onchange({ ...view, unread: 0 });
    } catch (e) {
      console.error('DASHBOARD.READ.FAILED', { id: target, error: e.name, message: e.message, stack: e.stack });
      if (mine === token) notice = `Could not mark the triage messages read: ${e.message}`;
    }
  }

  function call(kind, target, text) {
    if (kind === 'ruling') return rule(target, text);
    if (kind === 'comment') return comment(target, text);
    return editMessage(target, kind.edit, text);
  }

  function send(kind, text) {
    return act(kind, (target) => call(kind, target, text));
  }

  async function act(kind, change) {
    if (busy || locked) return;
    const mine = token;
    const target = record.id;
    const at = record.opened;
    busy = true;
    notice = null;
    try {
      await change(target);
      const view = await issue(target, at);
      if (mine !== token) return;
      composing = null;
      draft = '';
      record = view;
      onchange(view);
    } catch (e) {
      console.error('DASHBOARD.POST.FAILED', { id: target, kind: JSON.stringify(kind), error: e.name, message: e.message, stack: e.stack });
      if (mine === token) notice = e.message;
    } finally {
      busy = false;
    }
  }

  function accept() {
    if (acceptable) send('ruling', record.recommendation.text);
  }

  function compose(kind, text = '') {
    if (locked) return;
    composing = kind;
    draft = text;
    notice = null;
  }

  function openLink(event) {
    const href = projectLinkAt(event);
    if (!href) return;
    event.preventDefault();
    viewing = resolveLink(href);
  }

  function toggleDiff(n) {
    const next = new Set(openDiffs);
    if (next.has(n)) next.delete(n);
    else next.add(n);
    openDiffs = next;
  }

  const withdrawRuling = () => act('unrule', (target) => unrule(target));
  const toggleFlag = () => act('flag', (target) => flag(target, !record.flagged));
  const remove = (m) => act('remove', (target) => removeMessage(target, m.n));
  const label = (kind) =>
    kind === 'ruling' ? 'Your ruling' : kind === 'comment' ? 'Your comment' : `Edit message #${kind.edit}`;

  function typed(event) {
    if (submits(event)) {
      event.preventDefault();
      send(composing, draft);
    } else if (cancels(event)) {
      event.preventDefault();
      composing = null;
      draft = '';
    }
  }

  $effect(() => {
    open(id, opened);
  });

  $effect(() => onKeys({ a: accept, r: () => compose('ruling'), c: () => compose('comment'), f: toggleFlag }));

  $effect(() => {
    if (composing && box) box.focus();
  });
</script>

{#if failure}
  <p class="empty warn">Could not read issue {id}: {failure}</p>
{:else if record === null}
  <p class="empty">Reading…</p>
{:else}
  <article onclick={openLink} role="presentation">
    <h2>{record.title}</h2>
    <p class="sub">
      <span class="mono">{record.id}</span>
      <span class="tag {record.state}">{record.state}</span>
      {#if record.flagged}<span class="tag flagged">flagged for discussion</span>{/if}
      <span class="tag">{record.category}</span>
      <span class="tag">{record.kind}</span>
      {#if record.route}<span class="tag">route: {record.route}</span>{/if}
      {#each record.artifacts as a (a)}<span class="tag mono">{a}</span>{/each}
    </p>

    {#if record.state === 'closed'}
      <div class="announce">
        <div>Closed as {record.closed_as} at {record.closed}. This record is read-only.</div>
        {#if record.reason}<div>Reason: {record.reason}</div>{/if}
        {#if record.fixed_by}<div>Fixed by {record.fixed_by}</div>{/if}
        {#if record.sprint}<div>Sprint: {record.sprint}</div>{/if}
      </div>
    {:else if record.sprint}
      <div class="announce">Promoted into {record.sprint}. This record is read-only.</div>
    {/if}

    <h3>Problem</h3>
    <div class="body md">{@html rendered(record.problem)}</div>

    {#if record.options.length > 0}
      <h3>Options</h3>
      <dl class="options">
        {#each record.options as o (o.label)}
          <dt>{o.label}</dt>
          <dd class="md">{@html rendered(o.text)}</dd>
        {/each}
      </dl>
    {/if}

    <h3>Recommendation</h3>
    {#if record.recommendation}
      <div class="body">
        <span class="tag">{record.recommendation.form}</span>
        <div class="md">{@html rendered(record.recommendation.text)}</div>
      </div>
    {:else}
      <p class="empty">Triage has written no recommendation.</p>
    {/if}

    <h3>Your ruling</h3>
    {#if record.ruling}
      <div class="body ruling">
        <div class="md">{@html rendered(record.ruling.text)}</div>
        <div class="sub">
          ruled {record.ruling.at}
          {#if !locked}
            · <button class="link" disabled={busy} onclick={withdrawRuling}>Withdraw ruling</button>
          {/if}
        </div>
      </div>
    {:else}
      <p class="empty">No ruling yet.</p>
    {/if}

    {#if record.upstream}
      <h3>Upstream issue</h3>
      <div class="body md">{@html rendered(record.upstream)}</div>
    {/if}

    <h3>Thread</h3>
    <div class="thread-frame">
    {#if record.messages.length === 0}
      <p class="empty">No messages yet.</p>
    {:else}
      <ol class="thread">
        {#each record.messages as m (m.n)}
          <li
            class:triage={isTriage(m)}
            class:fresh={isTriage(m) && (fresh.has(m.n) || isNew(m))}
            class:withdrawn={Boolean(m.withdrawn)}
          >
            <div class="sub">
              <span class="mono">#{m.n}</span>
              {#if isTriage(m)}
                triage · {m.type}
                {#if m.replies_to}to {m.replies_to.map((n) => `#${n}`).join(', ')}{/if}
                {#if m.changed}(changed {m.changed.join(', ')}){/if}
                {#if fresh.has(m.n) || isNew(m)}<span class="tag new">new</span>{/if}
              {:else}
                you · {m.type}
                {#if m.seen}
                  <span class="tag">seen by triage {m.seen}</span>
                {:else}
                  <span class="tag pending">not yet seen by triage</span>
                {/if}
              {/if}
              · {m.at}
              {#if m.edited}<span class="tag">edited {m.edited}</span>{/if}
              {#if m.withdrawn}<span class="tag">withdrawn {m.withdrawn}</span>{/if}
              {#if isOwn(m) && !m.withdrawn && !locked}
                · <button class="link" disabled={busy} onclick={() => compose({ edit: m.n }, m.text)}>Edit</button>
                · <button class="link" disabled={busy} onclick={() => remove(m)}>
                  {untouched(record, m) ? 'Remove' : 'Withdraw'}
                </button>
              {/if}
            </div>
            {#if m.type === 'update'}
              <div class="revision">
                {#if m.diff}
                  <button class="link" onclick={() => toggleDiff(m.n)}>
                    {openDiffs.has(m.n) ? '▾' : '▸'} {m.text}
                  </button>
                {:else}
                  {m.text}
                {/if}
              </div>
              {#if m.diff && openDiffs.has(m.n)}
                {#each Object.entries(m.diff) as [field, change] (field)}
                  <div class="diff">
                    <div class="sub mono">{field}</div>
                    <p class="words">{#each wordDiff(change.before, change.after) as part, i (i)}<span class={part.kind}>{part.text}</span>{/each}</p>
                  </div>
                {/each}
              {/if}
            {:else}
              <div class="text md">{@html rendered(m.text)}</div>
            {/if}
            {#if m.earlier}
              <details class="earlier">
                <summary>earlier text ({m.earlier.length})</summary>
                {#each m.earlier as e, i (i)}<div class="md">{@html rendered(e)}</div>{/each}
              </details>
            {/if}
          </li>
        {/each}
      </ol>
    {/if}
    </div>

    {#if !locked}
      <div class="actions">
        <button disabled={!acceptable || busy} onclick={accept}>
          {accepted ? 'Accepted' : 'Accept the recommendation'} <kbd>a</kbd>
        </button>
        <button disabled={busy} onclick={() => compose('ruling')}>Rule <kbd>r</kbd></button>
        <button disabled={busy} onclick={() => compose('comment')}>Comment <kbd>c</kbd></button>
        <button disabled={busy} onclick={toggleFlag}>
          {record.flagged ? 'Unflag' : 'Flag for discussion'} <kbd>f</kbd>
        </button>
      </div>
      {#if composing}
        <div class="compose">
          <label for="draft">{label(composing)}</label>
          <textarea id="draft" bind:this={box} bind:value={draft} onkeydown={typed} rows="5"></textarea>
          <div class="sub">
            <kbd>Ctrl</kbd>/<kbd>⌘</kbd>+<kbd>Enter</kbd> sends · <kbd>Esc</kbd> cancels
          </div>
        </div>
      {/if}
    {/if}
    {#if notice}
      <p class="empty warn">{notice}</p>
    {/if}
  </article>
  {#if viewing}
    <FileModal link={viewing} onclose={() => (viewing = null)} />
  {/if}
{/if}
