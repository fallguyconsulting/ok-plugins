#!/usr/bin/env node
// ok-workspaces materialization. Requires an authoritative committed
// profile at .ok-workspaces/config.json (detection proposes via
// detect.js; a human commits the config). Materializes, from the
// profile: the canonical src-tag script at the profile-declared path,
// the port-block allocator at .ok-workspaces/bin/port-block (dev-server
// runtime only; removed otherwise), the always-in-context cheatsheet at
// .claude/rules/ok-workspaces-cheatsheet.md, the worktree .gitignore
// inside .ok-workspaces/, the family LICENSE at the estate root (so the
// license text rides with every vendored copy), and the vendored skill
// set in .claude/skills/ (audit family-prefixed under the collision
// rule). It also removes the
// retired payloads earlier versions wrote (the session-start hook, its
// skills-index context payload, and the merged true-up verb the front
// door's administration replaced). All materialized files are
// suite-owned whole files, overwritten wholesale, stamped with the
// suite version.

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
const configPath = path.join(root, '.ok-workspaces', 'config.json');

// @decision: declared-stack-profile
if (!fs.existsSync(configPath)) {
  console.error(
    'ok-workspaces converge: no committed profile at .ok-workspaces/config.json.\n' +
      'Run detection first (node scripts/detect.js), review the proposal, and commit it as config.json.'
  );
  process.exit(2);
}
const cfg = JSON.parse(fs.readFileSync(configPath, 'utf8'));

// A worktree prefix that resolves to the repository root itself would
// put the suite-owned worktree ignore file at the project's root
// .gitignore — a file the human owns and the suite never edits. Refuse
// before anything is written, rather than materialize half an estate.
// @decision: whole-file-ownership
const declaredDirPrefix = (cfg.worktrees && cfg.worktrees.dirPrefix) || '.ok-workspaces/worktrees/';
if (path.relative(root, path.resolve(root, declaredDirPrefix)) === '') {
  console.error(
    `ok-workspaces converge: worktrees.dirPrefix in .ok-workspaces/config.json is ${JSON.stringify(declaredDirPrefix)}, ` +
      'which resolves to the repository root.\n' +
      "Worktrees cannot live at the root: covering them would mean writing the project's own .gitignore, " +
      'which the suite never touches. Declare a subdirectory (the default is ".ok-workspaces/worktrees/") and re-run.'
  );
  process.exit(2);
}

const stamp = (s) => s.replace(/\{\{OK_WORKSPACES_VERSION\}\}/g, version);

const srcTagRel = (cfg.srcTag && cfg.srcTag.path) || '.ok-workspaces/bin/src-tag';
const srcTagAbs = path.join(root, srcTagRel);
fs.mkdirSync(path.dirname(srcTagAbs), { recursive: true });
fs.writeFileSync(srcTagAbs, stamp(fs.readFileSync(path.join(pluginRoot, 'scripts', 'src-tag'), 'utf8')));
fs.chmodSync(srcTagAbs, 0o755);

// The port-block allocator: the one computed source of the dev-server port
// arithmetic. Materialized only where the profile declares that runtime.
const portBlockAbs = path.join(root, '.ok-workspaces', 'bin', 'port-block');
if (cfg.runtime === 'dev-server') {
  fs.mkdirSync(path.dirname(portBlockAbs), { recursive: true });
  fs.writeFileSync(portBlockAbs, stamp(fs.readFileSync(path.join(pluginRoot, 'scripts', 'port-block'), 'utf8')));
  fs.chmodSync(portBlockAbs, 0o755);
} else if (fs.existsSync(portBlockAbs)) {
  fs.unlinkSync(portBlockAbs);
}

const dirPrefix = declaredDirPrefix;
const branchPrefix = (cfg.worktrees && cfg.worktrees.branchPrefix) || 'wt/';

