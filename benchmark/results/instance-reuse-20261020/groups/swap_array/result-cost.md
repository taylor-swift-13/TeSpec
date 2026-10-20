# swap_array — instance normalization regression

Native results; UNKNOWN is unresolved. Prior four-tool and ITP tables remain authoritative historical measurements.

| Strategy | Spatial SMT | Runs | Native | Final with certificates | CLI mean s | Mean per-run peak MiB |
|---|---|---:|---|---|---:|---:|
| inline | off | 20 | {'PASS': 20} | None | 0.177521 | 23.339 |
| inline | on | 20 | {'PASS': 20} | None | 0.177431 | 23.346 |
| modular-on | off | 20 | {'PASS': 20} | {'PASS': 20} | 0.169918 | 23.346 |
| modular-on | on | 20 | {'PASS': 20} | {'PASS': 20} | 0.170028 | 23.353 |
| modular-off | off | 20 | {'PASS': 20} | {'PASS': 20} | 0.167603 | 23.309 |
| modular-off | on | 20 | {'PASS': 20} | {'PASS': 20} | 0.167422 | 23.312 |
