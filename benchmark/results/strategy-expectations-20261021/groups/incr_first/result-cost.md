# incr_first

| Strategy | Spatial SMT | Runs | Native | Final | Expected matches | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|---:|
| inline | off | 16 | {'PASS': 16} | {'PASS': 16} | 16 | 0.168009 | 23.368 |
| inline | on | 16 | {'PASS': 16} | {'PASS': 16} | 16 | 0.177477 | 23.420 |
| modular | off | 16 | {'PASS': 16} | {'PASS': 16} | 16 | 0.168069 | 23.365 |
| modular | on | 16 | {'PASS': 16} | {'PASS': 16} | 16 | 0.177537 | 23.431 |

CN/QCP/Fulminate and prior ITP costs: [historical four-tool table](../../../incr_first/result-cost.md). Native substage metrics are retained in JSON and are nested, not additive.
