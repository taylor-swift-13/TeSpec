# abs_mem_struct

| Strategy | Spatial SMT | Runs | Native | Final | Expected matches | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|---:|
| inline | off | 7 | {'PASS': 7} | {'PASS': 7} | 7 | 0.186421 | 23.371 |
| inline | on | 7 | {'PASS': 7} | {'PASS': 7} | 7 | 0.193735 | 23.401 |
| modular | off | 7 | {'PASS': 7} | {'PASS': 7} | 7 | 0.186432 | 23.353 |
| modular | on | 7 | {'PASS': 7} | {'PASS': 7} | 7 | 0.186412 | 23.417 |

CN/QCP/Fulminate and prior ITP costs: [historical four-tool table](../../../abs_mem_struct/result-cost.md). Native substage metrics are retained in JSON and are nested, not additive.
