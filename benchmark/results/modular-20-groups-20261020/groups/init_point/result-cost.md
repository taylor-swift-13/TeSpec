# init_point

Current CLI has no modular sampling switch. OFF/ON below refers only to spatial SMT.

| Strategy | Spatial SMT | Runs | Native | Final with exact certificates | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|
| modular | off | 6 | {'PASS': 6} | {'PASS': 6} | 0.173350 | 23.330 |
| modular | on | 6 | {'PASS': 6} | {'PASS': 6} | 0.173382 | 23.247 |
| inline | off | 6 | {'PASS': 6} | None | 0.164927 | 23.214 |
| inline | on | 6 | {'PASS': 6} | None | 0.173280 | 23.369 |

Historical CN/QCP/Fulminate costs: [original group table](../../../init_point/result-cost.md). New native per-stage costs remain in this group's JSON; nested stages are not added together.
