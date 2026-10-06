const OWNER = 'owner';
const AGENT_AUTHORS = ['triage-issues', 'converge'];

async function answer(res) {
  const body = await res.json();
  if (!res.ok) throw new Error(body.error || `request failed: ${res.status}`);
  return body;
}

async function get(path) {
  return answer(await fetch(path, { headers: { accept: 'application/json' } }));
}

async function post(path, body) {
  return answer(
    await fetch(path, {
      method: 'POST',
      headers: { accept: 'application/json', 'content-type': 'application/json' },
      body: JSON.stringify(body),
    }),
  );
}

const at = (id) => `/api/issue/${encodeURIComponent(id)}`;

const which = (opened) => (opened ? `?opened=${encodeURIComponent(opened)}` : '');

export const key = (summary) => `${summary.id} ${summary.opened}`;

export const meta = () => get('/api/meta');
export const issues = () => get('/api/issues');
export const closed = () => get('/api/closed');
// @concept: issue
export const issue = (id, opened) => get(at(id) + which(opened));
// @decision: linked-files-open-in-place
export const file = (path) => get(`/api/file?path=${encodeURIComponent(path)}`);

// @story: rule-on-the-whole-intake
export const rule = (id, text) => post(`${at(id)}/rule`, { text });

// @story: discuss-an-issue
export const comment = (id, text) => post(`${at(id)}/comment`, { text });

// @story: discuss-an-issue
// @decision: owner-messages-can-change
export const editMessage = (id, n, text) => post(`${at(id)}/message/${n}/edit`, { text });

// @story: discuss-an-issue
// @decision: owner-messages-can-change
export const removeMessage = (id, n) => post(`${at(id)}/message/${n}/remove`, {});

// @decision: flagged-issues-discussed-in-session
export const flag = (id, on) => post(`${at(id)}/${on ? 'flag' : 'unflag'}`, {});

// @story: rule-on-the-whole-intake
// @decision: owner-messages-can-change
export const unrule = (id) => post(`${at(id)}/unrule`, {});

export const isOwn = (message) => message.by === OWNER;

// @decision: owner-messages-can-change
export const untouched = (record, message) =>
  message.seen === null &&
  !message.edited &&
  !record.messages.some((m) => (m.replies_to ?? []).includes(message.n));

// @story: see-new-analysis
export const markRead = (id, opened) => post(`${at(id)}/read${which(opened)}`, {});

// @story: see-new-analysis
// @decision: closed-answers-count-as-new
export const unread = () => get('/api/issues?unread=1');

// @story: see-new-analysis
// @decision: agent-revisions-reach-the-owner
export const isNew = (message) => AGENT_AUTHORS.includes(message.by) && message.read === null;

// @story: see-new-analysis
export const isUnread = (summary) => summary.unread > 0;

export const isAgent = (message) => message.by !== OWNER;

export const readOnly = (record) => record.state === 'closed' || Boolean(record.sprint);

// @story: rule-on-the-whole-intake
export const tabs = [
  { key: 'unread', label: 'unread', holds: (v) => v.state !== 'verified' && isUnread(v) },
  { key: 'needs-ruling', label: 'needs ruling', holds: (v) => v.state === 'needs-ruling' },
  { key: 'waiting', label: 'waiting on triage', holds: (v) => v.state !== 'verified' && v.waiting },
  { key: 'flagged', label: 'flagged', holds: (v) => Boolean(v.flagged) },
  { key: 'ruled', label: 'ruled', holds: (v) => v.state === 'ruled' },
  { key: 'closed', label: 'closed', holds: () => true, archive: true },
  { key: 'verified', label: 'verified defects', holds: (v) => v.state === 'verified', hidden: true },
];
