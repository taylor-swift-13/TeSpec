# slf_quadruple_mem

Current CLI has no modular sampling switch. OFF/ON below refers only to spatial SMT.

| Strategy | Spatial SMT | Runs | Native | Final with exact certificates | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|
| modular | off | 7 | {'PASS': 7} | {'PASS': 7} | 0.165309 | 23.238 |
| modular | on | 7 | {'PASS': 7} | {'PASS': 7} | 0.164797 | 23.296 |
| inline | off | 7 | {'PASS': 7} | None | 0.164740 | 23.224 |
| inline | on | 7 | {'PASS': 7} | None | 0.164950 | 23.332 |

Historical CN/QCP/Fulminate costs: [original group table](../../../slf_quadruple_mem/result-cost.md). New native per-stage costs remain in this group's JSON; nested stages are not added together.
