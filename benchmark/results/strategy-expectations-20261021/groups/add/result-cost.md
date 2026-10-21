# add

| Strategy | Spatial SMT | Runs | Native | Final | Expected matches | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|---:|
| inline | off | 122 | {'PASS': 76, 'FAIL': 46} | {'PASS': 76, 'FAIL': 46} | 122 | 0.166991 | 23.346 |
| inline | on | 122 | {'PASS': 76, 'FAIL': 46} | {'PASS': 76, 'FAIL': 46} | 122 | 0.169447 | 23.371 |
| modular | off | 122 | {'PASS': 76, 'FAIL': 46} | {'PASS': 76, 'FAIL': 46} | 122 | 0.168625 | 23.346 |
| modular | on | 122 | {'PASS': 76, 'FAIL': 46} | {'PASS': 76, 'FAIL': 46} | 122 | 0.169913 | 23.365 |

CN/QCP/Fulminate and prior ITP costs: [historical four-tool table](../../../add/result-cost.md). Native substage metrics are retained in JSON and are nested, not additive.
