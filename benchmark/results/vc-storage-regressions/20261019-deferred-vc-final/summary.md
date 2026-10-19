# Inline VC storage differential regression

Original Coq goal/auto/check bytes, raw native decisions, witness counts and enabled instance traces are compared.
Only generated output directory prefixes, explicitly named additive metrics, and validated branch query counters are normalized.
Runs execute serially. Times/RSS are observations; a single pair does not establish a general speedup.
No ITP or Coq certificate is inferred. Native model tokens: 0.

| Case | Exact gate | Old/new VC count | Old/new executor seconds | Old/new peak KiB |
| --- | --- | --- | --- | --- |
| counter-16 | PASS | 36 / 36 | 0.024975 / 0.021332 | 8640 / 8828 |
| last-assertion-16 | PASS | 36 / 36 | 0.032705 / 0.030526 | 10616 / 10636 |
| break-continue-16 | PASS | 21 / 21 | 0.011254 / 0.010388 | 6620 / 6724 |
| counter-64 | PASS | 132 / 132 | 0.482782 / 0.508508 | 55672 / 55620 |
| last-assertion-64 | PASS | 132 / 132 | 1.018775 / 0.99597 | 117696 / 117644 |
| break-continue-64 | PASS | 21 / 21 | 0.011694 / 0.011213 | 6668 / 6800 |
| invariant-inline-entry-exit | PASS | 11 / 11 | 0.007875 / 0.006057 | 5564 / 5564 |
| invariant-inline-all-boundaries | PASS | 12 / 12 | 0.009711 / 0.007774 | 6136 / 6136 |
| invariant-modular-entry-exit | PASS | 3 / 3 | 0.008195 / 0.008953 | 5304 / 5436 |
| invariant-modular-all-boundaries | PASS | 5 / 5 | 0.009364 / 0.007571 | 5320 / 5404 |
| ignored-last-assertion | PASS | 11 / 11 | 0.008704 / 0.00788 | 5832 / 5920 |
| zero-trip-entry-exit | PASS | 3 / 3 | 0.004916 / 0.004825 | 5036 / 5280 |
| zero-trip-all-boundaries | PASS | 3 / 3 | 0.004854 / 0.005227 | 5028 / 5068 |
| do-while-entry-exit | PASS | 8 / 8 | 0.005591 / 0.005563 | 5332 / 5516 |
| do-while-all-boundaries | PASS | 8 / 8 | 0.005703 / 0.005682 | 5320 / 5360 |
| for-continue-entry-exit | PASS | 20 / 20 | 0.012446 / 0.011741 | 6592 / 6580 |
| for-continue-all-boundaries | PASS | 20 / 20 | 0.012085 / 0.011709 | 6648 / 6572 |
| short-circuit-null-entry-exit | PASS | 4 / 4 | 0.005023 / 0.004581 | 5240 / 5240 |
| short-circuit-null-all-boundaries | PASS | 4 / 4 | 0.005041 / 0.004677 | 4980 / 5260 |
| short-circuit-effects-entry-exit | PASS | 16 / 16 | 0.009307 / 0.008225 | 5748 / 6028 |
| short-circuit-effects-all-boundaries | PASS | 22 / 22 | 0.011478 / 0.01026 | 6508 / 6536 |
| conditional-null-entry-exit | PASS | 4 / 4 | 0.006674 / 0.005063 | 5116 / 5104 |
| conditional-null-all-boundaries | PASS | 4 / 4 | 0.005336 / 0.004866 | 5076 / 5032 |
| switch-fixed-entry-exit | PASS | 3 / 3 | 0.005536 / 0.005415 | 5036 / 5196 |
| switch-fixed-all-boundaries | PASS | 3 / 3 | 0.006009 / 0.004942 | 5064 / 5244 |
| unsigned-wrap-entry-exit | PASS | 3 / 3 | 0.005244 / 0.005263 | 5024 / 5068 |
| unsigned-wrap-all-boundaries | PASS | 3 / 3 | 0.005355 / 0.005939 | 5128 / 5132 |
| negative-loop-entry-exit | PASS | 10 / 10 | 0.007382 / 0.006817 | 5328 / 5444 |
| negative-loop-all-boundaries | PASS | 10 / 10 | 0.007024 / 0.005879 | 5296 / 5420 |
| pointer-alias-entry-exit | PASS | 1 / 1 | 0.004854 / 0.005652 | 4808 / 4756 |
| pointer-alias-all-boundaries | PASS | 1 / 1 | 0.005079 / 0.005005 | 4776 / 4740 |
| bad-selected-branch-entry-exit | PASS | 3 / 3 | 0.005932 / 0.004884 | 5240 / 5068 |
| bad-selected-branch-all-boundaries | PASS | 3 / 3 | 0.005243 / 0.005296 | 5016 / 5144 |
| nonterminating-limit-entry-exit | PASS | 2 / 2 | 0.00919 / 0.007587 | 5560 / 5524 |
| nonterminating-limit-all-boundaries | PASS | 2 / 2 | 0.008017 / 0.007477 | 5596 / 5560 |
| error-after-safety-entry-exit | PASS | 2 / 2 | 0.005308 / 0.005157 | 5280 / 5224 |
| error-after-safety-all-boundaries | PASS | 2 / 2 | 0.005281 / 0.004649 | 5232 / 5188 |
| error-after-invalid-assertion-entry-exit | PASS | 1 / 1 | 0.004987 / 0.005445 | 4804 / 4784 |
| error-after-invalid-assertion-all-boundaries | FAIL | 2 / 2 | 0.005715 / 0.005633 | 5288 / 5288 |
