# Complete primary QCP verification

This completes the designated read primary's original universal QCP VC. No concrete test input is bound. The previous native stage is reused by exact source/goal/log hashes; proof artifact generation, Coq compilation, assumption audit and independent kernel replay were actually run and metered.

The fresh gpt-6.1-sol output proves `PrimaryQcpGoal.read_return_wit_1` and implements the original `VC_Correct` interface. The theorem audit is Closed under the global context and coqchk exits zero. It imports no admitted proof solution. The source goal is byte-identical to the original native QCP VC.

`statistics.json` records native, model, compilation and kernel costs separately and combined. The native-only 0.0064 s / 4544 KiB / zero-token observation remains valid for that stage but is not the full verification cost. CLI usage-events.json gives actual input/output token usage; cached input and reasoning output are subsets and not added twice. Memory is the maximum local process resident memory across sequential stages, excluding remote model/GPU memory.

`receipt.json` is the authoritative proof and measurement receipt. Validate it with `python3 tools/benchmark/validate_qcp_primary_complete.py`. The proof sources are retained; compiled caches are removed after checking. QCP source/native VC generation is not rerun.
