# transpose

Current CLI has no modular sampling switch. OFF/ON below refers only to spatial SMT.

| Strategy | Spatial SMT | Runs | Native | Final with exact certificates | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|
| modular | off | 24 | {'PASS': 24} | {'PASS': 24} | 0.179601 | 23.296 |
| modular | on | 24 | {'PASS': 24} | {'PASS': 24} | 0.179591 | 23.337 |
| inline | off | 24 | {'PASS': 24} | None | 0.179731 | 23.302 |
| inline | on | 24 | {'PASS': 24} | None | 0.175459 | 23.303 |

Historical CN/QCP/Fulminate costs: [original group table](../../../transpose/result-cost.md). New native per-stage costs remain in this group's JSON; nested stages are not added together.
