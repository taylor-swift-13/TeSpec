# array_load — instance normalization regression

Native results; UNKNOWN is unresolved. Prior four-tool and ITP tables remain authoritative historical measurements.

| Strategy | Spatial SMT | Runs | Native | Final with certificates | CLI mean s | Mean per-run peak MiB |
|---|---|---:|---|---|---:|---:|
| inline | off | 67 | {'PASS': 65, 'UNKNOWN': 2} | None | 0.169407 | 23.302 |
| inline | on | 67 | {'PASS': 67} | None | 0.173176 | 24.415 |
| modular-on | off | 67 | {'PASS': 65, 'UNKNOWN': 2} | {'PASS': 66, 'UNKNOWN': 1} | 0.170916 | 23.328 |
| modular-on | on | 67 | {'PASS': 65, 'UNKNOWN': 2} | {'PASS': 66, 'UNKNOWN': 1} | 0.173162 | 23.360 |
| modular-off | off | 67 | {'PASS': 65, 'UNKNOWN': 2} | {'PASS': 66, 'UNKNOWN': 1} | 0.170137 | 23.319 |
| modular-off | on | 67 | {'PASS': 65, 'UNKNOWN': 2} | {'PASS': 66, 'UNKNOWN': 1} | 0.169348 | 23.335 |
