# quadruple

| Strategy | Spatial SMT | Runs | Native | Final | Expected matches | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|---:|
| inline | off | 120 | {'PASS': 46, 'FAIL': 74} | {'PASS': 46, 'FAIL': 74} | 120 | 0.166571 | 23.345 |
| inline | on | 120 | {'PASS': 46, 'FAIL': 74} | {'PASS': 46, 'FAIL': 74} | 120 | 0.169120 | 23.385 |
| modular | off | 120 | {'PASS': 46, 'FAIL': 74} | {'PASS': 46, 'FAIL': 74} | 120 | 0.167029 | 23.360 |
| modular | on | 120 | {'PASS': 46, 'FAIL': 74} | {'PASS': 46, 'FAIL': 74} | 120 | 0.168320 | 23.387 |

CN/QCP/Fulminate and prior ITP costs: [historical four-tool table](../../../quadruple/result-cost.md). Native substage metrics are retained in JSON and are nested, not additive.
