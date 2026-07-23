export function stripGuidance(path: string): string {
  return path.replace(/^\/guidance\//, '');
}

export function stripProtocol(url: string): string {
  return url.replace(/^https:\/\//, '');
}

export function isSlashPair(s: string): boolean {
  return /[//]/.test(s);
}

export function ratio(a: number, b: number): number {
  return a / b;
}

export function halves(a: number, b: number, c: number): number {
  return a / b / c;
}
