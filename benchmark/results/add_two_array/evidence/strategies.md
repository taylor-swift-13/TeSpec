# add_two_array

| Strategy | Spatial SMT | Runs | Native | Final | Expected matches | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|---:|
| inline | off | 8 | {'PASS': 8} | {'PASS': 8} | 8 | 0.164874 | 23.349 |
| inline | on | 8 | {'PASS': 8} | {'PASS': 8} | 8 | 0.164934 | 23.396 |
| modular | off | 8 | {'PASS': 8} | {'PASS': 8} | 8 | 0.165050 | 23.361 |
| modular | on | 8 | {'PASS': 8} | {'PASS': 8} | 8 | 0.164939 | 23.374 |

CN/QCP/Fulminate and prior ITP costs: [historical four-tool table](../../../add_two_array/result-cost.md). Native substage metrics are retained in JSON and are nested, not additive.
