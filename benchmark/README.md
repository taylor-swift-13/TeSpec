# TeSpec bidirectional synthesis benchmark

The active benchmark evaluates two inverse generation tasks:

- `code-to-spec`: synthesize a QCP specification from a C implementation;
- `spec-to-code`: synthesize a C implementation from a QCP specification and
  ABI declarations.

There is no training split and no semantic feedback loop. The model receives
one unrelated format example and, in the tool condition, syntax-only
diagnostics. Final submissions are frozen before the hidden test machine runs.

The current audited task is
[`experiments/spec-synthesis-tester-ablation-20260731`](experiments/spec-synthesis-tester-ablation-20260731).
It contains six semantic groups of five hidden cases. Specification
submissions must also reject all hidden incorrect-program mutations.

Raw model traces and judge artifacts belong under the ignored
`benchmark/results/` path. Durable protocol inputs and their SHA-256 values are
recorded in the experiment's `dataset-manifest.json`.
