# GPT-5 Nano tool-policy comparison

> **Invalid experiment — do not use the accuracy delta.** The nominal
> tool-enabled condition never invoked `qcp-spectest` with the implementation,
> QCP specification, and concrete binds. It only asked Nano to write ordinary
> C compiler harnesses, so this run measured ad-hoc implementation probing,
> not the TeSpec tool skill.

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

The table is retained only as provenance for the invalid run. It cannot answer
whether TeSpec improves Nano because the required spec-testing executable was
absent from the treatment. A valid rerun must assemble the separate
`impl.c/spec.qcp` inputs into the QCP source consumed by `qcp-spectest`, obtain
concrete binds, and require successful `analyze` and `run` calls.

`report.json` contains every prediction, gold label, duration, tool action
count, direct-read audit, probe-success audit, input/skill hashes, and excluded
pre-experiments. `build_datasets.py` reproduces both label-blind datasets, and
`analyze_results.py` regenerates the aggregate report from raw traces.

The legacy pilot metadata had the h02/h03 axes reversed relative to the current
contract. This experiment re-reviewed the actual pairs: h02 is Complete-only
(`complete`) because the spec permits alternate rows with equal sums; h03 is
Sound-only (`soundness`) because `HeadLeTail` rejects some implementation
executions.
