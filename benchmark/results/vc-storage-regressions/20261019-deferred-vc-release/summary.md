# Inline VC storage differential regression

Original Coq goal/auto/check bytes, raw native decisions, witness counts and enabled instance traces are compared.
Only generated output directory prefixes, explicitly named additive metrics, and validated branch query counters are normalized.
Runs execute serially. Times/RSS are observations; a single pair does not establish a general speedup.
No ITP or Coq certificate is inferred. Native model tokens: 0.

| Case | Exact gate | Old/new VC count | Old/new executor seconds | Old/new peak KiB |
| --- | --- | --- | --- | --- |
| counter-16 | PASS | 36 / 36 | 0.024225 / 0.023037 | 8656 / 8652 |
| last-assertion-16 | PASS | 36 / 36 | 0.033274 / 0.029388 | 10436 / 10408 |
| break-continue-16 | PASS | 21 / 21 | 0.01124 / 0.010663 | 6568 / 6628 |
| counter-64 | PASS | 132 / 132 | 0.482747 / 0.490417 | 55476 / 55148 |
| last-assertion-64 | PASS | 132 / 132 | 1.0179 / 1.010722 | 117992 / 117656 |
| break-continue-64 | PASS | 21 / 21 | 0.011922 / 0.010656 | 6668 / 6556 |
| invariant-inline-entry-exit | PASS | 11 / 11 | 0.006989 / 0.00644 | 5752 / 5556 |
| invariant-inline-all-boundaries | PASS | 12 / 12 | 0.008105 / 0.007908 | 6096 / 6236 |
| invariant-modular-entry-exit | PASS | 3 / 3 | 0.008845 / 0.007432 | 5492 / 5364 |
| invariant-modular-all-boundaries | PASS | 5 / 5 | 0.009121 / 0.00789 | 5292 / 5516 |
| ignored-last-assertion | PASS | 11 / 11 | 0.008618 / 0.00789 | 5976 / 5788 |
| zero-trip-entry-exit | PASS | 3 / 3 | 0.005238 / 0.005538 | 5028 / 5076 |
| zero-trip-all-boundaries | PASS | 3 / 3 | 0.005355 / 0.004976 | 5284 / 5064 |
| do-while-entry-exit | PASS | 8 / 8 | 0.006405 / 0.005589 | 5280 / 5316 |
| do-while-all-boundaries | PASS | 8 / 8 | 0.005732 / 0.005491 | 5256 / 5268 |
| for-continue-entry-exit | PASS | 20 / 20 | 0.013079 / 0.012207 | 6816 / 6584 |
| for-continue-all-boundaries | PASS | 20 / 20 | 0.012617 / 0.0112 | 6600 / 6508 |
| short-circuit-null-entry-exit | PASS | 4 / 4 | 0.00525 / 0.005234 | 5104 / 5064 |
| short-circuit-null-all-boundaries | PASS | 4 / 4 | 0.005559 / 0.005049 | 5036 / 5000 |
| short-circuit-effects-entry-exit | PASS | 16 / 16 | 0.008778 / 0.007822 | 5800 / 5796 |
| short-circuit-effects-all-boundaries | PASS | 22 / 22 | 0.011438 / 0.009899 | 6560 / 6576 |
| conditional-null-entry-exit | PASS | 4 / 4 | 0.00498 / 0.004836 | 4980 / 5064 |
| conditional-null-all-boundaries | PASS | 4 / 4 | 0.004856 / 0.005179 | 5024 / 4972 |
| switch-fixed-entry-exit | PASS | 3 / 3 | 0.005438 / 0.005295 | 5040 / 5032 |
| switch-fixed-all-boundaries | PASS | 3 / 3 | 0.00512 / 0.00483 | 5124 / 5012 |
| unsigned-wrap-entry-exit | PASS | 3 / 3 | 0.00544 / 0.00524 | 5052 / 4972 |
| unsigned-wrap-all-boundaries | PASS | 3 / 3 | 0.005314 / 0.005182 | 5076 / 5060 |
| negative-loop-entry-exit | PASS | 10 / 10 | 0.006813 / 0.005916 | 5312 / 5320 |
| negative-loop-all-boundaries | PASS | 10 / 10 | 0.006343 / 0.005794 | 5380 / 5324 |
| pointer-alias-entry-exit | PASS | 1 / 1 | 0.005573 / 0.00491 | 4796 / 4700 |
| pointer-alias-all-boundaries | PASS | 1 / 1 | 0.005224 / 0.004663 | 4688 / 4808 |
| bad-selected-branch-entry-exit | PASS | 3 / 3 | 0.005274 / 0.004873 | 5100 / 5204 |
| bad-selected-branch-all-boundaries | PASS | 3 / 3 | 0.005182 / 0.005577 | 4972 / 4980 |
| nonterminating-limit-entry-exit | PASS | 2 / 2 | 0.007107 / 0.007156 | 5752 / 5568 |
| nonterminating-limit-all-boundaries | PASS | 2 / 2 | 0.00819 / 0.007387 | 5568 / 5560 |
| error-after-safety-entry-exit | PASS | 2 / 2 | 0.004867 / 0.005742 | 5308 / 5288 |
| error-after-safety-all-boundaries | PASS | 2 / 2 | 0.00479 / 0.00558 | 5208 / 5056 |
| error-after-invalid-assertion-entry-exit | PASS | 1 / 1 | 0.00489 / 0.004898 | 4772 / 4856 |
| error-after-invalid-assertion-all-boundaries | PASS | 2 / 2 | 0.004899 / 0.00563 | 5248 / 5032 |
