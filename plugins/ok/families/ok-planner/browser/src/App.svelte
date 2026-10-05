<script>
  import { route, href } from './lib/route.js';
  import { meta, issues, unread, closed, key, tabs } from './lib/api.js';
  import IssueList from './views/IssueList.svelte';
  import IssueDetail from './views/IssueDetail.svelte';

  const shown = tabs.filter((t) => !t.hidden);
  const verified = tabs.find((t) => t.key === 'verified');

  let parts = $derived($route.parts);
  let tab = $derived(tabs.find((t) => t.key === parts[0]) || tabs[0]);
  let selected = $derived(parts[1] ? { id: parts[1], opened: parts[2] || null } : null);
  let category = $derived($route.query.get('category') || '');
  let query = $derived(category ? `?category=${encodeURIComponent(category)}` : '');

  let info = $state(null);
  let listed = $state([]);
  let pool = $state([]);
  let loading = $state(true);
  let failure = $state(null);
  let request = 0;

  let rows = $derived(pool.filter((v) => !category || v.category === category));
  let categories = $derived([...new Set([...pool.map((v) => v.category), category].filter(Boolean))].sort());
  let counts = $derived(Object.fromEntries(tabs.map((t) => [t.key, listed.filter(t.holds).length])));

  async function loadMeta() {
    try {
      info = await meta();
    } catch (e) {
      console.error('DASHBOARD.META.FAILED', { error: e.name, message: e.message, stack: e.stack });
      info = { failure: e.message };
    }
  }

  async function load(current) {
    const mine = ++request;
    loading = true;
    failure = null;
    try {
      const [open, archive] = await Promise.all([gather(), current.archive ? closed() : null]);
      if (mine !== request) return;
      listed = open;
      pool = archive
        ? archive.issues.slice().sort((a, b) => b.closed.localeCompare(a.closed))
        : listed.filter(current.holds);
    } catch (e) {
      console.error('DASHBOARD.LIST.FAILED', { tab: current.key, error: e.name, message: e.message, stack: e.stack });
      if (mine === request) failure = e.message;
    } finally {
      if (mine === request) loading = false;
    }
  }

  async function gather() {
    const [open, answered] = await Promise.all([issues(), unread()]);
    return [...open.issues, ...answered.issues.filter((v) => v.state === 'closed')];
  }

  async function recount() {
    try {
      listed = await gather();
    } catch (e) {
      console.error('DASHBOARD.COUNTS.FAILED', { error: e.name, message: e.message, stack: e.stack });
      failure = e.message;
    }
  }

  function patch(view) {
    pool = pool.map((v) => (key(v) === key(view) ? { ...v, ...view } : v));
    recount();
  }

  function link(v) {
    return href(tab.key, v.id, v.opened) + query;
  }

  function select(v) {
    window.location.hash = link(v);
  }

  function filter(value) {
    const q = value ? `?category=${encodeURIComponent(value)}` : '';
    window.location.hash = href(tab.key, ...parts.slice(1, 3)) + q;
  }

  loadMeta();

  $effect(() => {
    load(tab);
  });
</script>

<header class="top">
  <div class="shell">
    <div class="titlebar">
      <h1>ok-planner dashboard</h1>
      {#if counts.verified > 0}
        <a class="converge" href={href(verified.key) + query}>
          {counts.verified} verified {counts.verified === 1 ? 'defect' : 'defects'} waiting on <code>/converge</code>
        </a>
      {/if}
    </div>
    <nav>
      {#each shown as t (t.key)}
        <a href={href(t.key) + query} class:on={tab.key === t.key}>
          {t.label}
          {#if !t.archive}<span class="count">{counts[t.key]}</span>{/if}
        </a>
      {/each}
    </nav>
    {#if info}
      <div class="announce" class:warn={info.failure || info.version_agrees === false || info.estate_version === null || info.build_agrees === false || info.service_version === null}>
        {#if info.failure}
          Could not read the service's version: {info.failure}
        {:else}
          {#if info.service_version === null}
            This service is the carried copy, which carries no version stamp; run the project's
            <code>.ok-planner/bin/dashboard</code>.
          {:else if info.estate_version === null}
            Running v{info.service_version}. This project's estate carries no suite version stamp; run
            <code>/ok</code> to converge it.
          {:else if info.version_agrees}
            Running v{info.service_version}, the version this project is pinned to.
          {:else}
            Running v{info.service_version}, but this project is pinned to v{info.estate_version}. Run
            <code>/ok</code> to converge.
          {/if}
          {#if !info.build}
            &nbsp;· This project holds no placed page build; run <code>/ok</code>.
          {:else if info.build_version === null}
            &nbsp;· This page carries no version stamp; run <code>/ok</code> to place a stamped one.
          {:else if info.build_agrees === false}
            &nbsp;· This page is v{info.build_version}, not v{info.service_version}; run <code>/ok</code>.
          {/if}
        {/if}
      </div>
    {/if}
  </div>
</header>

<main class="shell">
  <div class="filters">
    <label>
      category
      <select value={category} onchange={(e) => filter(e.currentTarget.value)}>
        <option value="">all</option>
        {#each categories as c (c)}
          <option value={c}>{c}</option>
        {/each}
      </select>
    </label>
    <span class="keys">
      <kbd>j</kbd>/<kbd>k</kbd> move · <kbd>a</kbd> accept the recommendation · <kbd>r</kbd> rule ·
      <kbd>c</kbd> comment
    </span>
  </div>

  <div class="panes">
    <section class="list">
      <IssueList {rows} {selected} {loading} {failure} archive={Boolean(tab.archive)} {link} onselect={select} />
    </section>
    <section class="detail">
      {#if selected}
        <IssueDetail id={selected.id} opened={selected.opened} onchange={patch} />
      {:else}
        <p class="empty">Select an issue, or press <kbd>j</kbd>.</p>
      {/if}
    </section>
  </div>
</main>
