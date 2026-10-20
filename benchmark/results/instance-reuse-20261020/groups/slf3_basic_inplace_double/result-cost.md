# slf3_basic_inplace_double — instance normalization regression

Native results; UNKNOWN is unresolved. Prior four-tool and ITP tables remain authoritative historical measurements.

| Strategy | Spatial SMT | Runs | Native | Final with certificates | CLI mean s | Mean per-run peak MiB |
|---|---|---:|---|---|---:|---:|
| inline | off | 52 | {'PASS': 20, 'FAIL': 28, 'UNKNOWN': 2, 'ERROR': 2} | None | 0.167872 | 23.287 |
| inline | on | 52 | {'PASS': 20, 'FAIL': 30, 'ERROR': 2} | None | 0.172691 | 24.662 |
| modular-on | off | 52 | {'PASS': 20, 'FAIL': 28, 'UNKNOWN': 2, 'ERROR': 2} | {'PASS': 20, 'FAIL': 30, 'ERROR': 2} | 0.168745 | 23.305 |
| modular-on | on | 52 | {'PASS': 20, 'FAIL': 28, 'UNKNOWN': 2, 'ERROR': 2} | {'PASS': 20, 'FAIL': 30, 'ERROR': 2} | 0.171659 | 23.303 |
| modular-off | off | 52 | {'PASS': 20, 'FAIL': 28, 'UNKNOWN': 2, 'ERROR': 2} | {'PASS': 20, 'FAIL': 30, 'ERROR': 2} | 0.164996 | 23.310 |
| modular-off | on | 52 | {'PASS': 20, 'FAIL': 28, 'UNKNOWN': 2, 'ERROR': 2} | {'PASS': 20, 'FAIL': 30, 'ERROR': 2} | 0.164836 | 23.323 |
