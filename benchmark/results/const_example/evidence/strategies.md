# const_example

| Strategy | Spatial SMT | Runs | Native | Final | Expected matches | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|---:|
| inline | off | 7 | {'PASS': 7} | {'PASS': 7} | 7 | 0.164832 | 23.321 |
| inline | on | 7 | {'PASS': 7} | {'PASS': 7} | 7 | 0.164921 | 23.415 |
| modular | off | 7 | {'PASS': 7} | {'PASS': 7} | 7 | 0.164866 | 23.388 |
| modular | on | 7 | {'PASS': 7} | {'PASS': 7} | 7 | 0.164829 | 23.444 |

CN/QCP/Fulminate and prior ITP costs: [historical four-tool table](../../../const_example/result-cost.md). Native substage metrics are retained in JSON and are nested, not additive.
