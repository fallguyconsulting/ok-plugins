#!/usr/bin/env node
// ok-workspaces diagnose: read-only drift report. Reality vs declaration
// on two axes: project drift (fresh detection vs the committed profile)
// and version drift (materialized artifacts older than the carried
// suite version, or diverging from what converge would write). Writes
// nothing.

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const pluginRoot = path.resolve(__dirname, '..');
// The suite version comes from the front-door plugin's manifest — the
// family carries no manifest of its own.
const version = JSON.parse(
  fs.readFileSync(path.resolve(pluginRoot, '..', '..', '.claude-plugin', 'plugin.json'), 'utf8')
).version;

function repoRoot() {
  try {
    return execSync('git rev-parse --show-toplevel', { encoding: 'utf8' }).trim();
  } catch {
    return process.cwd();
  }
}
const root = repoRoot();
const results = [];
let drift = false;
function check(name, ok, detail) {
  results.push(`[${ok ? 'ok' : 'DRIFT'}] ${name.padEnd(14)} ${detail}`);
  if (!ok) drift = true;
}

const configPath = path.join(root, '.ok-workspaces', 'config.json');
let cfg = null;
if (!fs.existsSync(configPath)) {
  check('profile', false, 'no .ok-workspaces/config.json — the front door\'s administration (/ok) detects and proposes one');
} else {
  try {
    cfg = JSON.parse(fs.readFileSync(configPath, 'utf8'));
    check('profile', true, 'config.json parses');
  } catch (e) {
    check('profile', false, `config.json does not parse: ${e.message}`);
  }
}

