<script>
  import { onKeys } from '../lib/keys.js';
  import { isUnread, key } from '../lib/api.js';

  let { rows, selected, loading, failure, archive, link, onselect } = $props();

  let marks = $state({});
  let queued = [];

  let chosen = $derived(
    selected === null
      ? null
      : (rows.find((v) => v.id === selected.id && (selected.opened === null || v.opened === selected.opened)) ?? null),
  );
  let current = $derived(chosen === null ? null : key(chosen));

  function step(by) {
    if (rows.length === 0) return;
    const from = queued.at(-1) ?? current;
    const at = rows.findIndex((v) => key(v) === from);
    const next = at === -1 ? (by > 0 ? 0 : rows.length - 1) : Math.min(rows.length - 1, Math.max(0, at + by));
    if (key(rows[next]) === from) return;
    queued.push(key(rows[next]));
    onselect(rows[next]);
  }

  $effect(() => {
    if (current === queued.at(-1) || !queued.includes(current)) queued = [];
  });

  $effect(() => onKeys({ j: () => step(1), k: () => step(-1) }));

  $effect(() => {
    const row = current && marks[current];
    if (row) row.scrollIntoView({ block: 'nearest' });
  });
</script>

{#if failure}
  <p class="empty warn">Could not read the intake: {failure}</p>
{:else if loading && rows.length === 0}
  <p class="empty">Reading…</p>
{:else if rows.length === 0}
  <p class="empty">Nothing here.</p>
{:else}
  <table>
    <thead>
      <tr>
        <th>issue</th>
        <th>category</th>
        <th>{archive ? 'closed as' : 'state'}</th>
        <th>thread</th>
      </tr>
    </thead>
    <tbody>
      {#each rows as v (key(v))}
        <tr bind:this={marks[key(v)]} class:on={key(v) === current}>
          <td>
            <a class="title" href={link(v)}>{v.title}</a>
            <div class="mono sub">{v.id}</div>
          </td>
          <td><span class="tag">{v.category}</span></td>
          <td>
            {#if archive}
              <span class="tag">{v.closed_as}</span>
            {:else}
              <span class="tag {v.state}">{v.state}</span>
              {#if v.sprint}<span class="tag">promoted</span>{/if}
            {/if}
          </td>
          <td>
            {#if isUnread(v)}<span class="tag new">{v.unread} new</span>{/if}
            {#if v.unseen > 0}<span class="tag pending">{v.unseen} not yet seen</span>{/if}
          </td>
        </tr>
      {/each}
    </tbody>
  </table>
{/if}
