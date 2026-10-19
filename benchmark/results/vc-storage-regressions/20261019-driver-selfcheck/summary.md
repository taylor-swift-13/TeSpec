# Inline VC storage differential regression

Original Coq goal/auto/check bytes, raw native decisions, witness counts and enabled instance traces are compared.
Only generated output directory prefixes and explicitly named additive storage metrics are normalized.
Runs execute serially. Times/RSS are observations; a single pair does not establish a general speedup.
No ITP or Coq certificate is inferred. Native model tokens: 0.

| Case | Exact gate | Old/new VC count | Old/new executor seconds | Old/new peak KiB |
| --- | --- | --- | --- | --- |
| counter-5 | PASS | 14 / 14 | 0.010323 / 0.009231 | 6128 / 6072 |
| last-assertion-5 | PASS | 14 / 14 | 0.011251 / 0.010087 | 6660 / 6752 |
| break-continue-5 | PASS | 21 / 21 | 0.010997 / 0.011924 | 7180 / 7116 |
| invariant-inline-entry-exit | PASS | 11 / 11 | 0.006537 / 0.007292 | 5648 / 5656 |
| invariant-inline-all-boundaries | PASS | 12 / 12 | 0.00867 / 0.008317 | 5996 / 6284 |
| invariant-modular-entry-exit | PASS | 3 / 3 | 0.009672 / 0.007924 | 5368 / 5516 |
| invariant-modular-all-boundaries | PASS | 5 / 5 | 0.008778 / 0.009797 | 5376 / 5496 |
| ignored-last-assertion | PASS | 11 / 11 | 0.008187 / 0.008077 | 6272 / 6028 |
