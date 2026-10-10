> 历史扫描记录：以下数据对应本文记录的旧二进制。当前执行语义及分类测试见 [inline-preserve/v1](inline-preserve-implementation.md)。

# QCP corpus evaluation

The input corpus is `/home/yangfp/QCIP/QCP_examples`. Sources are read-only.
The runner is `scripts/run-qcp-corpus.py`. It inventories every C source and
specification, records source and binary hashes, and evaluates both execution
modes without launching a proof Agent.

```sh
python3 scripts/run-qcp-corpus.py \
  --examples /home/yangfp/QCIP/QCP_examples \
  --binary /tmp/tespec-precondition-build/symexec \
  --runtime runtime/qcip \
  --output /tmp/tespec-evaluation/reproduction \
  --timeout 5
```

## Interpretation

The automatically generated sizes 0, 1, and 2 are smoke-test inputs, not a
validity oracle. Pointer arguments remain symbolic. Opaque types and unresolved
template terms are reported as `NEEDS_BINDINGS`; they are not replaced by guessed
integers. The inventory includes declarations as well as definitions.

A declaration with a specification checks instantiated Require satisfiability.
Its report has `scope: specification-only` and execution `NOT_RUN`. It does not
claim to validate a function implementation or its postcondition. A target
without a specification is an error. The two execution modes apply when a body
exists; both accept declaration-only specification checking.

Each case reports separate `phases.precondition` and `phases.execution` values.
Execution PASS with Require UNKNOWN is conditional, and the overall result stays
UNKNOWN. A proven inconsistent Require means invalid test bindings. It is not a
counterexample to the implementation. A generated residual VC is not a proof.

The automatic stage records elapsed wall time, GNU time CPU time and maximum process RSS in KiB.
The summary peak is the maximum per-case QCP RSS, not the total memory of the
Python controller or the sum of concurrent processes. Missing measurements are
null. Timeout terminates the executor process group. Small timeout runs diagnose
routing and robustness; they cannot measure a tool's ultimate solving capability.

## Regressions addressed

- Pointer arguments may be omitted or explicitly marked symbolic. Scalar
  arguments require a binding or an explicit symbolic marker. Logical With
  variables may remain unbound.
- Source-relative strategy imports resolve against the original source, so
  generated sources do not lose their domain strategies when moved.
- Declaration-only targets generate actual Require VCs instead of succeeding
  with an empty VC set. Missing specifications are rejected.
- Primitive memory interval constraints detect symbolic overlapping storage,
  including arithmetic aliases and reordered assertions. The constraints are
  necessary conditions for contradiction detection; they do not manufacture a
  SAT witness for unsupported memory predicates.
- Nonzero executor exits retain RSS measurements. Timeouts terminate child
  processes instead of only terminating the measurement wrapper.

## Remaining evaluation barriers

- Arbitrary structures' field addresses and opaque predicates can still leave
  Require UNKNOWN. The memory matrix contains seven such cases.
- Some input functions need explicitly typed graph, tree, floating-point, or
  polymorphic bindings. Automated integer/list templates do not supply these.
- Some corpus targets have named specifications that are not attached to the
  chosen definition, missing dependencies, or annotations rejected by the
  current frontend. Their diagnostics must remain visible.
- The legacy packaged executable and the candidate sac executable have different
  precondition semantics. Legacy PASS expectations are not evidence that the
  candidate proved Require. Candidate integration tests use `SAC_SYMEXEC`.
- Automatic verdicts rely on QCP/SMT; existing auto files may use admitted
  obligations. They are not independently replayed proof certificates.

Do not report smoke-test PASS fractions as accuracy, complete support, or
independently certified results. A research evaluation still needs curated valid
and invalid bindings, expected outcomes, mutation tests, ablations, and a frozen
runtime/dependency environment.

## 2026-10-09 scan

Inventory: 267 C files, 1,147 specification entries. For 860 entries the runner
constructed three candidate bindings and ran both modes (5,160 case runs);
287 entries require explicit typed bindings. With a one-second per-case timeout,
the scan recorded 677 PASS, 2,776 UNKNOWN, 10 FAIL, and 1,697 ERROR. ERROR includes
933 bindings inconsistent with Require, 182 timeouts, and 582 execution errors.
These are observed outcomes, not independently validated ground-truth labels.

This scan started before the relative-strategy relocation fix and some report
refinements. It is a diagnostic baseline, not the aggregate result of the final
patch. The corrected CDCL target was replayed separately: its three no-expand
cases moved from missing-strategy errors to Require UNKNOWN with residual VCs.

Local full artifacts: `/tmp/tespec-evaluation/reproducible/report.json`;
corrected strategy check: `/tmp/tespec-evaluation/strategy-regression/report.json`;
declaration-only examples: `/tmp/tespec-evaluation/declaration-only/`;
historical memory matrix: `/tmp/tespec-evaluation/memory-final/`.

The old packaged `bin/qcp-symexec` and its experiment hash remain unchanged.
The new default is `bin/tespec-symexec`; its source/binary metadata is in
`bin/tespec-symexec.build.json`. Tests now assert precondition, safety,
postcondition and annotation phases. A failed entailment remains UNKNOWN until
reachable counterexample evidence is available; legacy mutation-kill counts
must not be compared directly with the new verdicts.

The completed implementation run and paired curated benchmark are documented in
[spec-test-implementation.md](spec-test-implementation.md).
