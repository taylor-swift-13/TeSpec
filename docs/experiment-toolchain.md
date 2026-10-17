# Experimental CN/Fulminate toolchain

Updated on 2026-10-17 from the official CN default branch. The installed source is
`b4a2f009234d9c80380dbf95a9b2325e36a4705d` (2026-10-13 UTC). CN verification,
Fulminate instrumentation, Bennet, Darcy and Lucas are commands in this same build.
Cerberus is pinned by CN to `c8c085d4714ae17095b2e1202fa33c5545d98df1`.

## Installed environment

- Source: `/home/yangfp/tespec-baselines/cn`, clean `main`, updated fast-forward.
- Dedicated existing opam switch: `tespec-cn-5.2`, pinned to the full CN commit.
- CN binary SHA-256: `bae893a3e360b4cfd07e41469f5dc9877a261fd1ed887ea6a8535a6b101b7700`.
- Active configuration: `tools/benchmark/cn-toolchain.json`.
- Build, dependency export, runtime hashes, checks and limitations:
  `benchmark/results/toolchain/20261017-upgrade/`.

The version string contains `dirty` because `dune subst` inserts version fields
and expands the version watermark in the opam build copy. The exact four-file
diff is retained in `source-build.diff`; the upstream source checkout is clean.
No semantic patches were applied to CN or Cerberus.

The shared benchmark helper now selects this switch instead of the April build.
It checks the CN executable, 196 installed runtime files, opam switch state, and
actual GCC/Z3 executables against the recorded identity before a new measurement.
The allocator scripts also default to this updated switch. An explicit old
`--switch` is reserved for separately labelled historical reproduction.

This update covers the external CN tool family. The project's QCP/teSpec custom
executors, Rocq proof environment and Python solver dependency retain their
existing validated versions. They are not replaced with unrelated upstream code.

## Checks and observed limitations

| Check | Result |
| --- | --- |
| CN verifies the valid heap update | Pass |
| CN rejects its incorrect postcondition | Expected unprovable-constraint diagnostic |
| Fulminate runs the valid heap update | Exit 0 |
| Fulminate rejects its incorrect postcondition | Expected runtime assertion failure |
| Bennet, Darcy and Lucas on a no-input function and its incorrect postcondition | All three accept the valid case and reject the invalid case |
| Bennet/Lucas on the bounded integer heap case | Upstream integer-generation conversion error |
| Darcy on the bounded integer heap case | Generated program fails to link its integer replication helper |

The generator failures remain in the raw records. They are not counted as
successful bug detections. Lucas additionally prints an experimental-status
warning. Installation checks are not benchmark performance measurements.

Recheck the required CN/Fulminate interfaces in a **fresh** output directory:

```sh
python3 scripts/check-cn-toolchain.py \
  --output benchmark/results/toolchain/<new-batch>/core-smoke
```

`--generators` additionally probes the bounded heap case and returns failure if
those probes remain unsupported. Both successful and failed attempts are retained.

## Starting a new experiment

Before each new batch, resolve the latest upstream default-branch commit, build
CN and Fulminate together, validate the installation and refresh its active lock.
Freeze that identity within the batch. Never silently use the April fallback.
Changes to toolchain, source, logical dependencies or compiler configuration
require a new batch identity; they cannot relabel a measured old batch.

```sh
python3 tools/benchmark/test_group_variants.py --group <group> --run-id <new-batch>
python3 tools/benchmark/prepare_group_primary.py \
  --group <group> --run-id <new-primary-batch> --task-dir <proof-task-directory>
python3 tools/benchmark/test_read_variants.py \
  --output benchmark/results/read/<new-batch>
```

The group driver checks toolchain and input identities before resuming cached
measurements or importing Fulminate stages. Missing legacy metadata is a refusal,
not permission to reuse. Incomplete execution directories are preserved; use a
fresh batch rather than reading a stale report. Primary verification also checks
input/dependency and executor identity before reuse; the explicit continuation
of a failed CN attempt must match its original input and leave QCP output empty.
Historical reports and already completed proofs remain available under their
original identities. This installation update does not rerun the full benchmark.
