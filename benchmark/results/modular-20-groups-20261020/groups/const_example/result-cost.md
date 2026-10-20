# const_example

Current CLI has no modular sampling switch. OFF/ON below refers only to spatial SMT.

| Strategy | Spatial SMT | Runs | Native | Final with exact certificates | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|
| modular | off | 7 | {'PASS': 7} | {'PASS': 7} | 0.164913 | 23.315 |
| modular | on | 7 | {'PASS': 7} | {'PASS': 7} | 0.164936 | 23.302 |
| inline | off | 7 | {'PASS': 7} | None | 0.165086 | 23.270 |
| inline | on | 7 | {'PASS': 7} | None | 0.172422 | 23.292 |

Historical CN/QCP/Fulminate costs: [original group table](../../../const_example/result-cost.md). New native per-stage costs remain in this group's JSON; nested stages are not added together.
