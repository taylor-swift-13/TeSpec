# add

Current CLI has no modular sampling switch. OFF/ON below refers only to spatial SMT.

| Strategy | Spatial SMT | Runs | Native | Final with exact certificates | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|
| modular | off | 122 | {'PASS': 76, 'FAIL': 46} | {'PASS': 76, 'FAIL': 46} | 0.168293 | 23.284 |
| modular | on | 122 | {'PASS': 76, 'FAIL': 46} | {'PASS': 76, 'FAIL': 46} | 0.169103 | 23.315 |
| inline | off | 122 | {'PASS': 76, 'FAIL': 46} | None | 0.169138 | 23.259 |
| inline | on | 122 | {'PASS': 76, 'FAIL': 46} | None | 0.166635 | 23.304 |

Historical CN/QCP/Fulminate costs: [original group table](../../../add/result-cost.md). New native per-stage costs remain in this group's JSON; nested stages are not added together.
