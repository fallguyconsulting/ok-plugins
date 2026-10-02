#!/usr/bin/env node
// ok-workspaces cleanup offers: every item converge cannot settle alone,
// each with the one fix the owner consents to. Shared by diagnose.js and
// converge.js (which print the blocks) and run directly by the converge
// core's resolve mode, which re-reads the offers and refuses an id they
// do not hold now. Ids are `<kind>:<path from the project root>`.
//
//   node offers.js offers
//   node offers.js resolve <id> [--from <draft>]

const fs = require('fs');
const path = require('path');
const { execSync, spawnSync } = require('child_process');

const pluginRoot = path.resolve(__dirname, '..');
const core = path.join(pluginRoot, 'admin', 'converge');
const PROFILE_REL = path.join('.ok-workspaces', 'config.json');
const PROPOSAL_REL = path.join('.ok-workspaces', 'config.proposed.json');
const RUNTIMES = ['docker-compose', 'dev-server', 'none'];

function readProfile(file) {
  try {
    const cfg = JSON.parse(fs.readFileSync(file, 'utf8'));
    if (!cfg || typeof cfg !== 'object' || Array.isArray(cfg)) return { cfg: null, error: 'top level must be an object' };
    return { cfg, error: null };
  } catch (e) {
    return { cfg: null, error: e.message };
  }
}

function detectedProfile(root) {
  return JSON.parse(
    execSync(`node ${JSON.stringify(path.join(pluginRoot, 'scripts', 'detect.js'))}`, { encoding: 'utf8', cwd: root })
  );
}

const EXIT_DRIFT = 1;
const EXIT_OFFERS_ONLY = 3;
const ANY_OK_STAMP = '<!-- Materialized by ok';
const RETIRED_VENDORED_SKILLS = ['true-up'];

function shellQuote(word) {
  return /^[A-Za-z0-9_\/.:@%+=,-]+$/.test(word) ? word : `'${word.replace(/'/g, "'\\''")}'`;
}

// The declaration's own defects: what a draft must not carry either.
// Each names the profile keys a draft may change to settle it.
function declarationDefects(root, cfg) {
  const found = [];
  if (cfg.srcTag) found.push(['declares `srcTag`; the field is `runTag` since per-run artifacts replaced content addressing', ['srcTag', 'runTag']]);
  if (!RUNTIMES.includes(cfg.runtime)) found.push([`declares runtime ${JSON.stringify(cfg.runtime)}, not one of ${RUNTIMES.join(' | ')}`, ['runtime']]);
  const dirPrefix = (cfg.worktrees && cfg.worktrees.dirPrefix) || '.ok-workspaces/worktrees/';
  if (path.relative(root, path.resolve(root, dirPrefix)) === '') {
    found.push([`declares worktrees.dirPrefix ${JSON.stringify(dirPrefix)}, which resolves to the repository root`, ['worktrees']]);
  }
  return found;
}

function profileProblems(root) {
  const profile = path.join(root, PROFILE_REL);
  if (!fs.existsSync(profile)) {
    return { problems: [[`no ${PROFILE_REL}; converge materializes nothing until the owner declares a profile`, []]], current: null };
  }
  const { cfg, error } = readProfile(profile);
  if (!cfg) return { problems: [[`${PROFILE_REL} does not parse: ${error}`, []]], current: null };
  const problems = declarationDefects(root, cfg);
  const detected = detectedProfile(root);
  const dStacks = [...detected.stacks].sort().join(',');
  const cStacks = [...(Array.isArray(cfg.stacks) ? cfg.stacks : [])].sort().join(',');
  if (dStacks !== cStacks) problems.push([`declares stacks [${cStacks}] but detection finds [${dStacks}]`, ['stacks']]);
  if (detected.runtime !== cfg.runtime) problems.push([`declares runtime ${cfg.runtime} but detection finds ${detected.runtime}`, ['runtime']]);
  return { problems, current: cfg };
}

