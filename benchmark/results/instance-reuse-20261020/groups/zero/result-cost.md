# zero — instance normalization regression

Native results; UNKNOWN is unresolved. Prior four-tool and ITP tables remain authoritative historical measurements.

| Strategy | Spatial SMT | Runs | Native | Final with certificates | CLI mean s | Mean per-run peak MiB |
|---|---|---:|---|---|---:|---:|
| inline | off | 46 | {'PASS': 19, 'FAIL': 23, 'UNKNOWN': 2, 'ERROR': 2} | None | 0.171711 | 23.283 |
| inline | on | 46 | {'PASS': 19, 'FAIL': 25, 'ERROR': 2} | None | 0.170624 | 24.797 |
| modular-on | off | 46 | {'PASS': 19, 'FAIL': 23, 'UNKNOWN': 2, 'ERROR': 2} | {'PASS': 19, 'FAIL': 25, 'ERROR': 2} | 0.173814 | 23.271 |
| modular-on | on | 46 | {'PASS': 19, 'FAIL': 23, 'UNKNOWN': 2, 'ERROR': 2} | {'PASS': 19, 'FAIL': 25, 'ERROR': 2} | 0.172641 | 23.280 |
| modular-off | off | 46 | {'PASS': 19, 'FAIL': 23, 'UNKNOWN': 2, 'ERROR': 2} | {'PASS': 19, 'FAIL': 25, 'ERROR': 2} | 0.164948 | 23.289 |
| modular-off | on | 46 | {'PASS': 19, 'FAIL': 23, 'UNKNOWN': 2, 'ERROR': 2} | {'PASS': 19, 'FAIL': 25, 'ERROR': 2} | 0.166149 | 23.296 |
