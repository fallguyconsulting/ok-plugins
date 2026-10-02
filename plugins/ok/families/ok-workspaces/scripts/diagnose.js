#!/usr/bin/env node
// ok-workspaces diagnose: read-only drift report. Reality vs declaration
// on two axes: project drift (fresh detection vs the committed profile)
// and version drift (materialized artifacts older than the carried
// suite version, or diverging from what converge would write). Writes
// nothing.

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');
const {
  cleanupOffers, printOffer, readProfile, detectedProfile, vendoredCollisions, retiredSkillFolders, EXIT_DRIFT, EXIT_OFFERS_ONLY,
} = require('./offers');

const pluginRoot = path.resolve(__dirname, '..');
// The suite version comes from the front-door plugin's manifest — the
// family carries no manifest of its own.
const version = JSON.parse(
  fs.readFileSync(path.resolve(pluginRoot, '..', '..', '.claude-plugin', 'plugin.json'), 'utf8')
).version;

// Project root: nearest ancestor carrying a suite estate marker, else
// the working directory — never derived from .git; the estate may live
// in a subfolder, submodule, or subproject of a repo whose own root
// wants no estate.
const ROOT_MARKERS = [
  '.ok-planner',
  '.ok-plumbline',
  '.ok-workspaces',
  '.plumbline.json',
  path.join('.claude', 'rules', 'plumbline-cheatsheet.md'),
];
function projectRoot() {
  let dir = process.cwd();
  for (;;) {
    if (ROOT_MARKERS.some((m) => fs.existsSync(path.join(dir, m)))) return dir;
    const parent = path.dirname(dir);
    if (parent === dir) return process.cwd();
    dir = parent;
  }
}
const root = projectRoot();
const results = [];
let drift = false;
function check(name, ok, detail) {
  results.push(`[${ok ? 'ok' : 'DRIFT'}] ${name.padEnd(14)} ${detail}`);
  if (!ok) drift = true;
}
function offered(name, ok, detail) {
  results.push(`[${ok ? 'ok' : 'OFFER'}] ${name.padEnd(14)} ${detail}`);
}

const configPath = path.join(root, '.ok-workspaces', 'config.json');
let cfg = null;
if (!fs.existsSync(configPath)) {
  offered('profile', false, 'no .ok-workspaces/config.json — offered below with a drafted profile');
} else {
  const read = readProfile(configPath);
  cfg = read.cfg;
  if (cfg) offered('profile', true, 'config.json parses');
  else offered('profile', false, `config.json does not parse: ${read.error} — offered below with a drafted profile`);
}

