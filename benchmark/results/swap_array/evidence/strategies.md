# swap_array

| Strategy | Spatial SMT | Runs | Native | Final | Expected matches | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|---:|
| inline | off | 20 | {'PASS': 20} | {'PASS': 20} | 20 | 0.164824 | 23.397 |
| inline | on | 20 | {'PASS': 20} | {'PASS': 20} | 20 | 0.164881 | 23.387 |
| modular | off | 20 | {'PASS': 20} | {'PASS': 20} | 20 | 0.164937 | 23.394 |
| modular | on | 20 | {'PASS': 20} | {'PASS': 20} | 20 | 0.164882 | 23.417 |

CN/QCP/Fulminate and prior ITP costs: [historical four-tool table](../../../swap_array/result-cost.md). Native substage metrics are retained in JSON and are nested, not additive.
