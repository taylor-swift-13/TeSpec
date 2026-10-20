# zero

Current CLI has no modular sampling switch. OFF/ON below refers only to spatial SMT.

| Strategy | Spatial SMT | Runs | Native | Final with exact certificates | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|
| modular | off | 46 | {'PASS': 19, 'FAIL': 23, 'UNKNOWN': 2, 'ERROR': 2} | {'PASS': 19, 'FAIL': 25, 'ERROR': 2} | 0.168181 | 23.289 |
| modular | on | 46 | {'PASS': 19, 'FAIL': 23, 'UNKNOWN': 2, 'ERROR': 2} | {'PASS': 19, 'FAIL': 25, 'ERROR': 2} | 0.169282 | 23.312 |
| inline | off | 46 | {'PASS': 19, 'FAIL': 23, 'UNKNOWN': 2, 'ERROR': 2} | None | 0.167117 | 23.270 |
| inline | on | 46 | {'PASS': 19, 'FAIL': 25, 'ERROR': 2} | None | 0.170413 | 24.819 |

Historical CN/QCP/Fulminate costs: [original group table](../../../zero/result-cost.md). New native per-stage costs remain in this group's JSON; nested stages are not added together.
