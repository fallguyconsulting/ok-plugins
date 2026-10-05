<script>
  import { issue, rule, comment, markRead, isNew, isTriage, isUnread, readOnly } from '../lib/api.js';
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
  let token = 0;

  let locked = $derived(record === null || readOnly(record));
  let acceptable = $derived(!locked && record.recommendation !== null);

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

  async function send(kind, text) {
    if (busy || locked) return;
    const mine = token;
    const target = record.id;
    const at = record.opened;
    busy = true;
    notice = null;
    try {
      await (kind === 'ruling' ? rule(target, text) : comment(target, text));
      const view = await issue(target, at);
      if (mine !== token) return;
      composing = null;
      draft = '';
      record = view;
      onchange(view);
    } catch (e) {
      console.error('DASHBOARD.POST.FAILED', { id: target, kind, error: e.name, message: e.message, stack: e.stack });
      if (mine === token) notice = e.message;
    } finally {
      busy = false;
    }
  }

  function accept() {
    if (acceptable) send('ruling', record.recommendation.text);
  }

  function compose(kind) {
    if (locked) return;
    composing = kind;
    draft = '';
    notice = null;
  }

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

  $effect(() => onKeys({ a: accept, r: () => compose('ruling'), c: () => compose('comment') }));

  $effect(() => {
    if (composing && box) box.focus();
  });
</script>

{#if failure}
  <p class="empty warn">Could not read issue {id}: {failure}</p>
{:else if record === null}
  <p class="empty">Reading…</p>
{:else}
  <article>
    <h2>{record.title}</h2>
    <p class="sub">
      <span class="mono">{record.id}</span>
      <span class="tag {record.state}">{record.state}</span>
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
    <div class="body">{record.problem}</div>

    {#if record.options.length > 0}
      <h3>Options</h3>
      <dl class="options">
        {#each record.options as o (o.label)}
          <dt>{o.label}</dt>
          <dd>{o.text}</dd>
        {/each}
      </dl>
    {/if}

    <h3>Recommendation</h3>
    {#if record.recommendation}
      <div class="body">
        <span class="tag">{record.recommendation.form}</span>
        {record.recommendation.text}
      </div>
    {:else}
      <p class="empty">Triage has written no recommendation.</p>
    {/if}

    <h3>Your ruling</h3>
    {#if record.ruling}
      <div class="body ruling">
        {record.ruling.text}
        <div class="sub">ruled {record.ruling.at}</div>
      </div>
    {:else}
      <p class="empty">No ruling yet.</p>
    {/if}

    {#if record.upstream}
      <h3>Upstream issue</h3>
      <div class="body">{record.upstream}</div>
    {/if}

    <h3>Thread</h3>
    {#if record.messages.length === 0}
      <p class="empty">No messages yet.</p>
    {:else}
      <ol class="thread">
        {#each record.messages as m (m.n)}
          <li class:triage={isTriage(m)} class:fresh={isTriage(m) && (fresh.has(m.n) || isNew(m))}>
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
            </div>
            <div class="text">{m.text}</div>
          </li>
        {/each}
      </ol>
    {/if}

    {#if !locked}
      <div class="actions">
        <button disabled={!acceptable || busy} onclick={accept}>
          Accept the recommendation <kbd>a</kbd>
        </button>
        <button disabled={busy} onclick={() => compose('ruling')}>Rule <kbd>r</kbd></button>
        <button disabled={busy} onclick={() => compose('comment')}>Comment <kbd>c</kbd></button>
      </div>
      {#if composing}
        <div class="compose">
          <label for="draft">{composing === 'ruling' ? 'Your ruling' : 'Your comment'}</label>
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
{/if}
