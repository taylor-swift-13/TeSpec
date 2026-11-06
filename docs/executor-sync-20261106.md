# sac / teSpec executor synchronization — 2026-11-06

Canonical source: /home/yangfp/sac_c_parser, branch tespec.
Deployed binary: bin/tespec-symexec. Provenance: bin/tespec-symexec.build.json.

- sac_revision: b36b30773cf5dd9c1cb090997c0004dd4940e659
- sac_master_base: 1cde2a4b2069c41b6a7a1fa29bf6a2492c7a34f1
- smt_revision: 3098d53575ad2a99f9f561ec4e10233c98f44fd3
- binary_sha256: 09987e13f52a78c83925e5a67ee0d6cd05bf657eb3f94d17c4f70e3dfa74fed5
- source_dirty: False

Installed and build binary hashes match. The tracked source and SMT trees were
clean at build. Master remained at 1cde2a4b2069c41b6a7a1fa29bf6a2492c7a34f1.
No sac push.

## Compatibility

Retain inline/modular execution, fixed entry bindings, independent VC-generation
options, original VC snapshots, deferred scheduling and three-valued teSpec queries.
Adapt C parameters to upstream spec.params, storage to StoreCType, and errors to
structured diagnostics while retaining legacy teSpec JSON fields. Legacy typed-PTR
strategies are accepted in teSpec mode only. Ordinary QCP retains upstream
implication, source contradiction, and goal preprocessing; teSpec-specific equality
rewriting is mode-gated. The installed binary comes from the canonical branch.

The query-isolation test accepts pre_value and upstream free_value names for the
same symbolic witness. Status expectations were unchanged.

## Initial merge verification receipts (020aae13fbe1)

```json
[
  {
    "check": "sac upstream tests",
    "tests": 608,
    "result": "PASS",
    "log_sha256": "5d6f4e80cb5beef103272f7a9c4cb7ca2cd39685a8fd189c3adcd1f50bbd76e4"
  },
  {
    "check": "teSpec behavior regressions",
    "tests": 116,
    "result": "PASS",
    "log_sha256": "f367a6d0637d989fa836f200cd7b2c289a35ad38b9852af7f21ac04ce66663f7"
  },
  {
    "check": "ASan native regressions (detect_leaks=0)",
    "tests": 39,
    "result": "PASS",
    "log_sha256": "99ec8a74a47d92e7b9a431aa1db22b3c3c24a326f4c0fc4d0840585075c49201"
  },
  {
    "check": "original VC storage",
    "tests": null,
    "result": "PASS",
    "log_sha256": "fa448eef500c17ad14379e78ccf58a0bb5b5bd52b01b0d401b68de4db5686b66"
  },
  {
    "check": "deferred witness solving",
    "tests": null,
    "result": "PASS",
    "log_sha256": "668a65338f4434d12ad2ceed7b4624c420037901922ab5036d651d89f5934bdc"
  }
]
```

The 116-test suite includes the frozen 34-case, two-VC-mode query replay plus
inline/modular, array, contract and spatial-SMT checks. This is compatibility
evidence, not a fresh rerun of all benchmark groups or Coq proofs.
ASan checks cover invalid accesses; leak detection was disabled.
Runtime check found 392 compiled Coq modules and Coq 8.20.1.
Raw temporary build/replay files were not added to benchmark results.

## Subsequent installed-binary interface check

The per-VC fallback change replayed 22 compact groups on the installed binary.
This exposed adapter gaps for `verification_conditions`, `{Z_1}` list printing,
and erased `PTR`; the Python adapter now accepts the checked formats. The replay
also found pre-existing array_load discrepancies: translation9 returns native
FAIL in both strategies, while inline translation7/12 remain UNKNOWN. The earlier
compatibility receipts must not be read as a full installed-binary benchmark pass.
See docs/spatial-smt.md for scope, negative-writeback protection and focused checks.

## Native entry and annotation fixes

The first native fix was introduced in sac `db632c3cebe0cfa9315d076e433e5879f7d9c077`.
Body annotations bind `With` variables to the selected entry specification before
semantic analysis captures their IDs. Fresh observation goals again resolve local
addresses and retain unmentioned C scalar local storage after template lowering.
The live execution state and arbitrary user heap are not completed or rewritten.
The changes are gated to teSpec; ordinary QCP and master were not modified.

Installed-binary focused replay (all-boundaries, spatial SMT enabled):

| Original array_load case | inline | modular |
| --- | --- | --- |
| translation7 | PASS | PASS |
| translation9 | PASS | PASS |
| translation12 | PASS | FAIL |

All six match their existing expectations. No benchmark source, specification,
input or expectation changed. The prior four open discrepancies are resolved;
this does not claim a new complete 22-group replay or 45-group completion.

Validation: 608 sac regressions and 137 teSpec targeted regressions passed with
no skipped tests; the six new test methods cover 15 configurations and also pass
with ASan (`detect_leaks=0`). Tests include specification selection/order,
C-variable shadowing, wrong alias assertions and missing external heap.
The installed binary matches the canonical Release build from clean tracked source.
No new ITP/Coq proof or performance evaluation is claimed. sac was committed locally
only; teSpec carries the binary, provenance, regressions and compact receipt.
See [current executor receipt](../benchmark/results/tespec-unexpected/current-executor-replay.json)
for status, source/VC hashes, native resource measurements and test-log hashes.

## Inline helper binding and recursive frame fixes

Current sac source: `b36b30773cf5dd9c1cb090997c0004dd4940e659` (local commit only).
QCP's existing call-result instance map now retains original With IDs alongside
inferred and explicit `where(...)` values. Each inline invocation uses its own
map; simultaneous substitution protects outer symbolic values during recursion.
Same-name aliases are limited to same-type With binders in the current callee's
specifications. This fixes correct helper assertions that previously reported FAIL,
including selection of a non-last named specification.

A further symbolic-recursion control exposed caller stack cells being renamed to
callee addresses when an assertion omitted a parameter. Callee-local annotation
preparation now precedes caller-frame merging. Only shadowed LOCAL entries are
removed from that frame copy; its SEP/PROP and old stack addresses are preserved.
Unmentioned local scalar storage is added after the merge to avoid duplication.
Actual execution states and original witness storage remain unchanged.

Final installed-binary checks: **608 sac tests and 147 teSpec tests passed**, no
skips. ASan (`detect_leaks=0`) passed 39 existing call/strategy tests and 16 entry/
annotation methods covering 36 configurations, including positive and negative
assertions, explicit/named contracts, invariants and symbolic recursive swaps.
The six array_load controls above still match their original expectations.
No benchmark source/expectation changed and no full-group, ITP or Coq proof rerun
is claimed. The existing compact receipt contains updated hashes and check totals.
