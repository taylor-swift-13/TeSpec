# Fully metered read ITP replay

This is a new measured run, not reconstructed telemetry for the older conversation-authored proofs. A fresh gpt-6.1-sol call filled all 36 exact statements (12 return-VC refutations, 12 spatial refutations, 12 satisfiable entries). Immutable original goal modules and the previously checked concrete-heap helper were supplied; prior refutation solutions were excluded.

- Model calls: 1.
- Model generation wall time: 56.047000 seconds.
- Coq compile/assumption-audit wall time: 16.013148 seconds.
- Independent kernel replay wall time: 129.237032 seconds.
- Total ITP stage wall time: 201.297180 seconds.
- Peak Coq process RSS: 2037252 KiB.
- Peak model-client process working set: 197382144 bytes.
- Maximum local process resident memory across stages: 1989.503906 MiB.
- Actual input tokens: 132469; cached input subset: 109184.
- Actual output tokens: 1446; total tokens: 133915.

Cached input is included in input tokens and reasoning output is included in output tokens; neither is added again. Token events are actual CLI turn.completed telemetry in attempt-1/usage-events.json. Windows model client memory excludes remote service/GPU memory. Linux Coq peaks use GNU time %M. The combined memory metric is largest-process resident memory across sequential stages, not simultaneous process-tree aggregate memory. Shared model/helper/kernel stages are charged once for the batch, not twelve times.

All 36 assumption audits are Closed under the global context; independent coqchk exits zero. Goal and candidate source hashes, commands, stage stdout/stderr and resources.json are retained. Compiled Coq caches are removed after checking. Execution-test observations and executor binary remain unchanged.

`receipt.json` and `statistics.json` are authoritative metered ITP records. `benchmark/results/read/complete/` incorporates these costs into the full test pipeline. The earlier unmetered ITP run remains under 20261015-itp-refutations as historical evidence.

Reproduction drivers: `prepare_read_itp_model.py --task-dir <fresh task directory>` creates immutable goal inputs and the candidate template; `meter_itp_model_windows.py --task-dir <Windows task directory> --attempt 1` records real model usage and client memory; `meter_read_itp_coq.py --attempt 1` records Coq compilation and kernel resources. The Coq driver uses the current task's prepared Windows mount by default. Summarize with `summarize_metered_read_itp.py`, audit with `validate_metered_read_itp.py`, and publish complete statistics with `complete_read_pipeline.py`. Metering a fresh run must use fresh attempt locations; old measured attempts must not be overwritten.
