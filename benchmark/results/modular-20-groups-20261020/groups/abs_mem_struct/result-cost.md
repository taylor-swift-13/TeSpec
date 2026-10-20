# abs_mem_struct

Current CLI has no modular sampling switch. OFF/ON below refers only to spatial SMT.

| Strategy | Spatial SMT | Runs | Native | Final with exact certificates | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|
| modular | off | 7 | {'PASS': 7} | {'PASS': 7} | 0.171934 | 23.290 |
| modular | on | 7 | {'PASS': 7} | {'PASS': 7} | 0.164881 | 23.307 |
| inline | off | 7 | {'PASS': 7} | None | 0.164926 | 23.249 |
| inline | on | 7 | {'PASS': 7} | None | 0.164887 | 23.291 |

Historical CN/QCP/Fulminate costs: [original group table](../../../abs_mem_struct/result-cost.md). New native per-stage costs remain in this group's JSON; nested stages are not added together.
