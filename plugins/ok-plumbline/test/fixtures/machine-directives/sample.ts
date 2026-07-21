// SPDX-License-Identifier: Apache-2.0
// Copyright 2026 Fall Guy Consulting

// eslint-disable-next-line @typescript-eslint/no-explicit-any
export function unsafe(value: any): unknown {
  // @ts-ignore
  return value.whatever;
}
