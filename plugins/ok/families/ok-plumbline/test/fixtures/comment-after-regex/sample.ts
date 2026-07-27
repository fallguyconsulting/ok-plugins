export function stripGuidance(path: string): string {
  return path.replace(/^\/guidance\//, '');
}

// a comment following a regex literal is still residue
export const flagged = true;
