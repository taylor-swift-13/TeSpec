# Benchmark historical support

`selection/` preserves the previous CN/QCP migration scripts, frozen tests, measurements and proof artifacts byte for byte (apart from explicitly updated policy documentation). The active dataset is organized under `benchmark/programs/<group>/`.

Original upstream files live in `arxiv/fulminate-cn/`. Archived reports retain their original path strings and hashes. Resolve those paths through `path-map.json` or the current `benchmark/programs/evidence.json`; do not rewrite signed/hashed proof receipts or reuse a result for different source/spec/input.

Historical scripts expect their original directory layout. `python3 tools/benchmark/audit_archive.py` creates an isolated temporary copy with that layout and runs the existing metadata/hash validators there. Do not run archive generators directly in this relocated directory. Active grouped input generation and validation use `tools/benchmark/build_program_groups.py`.
