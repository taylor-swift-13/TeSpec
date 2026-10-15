# Benchmark archives

- `fulminate-cn/`: the pinned original upstream source snapshot (76 C inputs and their dependencies).
- `benchmark-support/`: historical CN/QCP input programs, migration scripts and formal proof sources. Results, execution logs and measurements are under `benchmark/results/`.

The active dataset lives under `benchmark/programs/<group>/`. Archived source and evidence bytes remain unchanged. Resolve historical path strings using `benchmark-support/path-map.json` followed by `benchmark/results/relocation-map.json`; the current artifact locations and hashes are in `benchmark/results/evidence.json`.

Run `python3 tools/benchmark/build_program_groups.py --check` and `python3 tools/benchmark/audit_archive.py` from the repository root to audit both current groups and archived records.
