// The one derivation of ok-workspaces' vendored-skill renderings and of the
// two materialized LICENSE forms, shared by converge.js (writes),
// diagnose.js (compares), and the repo's vendored-layer conformance check.
// The audit verb materializes family-prefixed under the integration
// contract's collision rule; every other verb keeps its name.
// @decision: vendored-skills

const fs = require('fs');
const path = require('path');

const SKILLS = {
  audit: 'ok-workspaces-audit',
  close: 'close',
  'ok-workspaces': 'ok-workspaces',
  open: 'open',
};

function renderSkill(text, srcName, version) {
  if (srcName === 'audit') {
    text = text.replace('name: audit', 'name: ok-workspaces-audit');
  }
  text = text.replace(/ok-workspaces:audit/g, 'ok-workspaces-audit');
  // Rewrite slash-command references only — never support-script paths
  // (an `/audit-…` file name must survive), hence the hyphen guard.
  text = text.replace(/\/audit\b(?!-)/g, '/ok-workspaces-audit');
  text = text.replace(/ok-workspaces:(open|close)/g, '$1');
  return (
    text +
    `\n<!-- Materialized by ok-workspaces v${version} — suite-owned; overwritten on converge; do not hand-edit. -->\n`
  );
}

// Both materialized destinations sit among content the project owns — the
// estate root beside its committed profile and worktrees, the vendored
// folders beside skills the project wrote — so each LICENSE opens with a
// preamble naming the licensor and what the grant covers. The Apache text
// below it is verbatim. The license never goes inside SKILL.md: a skill
// body is context an agent pays for on every read.
const ESTATE_LICENSE_PREAMBLE = `ok-workspaces, materialized by the ok-* suite (Fall Guy LLC).

The license below covers the ok-workspaces files the suite's
administration materialized into this directory: this file, the src-tag
script, the port-block allocator under bin/, and the worktree ignore
file. It does not cover this project's own work — config.json, the
worktrees themselves, and anything else the project put here are the
project's own, licensed however the project licenses itself.

======================================================================

`;

const VENDORED_LICENSE_PREAMBLE = `Vendored ok-workspaces files, materialized by the ok-* suite (Fall Guy LLC).

The license below covers the suite-owned files in this directory. Other
skills under .claude/skills/ are not covered by it — they carry their own
license, or the project's.

======================================================================

`;

function familyLicense(pluginRoot) {
  const src = path.join(pluginRoot, 'LICENSE');
  return fs.existsSync(src) ? fs.readFileSync(src, 'utf8') : null;
}

function estateLicense(pluginRoot) {
  const body = familyLicense(pluginRoot);
  return body === null ? null : ESTATE_LICENSE_PREAMBLE + body;
}

function vendoredLicense(pluginRoot) {
  const body = familyLicense(pluginRoot);
  return body === null ? null : VENDORED_LICENSE_PREAMBLE + body;
}

function vendoredSkills(pluginRoot, root, version) {
  const out = {};
  const license = vendoredLicense(pluginRoot);
  for (const [src, name] of Object.entries(SKILLS)) {
    const body = fs.readFileSync(path.join(pluginRoot, 'skills', src, 'SKILL.md'), 'utf8');
    out[path.join(root, '.claude', 'skills', name, 'SKILL.md')] = renderSkill(body, src, version);
    if (license !== null) out[path.join(root, '.claude', 'skills', name, 'LICENSE')] = license;
  }
  return out;
}

module.exports = { vendoredSkills, estateLicense, vendoredLicense };
