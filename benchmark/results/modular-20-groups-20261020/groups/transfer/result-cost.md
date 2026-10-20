# transfer

Current CLI has no modular sampling switch. OFF/ON below refers only to spatial SMT.

| Strategy | Spatial SMT | Runs | Native | Final with exact certificates | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|
| modular | off | 16 | {'PASS': 16} | {'PASS': 16} | 0.164986 | 23.291 |
| modular | on | 16 | {'PASS': 16} | {'PASS': 16} | 0.167941 | 23.348 |
| inline | off | 16 | {'PASS': 16} | None | 0.164833 | 23.315 |
| inline | on | 16 | {'PASS': 16} | None | 0.164931 | 23.281 |

Historical CN/QCP/Fulminate costs: [original group table](../../../transfer/result-cost.md). New native per-stage costs remain in this group's JSON; nested stages are not added together.
