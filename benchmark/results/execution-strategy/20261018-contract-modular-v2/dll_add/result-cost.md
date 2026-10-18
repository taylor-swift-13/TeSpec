# dll_add — execution strategy costs

Supplemental native tests; no new universal or ITP certificate.
Time is per-execution mean. RSS is largest process peak. CLI/executor times are nested. Tokens=0 for this native run.

| Strategy | VC mode | SMT | Runs | PASS / UNKNOWN / FAIL / ERROR | CLI mean s | CLI peak KiB | Executor mean s | Executor peak KiB |
| --- | --- | --- | ---: | --- | ---: | ---: | ---: | ---: |
| inline | entry-exit | off | 14 | 0 / 14 / 0 / 0 | 0.211656 | 22780 | 0.017506714285714285 | 6284 |
| inline | entry-exit | on | 14 | 0 / 14 / 0 / 0 | 0.247533 | 50448 | 0.01758442857142857 | 6332 |
| inline | all-boundaries | off | 14 | 0 / 14 / 0 / 0 | 0.211638 | 22788 | 0.018616214285714285 | 6524 |
| inline | all-boundaries | on | 14 | 0 / 14 / 0 / 0 | 0.240316 | 50364 | 0.017528214285714286 | 6540 |
| modular | entry-exit | off | 14 | 0 / 14 / 0 / 0 | 0.197245 | 22768 | 0.017287214285714288 | 6332 |
| modular | entry-exit | on | 14 | 0 / 14 / 0 / 0 | 0.247489 | 50424 | 0.01753342857142857 | 6332 |
| modular | all-boundaries | off | 14 | 0 / 14 / 0 / 0 | 0.211658 | 22804 | 0.01844442857142857 | 6540 |
| modular | all-boundaries | on | 14 | 0 / 14 / 0 / 0 | 0.233105 | 50440 | 0.01789457142857143 | 6588 |
