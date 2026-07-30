# OpenHands + GPT-5 nano baseline

This runner evaluates the `generic-agent` condition: OpenHands may use ordinary
local shell/file tools, but its temporary workspace contains neither TeSpec nor
hidden gold data.

The API key is read only from the current process environment. A shell-safe
interactive invocation is:

```bash
read -rsp "OpenAI API key: " LLM_API_KEY
export LLM_API_KEY
python3 benchmark/baselines/openhands_gpt5nano/run.py --questions all
unset LLM_API_KEY
```

Independent questions can be run concurrently with `--jobs 3`. The published
comparison must use the same concurrency and timeout policy for every condition.

For an OpenAI-compatible gateway, also set its API root without a trailing
endpoint name:

```bash
export LLM_BASE_URL=https://gateway.example/v1
```

The runner forces OpenHands to use Chat Completions for this model. This avoids
provider-specific Responses API reasoning-item affinity requirements while
preserving the same OpenHands agent, model name, prompt, and tools.
The baseline uses OpenHands SDK's default `reasoning_effort=high`; this value,
the API mode, package versions, concurrency, timeout, and public-artifact
hashes are recorded in the run summary.

For a one-question configuration probe:

```bash
python3 benchmark/baselines/openhands_gpt5nano/run.py --questions q01
```

Raw OpenHands JSONL, stderr, parsed submissions, timing, and aggregate accuracy
are saved under `benchmark/results/openhands-gpt-5-nano/`. The runner never
copies `gold.json` into an agent workspace and never serializes the credential.
Authentication, gateway, timeout, and malformed-output failures are recorded as
infrastructure failures and are not silently scored as `abstain`.
