<script>
  import { artifacts } from '../lib/api.js';
  import { href } from '../lib/route.js';

  export let kind;

  let filter = '';
  $: load = artifacts(kind);
  $: label = kind === 'story' ? 'Stories' : 'Decisions';

  const match = (a, q) =>
    !q ||
    a.slug.includes(q.toLowerCase()) ||
    a.title.toLowerCase().includes(q.toLowerCase());
</script>

<h2>{label}</h2>
<p class="sub">
  Each one with what its implementation audit determined, and how much code
  that audit cites. Open one to see the code itself.
</p>

<div class="filters">
  <input type="search" bind:value={filter} placeholder="filter by slug or title" />
</div>

{#await load}
  <p class="empty">Reading…</p>
{:then d}
  {@const rows = d.artifacts.filter((a) => match(a, filter))}
  {#if rows.length === 0}
    <p class="empty">Nothing matches.</p>
  {:else}
    <table>
      <thead>
        <tr>
          <th>slug</th>
          <th>title</th>
          <th>audit</th>
          <th>cites</th>
          <th>files</th>
        </tr>
      </thead>
      <tbody>
        {#each rows as a (a.slug)}
          <tr>
            <td class="mono"><a href={href(kind, a.slug)}>{a.slug}</a></td>
            <td>{a.title}</td>
            <td>
              {#if !a.has_audit}
                <span class="tag none">no audit</span>
              {:else}
                <span class="tag {a.determination}">{a.determination}</span>
                {#if a.stale > 0}
                  <span class="tag stale">{a.stale} stale</span>
                {/if}
              {/if}
            </td>
            <td>{a.citations}</td>
            <td>{a.files.length}</td>
          </tr>
        {/each}
      </tbody>
    </table>
  {/if}
{:catch e}
  <p class="empty">Could not read: {e.message}</p>
{/await}
