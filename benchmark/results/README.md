# Benchmark results

All results and statistics for the 45 CN/Fulminate program groups are stored here. Program-group directories contain variant sources, specifications and test inputs; their manifests reference this result directory.

- `index.json`: current/historical result entry points and honest coverage summary.
- `evidence.json`: existing observations, raw statuses, metrics, artifact locations and hashes.
- `relocation-map.json`: byte-preserving moves from earlier layouts. Archived report text is unchanged.
- `historical/selection/`: frozen verification, tests, model receipts, measurement logs and their result bundles.
- `historical/grouped/`: per-variant historical result associations.
- `read/index.json`: read variant/input result pointers.
- `read/20261015-variants/`: new finite tests and statistics; no universal verification rerun.

Read testing uses six owned-cell values (INT_MIN, -1, 0, 1, 7, INT_MAX), plus null for the no-ownership precondition. Ten paired configurations cover thirteen existing CN/QCP records. Every execution is recorded, including 12 UNKNOWN postcondition results and 7 memory-access ERROR results from teSpec. They are not upgraded to successful negative detection. At INT_MIN, the negated-return implementation reports Fulminate PASS and teSpec FAIL; this signed-overflow case is retained as an observed tool difference.

Timing includes separate Fulminate instrumentation/compile/initial-execution pipeline and standalone runtime measurements. GNU time %M records the largest measured process RSS, not total concurrent process-tree memory. Tests make no model calls (zero tokens). Old model calls and resource usage remain in their frozen historical reports.

Reproduce and audit (the test runner refuses to overwrite a measured run):

```sh
python3 tools/benchmark/test_read_variants.py
python3 tools/benchmark/summarize_read_variants.py
python3 tools/benchmark/validate_read_results.py
python3 tools/benchmark/build_program_groups.py --check
python3 tools/benchmark/audit_archive.py
```

## Read UNKNOWN results adjudicated by Coq

`read/20261015-itp-refutations/receipt.json` records independent kernel-checked refutations of all 12 actual UNKNOWN VCs and their spatial splits, plus 12 proved satisfiable entries. All 36 theorem assumption audits are closed. No executor or solver code was changed.

`resolved-results.json` in that directory gives the separate adjudicated view (22 PASS, 32 FAIL, 7 expected ERROR). The original automatic results are unchanged. Authoritative evidence consists of the exact goal copies, refutation sources, compilation/audit logs and kernel receipt. Replay with `python3 tools/benchmark/refute_read_unknowns.py`; audit saved source hashes and receipts with `python3 tools/benchmark/validate_read_itp.py`.
