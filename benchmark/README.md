# TeSpec bidirectional synthesis benchmark

The active benchmark evaluates two inverse generation tasks:

- `code-to-spec`: synthesize a QCP specification from a C implementation;
- `spec-to-code`: synthesize a C implementation from a QCP specification and
  ABI declarations.

There is no training split and no semantic feedback loop. The model receives
three unrelated QCP examples in raw and annotated forms. The three ablation
conditions provide no tool, the original QCP symbolic executor, or TeSpec.
Final submissions are frozen before the hidden test machine runs.

The current audited task is
[`experiments/spec-synthesis-tester-ablation-20260731`](experiments/spec-synthesis-tester-ablation-20260731).
It contains six semantic groups of five hidden cases. Specification
submissions must also reject all hidden incorrect-program mutations. Hidden
cases record concrete C object states; candidate-specific QCP binds are derived
structurally from `Require store(...)` terms only after submission freeze.

Raw model traces and judge artifacts are not part of the benchmark. By default,
the runner writes them outside the repository under
`../teSpec-artifacts/benchmark-results/`. Durable protocol inputs and their
SHA-256 values are recorded in the experiment's `dataset-manifest.json`.
