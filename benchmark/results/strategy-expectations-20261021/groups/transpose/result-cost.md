# transpose

| Strategy | Spatial SMT | Runs | Native | Final | Expected matches | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|---:|
| inline | off | 24 | {'PASS': 24} | {'PASS': 24} | 24 | 0.171200 | 23.379 |
| inline | on | 24 | {'PASS': 24} | {'PASS': 24} | 24 | 0.177536 | 23.434 |
| modular | off | 24 | {'PASS': 24} | {'PASS': 24} | 24 | 0.173406 | 23.391 |
| modular | on | 24 | {'PASS': 24} | {'PASS': 24} | 24 | 0.173355 | 23.396 |

CN/QCP/Fulminate and prior ITP costs: [historical four-tool table](../../../transpose/result-cost.md). Native substage metrics are retained in JSON and are nested, not additive.
