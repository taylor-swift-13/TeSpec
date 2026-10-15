# TeSpec ICSE manuscript

**TeSpec: Proof-Based Testing of Separation-Logic Specifications for C** is the
current manuscript in `main.tex` and `main.pdf`. The current revision is nine
pages including references. It develops the method before its formal guarantees
and uses one main workflow figure, shared with `figures/overview-standalone.pdf`. The diagram explicitly connects
SMT SAT/UNSAT/UNKNOWN, original-VC VALID/INVALID/UNKNOWN, ITP completion,
and path/whole-instance PASS/FAIL/UNKNOWN.

## Argument and structure

1. Original logical assertions can require proof after inputs are fixed.
2. Actual C execution supplies the states; copied observations preserve them.
3. Exact local frames and joint heap/value normalization preserve what is checked.
4. Instance semantics distinguishes covered acceptance from reachable violations.
5. Four evidence-backed case studies explain arithmetic safety, quantified
   contracts, and spatial proof completion.
6. The evaluation design distinguishes planned comparisons from recorded cases.

The first case study is the read negation mutant at INT_MIN: the recorded
Fulminate configuration exits normally, whereas TeSpec rejects its arithmetic
safety obligation. Least-root and divisibility demonstrate instrumentation
support limitations and successful proof completion; they are not false-PASS
cases. Missing read ownership is a common negative control for both tools.

## Build and checks

```sh
bash paper/build.sh
```

The build verifies the pinned case-study evidence, checks the existing archived
comparison/proof evidence, builds the vector workflow, and compiles the manuscript
with pdfLaTeX and BibTeX. It writes only under `paper/`. Source benchmark paths are
read-only dependencies of the paper evidence audit.

`revision-validation.json` records the latest PDF build and visual inspection.
`tmp/pdfs/` holds ignored preview images. The present revision does not rerun
benchmarks, invoke proof agents, or recheck the Coq theory. Existing theorem
receipts remain under `evidence/theory-review-20261012/` (11 modules, 88 principal
statements). The reference guarantees and implementation obligations are
separated in the formal section.

## Evidence and study protocol

- `evidence/case-study-audit.json`: hashes of 99 existing evidence files, six
  read-negation controls, and twelve independent read proof-completion groups.
- `scripts/audit-case-studies.py`: validates that inventory and the reported
  case counts. `--record` is reserved for explicitly reviewed evidence updates.
- `evidence/case-study-notes.md`: exact claim scope and evidence locations.
- `evidence/comparative-case-studies-20261013/`: quantified examples, proof
  receipts, and historical shared-task/allocator investigations.
- `evidence-summary.json` and `scripts/summarize-evidence.py`: the older paired
  archive, proof groups, and original/finite-form controls. These historical
  tables are not presented as a completed benchmark evaluation in the main text.
- `research-protocol.md`: required baselines, per-execution ITP units, model and
  resource accounting. QCP verifies each primary's original contract once;
  it is not treated as a fixed-input testing configuration.

The main manuscript uses `sections/{introduction,motivation,approach,semantics,
case-studies,evaluation,discussion,related-work}.tex`. The normalization algorithm
is included by `approach.tex`. Older standalone semantics, result-flow graphics,
and development material are retained for provenance and are not included in
the current manuscript. The IEEE template files retain their original licenses.
