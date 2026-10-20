# swap — instance normalization regression

Native results; UNKNOWN is unresolved. Prior four-tool and ITP tables remain authoritative historical measurements.

| Strategy | Spatial SMT | Runs | Native | Final with certificates | CLI mean s | Mean per-run peak MiB |
|---|---|---:|---|---|---:|---:|
| inline | off | 10 | {'PASS': 10} | None | 0.169921 | 23.310 |
| inline | on | 10 | {'PASS': 10} | None | 0.169880 | 23.335 |
| modular-on | off | 10 | {'PASS': 10} | {'PASS': 10} | 0.174911 | 23.306 |
| modular-on | on | 10 | {'PASS': 10} | {'PASS': 10} | 0.170029 | 23.345 |
| modular-off | off | 10 | {'PASS': 10} | {'PASS': 10} | 0.165128 | 23.306 |
| modular-off | on | 10 | {'PASS': 10} | {'PASS': 10} | 0.165191 | 23.293 |
