# Inline VC storage and exact regression — 2026-10-19

The installed executor shares exactly equal frozen safety-witness payloads in inline tests. Every original occurrence, source location, printing name map, solve status, and generated Coq goal remains independent. QCP's existing witness representation, solver, and proof printer are reused. No online condition, loop-exit or pruning implementation changed.

The report-level duplicate lookup now uses a collision-checked hash index with the original key, order and status precedence. An empty temporary entailment witness is no longer copied in inline mode (legacy auto-check logging keeps its original path). Safety/entailment JSON temporary-string ownership is fixed. There is no solver-verdict memoization.

## Validation

- 105 existing Python tests passed, including execution modes/strategies, query simplification, VC status, spatial SMT and contract instantiation.
- Real QCP AST snapshot and report-index tests passed under ASan/UBSan: exact pointer types, metadata, locals, frozen printing data, hash collisions, allocation fallback, rehashing, independent occurrence state and arbitrary release order.
- 14 paired loop/control cases passed exact comparison: 16/64/256 iterations, a final-iteration bad assertion, break/continue, and inline/modular × entry-exit/all-boundaries guards.
- All 1,800 inline executions from 21 complete groups (900 input pairs × spatial SMT OFF/ON) passed the regression and exact differential gates.
- All 5,262 generated Goal/proof_auto/goal_check files in 1,754 full-suite executions match; the other 46 expected early ERROR executions have no such files on either side. Original Goal, proof_auto and goal_check file bytes, native VC formulas/status/counts and witness counts match the old binary. Enabled traces match in focused cases. Only output-directory prefixes and the newly added `spec_test.vc_storage` diagnostic field are normalized.
- All 42 modular positive representative executions passed.
- Frozen historical evidence hashes remain unchanged. No new ITP/Coq kernel proof is claimed; this storage change preserves the original goals byte for byte.

The 1,800 comparisons include original negative cases, UNKNOWN and expected ERROR results. They are not 1,800 program PASS verdicts. Current group-completion progress remains 21/45.

## Measured examples

One serial before/after pair was measured per workload. Full-suite concurrent timings are development-regression costs, not controlled performance comparisons.

| Workload | Safety occurrences | Shared storage requests | Old/new peak RSS (KiB) | Old/new executor time (s) |
| --- | ---: | ---: | ---: | ---: |
| counter-16 | 67 | 32 | 9,676 / 8,852 | 0.023927 / 0.025873 |
| counter-64 | 259 | 128 | 59,620 / 55,424 | 0.480611 / 0.475281 |
| counter-256 | 1027 | 512 | 1,506,488 / 1,489,116 | 8.110429 / 7.505389 |
| last-assertion-256 | 1282 | 768 | 4,363,596 / 4,338,552 | 28.318485 / 27.372789 |

Sharing counts refer to storage, not deleted VCs. The long-loop total-memory reduction is limited: live symbolic history, non-safety witnesses and optional traces can still dominate. This change does not claim bounded memory or implement streaming/persistent state graphs.

## Evidence and reproduction

- [Targeted pairs](../20261019-candidate/summary.md), [machine results](../20261019-candidate/results.json).
- [1,800 exact comparisons](../20261019-full-comparison/results.json).
- [Full inline regression](../../spatial-smt-regressions/20261019-vc-storage/summary.json).
- [Modular representatives](../../spatial-smt-regressions/20261019-vc-storage-modular/summary.json).
- [Source scope](source-scope-audit.json), [build and source hashes](executor-build.json), [all measurements](summary.json).
- Native stage tokens are 0. No ITP model was called. All raw logs are retained.

```sh
SAC_SYMEXEC=bin/tespec-symexec python3 -B -m unittest \
  tests.test_execution_strategies tests.test_execution_modes \
  tests.test_query_simplification tests.test_vc_status \
  tests.test_spatial_smt tests.test_contract_instantiation

python3 -B tools/benchmark/regress_inline_vc_storage.py \
  --baseline-binary /tmp/tespec-vc-storage-baseline/symexec \
  --candidate-binary bin/tespec-symexec \
  --output benchmark/results/vc-storage-regressions/<fresh-directory> \
  --ignore-storage-metric vc_storage

python3 -B tools/benchmark/regress_execution_strategies.py \
  --execution-strategy inline --workers 4 \
  --output benchmark/results/spatial-smt-regressions/<fresh-directory>
```

The baseline binary is retained locally outside the repository; its SHA-256 is in baseline-build.json. QCP source remains only in `/home/yangfp/sac-query-simplification`; it is neither vendored nor pushed. Its new tests are `SymExec/tests/run-inline-vc-storage-tests.py [--sanitize]`. Build invocation and every changed source hash are recorded in executor-build.json.
