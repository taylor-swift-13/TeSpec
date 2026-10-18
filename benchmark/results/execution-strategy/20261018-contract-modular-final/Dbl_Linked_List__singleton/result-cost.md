# Dbl_Linked_List__singleton — execution strategy costs

Supplemental native tests; no new universal or ITP certificate.
Time is per-execution mean. RSS is largest process peak. CLI/executor times are nested. Tokens=0 for this native run.

| Strategy | VC mode | SMT | Runs | PASS / UNKNOWN / FAIL / ERROR | CLI mean s | CLI peak KiB | Executor mean s | Executor peak KiB |
| --- | --- | --- | ---: | --- | ---: | ---: | ---: | ---: |
| inline | entry-exit | off | 7 | 0 / 7 / 0 / 0 | 0.165064 | 23496 | 0.011397571428571429 | 5816 |
| inline | entry-exit | on | 7 | 0 / 7 / 0 / 0 | 0.215141 | 50604 | 0.011198714285714286 | 5772 |
| inline | all-boundaries | off | 7 | 0 / 7 / 0 / 0 | 0.164950 | 23488 | 0.011580285714285715 | 5772 |
| inline | all-boundaries | on | 7 | 0 / 7 / 0 / 0 | 0.215045 | 50700 | 0.011629142857142857 | 5800 |
| modular | entry-exit | off | 7 | 0 / 7 / 0 / 0 | 0.164956 | 23532 | 0.011629571428571428 | 5772 |
| modular | entry-exit | on | 7 | 0 / 7 / 0 / 0 | 0.215058 | 50684 | 0.011181714285714286 | 5812 |
| modular | all-boundaries | off | 7 | 0 / 7 / 0 / 0 | 0.172085 | 23488 | 0.011746857142857142 | 5816 |
| modular | all-boundaries | on | 7 | 0 / 7 / 0 / 0 | 0.215096 | 50652 | 0.011437571428571429 | 5820 |
