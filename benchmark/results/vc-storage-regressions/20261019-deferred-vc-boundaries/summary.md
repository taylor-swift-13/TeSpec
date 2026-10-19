# Inline VC storage differential regression

Original Coq goal/auto/check bytes, raw native decisions, witness counts and enabled instance traces are compared.
Only generated output directory prefixes, explicitly named additive metrics, and validated branch query counters are normalized.
Runs execute serially. Times/RSS are observations; a single pair does not establish a general speedup.
No ITP or Coq certificate is inferred. Native model tokens: 0.

| Case | Exact gate | Old/new VC count | Old/new executor seconds | Old/new peak KiB |
| --- | --- | --- | --- | --- |
| zero-trip-entry-exit | PASS | 3 / 3 | 0.006001 / 0.006646 | 5084 / 5048 |
| zero-trip-all-boundaries | PASS | 3 / 3 | 0.005571 / 0.007708 | 4972 / 5072 |
| do-while-entry-exit | PASS | 8 / 8 | 0.008425 / 0.005903 | 5328 / 5452 |
| do-while-all-boundaries | PASS | 8 / 8 | 0.005436 / 0.005368 | 5376 / 5320 |
| for-continue-entry-exit | PASS | 20 / 20 | 0.012862 / 0.012902 | 6612 / 6732 |
| for-continue-all-boundaries | PASS | 20 / 20 | 0.011768 / 0.011033 | 6564 / 6592 |
| short-circuit-null-entry-exit | PASS | 4 / 4 | 0.005308 / 0.00536 | 5052 / 5084 |
| short-circuit-null-all-boundaries | PASS | 4 / 4 | 0.005791 / 0.00487 | 5208 / 5032 |
| short-circuit-effects-entry-exit | PASS | 16 / 16 | 0.009075 / 0.008629 | 6020 / 5828 |
| short-circuit-effects-all-boundaries | PASS | 22 / 22 | 0.012301 / 0.009475 | 6804 / 6616 |
| conditional-null-entry-exit | PASS | 4 / 4 | 0.004878 / 0.005104 | 5084 / 5052 |
| conditional-null-all-boundaries | PASS | 4 / 4 | 0.005141 / 0.005131 | 5024 / 5128 |
| switch-fixed-entry-exit | PASS | 3 / 3 | 0.004909 / 0.004856 | 5064 / 5120 |
| switch-fixed-all-boundaries | PASS | 3 / 3 | 0.005365 / 0.005245 | 5084 / 5200 |
| unsigned-wrap-entry-exit | PASS | 3 / 3 | 0.005754 / 0.005608 | 5100 / 5128 |
| unsigned-wrap-all-boundaries | PASS | 3 / 3 | 0.005696 / 0.005181 | 4992 / 4976 |
| negative-loop-entry-exit | PASS | 10 / 10 | 0.006837 / 0.00687 | 5312 / 5276 |
| negative-loop-all-boundaries | PASS | 10 / 10 | 0.00703 / 0.00681 | 5288 / 5228 |
| pointer-alias-entry-exit | PASS | 1 / 1 | 0.005067 / 0.00486 | 4808 / 4820 |
| pointer-alias-all-boundaries | PASS | 1 / 1 | 0.004895 / 0.004468 | 4716 / 4728 |
| bad-selected-branch-entry-exit | PASS | 3 / 3 | 0.005497 / 0.005222 | 5192 / 4776 |
| bad-selected-branch-all-boundaries | PASS | 3 / 3 | 0.005949 / 0.00513 | 5208 / 5088 |
| nonterminating-limit-entry-exit | PASS | 2 / 2 | 0.007356 / 0.007644 | 5536 / 5756 |
| nonterminating-limit-all-boundaries | PASS | 2 / 2 | 0.008147 / 0.007645 | 5540 / 5556 |
