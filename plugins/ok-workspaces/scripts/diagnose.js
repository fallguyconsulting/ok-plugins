#!/usr/bin/env node
// ok-workspaces diagnose: read-only drift report. Reality vs declaration
// on two axes: project drift (fresh detection vs the committed profile)
// and version drift (materialized artifacts older than the installed
// plugin, or diverging from what true-up would write). Writes nothing.

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const pluginRoot = path.resolve(__dirname, '..');
const version = JSON.parse(
  fs.readFileSync(path.join(pluginRoot, '.claude-plugin', 'plugin.json'), 'utf8')
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
  check('profile', false, 'no .ok-workspaces/config.json — run /ok-workspaces:true-up to detect and propose one');
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
    dStacks === cStacks ? `declared = detected (${cStacks || 'none'})` : `declared [${cStacks}] but detected [${dStacks}] — re-run true-up after updating config.json`
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
  if (!fs.existsSync(ignPath)) {
    check('worktree-ign', false, 'missing .ok-workspaces/.gitignore — worktrees could be committed into the repo');
  } else {
    const ign = fs.readFileSync(ignPath, 'utf8');
    const covered = !dirPrefix.startsWith('.ok-workspaces/') || ign.includes(dirPrefix.slice('.ok-workspaces/'.length).replace(/\/$/, ''));
    check('worktree-ign', covered, covered ? `worktrees under ${dirPrefix} are ignored` : `.ok-workspaces/.gitignore does not cover ${dirPrefix}`);
  }
  if (!dirPrefix.startsWith('.ok-workspaces/') && !dirPrefix.startsWith('.')) {
    check('worktree-dir', true, `worktrees at ${dirPrefix}* — outside the plugin dot-directory by declaration, not drift`);
  }

  const csPath = path.join(root, '.claude', 'rules', 'ok-workspaces-cheatsheet.md');
  if (!fs.existsSync(csPath)) {
    check('cheatsheet', false, 'missing .claude/rules/ok-workspaces-cheatsheet.md');
  } else {
    const m = fs.readFileSync(csPath, 'utf8').match(/Materialized by ok-workspaces v([0-9a-zA-Z.\-]+)/);
    const v = m ? m[1] : null;
    check('cheatsheet', v === version, v === version ? `stamped v${v}` : `stamped v${v || 'unknown'}, installed v${version}`);
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
      check('retired', false, `retired payload present: .ok-workspaces/${rel} — true-up removes it`);
    }
  }
}

console.log(`ok-workspaces diagnose — ${root}\n`);
console.log(results.join('\n'));
console.log(`\nRemedy: ${drift ? 'run /ok-workspaces:true-up (after reconciling config.json if stacks/runtime drifted)' : 'nothing — clean'}`);
process.exit(drift ? 2 : 0);
