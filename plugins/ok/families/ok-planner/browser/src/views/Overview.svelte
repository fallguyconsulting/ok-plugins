<script>
  import { meta, artifacts, sources } from '../lib/api.js';

  const load = (async () => {
    const [m, a, s] = await Promise.all([meta(), artifacts(), sources()]);
    const stale = a.artifacts.reduce((n, x) => n + x.stale, 0);
    const unaudited = a.artifacts.filter((x) => !x.has_audit).length;
    const violated = a.artifacts.filter((x) => x.determination === 'violated').length;
    const uncited = s.sources.filter((x) => !x.line_claims && !x.file_claims).length;
    return { m, a: a.artifacts, s: s.sources, stale, unaudited, violated, uncited };
  })();
</script>

<h2>What the corpus claims of the code</h2>
<p class="sub">
  Every live story and decision, the code its implementation audit cites, and
  the sources nothing claims at all.
</p>

{#await load}
  <p class="empty">Reading the corpus…</p>
{:then d}
  <div class="cards">
    <div class="card">
      <div class="n">{d.a.filter((x) => x.kind === 'story').length}</div>
      <div class="l">stories</div>
    </div>
    <div class="card">
      <div class="n">{d.a.filter((x) => x.kind === 'decision').length}</div>
      <div class="l">decisions</div>
    </div>
    <div class="card">
      <div class="n">{d.s.length - d.uncited}</div>
      <div class="l">sources something claims</div>
    </div>
    <div class="card">
      <div class="n">{d.uncited}</div>
      <div class="l">sources nothing claims</div>
    </div>
  </div>

  <h3>Where attention is owed</h3>
  <table>
    <tbody>
      <tr>
        <td>Artifacts with no implementation audit</td>
        <td><span class="tag" class:stale={d.unaudited > 0}>{d.unaudited}</span></td>
      </tr>
      <tr>
        <td>Artifacts audited <em>violated</em></td>
        <td><span class="tag" class:violated={d.violated > 0}>{d.violated}</span></td>
      </tr>
      <tr>
        <td>Citations that no longer resolve as recorded</td>
        <td><span class="tag" class:stale={d.stale > 0}>{d.stale}</span></td>
      </tr>
      <tr>
        <td>Sources the committed graph mirrors</td>
        <td><span class="tag">{d.s.filter((x) => x.in_graph).length}</span></td>
      </tr>
    </tbody>
  </table>

  <p class="crumbs">
    Reading <code>{d.m.root}</code>. A citation is called stale here exactly
    when this project's own checker calls it stale — the view runs that
    checker rather than a second implementation of it.
  </p>
{:catch e}
  <p class="empty">Could not read the corpus: {e.message}</p>
{/await}
