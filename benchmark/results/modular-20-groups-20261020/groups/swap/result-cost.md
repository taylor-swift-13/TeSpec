# swap

Current CLI has no modular sampling switch. OFF/ON below refers only to spatial SMT.

| Strategy | Spatial SMT | Runs | Native | Final with exact certificates | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|
| modular | off | 10 | {'PASS': 10} | {'PASS': 10} | 0.165104 | 23.296 |
| modular | on | 10 | {'PASS': 10} | {'PASS': 10} | 0.165319 | 23.241 |
| inline | off | 10 | {'PASS': 10} | None | 0.164804 | 23.337 |
| inline | on | 10 | {'PASS': 10} | None | 0.164881 | 23.282 |

Historical CN/QCP/Fulminate costs: [original group table](../../../swap/result-cost.md). New native per-stage costs remain in this group's JSON; nested stages are not added together.
