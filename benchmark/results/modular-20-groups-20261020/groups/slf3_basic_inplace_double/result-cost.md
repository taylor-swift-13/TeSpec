# slf3_basic_inplace_double

Current CLI has no modular sampling switch. OFF/ON below refers only to spatial SMT.

| Strategy | Spatial SMT | Runs | Native | Final with exact certificates | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|
| modular | off | 52 | {'PASS': 20, 'FAIL': 28, 'UNKNOWN': 2, 'ERROR': 2} | {'PASS': 20, 'FAIL': 30, 'ERROR': 2} | 0.166870 | 23.313 |
| modular | on | 52 | {'PASS': 20, 'FAIL': 28, 'UNKNOWN': 2, 'ERROR': 2} | {'PASS': 20, 'FAIL': 30, 'ERROR': 2} | 0.164885 | 23.305 |
| inline | off | 52 | {'PASS': 20, 'FAIL': 28, 'UNKNOWN': 2, 'ERROR': 2} | None | 0.165830 | 23.282 |
| inline | on | 52 | {'PASS': 20, 'FAIL': 30, 'ERROR': 2} | None | 0.170702 | 24.660 |

Historical CN/QCP/Fulminate costs: [original group table](../../../slf3_basic_inplace_double/result-cost.md). New native per-stage costs remain in this group's JSON; nested stages are not added together.
