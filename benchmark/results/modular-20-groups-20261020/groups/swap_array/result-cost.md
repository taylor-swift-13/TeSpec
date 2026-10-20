# swap_array

Current CLI has no modular sampling switch. OFF/ON below refers only to spatial SMT.

| Strategy | Spatial SMT | Runs | Native | Final with exact certificates | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|
| modular | off | 20 | {'PASS': 20} | {'PASS': 20} | 0.187496 | 23.298 |
| modular | on | 20 | {'PASS': 20} | {'PASS': 20} | 0.187514 | 23.351 |
| inline | off | 20 | {'PASS': 20} | None | 0.184960 | 23.332 |
| inline | on | 20 | {'PASS': 20} | None | 0.184997 | 23.358 |

Historical CN/QCP/Fulminate costs: [original group table](../../../swap_array/result-cost.md). New native per-stage costs remain in this group's JSON; nested stages are not added together.
