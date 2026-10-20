# read

Current CLI has no modular sampling switch. OFF/ON below refers only to spatial SMT.

| Strategy | Spatial SMT | Runs | Native | Final with exact certificates | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|
| modular | off | 61 | {'PASS': 22, 'UNKNOWN': 12, 'FAIL': 20, 'ERROR': 7} | {'PASS': 22, 'FAIL': 32, 'ERROR': 7} | 0.171562 | 23.275 |
| modular | on | 61 | {'PASS': 22, 'UNKNOWN': 12, 'FAIL': 20, 'ERROR': 7} | {'PASS': 22, 'FAIL': 32, 'ERROR': 7} | 0.173997 | 23.319 |
| inline | off | 61 | {'PASS': 22, 'UNKNOWN': 12, 'FAIL': 20, 'ERROR': 7} | None | 0.171518 | 23.255 |
| inline | on | 61 | {'PASS': 22, 'FAIL': 32, 'ERROR': 7} | None | 0.184704 | 30.115 |

Historical CN/QCP/Fulminate costs: [original group table](../../../read/result-cost.md). New native per-stage costs remain in this group's JSON; nested stages are not added together.
