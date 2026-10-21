# zero

| Strategy | Spatial SMT | Runs | Native | Final | Expected matches | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|---:|
| inline | off | 46 | {'PASS': 19, 'FAIL': 23, 'UNKNOWN': 2, 'ERROR': 2} | {'PASS': 19, 'FAIL': 25, 'ERROR': 2} | 46 | 0.164886 | 23.364 |
| inline | on | 46 | {'PASS': 19, 'FAIL': 25, 'ERROR': 2} | {'PASS': 19, 'FAIL': 25, 'ERROR': 2} | 46 | 0.167052 | 24.869 |
| modular | off | 46 | {'PASS': 19, 'FAIL': 23, 'UNKNOWN': 2, 'ERROR': 2} | {'PASS': 19, 'FAIL': 25, 'ERROR': 2} | 46 | 0.164914 | 23.366 |
| modular | on | 46 | {'PASS': 19, 'FAIL': 25, 'ERROR': 2} | {'PASS': 19, 'FAIL': 25, 'ERROR': 2} | 46 | 0.167148 | 24.897 |

CN/QCP/Fulminate and prior ITP costs: [historical four-tool table](../../../zero/result-cost.md). Native substage metrics are retained in JSON and are nested, not additive.
