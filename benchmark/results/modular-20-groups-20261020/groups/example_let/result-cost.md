# example_let

Current CLI has no modular sampling switch. OFF/ON below refers only to spatial SMT.

| Strategy | Spatial SMT | Runs | Native | Final with exact certificates | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|
| modular | off | 136 | {'PASS': 46, 'FAIL': 90} | {'PASS': 46, 'FAIL': 90} | 0.172396 | 23.285 |
| modular | on | 136 | {'PASS': 46, 'FAIL': 90} | {'PASS': 46, 'FAIL': 90} | 0.171628 | 23.312 |
| inline | off | 136 | {'PASS': 46, 'FAIL': 90} | None | 0.170121 | 23.297 |
| inline | on | 136 | {'PASS': 46, 'FAIL': 90} | None | 0.170860 | 23.319 |

Historical CN/QCP/Fulminate costs: [original group table](../../../example_let/result-cost.md). New native per-stage costs remain in this group's JSON; nested stages are not added together.
