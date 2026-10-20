# example_let — instance normalization regression

Native results; UNKNOWN is unresolved. Prior four-tool and ITP tables remain authoritative historical measurements.

| Strategy | Spatial SMT | Runs | Native | Final with certificates | CLI mean s | Mean per-run peak MiB |
|---|---|---:|---|---|---:|---:|
| inline | off | 136 | {'PASS': 46, 'FAIL': 90} | None | 0.168244 | 23.290 |
| inline | on | 136 | {'PASS': 46, 'FAIL': 90} | None | 0.168959 | 23.311 |
| modular-on | off | 136 | {'PASS': 46, 'FAIL': 90} | {'PASS': 46, 'FAIL': 90} | 0.166755 | 23.302 |
| modular-on | on | 136 | {'PASS': 46, 'FAIL': 90} | {'PASS': 46, 'FAIL': 90} | 0.169337 | 23.304 |
| modular-off | off | 136 | {'PASS': 46, 'FAIL': 90} | {'PASS': 46, 'FAIL': 90} | 0.167549 | 23.297 |
| modular-off | on | 136 | {'PASS': 46, 'FAIL': 90} | {'PASS': 46, 'FAIL': 90} | 0.167215 | 23.313 |
