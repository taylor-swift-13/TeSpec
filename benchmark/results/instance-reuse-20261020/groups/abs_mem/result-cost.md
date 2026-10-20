# abs_mem — instance normalization regression

Native results; UNKNOWN is unresolved. Prior four-tool and ITP tables remain authoritative historical measurements.

| Strategy | Spatial SMT | Runs | Native | Final with certificates | CLI mean s | Mean per-run peak MiB |
|---|---|---:|---|---|---:|---:|
| inline | off | 7 | {'PASS': 7} | None | 0.165138 | 23.290 |
| inline | on | 7 | {'PASS': 7} | None | 0.165349 | 23.343 |
| modular-on | off | 7 | {'PASS': 7} | {'PASS': 7} | 0.164817 | 23.282 |
| modular-on | on | 7 | {'PASS': 7} | {'PASS': 7} | 0.172141 | 23.340 |
| modular-off | off | 7 | {'PASS': 7} | {'PASS': 7} | 0.165068 | 23.275 |
| modular-off | on | 7 | {'PASS': 7} | {'PASS': 7} | 0.164984 | 23.342 |
