# CN compatibility diagnostic costs

Only actual measurements retained in this compatibility directory. Existing 20261018-cn-primary-recheck receipt is external and excluded from these totals. Orchestration/source-authoring model costs are not represented by native stage token=0.

All 18 executed measurements are listed. The successful attempt04 CN verify is reused as the formal primary verification: allocate it once to formal_primary_cn_reuse and exclude it from additional diagnostics. Other 17 actual measurements remain diagnostic cost. instrument --run includes instrumentation/build and its initial execution; separate executable invocations are additional real measured executions.

GNU time %M: largest process RSS per measurement, not process-tree aggregate. Totals use maximum of peaks, never sum RSS.

| Measurement | Stage | Exit | Wall seconds | Max process RSS KiB | Allocation |
|---|---|---:|---:|---:|---|
| attempt-01-array-load2-math-integers--verify | cn_verify | 1 | 0.215423096 | 48604 | additional_compatibility_diagnostic |
| attempt-02-array-load2-instantiate--verify | cn_verify | 124 | 0.032731308 | 42900 | additional_compatibility_diagnostic |
| attempt-02-array-load2-instantiate--verify-retry-01 | cn_verify | 1 | 0.164604009 | 44816 | additional_compatibility_diagnostic |
| attempt-02-array-load2-instantiate--verify-read-only | cn_verify | 0 | 0.165211315 | 45048 | additional_compatibility_diagnostic |
| attempt-02-array-load2-instantiate--instrument-build-initial-run | fulminate_instrument_build_initial_run | 0 | 0.265195091 | 44928 | additional_compatibility_diagnostic |
| attempt-02-array-load2-instantiate--fulminate-test | fulminate_independent_execution | 0 | 0.003809280 | 1136 | additional_compatibility_diagnostic |
| attempt-03-array-load2-no-system-read-collision--verify | cn_verify | 1 | 0.315881270 | 52076 | additional_compatibility_diagnostic |
| attempt-03-array-load2-no-system-read-collision--instrument-build-initial-run | fulminate_instrument_build_initial_run | 0 | 0.265021070 | 45996 | additional_compatibility_diagnostic |
| attempt-03-array-load2-no-system-read-collision--fulminate-test | fulminate_independent_execution | 0 | 0.003750119 | 1200 | additional_compatibility_diagnostic |
| attempt-04-array-load2-client-focus--verify | cn_verify | 0 | 0.265422169 | 46704 | formal_primary_cn_reuse |
| attempt-04-array-load2-client-focus--instrument-build-initial-run | fulminate_instrument_build_initial_run | 0 | 0.265132059 | 46988 | additional_compatibility_diagnostic |
| attempt-04-array-load2-client-focus--fulminate-test | fulminate_independent_execution | 0 | 0.003986055 | 1136 | additional_compatibility_diagnostic |
| compat-cn_original_array_load--verify-read-only | cn_verify | 0 | 0.114623150 | 45008 | additional_compatibility_diagnostic |
| compat-cn_original_array_load--instrument-build-initial-run | fulminate_instrument_build_initial_run | 0 | 0.265098899 | 45148 | additional_compatibility_diagnostic |
| compat-cn_original_array_load--fulminate-test | fulminate_independent_execution | 0 | 0.003789204 | 1136 | additional_compatibility_diagnostic |
| compat-cn_original_array_load.broken--verify-read-only | cn_verify | 1 | 0.165005333 | 47580 | additional_compatibility_diagnostic |
| compat-cn_original_array_load.broken--instrument-build-initial-run | fulminate_instrument_build_initial_run | 0 | 0.264867661 | 44980 | additional_compatibility_diagnostic |
| compat-cn_original_array_load.broken--fulminate-test | fulminate_independent_execution | 0 | 0.003909750 | 1136 | additional_compatibility_diagnostic |

| Cost set | Measurements | Wall seconds | Peak RSS KiB |
|---|---:|---:|---:|
| all_executed_measurements | 18 | 2.783460838 | 52076 |
| additional_diagnostics_only | 17 | 2.518038669 | 52076 |
| formal_primary_cn_reuse_only | 1 | 0.265422169 | 46704 |

Native CN/Fulminate measurements have 0 model calls and 0 tokens. This is not a claim that source migration/orchestration had no model cost.

All 7 non-primary CN wrappers are indexed in `native-compatible-cn-attempts/index.json`. Wrapper creation did not rerun CN. The `attempt-02.../verify` exit 124 was an output-directory argument error, not a timeout.

Preserved evidence: every receipt, command, resource JSON, stdout/stderr log, candidate C, instrumented C, final source audit, and the three failure-state HTML files. The HTML files total about 347 KiB and are kept as useful failure evidence.

Cleanup removes only the five generated ELF `.exec.out` files. Their hashes and rebuild sources are recorded in `cleanup-receipt.json`. No source, log, report, or state evidence is deleted.
