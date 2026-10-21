# abs

| Strategy | Spatial SMT | Runs | Native | Final | Expected matches | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|---:|
| inline | off | 57 | {'PASS': 38, 'FAIL': 19} | {'PASS': 38, 'FAIL': 19} | 57 | 0.166873 | 23.358 |
| inline | on | 57 | {'PASS': 38, 'FAIL': 19} | {'PASS': 38, 'FAIL': 19} | 57 | 0.166783 | 23.360 |
| modular | off | 57 | {'PASS': 38, 'FAIL': 19} | {'PASS': 38, 'FAIL': 19} | 57 | 0.165978 | 23.341 |
| modular | on | 57 | {'PASS': 38, 'FAIL': 19} | {'PASS': 38, 'FAIL': 19} | 57 | 0.167030 | 23.372 |

CN/QCP/Fulminate and prior ITP costs: [historical four-tool table](../../../abs/result-cost.md). Native substage metrics are retained in JSON and are nested, not additive.
