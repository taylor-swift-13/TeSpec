# slf3_basic_inplace_double

| Strategy | Spatial SMT | Runs | Native | Final | Expected matches | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|---:|
| inline | off | 52 | {'PASS': 20, 'FAIL': 28, 'UNKNOWN': 2, 'ERROR': 2} | {'PASS': 20, 'FAIL': 30, 'ERROR': 2} | 52 | 0.167824 | 23.346 |
| inline | on | 52 | {'PASS': 20, 'FAIL': 30, 'ERROR': 2} | {'PASS': 20, 'FAIL': 30, 'ERROR': 2} | 52 | 0.167813 | 24.707 |
| modular | off | 52 | {'PASS': 20, 'FAIL': 28, 'UNKNOWN': 2, 'ERROR': 2} | {'PASS': 20, 'FAIL': 30, 'ERROR': 2} | 52 | 0.164885 | 23.364 |
| modular | on | 52 | {'PASS': 20, 'FAIL': 30, 'ERROR': 2} | {'PASS': 20, 'FAIL': 30, 'ERROR': 2} | 52 | 0.166821 | 24.734 |

CN/QCP/Fulminate and prior ITP costs: [historical four-tool table](../../../slf3_basic_inplace_double/result-cost.md). Native substage metrics are retained in JSON and are nested, not additive.
