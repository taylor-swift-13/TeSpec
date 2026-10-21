# incr

| Strategy | Spatial SMT | Runs | Native | Final | Expected matches | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|---:|
| inline | off | 103 | {'PASS': 28, 'ERROR': 12, 'FAIL': 50, 'UNKNOWN': 13} | {'PASS': 28, 'ERROR': 12, 'FAIL': 63} | 103 | 0.166362 | 23.363 |
| inline | on | 103 | {'PASS': 28, 'ERROR': 12, 'FAIL': 63} | {'PASS': 28, 'ERROR': 12, 'FAIL': 63} | 103 | 0.173720 | 27.773 |
| modular | off | 103 | {'PASS': 28, 'ERROR': 12, 'FAIL': 50, 'UNKNOWN': 13} | {'PASS': 28, 'ERROR': 12, 'FAIL': 63} | 103 | 0.165442 | 23.353 |
| modular | on | 103 | {'PASS': 28, 'ERROR': 12, 'FAIL': 63} | {'PASS': 28, 'ERROR': 12, 'FAIL': 63} | 103 | 0.172275 | 27.769 |

CN/QCP/Fulminate and prior ITP costs: [historical four-tool table](../../../incr/result-cost.md). Native substage metrics are retained in JSON and are nested, not additive.
