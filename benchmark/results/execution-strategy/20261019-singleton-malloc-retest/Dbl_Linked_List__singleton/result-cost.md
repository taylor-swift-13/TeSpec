# Dbl_Linked_List__singleton — execution strategy costs

Supplemental native tests; no new universal or ITP certificate.
Time is per-execution mean. RSS is largest process peak. CLI/executor times are nested. Tokens=0 for this native run.

| Strategy | VC mode | SMT | Runs | PASS / UNKNOWN / FAIL / ERROR | CLI mean s | CLI peak KiB | Executor mean s | Executor peak KiB |
| --- | --- | --- | ---: | --- | ---: | ---: | ---: | ---: |
| inline | entry-exit | off | 7 | 0 / 7 / 0 / 0 | 0.222110 | 23484 | 0.01098442857142857 | 5792 |
| inline | entry-exit | on | 7 | 0 / 7 / 0 / 0 | 0.221992 | 50764 | 0.01121042857142857 | 5768 |
| inline | all-boundaries | off | 7 | 0 / 7 / 0 / 0 | 0.164703 | 23536 | 0.011131142857142857 | 5820 |
| inline | all-boundaries | on | 7 | 0 / 7 / 0 / 0 | 0.222066 | 50840 | 0.011244857142857143 | 5740 |
| modular | entry-exit | off | 7 | 0 / 7 / 0 / 0 | 0.164747 | 23508 | 0.011032142857142857 | 5824 |
| modular | entry-exit | on | 7 | 0 / 7 / 0 / 0 | 0.214927 | 50688 | 0.011240571428571428 | 5836 |
| modular | all-boundaries | off | 7 | 0 / 7 / 0 / 0 | 0.164842 | 23512 | 0.01071457142857143 | 5760 |
| modular | all-boundaries | on | 7 | 0 / 7 / 0 / 0 | 0.214916 | 50736 | 0.011013571428571428 | 5832 |
