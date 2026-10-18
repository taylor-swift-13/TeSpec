# Dbl_Linked_List__singleton — execution strategy costs

Supplemental native tests; no new universal or ITP certificate.
Time is per-execution mean. RSS is largest process peak. CLI/executor times are nested. Tokens=0 for this native run.

| Strategy | VC mode | SMT | Runs | PASS / UNKNOWN / FAIL / ERROR | CLI mean s | CLI peak KiB | Executor mean s | Executor peak KiB |
| --- | --- | --- | ---: | --- | ---: | ---: | ---: | ---: |
| inline | entry-exit | off | 7 | 0 / 7 / 0 / 0 | 0.179359 | 22708 | 0.011099714285714286 | 5820 |
| inline | entry-exit | on | 7 | 0 / 7 / 0 / 0 | 0.222331 | 50404 | 0.011242571428571428 | 5820 |
| inline | all-boundaries | off | 7 | 0 / 7 / 0 / 0 | 0.172195 | 22680 | 0.011482142857142857 | 5820 |
| inline | all-boundaries | on | 7 | 0 / 7 / 0 / 0 | 0.222294 | 50548 | 0.011260571428571429 | 5768 |
| modular | entry-exit | off | 7 | 0 / 7 / 0 / 0 | 0.172150 | 22676 | 0.01112342857142857 | 5812 |
| modular | entry-exit | on | 7 | 0 / 7 / 0 / 0 | 0.236722 | 50288 | 0.011125 | 5820 |
| modular | all-boundaries | off | 7 | 0 / 7 / 0 / 0 | 0.186647 | 22680 | 0.011343 | 5820 |
| modular | all-boundaries | on | 7 | 0 / 7 / 0 / 0 | 0.215207 | 50392 | 0.01138457142857143 | 5812 |