// Worktrees default to living inside the project root, under the
// plugin's dot-directory, so nothing escapes the repo. A checkout
// inside the repo must never be committed to it, so the plugin owns
// the ignore file that covers wherever the profile puts them: the
// dot-directory's own .gitignore for the default location, and — when
// the profile points the prefix at another in-repo path — a
// suite-owned .gitignore at that path, since a .gitignore governs only
// its own directory. The project's root .gitignore belongs to the
// human and is never touched either way.
// @decision: worktrees-inside-project-root
const ignoreHeader = [
  `# Materialized by ok-workspaces v${version} — suite-owned; overwritten by the front door's administration (/ok).`,
  '# Worktrees are checkouts, never content of this repo.',
];
const inDotDir = dirPrefix.startsWith('.ok-workspaces/');
// In-repo is decided on the resolved location, not on the spelling: a
// prefix that normalizes out of the root (`a/../../escaped/`) is outside
// the repository however it is written.
const dirPrefixAbs = path.resolve(root, dirPrefix);
const dirPrefixFromRoot = path.relative(root, dirPrefixAbs);
const outsideRepo =
  path.isAbsolute(dirPrefixFromRoot) ||
  dirPrefixFromRoot === '..' ||
  dirPrefixFromRoot.startsWith(`..${path.sep}`);
const worktreeIgnoreRel = `${dirPrefix}${dirPrefix.endsWith('/') ? '' : '/'}.gitignore`;
const ignoreLines = ignoreHeader.slice();
if (inDotDir) {
  const rel = dirPrefix.slice('.ok-workspaces/'.length);
  ignoreLines.push(rel.endsWith('/') ? rel : `${rel}*`);
} else if (outsideRepo) {
  ignoreLines.push(`# Worktrees live at ${dirPrefix} — outside this repository, so nothing here needs ignoring.`);
} else {
  ignoreLines.push(`# Worktrees live at ${dirPrefix} — covered by the suite-owned ${worktreeIgnoreRel}.`);
}
fs.mkdirSync(path.join(root, '.ok-workspaces'), { recursive: true });
fs.writeFileSync(path.join(root, '.ok-workspaces', '.gitignore'), ignoreLines.join('\n') + '\n');

// The out-of-dot-directory in-repo case: cover the declared location
// itself. `*` hides every checkout under it; `!.gitignore` keeps this
// materialized artifact visible so the owner commits it like every
// other suite-owned file.
const worktreeIgnoreAbs = path.join(dirPrefixAbs, '.gitignore');
if (!inDotDir && !outsideRepo) {
  fs.mkdirSync(path.dirname(worktreeIgnoreAbs), { recursive: true });
  fs.writeFileSync(worktreeIgnoreAbs, ignoreHeader.concat(['*', '!.gitignore']).join('\n') + '\n');
}

let runtimeRule;
if (cfg.runtime === 'docker-compose') {
  const prefix = (cfg.compose && cfg.compose.projectPrefix) || path.basename(root);
  runtimeRule = `**One runtime stack per worktree.** Every workspace runs its own compose
project, namespaced by workspace: \`COMPOSE_PROJECT_NAME=${prefix}-<job>\`
(set it in the workspace's local env, never hardcoded in a compose file).
Container names, networks, and volumes all derive from the project name,
so two workspaces can run their stacks concurrently without collision.
Host-port mappings must be parameterized (env var with a per-workspace
value), never fixed numbers shared across workspaces.`;
} else if (cfg.runtime === 'dev-server') {
  runtimeRule = `**One runtime stack per worktree.** Every workspace allocates its own
port block, computed by the materialized allocator — run
\`.ok-workspaces/bin/port-block <job>\` and export the printed variables in
the workspace's local env. The allocator reads the committed profile and
live worktree state; it is the only statement of the arithmetic. No port
number is ever hardcoded in code, scripts, or config — a second workspace
must be startable without editing the first.`;
} else {
  runtimeRule = `**One runtime stack per worktree.** This project declares no shared
runtime (\`runtime: "none"\`). If a dev server, container stack, or other
long-lived process is introduced, re-run detection — the front door's
administration (\`/ok\`) will flag the profile drift.`;
}

