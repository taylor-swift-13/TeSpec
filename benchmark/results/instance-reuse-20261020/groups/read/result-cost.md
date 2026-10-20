# read — instance normalization regression

Native results; UNKNOWN is unresolved. Prior four-tool and ITP tables remain authoritative historical measurements.

| Strategy | Spatial SMT | Runs | Native | Final with certificates | CLI mean s | Mean per-run peak MiB |
|---|---|---:|---|---|---:|---:|
| inline | off | 61 | {'PASS': 22, 'UNKNOWN': 12, 'FAIL': 20, 'ERROR': 7} | None | 0.167362 | 23.284 |
| inline | on | 61 | {'PASS': 22, 'FAIL': 32, 'ERROR': 7} | None | 0.176423 | 30.145 |
| modular-on | off | 61 | {'PASS': 22, 'UNKNOWN': 12, 'FAIL': 20, 'ERROR': 7} | {'PASS': 22, 'FAIL': 32, 'ERROR': 7} | 0.168214 | 23.276 |
| modular-on | on | 61 | {'PASS': 22, 'UNKNOWN': 12, 'FAIL': 20, 'ERROR': 7} | {'PASS': 22, 'FAIL': 32, 'ERROR': 7} | 0.169064 | 23.310 |
| modular-off | off | 61 | {'PASS': 22, 'UNKNOWN': 12, 'FAIL': 20, 'ERROR': 7} | {'PASS': 22, 'FAIL': 32, 'ERROR': 7} | 0.164792 | 23.288 |
| modular-off | on | 61 | {'PASS': 22, 'UNKNOWN': 12, 'FAIL': 20, 'ERROR': 7} | {'PASS': 22, 'FAIL': 32, 'ERROR': 7} | 0.164858 | 23.310 |
