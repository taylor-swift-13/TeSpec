# Read benchmark results

Start with the four named tool entries:

```text
cn/results.json             Primary CN universal verification (reused)
cn/statistics.json
qcp/results.json            Primary QCP universal verification (reused)
qcp/statistics.json
fulminate/results.json      All 61 finite variant/input tests
fulminate/statistics.json
tespec/results.json         All 61 tests including required metered ITP
tespec/statistics.json
comparison.json             Four-tool scope, outcome and resource overview
comparison.csv
index.json                  Provenance and raw evidence entry points
```

CN and QCP verify only the designated primary function once. The selected representative is the hash-matched archived read2 repeat-1 verification; no rerun and no repeated timing charged. CN exits zero; QCP has one automatically discharged VC and no manual obligations. These are universal verification results, not 61 finite test outcomes.

Fulminate and complete teSpec cover 61 paired variant/input cases across 10 configurations, associated with all 13 language-version records. Fulminate matches expected outcomes on 60/61; teSpec with kernel-checked ITP matches 61/61. Only the approved no-readable-memory ERROR class counts as expected; other ERROR classes are not automatically credited.

`20261015-variants/` retains raw executions. `20261015-itp-metered/` retains measured model/Coq proof evidence. `complete/` is the full staged teSpec result. `20261015-itp-refutations/` is the older unmetered authoring history.

Run `python3 tools/benchmark/publish_read_tool_results.py` to rebuild these views. `complete_read_pipeline.py` also refreshes them. All result files are derived from actual saved measurements and immutable source/goal/log hashes; no performance value is synthesized or moved between incompatible variants.
