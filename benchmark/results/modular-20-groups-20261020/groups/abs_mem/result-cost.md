# abs_mem

Current CLI has no modular sampling switch. OFF/ON below refers only to spatial SMT.

| Strategy | Spatial SMT | Runs | Native | Final with exact certificates | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|
| modular | off | 7 | {'PASS': 7} | {'PASS': 7} | 0.164802 | 23.232 |
| modular | on | 7 | {'PASS': 7} | {'PASS': 7} | 0.164853 | 23.326 |
| inline | off | 7 | {'PASS': 7} | None | 0.164754 | 23.311 |
| inline | on | 7 | {'PASS': 7} | None | 0.164904 | 23.319 |

Historical CN/QCP/Fulminate costs: [original group table](../../../abs_mem/result-cost.md). New native per-stage costs remain in this group's JSON; nested stages are not added together.
