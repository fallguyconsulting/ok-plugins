<script>
  import { file } from '../lib/api.js';
  import { rendered, resolveLink, projectLinkAt } from '../lib/markdown.js';

  let { link, onclose } = $props();

  let dialog = $state(null);
  let trail = $state([]);
  let shown = $state(null);
  let failure = $state(null);
  let token = 0;

  let current = $derived(trail[trail.length - 1] ?? null);

  async function show(target) {
    const mine = ++token;
    shown = null;
    failure = null;
    try {
      const got = await file(target.path);
      if (mine === token) shown = got;
    } catch (e) {
      console.error('DASHBOARD.FILE.FAILED', { path: target.path, error: e.name, message: e.message, stack: e.stack });
      if (mine === token) failure = e.message;
    }
  }

  function go(target) {
    trail = [...trail, target];
  }

  function back() {
    trail = trail.slice(0, -1);
  }

  function follow(event) {
    const href = projectLinkAt(event);
    if (!href || !current) return;
    event.preventDefault();
    go(resolveLink(href, current.path));
  }

  const marked = (n) => current?.lines && n >= current.lines[0] && n <= current.lines[1];

  $effect(() => {
    trail = [link];
  });

  $effect(() => {
    if (current) show(current);
  });

  $effect(() => {
    if (dialog && !dialog.open) dialog.showModal();
  });

  $effect(() => {
    if (shown && current?.lines && dialog) {
      dialog.querySelector('.line.marked')?.scrollIntoView({ block: 'center' });
    }
  });
</script>

<dialog bind:this={dialog} class="file" onclose={onclose} onclick={(e) => e.target === dialog && dialog.close()}>
  <header>
    {#if trail.length > 1}<button class="link" onclick={back}>← back</button>{/if}
    <span class="mono path">{current?.path}{#if current?.lines} · lines {current.lines[0]}–{current.lines[1]}{/if}</span>
    <button class="link" onclick={() => dialog.close()} aria-label="Close">close <kbd>Esc</kbd></button>
  </header>
  <div class="content" onclick={follow} role="presentation">
    {#if failure}
      <p class="empty warn">Could not open {current?.path}: {failure}</p>
    {:else if shown === null}
      <p class="empty">Reading…</p>
    {:else if shown.kind === 'markdown'}
      <div class="md">{@html rendered(shown.text)}</div>
    {:else}
      <pre class="code">{#each shown.text.split('\n') as text, i (i)}<span class="line" class:marked={marked(i + 1)}><span class="no">{i + 1}</span>{text}
</span>{/each}</pre>
    {/if}
  </div>
</dialog>
