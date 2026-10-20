# abs

Current CLI has no modular sampling switch. OFF/ON below refers only to spatial SMT.

| Strategy | Spatial SMT | Runs | Native | Final with exact certificates | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|
| modular | off | 57 | {'PASS': 38, 'FAIL': 19} | {'PASS': 38, 'FAIL': 19} | 0.166669 | 23.265 |
| modular | on | 57 | {'PASS': 38, 'FAIL': 19} | {'PASS': 38, 'FAIL': 19} | 0.166572 | 23.286 |
| inline | off | 57 | {'PASS': 38, 'FAIL': 19} | None | 0.165733 | 23.240 |
| inline | on | 57 | {'PASS': 38, 'FAIL': 19} | None | 0.167484 | 23.289 |

Historical CN/QCP/Fulminate costs: [original group table](../../../abs/result-cost.md). New native per-stage costs remain in this group's JSON; nested stages are not added together.
