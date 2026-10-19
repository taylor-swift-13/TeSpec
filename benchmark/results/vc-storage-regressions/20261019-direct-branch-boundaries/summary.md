# Inline VC storage differential regression

Original Coq goal/auto/check bytes, raw native decisions, witness counts and enabled instance traces are compared.
Only generated output directory prefixes and explicitly named additive storage metrics are normalized.
Runs execute serially. Times/RSS are observations; a single pair does not establish a general speedup.
No ITP or Coq certificate is inferred. Native model tokens: 0.

| Case | Exact gate | Old/new VC count | Old/new executor seconds | Old/new peak KiB |
| --- | --- | --- | --- | --- |
| zero-trip-entry-exit | PASS | 3 / 3 | 0.005616 / 0.006179 | 5088 / 5260 |
| zero-trip-all-boundaries | PASS | 3 / 3 | 0.005018 / 0.005111 | 4980 / 5236 |
| do-while-entry-exit | PASS | 8 / 8 | 0.006797 / 0.005681 | 5360 / 5464 |
| do-while-all-boundaries | PASS | 8 / 8 | 0.005838 / 0.005513 | 5312 / 5336 |
| for-continue-entry-exit | PASS | 20 / 20 | 0.012801 / 0.011908 | 6604 / 6656 |
| for-continue-all-boundaries | PASS | 20 / 20 | 0.013699 / 0.013364 | 6592 / 6560 |
| short-circuit-null-entry-exit | PASS | 4 / 4 | 0.005363 / 0.005608 | 5020 / 5068 |
| short-circuit-null-all-boundaries | PASS | 4 / 4 | 0.004711 / 0.005965 | 5032 / 5024 |
| short-circuit-effects-entry-exit | FAIL | 0 / 0 | 0.004477 / 0.004127 | 4260 / 4460 |
| short-circuit-effects-all-boundaries | FAIL | 0 / 0 | 0.004806 / 0.004153 | 4260 / 4528 |
| conditional-null-entry-exit | PASS | 4 / 4 | 0.005474 / 0.005725 | 5076 / 5048 |
| conditional-null-all-boundaries | PASS | 4 / 4 | 0.005221 / 0.005189 | 5028 / 5236 |
| switch-fixed-entry-exit | PASS | 3 / 3 | 0.005686 / 0.005679 | 4976 / 5120 |
| switch-fixed-all-boundaries | PASS | 3 / 3 | 0.005495 / 0.005124 | 5120 / 5068 |
| unsigned-wrap-entry-exit | PASS | 3 / 3 | 0.005328 / 0.005343 | 5108 / 5156 |
| unsigned-wrap-all-boundaries | PASS | 3 / 3 | 0.005215 / 0.005226 | 5056 / 5048 |
| negative-loop-entry-exit | PASS | 10 / 10 | 0.009033 / 0.006651 | 5464 / 5516 |
| negative-loop-all-boundaries | PASS | 10 / 10 | 0.006346 / 0.006876 | 5324 / 5512 |
| pointer-alias-entry-exit | PASS | 1 / 1 | 0.005082 / 0.004699 | 4848 / 4812 |
| pointer-alias-all-boundaries | PASS | 1 / 1 | 0.005817 / 0.004876 | 4732 / 4928 |
| bad-selected-branch-entry-exit | PASS | 3 / 3 | 0.0052 / 0.005896 | 5252 / 5260 |
| bad-selected-branch-all-boundaries | PASS | 3 / 3 | 0.005162 / 0.005191 | 5044 / 5248 |
| nonterminating-limit-entry-exit | PASS | 2 / 2 | 0.008778 / 0.007566 | 5752 / 5752 |
| nonterminating-limit-all-boundaries | PASS | 2 / 2 | 0.007866 / 0.007152 | 5552 / 5580 |
