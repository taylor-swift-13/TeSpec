# add_read

Current CLI has no modular sampling switch. OFF/ON below refers only to spatial SMT.

| Strategy | Spatial SMT | Runs | Native | Final with exact certificates | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|
| modular | off | 8 | {'PASS': 8} | {'PASS': 8} | 0.164975 | 23.270 |
| modular | on | 8 | {'PASS': 8} | {'PASS': 8} | 0.165059 | 23.322 |
| inline | off | 8 | {'PASS': 8} | None | 0.165161 | 23.335 |
| inline | on | 8 | {'PASS': 8} | None | 0.164971 | 23.327 |

Historical CN/QCP/Fulminate costs: [original group table](../../../add_read/result-cost.md). New native per-stage costs remain in this group's JSON; nested stages are not added together.
