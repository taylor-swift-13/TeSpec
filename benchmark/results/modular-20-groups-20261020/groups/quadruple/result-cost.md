# quadruple

Current CLI has no modular sampling switch. OFF/ON below refers only to spatial SMT.

| Strategy | Spatial SMT | Runs | Native | Final with exact certificates | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|
| modular | off | 120 | {'PASS': 46, 'FAIL': 74} | {'PASS': 46, 'FAIL': 74} | 0.167004 | 23.280 |
| modular | on | 120 | {'PASS': 46, 'FAIL': 74} | {'PASS': 46, 'FAIL': 74} | 0.169983 | 23.297 |
| inline | off | 120 | {'PASS': 46, 'FAIL': 74} | None | 0.168220 | 23.285 |
| inline | on | 120 | {'PASS': 46, 'FAIL': 74} | None | 0.170411 | 23.306 |

Historical CN/QCP/Fulminate costs: [original group table](../../../quadruple/result-cost.md). New native per-stage costs remain in this group's JSON; nested stages are not added together.
