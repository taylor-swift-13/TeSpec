# Inline VC storage differential regression

Original Coq goal/auto/check bytes, raw native decisions, witness counts and enabled instance traces are compared.
Only generated output directory prefixes and explicitly named additive storage metrics are normalized.
Runs execute serially. Times/RSS are observations; a single pair does not establish a general speedup.
No ITP or Coq certificate is inferred. Native model tokens: 0.

| Case | Exact gate | Old/new VC count | Old/new executor seconds | Old/new peak KiB |
| --- | --- | --- | --- | --- |
| zero-trip-entry-exit | PASS | 3 / 3 | 0.005487 / 0.004794 | 5076 / 5036 |
| zero-trip-all-boundaries | PASS | 3 / 3 | 0.005433 / 0.004732 | 5308 / 5192 |
| do-while-entry-exit | PASS | 8 / 8 | 0.005651 / 0.005588 | 5340 / 5448 |
| do-while-all-boundaries | PASS | 8 / 8 | 0.006083 / 0.005764 | 5236 / 5180 |
| for-continue-entry-exit | PASS | 20 / 20 | 0.013204 / 0.011942 | 6588 / 6720 |
| for-continue-all-boundaries | PASS | 20 / 20 | 0.013916 / 0.012019 | 6772 / 6512 |
| short-circuit-null-entry-exit | PASS | 4 / 4 | 0.005053 / 0.005567 | 5020 / 5236 |
| short-circuit-null-all-boundaries | PASS | 4 / 4 | 0.00541 / 0.005036 | 5068 / 5032 |
| short-circuit-effects-entry-exit | PASS | 16 / 16 | 0.009038 / 0.008474 | 6020 / 5804 |
| short-circuit-effects-all-boundaries | PASS | 22 / 22 | 0.011837 / 0.011723 | 6628 / 6580 |
| conditional-null-entry-exit | PASS | 4 / 4 | 0.005266 / 0.005057 | 5016 / 5260 |
| conditional-null-all-boundaries | PASS | 4 / 4 | 0.005355 / 0.005304 | 5060 / 5052 |
| switch-fixed-entry-exit | PASS | 3 / 3 | 0.005425 / 0.005265 | 5096 / 5236 |
| switch-fixed-all-boundaries | PASS | 3 / 3 | 0.005865 / 0.004966 | 5032 / 5260 |
| unsigned-wrap-entry-exit | PASS | 3 / 3 | 0.005692 / 0.004989 | 5060 / 5040 |
| unsigned-wrap-all-boundaries | PASS | 3 / 3 | 0.005622 / 0.005393 | 5136 / 5084 |
| negative-loop-entry-exit | PASS | 10 / 10 | 0.007282 / 0.006117 | 5300 / 5504 |
| negative-loop-all-boundaries | PASS | 10 / 10 | 0.006903 / 0.007239 | 5228 / 5400 |
| pointer-alias-entry-exit | PASS | 1 / 1 | 0.006125 / 0.004969 | 4740 / 4844 |
| pointer-alias-all-boundaries | PASS | 1 / 1 | 0.004964 / 0.004839 | 4816 / 5004 |
| bad-selected-branch-entry-exit | PASS | 3 / 3 | 0.004813 / 0.005698 | 5076 / 5048 |
| bad-selected-branch-all-boundaries | PASS | 3 / 3 | 0.004792 / 0.005374 | 5036 / 5172 |
| nonterminating-limit-entry-exit | PASS | 2 / 2 | 0.0078 / 0.007488 | 5752 / 5764 |
| nonterminating-limit-all-boundaries | PASS | 2 / 2 | 0.008584 / 0.007534 | 5528 / 5772 |
