# quadruple — instance normalization regression

Native results; UNKNOWN is unresolved. Prior four-tool and ITP tables remain authoritative historical measurements.

| Strategy | Spatial SMT | Runs | Native | Final with certificates | CLI mean s | Mean per-run peak MiB |
|---|---|---:|---|---|---:|---:|
| inline | off | 120 | {'PASS': 46, 'FAIL': 74} | None | 0.166161 | 23.298 |
| inline | on | 120 | {'PASS': 46, 'FAIL': 74} | None | 0.167031 | 23.296 |
| modular-on | off | 120 | {'PASS': 46, 'FAIL': 74} | {'PASS': 46, 'FAIL': 74} | 0.166570 | 23.269 |
| modular-on | on | 120 | {'PASS': 46, 'FAIL': 74} | {'PASS': 46, 'FAIL': 74} | 0.165748 | 23.308 |
| modular-off | off | 120 | {'PASS': 46, 'FAIL': 74} | {'PASS': 46, 'FAIL': 74} | 0.165792 | 23.293 |
| modular-off | on | 120 | {'PASS': 46, 'FAIL': 74} | {'PASS': 46, 'FAIL': 74} | 0.165398 | 23.323 |
