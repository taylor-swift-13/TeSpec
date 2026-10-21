# swap

| Strategy | Spatial SMT | Runs | Native | Final | Expected matches | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|---:|
| inline | off | 10 | {'PASS': 10} | {'PASS': 10} | 10 | 0.164855 | 23.349 |
| inline | on | 10 | {'PASS': 10} | {'PASS': 10} | 10 | 0.164890 | 23.399 |
| modular | off | 10 | {'PASS': 10} | {'PASS': 10} | 10 | 0.164958 | 23.405 |
| modular | on | 10 | {'PASS': 10} | {'PASS': 10} | 10 | 0.164890 | 23.339 |

CN/QCP/Fulminate and prior ITP costs: [historical four-tool table](../../../swap/result-cost.md). Native substage metrics are retained in JSON and are nested, not additive.
