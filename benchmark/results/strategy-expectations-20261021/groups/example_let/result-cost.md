# example_let

| Strategy | Spatial SMT | Runs | Native | Final | Expected matches | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|---:|
| inline | off | 136 | {'PASS': 46, 'FAIL': 90} | {'PASS': 46, 'FAIL': 90} | 136 | 0.171958 | 23.361 |
| inline | on | 136 | {'PASS': 46, 'FAIL': 90} | {'PASS': 46, 'FAIL': 90} | 136 | 0.172693 | 23.385 |
| modular | off | 136 | {'PASS': 46, 'FAIL': 90} | {'PASS': 46, 'FAIL': 90} | 136 | 0.169443 | 23.352 |
| modular | on | 136 | {'PASS': 46, 'FAIL': 90} | {'PASS': 46, 'FAIL': 90} | 136 | 0.171637 | 23.380 |

CN/QCP/Fulminate and prior ITP costs: [historical four-tool table](../../../example_let/result-cost.md). Native substage metrics are retained in JSON and are nested, not additive.
