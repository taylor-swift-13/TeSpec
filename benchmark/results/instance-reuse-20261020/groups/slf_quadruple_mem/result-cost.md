# slf_quadruple_mem — instance normalization regression

Native results; UNKNOWN is unresolved. Prior four-tool and ITP tables remain authoritative historical measurements.

| Strategy | Spatial SMT | Runs | Native | Final with certificates | CLI mean s | Mean per-run peak MiB |
|---|---|---:|---|---|---:|---:|
| inline | off | 7 | {'PASS': 7} | None | 0.164871 | 23.330 |
| inline | on | 7 | {'PASS': 7} | None | 0.164968 | 23.332 |
| modular-on | off | 7 | {'PASS': 7} | {'PASS': 7} | 0.164786 | 23.289 |
| modular-on | on | 7 | {'PASS': 7} | {'PASS': 7} | 0.172057 | 23.267 |
| modular-off | off | 7 | {'PASS': 7} | {'PASS': 7} | 0.165025 | 23.283 |
| modular-off | on | 7 | {'PASS': 7} | {'PASS': 7} | 0.165136 | 23.358 |
