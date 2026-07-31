# Bidirectional Code/QCP synthesis with a hidden test machine

This benchmark contains two inverse generation tasks over the same QCIP-derived
program:

- `code-to-spec`: receive the C implementation and generate `spec.qcp`;
- `spec-to-code`: receive the QCP specification plus ABI declarations and
  generate the C function definition.

There is no training set and no semantic feedback loop. All 30 binds and all
12 incorrect-program mutations are private inputs of the final test machine.
They are neither copied into the model workspace nor included in prompts or
revision feedback.

## Public surface

Each direction exposes only:

1. three unrelated examples showing scalar, pointer-heap, and struct-field
   Code/QCP patterns in separate and `/*@ ... */` annotated forms; and
2. the public tool selected by the ablation condition.

The original-QCP condition deterministically attaches the candidate annotation
and returns the raw result of `qcp-symexec`. The TeSpec condition analyzes the
separate candidate and returns a normalized attachment, binding-analysis,
QCP-parser, or C-interface report. Neither tool receives a hidden bind,
mutation, counterexample, or final semantic verdict.

The ablation conditions use the same number of stateless Nano calls:

- `no-tool`: a revision must self-check;
- `qcp-tool`: a revision may see the original symbolic executor's report;
- `tespec-tool`: a revision may see TeSpec's normalized public report.

Internal Codex tools are forbidden and their event traces are audited in all
conditions. Any such action invalidates the attempt. “Tool” refers only to the
explicitly scoped interface invoked by the harness.

## One-shot hidden judgment

The final artifact is frozen before entering the test machine.

- A generated spec must accept the reference implementation on all 30 hidden
  binds and kill all 12 hidden mutants. Its score is the mean of positive pass
  rate and mutation score, so a vacuous postcondition cannot pass.
- A generated implementation is checked against the supplied target spec on
  all 30 hidden binds and must pass every one.

Both directions report six semantic sub-scores of five hidden cases:
preservation, injection, next-mode 1, next-mode 2, write precedence, and
combined boundaries. The spec direction additionally scores the hidden
mutations relevant to each group.

## Commands

Audit both gold artifacts against the hidden machine:

```bash
python3 benchmark/experiments/spec-synthesis-tester-ablation-20260731/run.py \
  --oracle-audit
```

Check a spec submission without exposing tests:

```bash
python3 benchmark/experiments/spec-synthesis-tester-ablation-20260731/syntax_checker.py \
  code-to-spec --submission candidate.qcp
```

Run one two-call Nano attempt in every direction/condition:

```bash
YUNWU_API_KEY=... \
python3 benchmark/experiments/spec-synthesis-tester-ablation-20260731/run.py \
  --direction both --condition all --attempts 1 --rounds 2
```

Raw submissions, traces, public-tool reports, and hidden-machine artifacts are
written under ignored `benchmark/results/bidirectional-synthesis/`. The API key
is read only from `YUNWU_API_KEY` and is never persisted.
