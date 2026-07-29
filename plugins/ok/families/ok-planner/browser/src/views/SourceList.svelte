<script>
  import { sources } from '../lib/api.js';
  import { href } from '../lib/route.js';

  let filter = '';
  let unclaimedOnly = false;
  const load = sources();

  const claimed = (s) => s.line_claims > 0 || s.file_claims > 0;
  const pct = (s) => (s.lines ? Math.round((s.claimed_lines / s.lines) * 100) : 0);
</script>

<h2>Code</h2>
<p class="sub">
  Every source the committed graph mirrors, and what claims it. Sources nothing
  claims are listed here, not left implicit — an empty row is a finding, not an
  absence of information.
</p>

<div class="filters">
  <input type="search" bind:value={filter} placeholder="filter by path" />
  <label class="chk">
    <input type="checkbox" bind:checked={unclaimedOnly} />
    only sources nothing claims
  </label>
</div>

{#await load}
  <p class="empty">Reading…</p>
{:then d}
  {@const rows = d.sources.filter(
    (s) => (!filter || s.path.includes(filter)) && (!unclaimedOnly || !claimed(s)),
  )}
  <p class="sub">
    {rows.length} of {d.sources.length} sources ·
    {d.sources.filter((s) => !claimed(s)).length} claimed by nothing
  </p>
  {#if rows.length === 0}
    <p class="empty">Nothing matches.</p>
  {:else}
    <table>
      <thead>
        <tr>
          <th>path</th>
          <th>claimed by</th>
          <th>lines cited</th>
          <th>coverage</th>
        </tr>
      </thead>
      <tbody>
        {#each rows.slice(0, 400) as s (s.path)}
          <tr>
            <td class="mono"><a href={href('source', ...s.path.split('/'))}>{s.path}</a></td>
            <td>
              {#if !claimed(s)}
                <span class="tag none">nothing</span>
              {:else}
                {#each s.claimants.slice(0, 3) as c}
                  <span class="tag {c.split(':')[0]}">{c}</span>
                {/each}
                {#if s.claimants.length > 3}
                  <span class="tag">+{s.claimants.length - 3}</span>
                {/if}
              {/if}
            </td>
            <td>
              {s.claimed_lines}/{s.lines}
              {#if s.file_claims}<span class="tag decision">whole-file ×{s.file_claims}</span>{/if}
            </td>
            <td><span class="bar"><i style="width:{pct(s)}%"></i></span></td>
          </tr>
        {/each}
      </tbody>
    </table>
    {#if rows.length > 400}
      <p class="empty">Showing the first 400 of {rows.length} — narrow the filter to see the rest.</p>
    {/if}
  {/if}
{:catch e}
  <p class="empty">Could not read: {e.message}</p>
{/await}
