# abs_mem_struct — instance normalization regression

Native results; UNKNOWN is unresolved. Prior four-tool and ITP tables remain authoritative historical measurements.

| Strategy | Spatial SMT | Runs | Native | Final with certificates | CLI mean s | Mean per-run peak MiB |
|---|---|---:|---|---|---:|---:|
| inline | off | 7 | {'PASS': 7} | None | 0.172384 | 23.285 |
| inline | on | 7 | {'PASS': 7} | None | 0.165173 | 23.250 |
| modular-on | off | 7 | {'PASS': 7} | {'PASS': 7} | 0.172192 | 23.367 |
| modular-on | on | 7 | {'PASS': 7} | {'PASS': 7} | 0.165118 | 23.331 |
| modular-off | off | 7 | {'PASS': 7} | {'PASS': 7} | 0.165199 | 23.312 |
| modular-off | on | 7 | {'PASS': 7} | {'PASS': 7} | 0.165151 | 23.235 |
