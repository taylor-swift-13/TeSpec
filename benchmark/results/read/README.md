# read ITP 展示入口

每次需要 ITP 的测试执行平均开销见 [tespec/itp-average.md](tespec/itp-average.md)。这是现有共享批次按 12 次执行均摊的估算；原始批次数据保留用于审计。

# Read benchmark results

Start with the four named tool entries:

```text
cn/results.json             Primary CN universal verification (reused)
cn/statistics.json
qcp/results.json            Complete primary QCP universal verification
qcp/statistics.json
fulminate/results.json      All 61 finite variant/input tests
fulminate/statistics.json
tespec/results.json         All 61 tests including required metered ITP
tespec/statistics.json
comparison.json             Four-tool scope, outcome and resource overview
comparison.csv
index.json                  Provenance and raw evidence entry points
```

CN and QCP verify only the designated primary function once. CN verification and QCP native VC generation reuse hash-matched archived read2 repeat-1 evidence. QCP additionally includes metered gpt-6.1-sol proof generation, Coq compilation/audit and independent kernel checking under 20261015-qcp-verify-complete/. The native auto count of one VC is not used as a substitute for full proof-stage costs. These are universal verification results, not 61 finite test outcomes.

Fulminate and complete teSpec cover 61 paired variant/input cases across 10 configurations, associated with all 13 language-version records. Fulminate matches expected outcomes on 60/61; teSpec with kernel-checked ITP matches 61/61. Only the approved no-readable-memory ERROR class counts as expected; other ERROR classes are not automatically credited.

`20261015-variants/` retains raw executions. `20261015-itp-metered/` retains measured model/Coq proof evidence. `complete/` is the full staged teSpec result. `20261015-itp-refutations/` is the older unmetered authoring history.

Run `python3 tools/benchmark/publish_read_tool_results.py` to rebuild these views. `complete_read_pipeline.py` also refreshes them. All result files are derived from actual saved measurements and immutable source/goal/log hashes; no performance value is synthesized or moved between incompatible variants.

## 分阶段资源统计

QCP 与 teSpec 将生成／测试执行、agent 填写证明、Coq 编译与审计、独立内核检查分开统计；各阶段时间、进程峰值内存和 token 见 [stages.csv](stages.csv)／[stages.json](stages.json)。完整总计仍保留，历史测量回执不变。
