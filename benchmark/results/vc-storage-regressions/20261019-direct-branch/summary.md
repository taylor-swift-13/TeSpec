# Inline VC storage differential regression

Original Coq goal/auto/check bytes, raw native decisions, witness counts and enabled instance traces are compared.
Only generated output directory prefixes and explicitly named additive storage metrics are normalized.
Runs execute serially. Times/RSS are observations; a single pair does not establish a general speedup.
No ITP or Coq certificate is inferred. Native model tokens: 0.

| Case | Exact gate | Old/new VC count | Old/new executor seconds | Old/new peak KiB |
| --- | --- | --- | --- | --- |
| counter-16 | PASS | 36 / 36 | 0.023987 / 0.021482 | 8636 / 8564 |
| last-assertion-16 | PASS | 36 / 36 | 0.037844 / 0.036031 | 10420 / 10428 |
| break-continue-16 | PASS | 21 / 21 | 0.011282 / 0.011518 | 6516 / 6652 |
| counter-64 | PASS | 132 / 132 | 0.525959 / 0.512534 | 55640 / 55460 |
| last-assertion-64 | PASS | 132 / 132 | 1.073484 / 1.020518 | 117672 / 117672 |
| break-continue-64 | PASS | 21 / 21 | 0.015372 / 0.011595 | 6608 / 6592 |
| invariant-inline-entry-exit | PASS | 11 / 11 | 0.006736 / 0.00633 | 5572 / 5532 |
| invariant-inline-all-boundaries | PASS | 12 / 12 | 0.008234 / 0.009976 | 6064 / 6056 |
| invariant-modular-entry-exit | PASS | 3 / 3 | 0.008082 / 0.008423 | 5536 / 5548 |
| invariant-modular-all-boundaries | PASS | 5 / 5 | 0.010232 / 0.009522 | 5384 / 5324 |
| ignored-last-assertion | PASS | 11 / 11 | 0.008789 / 0.008249 | 5836 / 5800 |
