async function get(path) {
  const res = await fetch(path, { headers: { accept: 'application/json' } });
  const body = await res.json();
  if (!res.ok) throw new Error(body.error || `request failed: ${res.status}`);
  return body;
}

export const meta = () => get('/api/meta');
export const artifacts = (kind) =>
  get('/api/artifacts' + (kind ? `?kind=${encodeURIComponent(kind)}` : ''));
export const artifact = (kind, slug) =>
  get(`/api/artifact/${encodeURIComponent(kind)}/${encodeURIComponent(slug)}`);
export const sources = () => get('/api/sources');
export const source = (path) =>
  get(`/api/source?path=${encodeURIComponent(path)}`);
export const inspection = () => get('/api/inspection');
