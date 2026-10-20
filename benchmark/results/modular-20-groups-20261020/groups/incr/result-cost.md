# incr

Current CLI has no modular sampling switch. OFF/ON below refers only to spatial SMT.

| Strategy | Spatial SMT | Runs | Native | Final with exact certificates | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|
| modular | off | 103 | {'PASS': 28, 'ERROR': 12, 'FAIL': 50, 'UNKNOWN': 13} | {'PASS': 28, 'ERROR': 12, 'FAIL': 63} | 0.167863 | 23.287 |
| modular | on | 103 | {'PASS': 28, 'ERROR': 12, 'FAIL': 50, 'UNKNOWN': 13} | {'PASS': 28, 'ERROR': 12, 'FAIL': 63} | 0.168403 | 23.305 |
| inline | off | 103 | {'PASS': 28, 'ERROR': 12, 'FAIL': 50, 'UNKNOWN': 13} | None | 0.168374 | 23.300 |
| inline | on | 103 | {'PASS': 28, 'ERROR': 12, 'FAIL': 63} | None | 0.173223 | 27.678 |

Historical CN/QCP/Fulminate costs: [original group table](../../../incr/result-cost.md). New native per-stage costs remain in this group's JSON; nested stages are not added together.