function canonicalJson(value) {
  if (Array.isArray(value)) return `[${value.map(canonicalJson).join(',')}]`;
  if (value && typeof value === 'object') {
    return `{${Object.keys(value).sort().map((k) => `${JSON.stringify(k)}:${canonicalJson(value[k])}`).join(',')}}`;
  }
  return JSON.stringify(value);
}

function changedKeys(current, draft, named) {
  const found = [];
  for (const key of [...new Set([...Object.keys(current), ...Object.keys(draft)])].sort()) {
    if (named.includes(key)) continue;
    if (!(key in draft)) found.push(`${key} (dropped)`);
    else if (!(key in current)) found.push(`${key} (added)`);
    else if (canonicalJson(current[key]) !== canonicalJson(draft[key])) found.push(`${key} (changed)`);
  }
  return found;
}

function stampedMarkdown(file) {
  let text;
  try {
    if (!fs.statSync(file).isFile()) return false;
    text = fs.readFileSync(file, 'utf8');
  } catch (e) {
    return false;
  }
  const lines = text.split('\n').filter((l) => l.trim() !== '');
  return lines.length > 0 && lines[lines.length - 1].startsWith(ANY_OK_STAMP);
}

function present(abs) {
  try {
    fs.lstatSync(abs);
    return true;
  } catch (e) {
    return false;
  }
}

function filesUnder(abs) {
  if (!present(abs)) return [];
  if (!fs.lstatSync(abs).isDirectory()) return [abs];
  const out = [];
  for (const name of fs.readdirSync(abs).sort()) out.push(...filesUnder(path.join(abs, name)));
  return out;
}

// A vendored skill folder holding a SKILL.md the project wrote is a
// collision: converge writes nothing into it, and resolve deletes only
// the colliding files.
function vendoredCollisions(root, vendored) {
  const collided = {};
  for (const dest of Object.keys(vendored).sort()) {
    if (dest.endsWith('.md') && present(dest) && !stampedMarkdown(dest)) {
      (collided[path.dirname(dest)] = collided[path.dirname(dest)] || []).push(dest);
    }
  }
  return collided;
}

function suiteFile(file) {
  const name = path.basename(file);
  if (name === '.DS_Store') return true;
  if (name === 'LICENSE') return fs.readFileSync(file, 'utf8').startsWith('Vendored ok');
  return name.endsWith('.md') && stampedMarkdown(file);
}

function retiredSkillFolders(root) {
  const out = [];
  for (const name of RETIRED_VENDORED_SKILLS) {
    const folder = path.join(root, '.claude', 'skills', name);
    if (!present(folder) || !fs.lstatSync(folder).isDirectory()) continue;
    const files = filesUnder(folder);
    if (!stampedMarkdown(path.join(folder, 'SKILL.md'))) {
      out.push({ name, suite: [], owned: files });
      continue;
    }
    const suite = files.filter(suiteFile);
    out.push({ name, suite, owned: files.filter((f) => !suite.includes(f)) });
  }
  return out;
}

function pruneEmpty(dirs, stop) {
  for (let dir of [...new Set(dirs)].sort((a, b) => b.length - a.length)) {
    while (dir !== stop && dir.startsWith(stop + path.sep) && fs.existsSync(dir) && fs.readdirSync(dir).length === 0) {
      fs.rmdirSync(dir);
      dir = path.dirname(dir);
    }
  }
}

function gitLines(root, args) {
  const r = spawnSync('git', ['-C', root, ...args], { encoding: 'utf8' });
  if (r.status !== 0) return null;
  return r.stdout.split('\0').filter(Boolean);
}

function trackedFiles(root, rels) {
  return rels.length > 0 ? gitLines(root, ['ls-files', '-z', '--', ...rels]) || [] : [];
}

function uncommittedPaths(root, rels) {
  if (rels.length === 0) return [];
  if (gitLines(root, ['rev-parse', '-q', '--verify', 'HEAD']) === null) return trackedFiles(root, rels).sort();
  const changed = new Set();
  for (const cached of [[], ['--cached']]) {
    for (const p of gitLines(root, ['diff', ...cached, '--name-only', '--no-renames', '-z', '--relative', 'HEAD', '--', ...rels]) || []) changed.add(p);
  }
  return [...changed].sort();
}

