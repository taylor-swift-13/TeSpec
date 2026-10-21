# transfer

| Strategy | Spatial SMT | Runs | Native | Final | Expected matches | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|---:|
| inline | off | 16 | {'PASS': 16} | {'PASS': 16} | 16 | 0.164877 | 23.384 |
| inline | on | 16 | {'PASS': 16} | {'PASS': 16} | 16 | 0.164919 | 23.365 |
| modular | off | 16 | {'PASS': 16} | {'PASS': 16} | 16 | 0.165070 | 23.398 |
| modular | on | 16 | {'PASS': 16} | {'PASS': 16} | 16 | 0.164848 | 23.381 |

CN/QCP/Fulminate and prior ITP costs: [historical four-tool table](../../../transfer/result-cost.md). Native substage metrics are retained in JSON and are nested, not additive.
