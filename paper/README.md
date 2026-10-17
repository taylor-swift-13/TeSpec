# TeSpec ICSE manuscript

**TeSpec: Proof-Based Testing of Separation-Logic Specifications for C** is the
current manuscript in `main.tex` and `main.pdf`. The current revision is eleven
pages including references. It develops the method before its formal guarantees
and uses three complementary method figures:

| Figure | Purpose | Page | Standalone PDF |
| --- | --- | --- | --- |
| 1. Workflow | Three stages with a visible execution spine, logical snapshot, and proof branch | 3 | `figures/overview-standalone.pdf` |
| 2. Copied observation | The shared write/return above two different functional obligations | 3 | `figures/observation-standalone.pdf` |
| 3. Verdict flow | SMT/ITP evidence collected into VC sets, with explicit path verdict gates | 5 | `figures/result-flow-standalone.pdf` |

The overview directs readers to the mechanism and verdict diagrams. A shared
`figures/figure-style.tex` fixes colors, line roles, and print-size typography. All three
figures share their vector source between the manuscript and standalone PDF.

## Fulminate-centered literature review (2026-10-17)

[The research report](literature/fulminate-review.md) compares 20 core primary
sources and two supplementary works. It traces Fulminate's predecessors and
2026 successors, identifies direct proof/testing precedents, and records
concrete decisions for the next manuscript revision. The
[source index](literature/fulminate-sources.json) records versions, reading
locations, and artifact identities. This is a targeted literature study;
third-party artifacts were not executed. The report does not change the
current manuscript or PDF and supersedes the claim that baseline selection
is complete in the earlier study protocol.

## Argument and structure

1. Original logical assertions can require proof after inputs are fixed.
2. Actual C execution supplies the states; copied observations preserve them.
3. Exact local frames and joint heap/value normalization preserve what is checked.
4. Formal construction rules connect execution, faithful resolution, typed
   observation records, oracle evidence, and path/instance judgments.
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
comparison/proof evidence, builds all three vector figures, and compiles the manuscript
with pdfLaTeX and BibTeX. It writes only under `paper/`. Source benchmark paths are
read-only dependencies of the paper evidence audit.

`revision-validation.json` records the latest PDF build and visual inspection.
`citation-audit.md` records the 17-to-39 expansion of actual manuscript citations,
primary-source checks, and section coverage; the library contains 49 entries.
`formalization-map.md` connects the two theorems and two propositions to the
existing Rocq developments and identifies the paper-level interface arguments.
`tmp/pdfs/` holds ignored preview images. The present revision does not rerun
benchmarks, invoke proof agents, or recheck the Coq theory. Existing theorem
receipts remain under `evidence/theory-review-20261012/` (11 modules, 88 principal
statements). The reference guarantees and implementation obligations are
separated in the formal section.

## CN/Fulminate version policy

All subsequent CN verification and Fulminate tests use the same latest official
CN build, resolved at the start of each batch and frozen for that batch.
The upstream head checked on 2026-10-17 is `b4a2f00923`; its shared build is now
installed and passes the CN/Fulminate positive/negative installation checks.
Full benchmark measurements on that build remain pending. Existing read evidence uses the April 2026 build;
least-root and divisibility use the October 7 build. The manuscript labels
these historical versions. See `research-protocol.md` and
`evidence/cn-fulminate-version-policy-20261017.json` for provenance and rerun rules.

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
is included by `approach.tex`, as are the copied-observation and verdict-flow
figures. Older standalone semantics and development material are retained for
provenance and are not included in the current manuscript. The IEEE template
files retain their original licenses.