function symlinkedBetween(root, rels) {
  const found = new Set();
  for (const rel of rels) {
    let dir = path.dirname(path.join(root, rel));
    while (dir.startsWith(root + path.sep)) {
      if (present(dir) && fs.lstatSync(dir).isSymbolicLink()) found.add(path.relative(root, dir));
      dir = path.dirname(dir);
    }
  }
  return [...found].sort();
}

function cleanupOffers(root) {
  const out = [];
  const { problems, current } = profileProblems(root);
  if (problems.length > 0) {
    out.push({
      id: `profile:${PROFILE_REL}`,
      what: [`${PROFILE_REL} needs the owner's declaration:`].concat(problems.map(([text]) => text)),
      draft: `the whole profile — detection's proposal (${['node', path.join(pluginRoot, 'scripts', 'detect.js')].map(shellQuote).join(' ')}) where none exists, else the current profile with each problem above settled and every other key kept as it is — per the family's admin/ADMINISTRATION.md.`,
      fix: `write the drafted profile as ${PROFILE_REL}.`,
      keep: current === null ? null : { current, named: [...new Set(problems.flatMap(([, keys]) => keys))] },
    });
  }
  if (fs.existsSync(path.join(root, PROFILE_REL)) && fs.existsSync(path.join(root, PROPOSAL_REL))) {
    out.push({
      id: `stale-proposal:${PROPOSAL_REL}`,
      what: [`${PROPOSAL_REL} is detection scratch the declared ${PROFILE_REL} supersedes.`],
      fix: `delete ${PROPOSAL_REL}.`,
      remove: [PROPOSAL_REL],
    });
  }
  const { vendoredSkills } = require('./vendored-skills');
  for (const [folder, files] of Object.entries(vendoredCollisions(root, vendoredSkills(pluginRoot, root, suiteVersion())))) {
    const label = path.relative(root, folder);
    out.push({
      id: `collision:${label}`,
      what: [`${label}/ holds the project's own copy (no suite stamp) of ${files.length} file(s) at paths the suite vendors:`].concat(files.map((f) => path.relative(root, f))),
      fix: "delete the files listed above; converge then writes the suite's copy, and the folder's other files stay.",
      remove: files.map((f) => path.relative(root, f)),
    });
  }
  for (const { name, owned } of retiredSkillFolders(root)) {
    if (owned.length === 0) continue;
    out.push({
      id: `retired-verb:.claude/skills/${name}`,
      what: [`.claude/skills/${name}/ holds files the project wrote at a name the suite retired:`].concat(owned.map((f) => path.relative(root, f))),
      fix: 'delete the files listed above.',
      remove: owned.map((f) => path.relative(root, f)),
    });
  }
  for (const o of out) {
    o.uncommitted = uncommittedPaths(root, o.remove || []);
    o.links = symlinkedBetween(root, o.remove || []);
  }
  return out;
}

function suiteVersion() {
  return JSON.parse(fs.readFileSync(path.resolve(pluginRoot, '..', '..', '.claude-plugin', 'plugin.json'), 'utf8')).version;
}

function printOffer(o) {
  const command = ['bash', core, 'resolve', o.id].map(shellQuote).join(' ');
  console.log(`CLEANUP OFFERED (ok-workspaces): ${o.id}`);
  console.log(`  What: ${o.what[0]}`);
  for (const line of o.what.slice(1)) console.log(`    ${line}`);
  if (o.draft) console.log(`  Draft: ${o.draft}`);
  console.log(`  Fix: ${o.fix}`);
  if (o.uncommitted.length > 0) console.log(`  Uncommitted: ${o.uncommitted.join(', ')} carry uncommitted changes; resolve refuses until they are committed. Commit those changes first, then run /ok again.`);
  if (o.links.length > 0) console.log(`  Symbolic link: ${o.links.join(', ')}; resolve refuses to change files behind a link. Replace the link with the folder it points at, or remove the link yourself.`);
  console.log('  Recommended: accept');
  console.log(`  On the owner's consent run: ${command}${o.draft ? ' --from <draft>' : ''}`);
}

