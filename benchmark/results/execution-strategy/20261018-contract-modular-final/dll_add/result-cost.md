# dll_add — execution strategy costs

Supplemental native tests; no new universal or ITP certificate.
Time is per-execution mean. RSS is largest process peak. CLI/executor times are nested. Tokens=0 for this native run.

| Strategy | VC mode | SMT | Runs | PASS / UNKNOWN / FAIL / ERROR | CLI mean s | CLI peak KiB | Executor mean s | Executor peak KiB |
| --- | --- | --- | ---: | --- | ---: | ---: | ---: | ---: |
| inline | entry-exit | off | 14 | 0 / 14 / 0 / 0 | 0.172122 | 23564 | 0.018591285714285713 | 6324 |
| inline | entry-exit | on | 14 | 0 / 14 / 0 / 0 | 0.218707 | 50768 | 0.018137928571428572 | 6332 |
| inline | all-boundaries | off | 14 | 0 / 14 / 0 / 0 | 0.179305 | 23572 | 0.018242928571428573 | 6588 |
| inline | all-boundaries | on | 14 | 0 / 14 / 0 / 0 | 0.225838 | 50784 | 0.018668785714285714 | 6588 |
| modular | entry-exit | off | 14 | 0 / 14 / 0 / 0 | 0.182837 | 23568 | 0.018542714285714287 | 6332 |
| modular | entry-exit | on | 14 | 0 / 14 / 0 / 0 | 0.218746 | 50696 | 0.018197357142857144 | 6284 |
| modular | all-boundaries | off | 14 | 0 / 14 / 0 / 0 | 0.179363 | 23612 | 0.018446857142857143 | 6588 |
| modular | all-boundaries | on | 14 | 0 / 14 / 0 / 0 | 0.215139 | 50788 | 0.01837842857142857 | 6588 |
