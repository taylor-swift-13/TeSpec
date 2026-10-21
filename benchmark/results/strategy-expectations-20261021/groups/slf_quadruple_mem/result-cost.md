# slf_quadruple_mem

| Strategy | Spatial SMT | Runs | Native | Final | Expected matches | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|---:|
| inline | off | 7 | {'PASS': 7} | {'PASS': 7} | 7 | 0.164983 | 23.366 |
| inline | on | 7 | {'PASS': 7} | {'PASS': 7} | 7 | 0.165076 | 23.372 |
| modular | off | 7 | {'PASS': 7} | {'PASS': 7} | 7 | 0.164928 | 23.345 |
| modular | on | 7 | {'PASS': 7} | {'PASS': 7} | 7 | 0.164905 | 23.408 |

CN/QCP/Fulminate and prior ITP costs: [historical four-tool table](../../../slf_quadruple_mem/result-cost.md). Native substage metrics are retained in JSON and are nested, not additive.