if (cfg) {
  const detected = JSON.parse(
    execSync(`node ${JSON.stringify(path.join(pluginRoot, 'scripts', 'detect.js'))}`, {
      encoding: 'utf8',
      cwd: root,
    })
  );
  const dStacks = [...detected.stacks].sort().join(',');
  const cStacks = [...(cfg.stacks || [])].sort().join(',');
  check(
    'stacks',
    dStacks === cStacks,
    dStacks === cStacks ? `declared = detected (${cStacks || 'none'})` : `declared [${cStacks}] but detected [${dStacks}] — reconverge after updating config.json`
  );
  check(
    'runtime',
    detected.runtime === cfg.runtime,
    detected.runtime === cfg.runtime ? cfg.runtime : `declared ${cfg.runtime} but detected ${detected.runtime}`
  );

  const srcTagRel = (cfg.srcTag && cfg.srcTag.path) || '.ok-workspaces/bin/src-tag';
  const srcTagAbs = path.join(root, srcTagRel);
  if (!fs.existsSync(srcTagAbs)) {
    check('src-tag', false, `missing at ${srcTagRel}`);
  } else {
    const canonical = fs
      .readFileSync(path.join(pluginRoot, 'scripts', 'src-tag'), 'utf8')
      .replace(/\{\{OK_WORKSPACES_VERSION\}\}/g, version);
    const actual = fs.readFileSync(srcTagAbs, 'utf8');
    check('src-tag', actual === canonical, actual === canonical ? `${srcTagRel} matches canonical v${version}` : `${srcTagRel} diverges from canonical v${version}`);
  }

  if (cfg.runtime === 'dev-server') {
    const pbAbs = path.join(root, '.ok-workspaces', 'bin', 'port-block');
    if (!fs.existsSync(pbAbs)) {
      check('port-block', false, 'missing .ok-workspaces/bin/port-block — the dev-server port allocator');
    } else {
      const canonicalPb = fs
        .readFileSync(path.join(pluginRoot, 'scripts', 'port-block'), 'utf8')
        .replace(/\{\{OK_WORKSPACES_VERSION\}\}/g, version);
      const actualPb = fs.readFileSync(pbAbs, 'utf8');
      check('port-block', actualPb === canonicalPb, actualPb === canonicalPb ? `port-block matches canonical v${version}` : `port-block diverges from canonical v${version}`);
    }
  }

  const dirPrefix = (cfg.worktrees && cfg.worktrees.dirPrefix) || '.ok-workspaces/worktrees/';
  const ignPath = path.join(root, '.ok-workspaces', '.gitignore');
  const dirPrefixFromRoot = path.relative(root, path.resolve(root, dirPrefix));
  const outsideRepo =
    path.isAbsolute(dirPrefixFromRoot) ||
    dirPrefixFromRoot === '..' ||
    dirPrefixFromRoot.startsWith(`..${path.sep}`);
  // A prefix that resolves to the repository root is a profile problem,
  // not a coverage question: covering worktrees there would mean writing
  // the project's own root .gitignore, which the suite never touches, so
  // converge refuses the profile outright.
  // @decision: whole-file-ownership
  if (dirPrefixFromRoot === '') {
    check(
      'profile',
      false,
      `worktrees.dirPrefix is ${JSON.stringify(dirPrefix)}, which resolves to the repository root — covering worktrees there would mean writing the project's own .gitignore. Converge refuses this profile; declare a subdirectory in .ok-workspaces/config.json (default ".ok-workspaces/worktrees/")`
    );
  } else if (!fs.existsSync(ignPath)) {
    check('worktree-ign', false, 'missing .ok-workspaces/.gitignore — worktrees could be committed into the repo');
  } else if (outsideRepo) {
    check('worktree-ign', true, `worktrees at ${dirPrefix} live outside the repository — nothing to ignore`);
  } else {
    // Ask git itself whether a checkout at the declared prefix would be
    // offered as content of the repo — the only answer that matches the
    // claim, since a .gitignore governs only its own directory.
    const probe = path.posix.join(dirPrefix.replace(/\/$/, ''), 'ok-workspaces-probe-job');
    let ignored = false;
    try {
      execSync(`git check-ignore -q -- ${JSON.stringify(probe)}`, { cwd: root, stdio: 'ignore' });
      ignored = true;
    } catch {
      ignored = false;
    }
    check(
      'worktree-ign',
      ignored,
      ignored
        ? `worktrees under ${dirPrefix} are ignored (git check-ignore)`
        : `nothing ignores ${dirPrefix} — a checkout there would be offered as repo content; converge writes ${dirPrefix}${dirPrefix.endsWith('/') ? '' : '/'}.gitignore`
    );
  }
  if (dirPrefixFromRoot !== '' && !dirPrefix.startsWith('.ok-workspaces/') && !dirPrefix.startsWith('.')) {
    check('worktree-dir', true, `worktrees at ${dirPrefix}* — outside the family dot-directory by declaration, not drift`);
  }

  const licAbs = path.join(root, '.ok-workspaces', 'LICENSE');
  if (!fs.existsSync(licAbs)) {
    check('license', false, 'missing .ok-workspaces/LICENSE — the family license rides with the estate');
  } else {
    const licCanonical = fs.readFileSync(path.join(pluginRoot, 'LICENSE'), 'utf8');
    const licActual = fs.readFileSync(licAbs, 'utf8');
    check('license', licActual === licCanonical, licActual === licCanonical ? '.ok-workspaces/LICENSE matches the family license' : '.ok-workspaces/LICENSE diverges from the family license');
  }

  const csPath = path.join(root, '.claude', 'rules', 'ok-workspaces-cheatsheet.md');
  if (!fs.existsSync(csPath)) {
    check('cheatsheet', false, 'missing .claude/rules/ok-workspaces-cheatsheet.md');
  } else {
    const m = fs.readFileSync(csPath, 'utf8').match(/Materialized by ok-workspaces v([0-9a-zA-Z.\-]+)/);
    const v = m ? m[1] : null;
    check('cheatsheet', v === version, v === version ? `stamped v${v}` : `stamped v${v || 'unknown'}, carried v${version}`);
  }

  const { vendoredSkills } = require('./vendored-skills');
  const vendored = vendoredSkills(pluginRoot, root, version);
  const vBad = [];
  for (const [dest, body] of Object.entries(vendored)) {
    const rel = path.relative(root, dest);
    if (!fs.existsSync(dest)) vBad.push(`missing ${rel}`);
    else if (fs.readFileSync(dest, 'utf8') !== body) vBad.push(`${rel} diverges from canonical v${version}`);
  }
  check('vendored', vBad.length === 0, vBad.length === 0 ? `vendored skills match canonical v${version}` : vBad.join('; '));

  for (const rel of ['hooks/session-start', 'context/skills-index.md']) {
    const p = path.join(root, '.ok-workspaces', rel);
    if (fs.existsSync(p)) {
      check('retired', false, `retired payload present: .ok-workspaces/${rel} — converge removes it`);
    }
  }
  if (fs.existsSync(path.join(root, '.claude', 'skills', 'true-up'))) {
    check('retired', false, 'retired payload present: .claude/skills/true-up/ (the merged lifecycle verb) — converge removes it');
  }
}

console.log(`ok-workspaces diagnose — ${root}\n`);
console.log(results.join('\n'));
console.log(`\nRemedy: ${drift ? 'run the converge core (after reconciling config.json if stacks/runtime drifted)' : 'nothing — clean'}`);
process.exit(drift ? 2 : 0);
