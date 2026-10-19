# Inline VC storage differential regression

Original Coq goal/auto/check bytes, raw native decisions, witness counts and enabled instance traces are compared.
Only generated output directory prefixes and explicitly named additive storage metrics are normalized.
Runs execute serially. Times/RSS are observations; a single pair does not establish a general speedup.
No ITP or Coq certificate is inferred. Native model tokens: 0.

| Case | Exact gate | Old/new VC count | Old/new executor seconds | Old/new peak KiB |
| --- | --- | --- | --- | --- |
| counter-16 | FAIL | 36 / 36 | 0.023977 / 0.0241 | 8656 / 8672 |
| last-assertion-16 | FAIL | 36 / 36 | 0.032547 / 0.035102 | 10408 / 10432 |
| break-continue-16 | FAIL | 21 / 21 | 0.012939 / 0.011353 | 6620 / 6648 |
| invariant-inline-entry-exit | FAIL | 11 / 11 | 0.007299 / 0.00734 | 5632 / 5532 |
| invariant-inline-all-boundaries | FAIL | 12 / 12 | 0.008628 / 0.007333 | 6092 / 6116 |
| invariant-modular-entry-exit | FAIL | 3 / 5 | 0.007982 / 0.007688 | 5308 / 5356 |
| invariant-modular-all-boundaries | FAIL | 5 / 5 | 0.009135 / 0.008425 | 5304 / 5296 |
| ignored-last-assertion | FAIL | 11 / 11 | 0.008654 / 0.007422 | 5844 / 5852 |
