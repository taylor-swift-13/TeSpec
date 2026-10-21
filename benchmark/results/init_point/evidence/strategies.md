# init_point

| Strategy | Spatial SMT | Runs | Native | Final | Expected matches | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|---:|
| inline | off | 6 | {'PASS': 6} | {'PASS': 6} | 6 | 0.164982 | 23.389 |
| inline | on | 6 | {'PASS': 6} | {'PASS': 6} | 6 | 0.164973 | 23.389 |
| modular | off | 6 | {'PASS': 6} | {'PASS': 6} | 6 | 0.164829 | 23.419 |
| modular | on | 6 | {'PASS': 6} | {'PASS': 6} | 6 | 0.165030 | 23.399 |

CN/QCP/Fulminate and prior ITP costs: [historical four-tool table](../../../init_point/result-cost.md). Native substage metrics are retained in JSON and are nested, not additive.
