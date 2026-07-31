# iplib ModeConvert_AMMFun TeSpec trial

This directory is an isolated end-to-end trial over the QCIP iplib input.

- Frozen annotated source: `spec/final_spec.c`
- Exactly 30 concrete tests: `tests/binds.json`
- Reference evidence: `reports/reference-v002/report.json`
- Refinement matrix: `reports/refinement-v002/matrix.json`
- Held-out matrix: `reports/heldout-v002/matrix.json`
- Source and semantic scope: `SOURCE_ADAPTATION.md`

Run the frozen reference tests from the TeSpec root:

```bash
python3 -m spectest run \
  e2e/iplib_ModeConvert_AMMFun/spec/final_spec.c \
  --function ModeConvert_AMMFun \
  --binds e2e/iplib_ModeConvert_AMMFun/tests/binds.json \
  --output-dir .spectest/iplib_ModeConvert_AMMFun
```
