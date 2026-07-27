#!/usr/bin/env node
// ok-workspaces materialization. Requires an authoritative committed
// profile at .ok-workspaces/config.json (detection proposes via
// detect.js; a human commits the config). Materializes, from the
// profile: the canonical src-tag script at the profile-declared path,
// the port-block allocator at .ok-workspaces/bin/port-block (dev-server
// runtime only; removed otherwise), the always-in-context cheatsheet at
// .claude/rules/ok-workspaces-cheatsheet.md, the worktree .gitignore
// inside .ok-workspaces/, and the vendored skill set in .claude/skills/
// (merged lifecycle verb; audit prefixed under the collision rule). It
// also removes the retired estate payloads earlier versions wrote (the
// session-start hook and its skills-index context payload). All
// materialized files are plugin-owned whole files, overwritten
// wholesale, stamped with the version.

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
const configPath = path.join(root, '.ok-workspaces', 'config.json');

if (!fs.existsSync(configPath)) {
  console.error(
    'ok-workspaces true-up: no committed profile at .ok-workspaces/config.json.\n' +
      'Run detection first (node scripts/detect.js), review the proposal, and commit it as config.json.'
  );
  process.exit(2);
}
const cfg = JSON.parse(fs.readFileSync(configPath, 'utf8'));

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

const dirPrefix = (cfg.worktrees && cfg.worktrees.dirPrefix) || '.ok-workspaces/worktrees/';
const branchPrefix = (cfg.worktrees && cfg.worktrees.branchPrefix) || 'wt/';

// Worktrees default to living inside the project root, under the
// plugin's dot-directory, so nothing escapes the repo. A checkout
// inside the repo must never be committed to it, so the plugin owns a
// .gitignore in its own dot-directory covering wherever the profile
// puts them. Scoped to the dot-directory: the project's root
// .gitignore belongs to the human and is never touched.
const ignoreLines = ['# Plugin-owned; overwritten by /ok-workspaces:true-up.', '# Worktrees are checkouts, never content of this repo.'];
if (dirPrefix.startsWith('.ok-workspaces/')) {
  const rel = dirPrefix.slice('.ok-workspaces/'.length);
  ignoreLines.push(rel.endsWith('/') ? rel : `${rel}*`);
} else {
  ignoreLines.push('worktrees/');
}
fs.mkdirSync(path.join(root, '.ok-workspaces'), { recursive: true });
fs.writeFileSync(path.join(root, '.ok-workspaces', '.gitignore'), ignoreLines.join('\n') + '\n');

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
long-lived process is introduced, re-run detection — /ok-workspaces:true-up
will flag the profile drift.`;
}

const cheatsheet = `# ok-workspaces Cheatsheet

Materialized by ok-workspaces v${version} — plugin-owned; refreshed by
\`/ok-workspaces:true-up\`; do not hand-edit. Profile:
\`.ok-workspaces/config.json\` (stacks: ${(cfg.stacks || []).join(', ') || 'none'};
runtime: ${cfg.runtime}).

Three rules. Each one makes the next one safe — ship any subset and the
isolation story has a hole.

1. **One worktree per job.** Every unit of work gets its own checkout
   on its own branch: directory \`${dirPrefix}<job>\`, branch
   \`${branchPrefix}<job>\`. Never share a working tree between concurrent
   jobs; never do job work on the main checkout. Use
   \`/ok-workspaces:open <job>\` and \`/ok-workspaces:close <job>\`.

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
// the awareness surface now; plugin-owned files, so removal is converge,
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

// Vendor the user-facing skills into the project's committed skills
// directory, per the integration contract's vendored-skills layer: the
// audit verb plugin-prefixed under the collision rule, sibling references
// rewritten to the materialized names, the merged lifecycle verb written
// once from the shared template. Rendering lives in vendoredSkills() so
// diagnose compares against exactly what this writes.
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

console.log(
  `Trued up ok-workspaces v${version}: ${srcTagRel} + .claude/rules/ok-workspaces-cheatsheet.md + ${Object.keys(vendored).length} vendored skill files materialized from .ok-workspaces/config.json${retired.length ? ` (retired payloads removed: ${retired.join(', ')})` : ''}.`
);
