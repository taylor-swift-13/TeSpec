# array_load

| Strategy | Spatial SMT | Runs | Native | Final | Expected matches | Mean CLI s | Mean peak MiB |
|---|---|---:|---|---|---:|---:|---:|
| inline | off | 67 | {'PASS': 65, 'UNKNOWN': 2} | {'PASS': 67} | 67 | 0.171658 | 23.364 |
| inline | on | 67 | {'PASS': 67} | {'PASS': 67} | 67 | 0.177678 | 24.474 |
| modular | off | 67 | {'PASS': 65, 'UNKNOWN': 2} | {'PASS': 66, 'FAIL': 1} | 67 | 0.175440 | 23.381 |
| modular | on | 67 | {'PASS': 66, 'FAIL': 1} | {'PASS': 66, 'FAIL': 1} | 67 | 0.182156 | 24.499 |

CN/QCP/Fulminate and prior ITP costs: [historical four-tool table](../../../array_load/result-cost.md). Native substage metrics are retained in JSON and are nested, not additive.

translation12: inline expected PASS, modular expected FAIL (explicit user change). OFF uses a kernel-checked full-parent counterexample under a legal local environment, linked to the unchanged original definition. ON finds a finite spatial countermodel automatically. No claim of a bug in the actual read body.

New ITP: 2 model calls; 857838 tokens; 362.823473 seconds; 2101.969 MiB maximum process peak. All repairs/validation retries included, historical diagnostics linked separately.
