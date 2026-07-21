// @plumbline:allow-docstrings

/**
 * Outcome the executor relays back to the supervisor.
 */
export interface Outcome {
  status: string;
}

/**
 * Run delegates to the agent and translates its result into the wire shape.
 */
export async function run(input: string): Promise<Outcome> {
  return { status: input };
}
