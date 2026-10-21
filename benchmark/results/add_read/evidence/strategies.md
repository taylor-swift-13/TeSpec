# add_read

| Strategy | Spatial SMT | Runs | Native | Final | Expected matches | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|---:|
| inline | off | 8 | {'PASS': 8} | {'PASS': 8} | 8 | 0.177546 | 23.381 |
| inline | on | 8 | {'PASS': 8} | {'PASS': 8} | 8 | 0.183694 | 23.388 |
| modular | off | 8 | {'PASS': 8} | {'PASS': 8} | 8 | 0.177536 | 23.383 |
| modular | on | 8 | {'PASS': 8} | {'PASS': 8} | 8 | 0.171170 | 23.460 |

CN/QCP/Fulminate and prior ITP costs: [historical four-tool table](../../../add_read/result-cost.md). Native substage metrics are retained in JSON and are nested, not additive.
