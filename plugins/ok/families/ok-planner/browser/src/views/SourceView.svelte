<script>
  import { source } from '../lib/api.js';
  import { href } from '../lib/route.js';

  export let path;
  export let query;

  $: load = source(path);
  $: focus = Number(query.get('line') || 0);

  const key = (m) => `${m.artifact}`;

  function summarize(lines) {
    const seen = new Map();
    for (const l of lines)
      for (const m of l.marks) {
        const e = seen.get(key(m)) || { ...m, lines: 0 };
        e.lines += 1;
        seen.set(key(m), e);
      }
    return [...seen.values()].sort((a, b) => b.lines - a.lines);
  }
</script>

{#await load}
  <p class="empty">Reading…</p>
{:then d}
  <h2 class="mono">{d.path}</h2>
  {@const claims = summarize(d.lines)}
  {@const claimedLines = d.lines.filter((l) => l.marks.length).length}
  <p class="sub">
    {d.lines.length} lines · {claimedLines} claimed by a citation ·
    {d.lines.length - claimedLines} claimed by none
  </p>

  {#if d.population.length}
    {#each d.population as p}
      <div class="pop">
        <strong>Whole-file claim</strong> —
        <a href={href(p.kind, p.slug)}>{p.artifact}</a> reads this file as a
        population source ({p.form}{#if p.identity && p.identity.includes('#')}, <span class="mono">{p.identity}</span>{/if}).
        That is a claim over the file, not over each of its lines: no line
        below is marked on account of it.
        {#if p.status !== 'current'}<span class="tag stale">{p.status}</span>{/if}
      </div>
    {/each}
  {/if}

  {#if claims.length}
    <h3>Line-level claims</h3>
    <table>
      <thead>
        <tr><th>artifact</th><th>form</th><th>lines</th><th>state</th></tr>
      </thead>
      <tbody>
        {#each claims as c}
          <tr>
            <td><a href={href(c.kind, c.slug)}>{c.artifact}</a></td>
            <td>{c.form}</td>
            <td>{c.lines}</td>
            <td>
              {#if c.status === 'current'}
                <span class="tag satisfied">current</span>
              {:else}
                <span class="tag stale">{c.status}</span>
              {/if}
            </td>
          </tr>
        {/each}
      </tbody>
    </table>
  {:else if !d.population.length}
    <p class="empty">
      Nothing in the corpus claims this file — no story's or decision's audit
      cites any part of it.
    </p>
  {/if}

  <h3>Source</h3>
  <div class="codeview">
    <table>
      <tbody>
        {#each d.lines as l (l.n)}
          <tr
            class:claimed={l.marks.length > 0}
            class:stale={l.marks.some((m) => m.status !== 'current')}
            id={`L${l.n}`}
            style={focus === l.n ? 'outline:2px solid var(--accent)' : ''}
          >
            <td class="gutter">{l.n}</td>
            <td class="mark" title={l.marks.map((m) => `${m.artifact} (${m.form})`).join('\n')}>
              {l.marks.length ? '│' : ' '}
            </td>
            <td>{l.text}</td>
          </tr>
        {/each}
      </tbody>
    </table>
  </div>

  {#if d.nodes.length}
    <details class="group">
      <summary>Declared units the committed graph records ({d.nodes.length})</summary>
      <div class="inner">
        <table>
          <thead><tr><th>identity</th><th>lines</th></tr></thead>
          <tbody>
            {#each d.nodes as n (n.identity)}
              <tr>
                <td class="mono">{n.identity.split('#')[1] || '(whole file)'}</td>
                <td>{n.start}–{n.end}</td>
              </tr>
            {/each}
          </tbody>
        </table>
      </div>
    </details>
  {/if}
{:catch e}
  <p class="empty">Could not read: {e.message}</p>
{/await}
