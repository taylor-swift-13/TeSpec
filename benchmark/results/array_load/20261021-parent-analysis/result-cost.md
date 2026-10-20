# array_load — 2026-10-21

67 input pairs, 268 fresh native runs. Expectations unchanged. Modular remains incomplete.

| Strategy | Spatial SMT | Raw | Final with exact certificates | Match | Mean CLI s | Mean peak MiB |
|---|---|---|---|---:|---:|---:|
| inline | off | {'PASS': 65, 'UNKNOWN': 2} | {'PASS': 67} | 67/67 | 0.165703 | 23.306 |
| inline | on | {'PASS': 67} | {'PASS': 67} | 67/67 | 0.170178 | 24.408 |
| modular | off | {'PASS': 65, 'UNKNOWN': 2} | {'PASS': 66, 'UNKNOWN': 1} | 66/67 | 0.170996 | 23.300 |
| modular | on | {'PASS': 65, 'UNKNOWN': 2} | {'PASS': 66, 'UNKNOWN': 1} | 66/67 | 0.171694 | 23.338 |

One whole-execution ITP diagnostic task, all repairs included:

| Stage | Seconds | Peak process MiB | Tokens |
|---|---:|---:|---:|
| agent_proof_and_repairs | 208.766000 | 519.930 | 972766 |
| coq_compile_and_assumption_audit | 13.738443 | 573.945 | 0 |
| independent_kernel_check | 117.787117 | 1752.824 | 0 |

ITP total 340.291560s; peak 1752.824 MiB; 972766 tokens, 5 actual gpt-6.1-sol calls. Diagnostic proofs are kernel checked; no unconditional original parent proof/refutation exists in this result.

CN, QCP, Fulminate and earlier ITP costs: [historical four-tool table](../result-cost.md). Native substage costs and exact source/input/VC/certificate identities remain in JSON. No repeated model cost is attributed to certificate reuse.
