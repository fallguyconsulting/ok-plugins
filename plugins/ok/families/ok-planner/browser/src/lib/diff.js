export function shown(value) {
  if (value === null || value === undefined) return '';
  if (typeof value === 'string') return value;
  if (Array.isArray(value)) {
    return value.map((v) => (v && typeof v === 'object' && 'text' in v ? `${v.label ?? '-'}. ${v.text}` : shown(v))).join('\n');
  }
  if (typeof value === 'object' && 'text' in value) return value.form ? `(${value.form}) ${value.text}` : value.text;
  return JSON.stringify(value);
}

function tokens(text) {
  return text.match(/\s+|[^\s]+/g) ?? [];
}

export function wordDiff(before, after) {
  const a = tokens(shown(before));
  const b = tokens(shown(after));
  const rows = a.length + 1;
  const cols = b.length + 1;
  const table = new Uint32Array(rows * cols);
  for (let i = a.length - 1; i >= 0; i--) {
    for (let j = b.length - 1; j >= 0; j--) {
      table[i * cols + j] = a[i] === b[j] ? table[(i + 1) * cols + j + 1] + 1
        : Math.max(table[(i + 1) * cols + j], table[i * cols + j + 1]);
    }
  }
  const out = [];
  const push = (kind, text) => {
    const last = out[out.length - 1];
    if (last && last.kind === kind) last.text += text;
    else out.push({ kind, text });
  };
  let i = 0;
  let j = 0;
  while (i < a.length && j < b.length) {
    if (a[i] === b[j]) {
      push('same', a[i]);
      i++;
      j++;
    } else if (table[(i + 1) * cols + j] >= table[i * cols + j + 1]) {
      push('gone', a[i++]);
    } else {
      push('added', b[j++]);
    }
  }
  while (i < a.length) push('gone', a[i++]);
  while (j < b.length) push('added', b[j++]);
  return out;
}