function refuse(message) {
  console.error(`resolve: ${message}`);
  process.exit(1);
}

function removeFiles(root, rels, stopRel) {
  const links = symlinkedBetween(root, rels);
  if (links.length > 0) refuse(`${links.join(', ')} is a symbolic link; nothing changed. Replace the link with the folder it points at, or remove the link yourself, then run /ok again.`);
  const changed = uncommittedPaths(root, rels);
  if (changed.length > 0) refuse(`${changed.join(', ')} carry uncommitted changes; nothing changed. Commit those changes first, then run /ok again.`);
  const tracked = trackedFiles(root, rels);
  if (tracked.length > 0) {
    const r = spawnSync('git', ['-C', root, 'rm', '-q', '--', ...tracked], { stdio: 'inherit' });
    if (r.status !== 0) refuse(`git rm failed for ${tracked.join(', ')}`);
  }
  for (const rel of rels) {
    if (present(path.join(root, rel))) fs.unlinkSync(path.join(root, rel));
  }
  pruneEmpty(rels.map((rel) => path.dirname(path.join(root, rel))), path.join(root, stopRel));
  for (const rel of rels) console.log(`removed: ${rel}${tracked.includes(rel) ? ' (git rm; staged)' : ''}`);
}

function resolve(root, args) {
  const [wanted, ...rest] = args;
  if (!wanted) refuse('usage: converge resolve <id> [--from <draft>]');
  const o = cleanupOffers(root).find((x) => x.id === wanted);
  if (!o) refuse(`ok-workspaces offers nothing as ${wanted} at ${root}; run diagnose for the current offers`);
  const target = wanted.slice(wanted.indexOf(':') + 1);
  if (o.draft) {
    if (rest.length !== 2 || rest[0] !== '--from') refuse(`${wanted} writes a draft; run it as: resolve ${wanted} --from <draft>`);
    const draft = path.resolve(rest[1]);
    if (!fs.existsSync(draft)) refuse(`--from names no file: ${draft}`);
    const { cfg, error } = readProfile(draft);
    if (!cfg) refuse(`the draft does not parse: ${error}; nothing written`);
    const defects = declarationDefects(root, cfg).map(([text]) => text);
    if (defects.length > 0) refuse(`the draft ${defects.join('; ')}; nothing written`);
    if (o.keep) {
      const changed = changedKeys(o.keep.current, cfg, o.keep.named);
      if (changed.length > 0) refuse(`the draft changes keys the offer does not name: ${changed.join(', ')}; nothing written`);
    }
    const profileDest = path.join(root, target);
    fs.mkdirSync(path.dirname(profileDest), { recursive: true });
    fs.copyFileSync(draft, profileDest);
    console.log(`written: ${target}`);
  } else {
    if (rest.length > 0) refuse(`${wanted} takes no further argument`);
    removeFiles(root, o.remove, wanted.startsWith('stale-proposal:') ? '.ok-workspaces' : path.join('.claude', 'skills'));
  }
  console.log(`Resolved ${wanted}. Run converge to bring the estate current.`);
}

module.exports = {
  cleanupOffers, printOffer, readProfile, detectedProfile, vendoredCollisions, retiredSkillFolders, pruneEmpty,
  EXIT_DRIFT, EXIT_OFFERS_ONLY,
};

// Project root: nearest ancestor carrying a suite estate marker, else
// the working directory — never derived from .git.
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

if (require.main === module) {
  const root = projectRoot();
  const [verb, ...args] = process.argv.slice(2);
  if (verb === 'offers') {
    for (const o of cleanupOffers(root)) printOffer(o);
  } else if (verb === 'resolve') {
    resolve(root, args);
  } else {
    refuse('usage: offers.js offers | offers.js resolve <id> [--from <draft>]');
  }
}
