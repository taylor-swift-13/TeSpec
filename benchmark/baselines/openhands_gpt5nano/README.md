# OpenHands + GPT-5 nano baseline

`run_two_input.py` is the authoritative difficulty baseline for the current
benchmark. It evaluates the `generic-agent` condition: OpenHands may use ordinary
local shell/file tools, but its temporary workspace contains neither TeSpec nor
hidden gold data. The semantic question inputs are exactly `impl.c` and
`spec.qcp`; `TASK.md` is the common response contract and dependencies are
mounted under `dependencies/`.

The older `run.py` and results under `benchmark/results/openhands-gpt-5-nano/`
belong to the legacy paired-mutant pilots. Their labels and scores are not
accepted by the two-input difficulty gate.

The API key is read only from the current process environment. A shell-safe
interactive invocation is:

```bash
read -rsp "OpenAI API key: " LLM_API_KEY
export LLM_API_KEY
python3 benchmark/baselines/openhands_gpt5nano/run_two_input.py \
  --dataset /path/to/materialized-dataset \
  --questions all \
  --attempts 3
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

The dataset uses:

```json
{
  "schema": "tespec-four-class-public-index/v1",
  "benchmark": "tespec-four-class-600",
  "questions": [
    {
      "id": "q01",
      "impl": "q01/input/impl.c",
      "spec": "q01/input/spec.qcp",
      "task": "TASK.md",
      "dependencies": []
    }
  ]
}
```

The hidden `gold.json` uses schema `tespec-four-class-gold-index/v1`. The
runner performs exactly three independent attempts per question with frozen
model `openai/gpt-5-nano`, high reasoning effort, Chat Completions, and a
600-second attempt timeout. Each scored trajectory must contain an agent tool
action that inspects both `impl.c` and `spec.qcp`; a label emitted without that
attestation is unresolved, not evidence that the question is difficult.

Run the release gate:

```bash
python3 scripts/gate-gpt5-nano-difficulty.py \
  --summary benchmark/results/openhands-gpt-5-nano-v2/RUN/summary.json \
  --output benchmark/results/openhands-gpt-5-nano-v2/RUN/difficulty-gate.json
```

- Nano correct on zero or one of three attempts: retain the question.
- Nano correct on two or three attempts: replace the question with a harder
  question of the same class.
- Missing, timed-out, authentication, gateway, malformed, or input-uninspected attempts:
  unresolved; never count them as evidence of difficulty.

Raw JSONL, stderr, parsed submissions, timing, hashes, and package versions are
saved under `benchmark/results/openhands-gpt-5-nano-v2/`. The runner never
copies hidden gold into an agent workspace and never serializes credentials.
