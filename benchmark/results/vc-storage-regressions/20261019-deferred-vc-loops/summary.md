# Inline VC storage differential regression

Original Coq goal/auto/check bytes, raw native decisions, witness counts and enabled instance traces are compared.
Only generated output directory prefixes, explicitly named additive metrics, and validated branch query counters are normalized.
Runs execute serially. Times/RSS are observations; a single pair does not establish a general speedup.
No ITP or Coq certificate is inferred. Native model tokens: 0.

| Case | Exact gate | Old/new VC count | Old/new executor seconds | Old/new peak KiB |
| --- | --- | --- | --- | --- |
| counter-16 | PASS | 36 / 36 | 0.02408 / 0.023084 | 8644 / 8840 |
| last-assertion-16 | PASS | 36 / 36 | 0.03268 / 0.036869 | 10452 / 10556 |
| break-continue-16 | PASS | 21 / 21 | 0.011236 / 0.010401 | 6616 / 6788 |
| counter-64 | PASS | 132 / 132 | 0.484713 / 0.478451 | 55524 / 55620 |
| last-assertion-64 | PASS | 132 / 132 | 0.998348 / 1.007681 | 117676 / 117804 |
| break-continue-64 | PASS | 21 / 21 | 0.011668 / 0.010459 | 6832 / 6676 |
| invariant-inline-entry-exit | PASS | 11 / 11 | 0.007266 / 0.006851 | 5604 / 5588 |
| invariant-inline-all-boundaries | PASS | 12 / 12 | 0.007693 / 0.007381 | 6096 / 6156 |
| invariant-modular-entry-exit | PASS | 3 / 3 | 0.008412 / 0.00877 | 5516 / 5420 |
| invariant-modular-all-boundaries | PASS | 5 / 5 | 0.009307 / 0.007346 | 5320 / 5448 |
| ignored-last-assertion | PASS | 11 / 11 | 0.008218 / 0.007246 | 5840 / 5964 |
