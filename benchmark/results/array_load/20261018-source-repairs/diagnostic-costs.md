# array_load preserved native diagnostic costs

This report covers the seven explicitly listed historical/repair batches. It excludes final batch 20261018-evaluation-v3, all primary CN/QCP verification, and all test ITP costs. Original evidence is read only.

Amounts are measured stage work, not end-to-end latency. RSS is the largest measured process RSS; maxima are never summed. fulminate_pipeline includes its initial --run; fulminate_test is a distinct binary invocation. Deduplication uses exact command arguments plus canonical stdout path.

| Stage | Executed | Not executed | Total seconds | Maximum process RSS (KiB) | Tokens | Model calls |
|---|---:|---:|---:|---:|---:|---:|
| fulminate_pipeline | 201 | 0 | 27.148106 | 46424 | 0 | 0 |
| fulminate_test | 127 | 74 | 0.478220 | 1136 | 0 | 0 |
| tespec_off | 210 | 0 | 37.052042 | 20164 | 0 | 0 |
| tespec_on | 210 | 0 | 34.658147 | 20164 | 0 | 0 |

Total: **748** unique executed measurements, **74** unexecuted stages, **99.336515 seconds** of measured work. Global observed maximum process RSS: **46424 KiB**. Native-stage token/model calls: **0 / 0**.

| Batch | Purpose | Executed / not executed | Seconds | Raw stage outcomes |
|---|---|---:|---:|---|
| 20261016-evaluation | historical_baseline | 268 / 0 | 30.528977 | EXIT_0: 67, FAIL: 2, PASS: 191, UNKNOWN: 8 |
| 20261017-client-region-annotation-fix | source_revision_diagnostic | 2 / 0 | 0.781941 | PASS: 2 |
| 20261018-source-repairs/attempt1 | source_revision_diagnostic | 8 / 0 | 1.769581 | PASS: 4, UNKNOWN: 4 |
| 20261018-source-repairs/attempt2 | source_revision_diagnostic | 4 / 0 | 1.060124 | UNKNOWN: 4 |
| 20261018-source-repairs/attempt3 | source_revision_diagnostic | 4 / 0 | 1.110464 | UNKNOWN: 4 |
| 20261018-evaluation | harness_compatibility_diagnostic | 201 / 67 | 25.543119 | EXIT_1: 67, NOT_BUILT: 67, PASS: 130, UNKNOWN: 4 |
| 20261018-evaluation-v2 | harness_compatibility_diagnostic | 261 / 7 | 38.542309 | EXIT_0: 60, EXIT_1: 7, NOT_BUILT: 7, PASS: 190, UNKNOWN: 4 |

Classification and interpretation:

- The historical 67-pair batch is retained in full. Its teSpec mismatches are source_revision_diagnostic; original UNKNOWN/FAIL labels are not overwritten.
- The annotation-fix and attempt1/2/3 batches are source-revision diagnostics. Successful native retests are listed separately in JSON, bound to their new source hashes. They are not same-source ITP certificates.
- 20261018-evaluation and 20261018-evaluation-v2 are harness compatibility attempts: the latest CN/Fulminate rejects fixed-width i32 literals where integer expressions are required. The first batch has no built test binaries; the second builds 60 helper tests while seven client harnesses remain unbuilt. Their actually executed pipeline and teSpec work still counts.
- NOT_BUILT contributes no fabricated execution time or RSS. Its measured failed pipeline is counted separately.
- This native report has no model calls. It does not assert that the complete repair process or ITP has zero token cost.
- Final benchmark correctness/completeness and the final current-source cost table must reference their own final batch and checked ITP receipts; this report is an additional diagnostic-cost component.

Per-measurement commands, source hashes where recorded, raw statuses, report/log hashes, per-stage metrics, and missing-stage records are in [diagnostic-costs.json](diagnostic-costs.json).
