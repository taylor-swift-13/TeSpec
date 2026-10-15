# Benchmark archives

- `fulminate-cn/`: the pinned original upstream source snapshot (76 C inputs and their dependencies).
- `benchmark-support/`: historical CN/QCP migration records, frozen test inputs and results, formal proof sources, and performance measurements.

The active dataset lives under `benchmark/programs/<group>/`. Archived source and evidence bytes remain unchanged. Resolve historical path strings using `benchmark-support/path-map.json`; the current artifact locations and hashes are in `benchmark/programs/evidence.json`.

Run `python3 tools/benchmark/build_program_groups.py --check` and `python3 tools/benchmark/audit_archive.py` from the repository root to audit both current groups and archived records.
