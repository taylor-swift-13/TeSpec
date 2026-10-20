# incr_first

Current CLI has no modular sampling switch. OFF/ON below refers only to spatial SMT.

| Strategy | Spatial SMT | Runs | Native | Final with exact certificates | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|
| modular | off | 16 | {'PASS': 16} | {'PASS': 16} | 0.164872 | 23.297 |
| modular | on | 16 | {'PASS': 16} | {'PASS': 16} | 0.174363 | 23.366 |
| inline | off | 16 | {'PASS': 16} | None | 0.171262 | 23.349 |
| inline | on | 16 | {'PASS': 16} | None | 0.168050 | 23.302 |

Historical CN/QCP/Fulminate costs: [original group table](../../../incr_first/result-cost.md). New native per-stage costs remain in this group's JSON; nested stages are not added together.
