# sac / teSpec executor synchronization — 2026-11-06

Canonical source: /home/yangfp/sac_c_parser, branch tespec.
Deployed binary: bin/tespec-symexec. Provenance: bin/tespec-symexec.build.json.

- sac_revision: 020aae13fbe120bf278f26d31a989f8439e86548
- sac_master_base: 1cde2a4b2069c41b6a7a1fa29bf6a2492c7a34f1
- smt_revision: 3098d53575ad2a99f9f561ec4e10233c98f44fd3
- binary_sha256: b8c6cf3a277cd782f23ad6775576d6fd5a7212d3ae5a8ad13acbba30e948e481
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

## Verification receipts

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
