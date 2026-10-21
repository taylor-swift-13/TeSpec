# read

| Strategy | Spatial SMT | Runs | Native | Final | Expected matches | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|---:|
| inline | off | 61 | {'PASS': 22, 'UNKNOWN': 12, 'FAIL': 20, 'ERROR': 7} | {'PASS': 22, 'FAIL': 32, 'ERROR': 7} | 61 | 0.164938 | 23.361 |
| inline | on | 61 | {'PASS': 22, 'FAIL': 32, 'ERROR': 7} | {'PASS': 22, 'FAIL': 32, 'ERROR': 7} | 61 | 0.176453 | 30.199 |
| modular | off | 61 | {'PASS': 22, 'UNKNOWN': 12, 'FAIL': 20, 'ERROR': 7} | {'PASS': 22, 'FAIL': 32, 'ERROR': 7} | 61 | 0.166590 | 23.358 |
| modular | on | 61 | {'PASS': 22, 'FAIL': 32, 'ERROR': 7} | {'PASS': 22, 'FAIL': 32, 'ERROR': 7} | 61 | 0.180657 | 30.207 |

CN/QCP/Fulminate and prior ITP costs: [historical four-tool table](../../../read/result-cost.md). Native substage metrics are retained in JSON and are nested, not additive.
