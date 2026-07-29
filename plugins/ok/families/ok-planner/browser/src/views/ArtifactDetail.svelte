<script>
  import { artifact } from '../lib/api.js';
  import { href } from '../lib/route.js';

  export let kind;
  export let slug;

  $: load = artifact(kind, slug);

  const chain = (identity) =>
    identity && identity.includes('#') ? identity.split('#')[1].split('.') : [];

  // Every region the citation reaches, named. A multi-hit anchor claims
  // each of its occurrences, and the page says so in the same breath the
  // source view marks them — one answer, not two.
  const span = ([a, b]) => (a === b ? `line ${a}` : `lines ${a}–${b}`);
  const where = (c) => {
    if (c.scope === 'file') return 'whole file';
    const rs = c.regions || [];
    if (rs.length === 0) return 'unresolved';
    if (rs.length === 1) return span(rs[0]);
    return `${rs.length} regions — ${rs.map(span).join(', ')}`;
  };
  const regionCount = (lines) =>
    lines.reduce((n, c) => n + (c.regions || []).length, 0);
  // A line citation that reaches nothing still exists and still has to be
  // visible — counting only regions would hide it behind a silent zero.
  const unresolvedCount = (lines) =>
    lines.filter((c) => (c.regions || []).length === 0).length;
</script>

{#await load}
  <p class="empty">Reading…</p>
{:then d}
  <h2>{d.title || d.slug}</h2>
  <p class="sub">
    <span class="tag {d.kind}">{d.kind}</span>
    <span class="mono">{d.slug}</span>
    {#if d.audit}
      · <span class="tag {d.audit.determination}">{d.audit.determination}</span>
      audited {d.audit.audited}
      {#if d.audit.issue}· issue <span class="mono">{d.audit.issue}</span>{/if}
    {:else}
      · <span class="tag none">no implementation audit</span>
    {/if}
  </p>

  <details class="group">
    <summary>The artifact, as the corpus states it — <span class="mono">{d.path}</span></summary>
    <div class="inner"><div class="artifact-body">{d.body}</div></div>
  </details>

  <h3>The code this audit claims</h3>
  {#if !d.audit}
    <p class="empty">
      Nothing is claimed: no implementation audit has been written for this
      artifact, so no code is bound to it yet.
    </p>
  {:else if d.groups.length === 0}
    <p class="empty">The audit cites no code.</p>
  {:else}
    <p class="sub">
      {d.groups.length} file{d.groups.length === 1 ? '' : 's'}. A whole-file
      claim is a population the audit read as a whole — it does not say every
      line serves this artifact.
    </p>

    {#each d.groups as g (g.target)}
      {@const rc = regionCount(g.lines)}
      {@const ur = unresolvedCount(g.lines)}
      <details class="group" open={g.lines.length > 0}>
        <summary>
          <span class="mono">{g.target}</span>
          {#if rc}<span class="tag">{rc} cited region{rc === 1 ? '' : 's'}</span>{/if}
          {#if ur}<span class="tag stale">{ur} unresolved</span>{/if}
          {#if g.file.length}<span class="tag decision">whole-file claim</span>{/if}
          <a href={href('source', ...g.target.split('/'))}>open in code&nbsp;→</a>
        </summary>
        <div class="inner">
          {#each g.file as c}
            <div class="pop">
              <strong>Whole file</strong> — read as a population source
              ({c.form}{#if c.identity}, <span class="mono">{c.identity}</span>{/if}).
              {#if c.status !== 'current'}
                <span class="tag stale">{c.status}</span> {c.detail}
              {:else}
                Pin still current.
              {/if}
            </div>
          {/each}

          {#each g.lines as c}
            <details class="group" open>
              <summary>
                <span class="tag">{c.form}</span>
                <span>{where(c)}</span>
                {#if chain(c.identity).length}
                  <span class="mono">
                    {#each chain(c.identity) as part, i}{i ? ' › ' : ''}{part}{/each}
                  </span>
                {/if}
                {#if c.status !== 'current'}
                  <span class="tag stale">{c.status}</span>
                {/if}
              </summary>
              <div class="inner">
                {#if c.detail}<p class="sub">{c.detail}</p>{/if}
                {#if c.excerpts && c.excerpts.length}
                  {#each c.excerpts as ex (ex.start)}
                    {#if c.excerpts.length > 1}
                      <p class="sub">{span([ex.start, ex.end])}</p>
                    {/if}
                    <div class="excerpt">
                      <table>
                        <tbody>
                          {#each ex.lines as l (l.n)}
                            <tr class:cited={l.cited}>
                              <td class="n">{l.n}</td>
                              <td>{l.text}</td>
                            </tr>
                          {/each}
                        </tbody>
                      </table>
                    </div>
                  {/each}
                {:else if c.status === 'current'}
                  <p class="empty">No excerpt: the citation resolves — the checker
                  finds what it cites — but the view could not localize it to
                  lines of the current file.</p>
                {:else}
                  <p class="empty">No excerpt: the citation does not resolve to a location in the current tree.</p>
                {/if}
              </div>
            </details>
          {/each}
        </div>
      </details>
    {/each}
  {/if}
{:catch e}
  <p class="empty">Could not read: {e.message}</p>
{/await}
