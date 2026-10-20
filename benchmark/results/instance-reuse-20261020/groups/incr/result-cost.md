# incr — instance normalization regression

Native results; UNKNOWN is unresolved. Prior four-tool and ITP tables remain authoritative historical measurements.

| Strategy | Spatial SMT | Runs | Native | Final with certificates | CLI mean s | Mean per-run peak MiB |
|---|---|---:|---|---|---:|---:|
| inline | off | 103 | {'PASS': 28, 'ERROR': 12, 'FAIL': 50, 'UNKNOWN': 13} | None | 0.167342 | 23.310 |
| inline | on | 103 | {'PASS': 28, 'ERROR': 12, 'FAIL': 63} | None | 0.173185 | 27.689 |
| modular-on | off | 103 | {'PASS': 28, 'ERROR': 12, 'FAIL': 50, 'UNKNOWN': 13} | {'PASS': 28, 'ERROR': 12, 'FAIL': 63} | 0.166368 | 23.289 |
| modular-on | on | 103 | {'PASS': 28, 'ERROR': 12, 'FAIL': 50, 'UNKNOWN': 13} | {'PASS': 28, 'ERROR': 12, 'FAIL': 63} | 0.168848 | 23.330 |
| modular-off | off | 103 | {'PASS': 28, 'ERROR': 12, 'FAIL': 50, 'UNKNOWN': 13} | {'PASS': 28, 'ERROR': 12, 'FAIL': 63} | 0.167451 | 23.314 |
| modular-off | on | 103 | {'PASS': 28, 'ERROR': 12, 'FAIL': 50, 'UNKNOWN': 13} | {'PASS': 28, 'ERROR': 12, 'FAIL': 63} | 0.169360 | 23.326 |
