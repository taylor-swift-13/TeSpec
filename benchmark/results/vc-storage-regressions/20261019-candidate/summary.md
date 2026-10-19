# Inline VC storage differential regression

Original Coq goal/auto/check bytes, raw native decisions, witness counts and enabled instance traces are compared.
Only generated output directory prefixes and explicitly named additive storage metrics are normalized.
Runs execute serially. Times/RSS are observations; a single pair does not establish a general speedup.
No ITP or Coq certificate is inferred. Native model tokens: 0.

| Case | Exact gate | Old/new VC count | Old/new executor seconds | Old/new peak KiB |
| --- | --- | --- | --- | --- |
| counter-16 | PASS | 36 / 36 | 0.023927 / 0.025873 | 9676 / 8852 |
| last-assertion-16 | PASS | 36 / 36 | 0.035808 / 0.033177 | 11984 / 10596 |
| break-continue-16 | PASS | 21 / 21 | 0.011583 / 0.011139 | 7164 / 6572 |
| counter-64 | PASS | 132 / 132 | 0.480611 / 0.475281 | 59620 / 55424 |
| last-assertion-64 | PASS | 132 / 132 | 1.031737 / 1.025966 | 124124 / 118060 |
| break-continue-64 | PASS | 21 / 21 | 0.011419 / 0.012646 | 7296 / 6700 |
| counter-256 | PASS | 516 / 516 | 8.110429 / 7.505389 | 1506488 / 1489116 |
| last-assertion-256 | PASS | 516 / 516 | 28.318485 / 27.372789 | 4363596 / 4338552 |
| break-continue-256 | PASS | 21 / 21 | 0.011494 / 0.010249 | 6816 / 6372 |
| invariant-inline-entry-exit | PASS | 11 / 11 | 0.008241 / 0.007638 | 5760 / 5700 |
| invariant-inline-all-boundaries | PASS | 12 / 12 | 0.009411 / 0.008271 | 6088 / 6224 |
| invariant-modular-entry-exit | PASS | 3 / 3 | 0.008266 / 0.008232 | 5536 / 5440 |
| invariant-modular-all-boundaries | PASS | 5 / 5 | 0.009714 / 0.009733 | 5280 / 5464 |
| ignored-last-assertion | PASS | 11 / 11 | 0.008943 / 0.008234 | 6100 / 5888 |
