# GPT-5 Nano tool-policy comparison

This experiment compares two reusable, question-independent four-class skills:

- `four-class-tool-forbidden` receives the complete impl/spec text inline and
  forbids every tool call;
- `four-class-tool-enabled` receives the same text inline, requires direct
  file reads, and requires a compiler-backed concrete probe.

The four questions cover binary buffers, nested arrays, a doubly linked
structure, and IEEE-754 behavior. They are balanced across `correct`,
`complete`, `soundness`, and `incomparable`. Each condition ran three attempts
per question with `openai/gpt-5-nano` through `https://yunwu.ai/v1`.

| condition | correct / assigned | adherence | successful probes | mean attempt |
|---|---:|---:|---:|---:|
| tools forbidden | 5/12 | 12/12 | 0/12 | 112.223 s |
| tools enabled | 4/12 | 2/12 | 3/12 | 282.702 s |

The tool-enabled skill did not improve this sample: allocated accuracy changed
from 41.7% to 33.3% (−8.3 percentage points), and mean attempt time increased
by 170.479 seconds. The only three successful executable probes all ended in
wrong labels. Nano often tested ordinary implementation executions but failed
to reason about behaviors admitted only by an underconstrained spec.

The result does not show that tools are generally harmful. It shows that a
generic instruction to invent C probes is not sufficient: the model needs a
direction-aware tool that can validate both `I \ S` and `S \ I`, especially
the spec-only Sound counterexample direction.

`report.json` contains every prediction, gold label, duration, tool action
count, direct-read audit, probe-success audit, input/skill hashes, and excluded
pre-experiments. `build_datasets.py` reproduces both label-blind datasets, and
`analyze_results.py` regenerates the aggregate report from raw traces.

The legacy pilot metadata had the h02/h03 axes reversed relative to the current
contract. This experiment re-reviewed the actual pairs: h02 is Complete-only
(`complete`) because the spec permits alternate rows with equal sums; h03 is
Sound-only (`soundness`) because `HeadLeTail` rejects some implementation
executions.
