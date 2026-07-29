<script>
  import { route } from './lib/route.js';
  import { meta } from './lib/api.js';
  import Overview from './views/Overview.svelte';
  import ArtifactList from './views/ArtifactList.svelte';
  import ArtifactDetail from './views/ArtifactDetail.svelte';
  import SourceList from './views/SourceList.svelte';
  import SourceView from './views/SourceView.svelte';

  const info = meta();

  $: parts = $route.parts;
  $: section = parts[0] || '';
</script>

<header class="top">
  <div class="shell">
    <h1>corpus view</h1>
    <nav>
      <a href="#/" class:on={section === ''}>overview</a>
      <a href="#/stories" class:on={section === 'stories' || section === 'story'}>stories</a>
      <a href="#/decisions" class:on={section === 'decisions' || section === 'decision'}>decisions</a>
      <a href="#/sources" class:on={section === 'sources' || section === 'source'}>code</a>
    </nav>
    {#await info then m}
      <div class="announce" class:warn={m.version_agrees === false || m.estate_version === null}>
        {#if m.estate_version === null}
          Running v{m.running_version}. This project's estate carries no suite
          version stamp — run <code>/ok</code> to converge it.
        {:else if m.version_agrees}
          Running v{m.running_version}, the version this project is pinned to.
        {:else}
          Running v{m.running_version}, but this project is pinned to
          v{m.estate_version} — an older corpus read by a newer view. Run
          <code>/ok</code> to converge.
        {/if}
        {#if m.bundle_source !== 'project'}
          &nbsp;· Page served from the front door's carried build, not this
          project's.
        {:else if !m.bundle_version}
          &nbsp;· This project's placed build carries no version stamp.
        {:else if m.bundle_version !== m.running_version}
          &nbsp;· This project's placed build is stamped v{m.bundle_version},
          not v{m.running_version}.
        {/if}
        &nbsp;· Citations resolved by
        <code>{m.resolution.audit_check.path}</code>.
      </div>
    {/await}
  </div>
</header>

<main class="shell">
  {#if section === ''}
    <Overview />
  {:else if section === 'stories'}
    <ArtifactList kind="story" />
  {:else if section === 'decisions'}
    <ArtifactList kind="decision" />
  {:else if section === 'story' || section === 'decision'}
    <ArtifactDetail kind={section} slug={parts[1]} />
  {:else if section === 'sources'}
    <SourceList />
  {:else if section === 'source'}
    <SourceView path={parts.slice(1).join('/')} query={$route.query} />
  {:else}
    <p class="empty">No such view.</p>
  {/if}
</main>