if (cfg) {
  const detected = detectedProfile(root);
  const dStacks = [...detected.stacks].sort().join(',');
  const cStacks = [...(Array.isArray(cfg.stacks) ? cfg.stacks : [])].sort().join(',');
  offered(
    'stacks',
    dStacks === cStacks,
    dStacks === cStacks ? `declared = detected (${cStacks || 'none'})` : `declared [${cStacks}] but detected [${dStacks}] — reconverge after updating config.json`
  );
  offered(
    'runtime',
    detected.runtime === cfg.runtime,
    detected.runtime === cfg.runtime ? cfg.runtime : `declared ${cfg.runtime} but detected ${detected.runtime}`
  );

  if (cfg.srcTag) {
    offered(
      'profile',
      false,
      'profile declares srcTag; the field is runTag since per-run artifacts replaced content addressing. The field is owner-decided, so converge never converts it silently — offered below with a drafted profile'
    );
  }

  const runTagRel = (cfg.runTag && cfg.runTag.path) || '.ok-workspaces/bin/run-tag';
  const runTagAbs = path.join(root, runTagRel);
  if (!fs.existsSync(runTagAbs)) {
    check('run-tag', false, `missing at ${runTagRel}`);
  } else {
    const canonical = fs
      .readFileSync(path.join(pluginRoot, 'scripts', 'run-tag'), 'utf8')
      .replace(/\{\{OK_WORKSPACES_VERSION\}\}/g, version);
    const actual = fs.readFileSync(runTagAbs, 'utf8');
    check('run-tag', actual === canonical, actual === canonical ? `${runTagRel} matches canonical v${version}` : `${runTagRel} diverges from canonical v${version}`);
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
    offered(
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
    const { estateLicense } = require('./vendored-skills');
    const licCanonical = estateLicense(pluginRoot);
    const licActual = fs.readFileSync(licAbs, 'utf8');
    check('license', licActual === licCanonical, licActual === licCanonical ? '.ok-workspaces/LICENSE matches the family license under its scope preamble' : '.ok-workspaces/LICENSE diverges from the family license');
  }

  const csPath = path.join(root, '.claude', 'rules', 'ok-workspaces-cheatsheet.md');
  if (!fs.existsSync(csPath)) {
    check('cheatsheet', false, 'missing .claude/rules/ok-workspaces-cheatsheet.md');
  } else {
    const m = fs.readFileSync(csPath, 'utf8').match(/Materialized by ok-workspaces v([0-9a-zA-Z.\-]+)/);
    const v = m ? m[1] : null;
    check('cheatsheet', v === version, v === version ? `stamped v${v}` : `stamped v${v || 'unknown'}, carried v${version}`);
  }

  const { vendoredSkills, ceremonySurfaces } = require('./vendored-skills');
  const vendored = vendoredSkills(pluginRoot, root, version);
  const collided = vendoredCollisions(root, vendored);
  const vBad = [];
  for (const [dest, body] of Object.entries(vendored)) {
    const rel = path.relative(root, dest);
    if (collided[path.dirname(dest)]) continue;
    if (!fs.existsSync(dest)) vBad.push(`missing ${rel}`);
    else if (fs.readFileSync(dest, 'utf8') !== body) vBad.push(`${rel} diverges from canonical v${version}`);
  }
  check('vendored', vBad.length === 0, vBad.length === 0 ? `vendored skills match canonical v${version}` : vBad.join('; '));

  const surfaces = ceremonySurfaces(pluginRoot, root, version);
  const sBad = [];
  for (const [dest, body] of Object.entries(surfaces)) {
    const rel = path.relative(root, dest);
    if (!fs.existsSync(dest)) sBad.push(`missing ${rel}`);
    else if (fs.readFileSync(dest, 'utf8') !== body) sBad.push(`${rel} diverges from canonical v${version}`);
  }
  check('ceremony', sBad.length === 0, sBad.length === 0 ? `ceremony contributions match canonical v${version}` : sBad.join('; '));

  for (const rel of ['hooks/session-start', 'context/skills-index.md', 'ceremony/plan-sprint.md', 'ceremony/certify-work.md']) {
    const p = path.join(root, '.ok-workspaces', rel);
    if (fs.existsSync(p)) {
      check('retired', false, `retired payload present: .ok-workspaces/${rel} — converge removes it`);
    }
  }
  for (const { name, suite } of retiredSkillFolders(root)) {
    if (suite.length > 0) {
      check('retired', false, `retired payload present: .claude/skills/${name}/ — converge removes its ${suite.length} suite-stamped file(s)`);
    }
  }
}

const offers = cleanupOffers(root);

console.log(`ok-workspaces diagnose — ${root}\n`);
console.log(results.join('\n'));
for (const o of offers) {
  console.log('');
  printOffer(o);
}
if (drift) {
  console.log(`\nRemedy: run the converge core${offers.length > 0 ? ', and settle the offers above on the owner\'s word' : ''}`);
  process.exit(EXIT_DRIFT);
}
if (offers.length > 0) {
  console.log("\nRemedy: settle the offers above on the owner's word; converge has nothing more to do");
  process.exit(EXIT_OFFERS_ONLY);
}
console.log('\nRemedy: nothing — clean');
process.exit(0);
