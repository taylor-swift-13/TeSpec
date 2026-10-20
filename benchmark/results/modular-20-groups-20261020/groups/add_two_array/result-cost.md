# add_two_array

Current CLI has no modular sampling switch. OFF/ON below refers only to spatial SMT.

| Strategy | Spatial SMT | Runs | Native | Final with exact certificates | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|
| modular | off | 8 | {'PASS': 8} | {'PASS': 8} | 0.165048 | 23.298 |
| modular | on | 8 | {'PASS': 8} | {'PASS': 8} | 0.165015 | 23.319 |
| inline | off | 8 | {'PASS': 8} | None | 0.165352 | 23.233 |
| inline | on | 8 | {'PASS': 8} | None | 0.165346 | 23.283 |

Historical CN/QCP/Fulminate costs: [original group table](../../../add_two_array/result-cost.md). New native per-stage costs remain in this group's JSON; nested stages are not added together.
