# abs_mem

| Strategy | Spatial SMT | Runs | Native | Final | Expected matches | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|---:|
| inline | off | 7 | {'PASS': 7} | {'PASS': 7} | 7 | 0.172462 | 23.368 |
| inline | on | 7 | {'PASS': 7} | {'PASS': 7} | 7 | 0.172596 | 23.326 |
| modular | off | 7 | {'PASS': 7} | {'PASS': 7} | 7 | 0.172077 | 23.367 |
| modular | on | 7 | {'PASS': 7} | {'PASS': 7} | 7 | 0.179155 | 23.354 |

CN/QCP/Fulminate and prior ITP costs: [historical four-tool table](../../../abs_mem/result-cost.md). Native substage metrics are retained in JSON and are nested, not additive.
