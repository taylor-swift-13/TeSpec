# Completed-group native regression

Full CLI executions in fresh output directories; formal benchmark evidence is read-only.
Existing ITP is a comparison oracle and is not reused as a new certificate.

- Complete suite selected: True
- Groups / input pairs / executed mode runs: 21 / 900 / 1800
- Run complete: True
- Regressions: 29
- Baseline and input hashes unchanged: True
- Regression gate passed: False

UNKNOWN_REMAINS is preserved incompleteness, never a successful check. Timeout/crash is a regression.
Times are nested: CLI total, executor resources and spatial stage must not be summed.
Spatial RSS is a 1 ms observed VmRSS peak; entry/exit process high water includes preceding phases.
tokens=0 describes this native run only; no model or ITP calls were made.

| Comparison | Executions |
| --- | ---: |
| DECISION_REGRESSION | 29 |
| EXPECTED_ERROR_PRESERVED | 46 |
| UNCHANGED_DECISION | 1692 |
| UNKNOWN_REMAINS | 33 |