const cheatsheet = `# ok-workspaces Cheatsheet

Materialized by ok-workspaces v${version} — suite-owned; refreshed by
the front door's administration (\`/ok\`); do not hand-edit. Profile:
\`.ok-workspaces/config.json\` (stacks: ${(cfg.stacks || []).join(', ') || 'none'};
runtime: ${cfg.runtime}).

Three rules. Each one makes the next one safe — ship any subset and the
isolation story has a hole.

1. **One worktree per job.** Every unit of work gets its own checkout
   on its own branch: directory \`${dirPrefix}<job>\`, branch
   \`${branchPrefix}<job>\`. Never share a working tree between concurrent
   jobs; never do job work on the main checkout. Use \`/open <job>\`
   and \`/close <job>\`.

2. ${runtimeRule}

3. **Content-addressed artifacts.** Build outputs used for verification
   are tagged by source-tree hash: \`${srcTagRel}\` prints
   \`src-<12 hex>\` — a git tree-object hash of the working tree,
   including uncommitted changes. Same tree → same tag, on every
   machine. Tests and harnesses resolve artifacts by that tag and fail
   loudly when it is missing. Never \`:latest\` or any mutable tag in a
   verification path — staleness must be unrepresentable, not avoided.
`;

// Retire estate payloads earlier versions materialized: the session-start
// hook and the skills-index context payload it injected. The cheatsheet is
// the awareness surface now; suite-owned files, so removal is converge,
// not consent.
const retired = [];
for (const rel of [['hooks', 'session-start'], ['context', 'skills-index.md']]) {
  const p = path.join(root, '.ok-workspaces', ...rel);
  if (fs.existsSync(p)) {
    fs.unlinkSync(p);
    retired.push(rel.join('/'));
  }
}
for (const dir of ['hooks', 'context']) {
  const p = path.join(root, '.ok-workspaces', dir);
  if (fs.existsSync(p) && fs.readdirSync(p).length === 0) fs.rmdirSync(p);
}

// The merged lifecycle verb retired when the front door became the
// suite's sole administrator; converge removes the stale vendored copy.
const retiredVerbDir = path.join(root, '.claude', 'skills', 'true-up');
if (fs.existsSync(retiredVerbDir)) {
  fs.rmSync(retiredVerbDir, { recursive: true });
  retired.push('.claude/skills/true-up/');
}

// Vendor the user-facing skills into the project's committed skills
// directory, per the integration contract's vendored-skills layer: the
// audit verb family-prefixed under the collision rule, sibling references
// rewritten to the materialized names. Rendering lives in vendoredSkills()
// so diagnose compares against exactly what this writes.
// @decision: vendored-skills
const { vendoredSkills } = require('./vendored-skills');
const vendored = vendoredSkills(pluginRoot, root, version);
for (const [dest, body] of Object.entries(vendored)) {
  fs.mkdirSync(path.dirname(dest), { recursive: true });
  fs.writeFileSync(dest, body);
}

const rulesDir = path.join(root, '.claude', 'rules');
fs.mkdirSync(rulesDir, { recursive: true });
fs.writeFileSync(path.join(rulesDir, 'ok-workspaces-cheatsheet.md'), cheatsheet);

// The family LICENSE rides at the estate root: a vendored family carries
// its license text into every consumer project, byte for byte.
fs.writeFileSync(path.join(root, '.ok-workspaces', 'LICENSE'), fs.readFileSync(path.join(pluginRoot, 'LICENSE'), 'utf8'));

console.log(
  `Converged ok-workspaces v${version}: ${srcTagRel} + .claude/rules/ok-workspaces-cheatsheet.md + .ok-workspaces/LICENSE + ${Object.keys(vendored).length} vendored skill files materialized from .ok-workspaces/config.json${retired.length ? ` (retired payloads removed: ${retired.join(', ')})` : ''}.`
);
