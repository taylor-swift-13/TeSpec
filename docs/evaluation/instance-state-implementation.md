> 历史验收记录：其模式/实例状态描述已由 [inline-preserve/v1](inline-preserve-implementation.md) 替代。以下数据只对应文中记录的旧二进制。

# Current-instance state implementation

The executor maintains a branch-owned current instance view alongside every
QCP assertion. C execution updates the formula; synchronization records current
locals, logical equalities and spatial contents. Ordinary assertion and
which-implies cuts use the incoming instance to specialize their successors
before those values can be lost through abstraction. The refined targets remain
subject to QCP entailment obligations.

## Mechanisms

- Owned `CurrentInstances` in `Assertion`, with deep copy, version and lifecycle.
- Full observation refresh at statement/expression boundaries and before matching;
  substitution, merge and principal writes invalidate previous observations.
- QCP's existing matcher transports symbolic pointers, scalar values, array
  constructors and spatial predicate arguments. No sample names or field offsets
  are hard-coded.
- Ordinary assertion cuts are specialized separately for each incoming branch;
  repeated visits do not reuse the first visit's instance. Current pure path
  conditions remain associated with their branch.
- Witness instantiation removes the target existential binder before substitution.
- Which-implies refinements retain their original obligations and add an
  entailment obligation for the refined continuation.
- Loop induction uses its invariant state, not entry-local values. Real contract
  calls use their postcondition and frame, never old modified-region contents.
- `--instance-trace` optionally records formulas and current observations in
  executor JSON. teSpec exposes the same CLI flag or `qcp.instance_trace: true`.

The observation view is rebuilt from the materialized, refined formula. It is
not a separately executing heap. Unknown predicate definitions or abstractions
without enough relations can still leave symbolic values and residual VCs.

## Verification

Final binary: `bin/tespec-symexec`; build/source hashes:
`bin/tespec-symexec.build.json`.

| Suite | Result |
|---|---|
| New current-instance regressions | 19 tests passed (both modes and negative cases) |
| Existing sac execution regressions | 42 tests passed |
| Require and VC artifact regressions | 43 tests passed |
| Memory satisfiability matrix | 281/281 expectations: 142 SAT, 135 UNSAT, 4 UNKNOWN |
| Curated QCP paired examples | 40/40 expectations: 21 PASS, 10 INVALID, 9 UNKNOWN |
| teSpec `make check` | 106 tests, 1 configured skip; lint, format and runtime checks passed |
| ASan/UBSan | New 19 and existing 42 execution tests passed; leak detection disabled |

The previous accepted executor fails 13 semantic subcases of the new suite,
including scalar updates, aliases, fields, arrays, branch correlations, call
frames, loop exits and which-implies. It additionally lacks the optional trace
flag. These failures are separate from the expected UNKNOWN cases used to guard
against unsound constant propagation.

Full corpus smoke output for this candidate is stored at
`/tmp/tespec-evaluation/instance-state-final-corpus/report.json`.
The final semantic matrix reports are under `instance-state-final-memory` and
`instance-state-final-curated` in the same evaluation directory. Smoke verdicts
are not ground-truth test expectations.

## Formalization

- `paper/instance-semantics.md`: Chinese semantic specification and code mapping.
- `paper/instance-semantics.tex` / `.pdf`: standalone formalization, compiled with
  `pdflatex` twice without unresolved references or overfull boxes.
- The requested copies are in `/home/yangfp/teSpec/paper`.

The argument is relative to QCP transitions, normalization and memory-model
correctness; the delivery does not contain a machine-checked proof of the C
implementation. No proof Agent was launched.

A reproducible end-to-end trace example is in
`/tmp/tespec-evaluation/instance-state-example`. Both modes pass. In no-expand
mode, the symbolic pointer identity stays fixed while successive statements and
assertion cuts retain heap contents 3 → 4 → 5. Each mode has its own `report.json`
and `artifacts/three/executor.json`.

## Final corpus smoke result

The final candidate completed 5,160 runs over 267 files and 1,147 specifications:
1,010 PASS, 1,022 INVALID, 2,471 UNKNOWN and 657 ERROR. Another 287 specification
entries require explicit typed bindings. There were no invalid executor JSON
results. The measured scan duration was 402.241 seconds with a 2-second per-case
timeout. This is a smoke evaluation using synthetic sizes, not a claim that
all QCP specifications were proved. Full counts, provenance and changes relative
to the previous candidate are in `instance-state-results.json`.
