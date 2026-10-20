# ICSE manuscript revision - 2026-10-17

This revision improves the figures and literature positioning. The manuscript
has 11 pages including references; the main text ends on page 9. Only paper
files changed.

## Figures

All three figures use shared vector sources, explicit print-size typography,
and a restrained palette. Light rules separate reading stages; the execution
state and evidence are the main visual objects.

- Figure 1 (page 3) follows the least-root instance: binding, symbolic address,
  cell value 13, executed updates, cell value 4, and a frozen observation.
  Automatic decisions and kernel-checked completion have separate evidence routes.
- Figure 2 (page 3) keeps one write/return line above two copied assertions.
  The valid proof and the complete k = 3 counterexample are visible; proof terms
  use d rather than the pointer name p.
- Figure 3 (page 5) connects SAT/UNSAT/UNKNOWN to original-VC polarity, collects
  all ITP outcomes into one VC set, and exposes the reachable-violation gate
  before path FAIL. PASS requires feasible execution, complete steps/checks,
  and valid obligations. Instance aggregation is defined by Table I.

The design follows stage/artifact organization in
[Agentless, Figure 1](https://lingming.cs.illinois.edu/publications/fse2025.pdf)
and explicit component interfaces in
[Rango, Figure 1](https://www.cs.cornell.edu/~lerner/papers/rango-final.pdf).
All artwork was independently drawn in TikZ.

## Literature

The compiled bibliography grew from 17 to 39 cited works: 16 newly added
primary references and 6 relevant entries already in the library. The library
contains 49 entries, of which 10 remain uncited research material.
Counts come from the compiled main.aux, not the size of the BibTeX file.

Related work now distinguishes executable specification oracles, logical
specification testing, proof-failure diagnosis, symbolic execution and input
generation, verification interfaces, and proof completion. Citations also
support claims in the introduction, method, semantics, and evaluation design.
The citation audit records source links, claim scope, and section coverage.

Two distinctions were checked against the original papers:

- COINS seeks proofs of example admission; an unproved rejection does not
  become a confirmed violation in the planned comparison.
- StaDy requires complete exploration of the original domain to confirm prover
  incapacity; incomplete exploration remains inconclusive.

The broader empirical comparison remains a study design. Citing an existing
method does not claim that it has been integrated or benchmarked.

## Validation

The build checks 99 pinned case-evidence files, six integer-boundary controls,
twelve independent ITP groups, and the separate 221-file comparison archive.
The PDF compiles with no errors, unresolved citations/references, bibliography
warnings, or overfull boxes. Three underfull vertical boxes were visually
checked. All 11 pages and the three standalone figures were reviewed.

The two theorems, two propositions, formalization map, and historical Rocq
receipts retain their existing scope. This revision runs no new experiment or
theory replay and changes no implementation, solver, benchmark, or raw result.

## 2026-10-17: CN/Fulminate version policy

- Resolve the official default-branch head at each new batch start and freeze a
  shared CN verification/Fulminate instrumentation build for the whole batch.
- Live upstream observation: `b4a2f009234d9c80380dbf95a9b2325e36a4705d`;
  record its Cerberus dependency and distinguish source selection from installation.
- Label April read and October 7 quantified-case builds explicitly in the paper.
  Preserve old measurements and require matching case/control reruns for new claims.
- Update Evaluation, case provenance, the research protocol and its source receipt.
- Build and existing evidence audits passed: 99 pinned case files and 221 paired
  archive files. No new experiments, tool builds or implementation edits.
- Final PDF remains 11 pages; zero overfull boxes, unresolved references or
  bibliography warnings; changed pages 6 and 8 visually inspected.

## 2026-10-19: execution strategies and conditional agreement

- Describe inline and modular state construction separately from the
  entry-exit/all-boundaries observation schedule, including bodyless calls.
- Retain the decision figure and add explicit instance aggregation and a
  QCP automatic route. The main figure shows both strategies and scoped
  evidence; the observation figure explicitly illustrates inline.
- Add Theorem 3 with a local two-way boundary simulation. Its conclusions
  include finite observation traces, reachable violations, semantic boundary
  termination, and nonvacuous total acceptance. Current sampler refinement and
  equality of resource-bounded UNKNOWN reports are explicitly not claimed.
- Record eight actual current-executor controls: a sound loose helper contract
  gives inline PASS versus modular model FAIL; an exact contract gives PASS
  in both strategies. Both observation schedules are exercised.
- Add ModeCorrespondence.v with 14 closed principal statements and recheck all
  12 modules / 102 principal statements with coqc and independent coqchk.
- Add hash and evidence checks to the paper build. Preserve previous receipts.
  New artifacts are under evidence/strategy-correspondence-20261019.
- The resulting PDF has 12 pages. No execution engine or benchmark files changed.

## 2026-10-20: verified specifications imply agreement

- Replace main Theorem 3 with agreement for fully verified modular specifications:
  every legal sample preserves verified assertions; both completed tests PASS.
  This does not require equal values, traces or exact summaries.
- Cover contracts, loop initiation/preservation/exit and framed assertions. State
  universal continuation obligations and the shared dependency interpretation.
- Add the whole-original-VC implication bridge; single-sample truth alone is
  insufficient. Original inventory coverage and sound completed decisions yield
  agreement of reports in the reference model.
- Retain the older boundary-bisimulation theorem as supplementary material and
  preserve the verdict diagram. Update the overview, introduction and discussion
  around the verified-specification premise.
- Add VerifiedSpecificationTesting.v: 20 closed principal statements, compiled
  and independently kernel-checked with Coq 8.20.1. Preserve all available proof
  attempt logs, including three failures. Reuse the hash-matching 12-module/
  102-statement receipt; combined coverage is 13 modules / 122 statements.
- This is a reference-model proof with explicit sampler/VC/report interfaces,
  not a verified implementation of the C executor. No runtime trials were rerun.
- Final build and visual review details are in revision-validation.json.
- Final manuscript: 13 pages, no LaTeX errors, overfull boxes, undefined
  references/citations or bibliography warnings. Five underfull diagnostics
  were visually checked. The theorem pages, overview and preserved decision
  diagram were inspected at readable resolution, with all pages reviewed in
  a contact sheet.

## 2026-10-20: restore the paper's argument hierarchy

- Center the narrative on testing original proof-oriented specifications before
  full verification: execution-derived states, original VCs, checked evidence,
  and verdict scope.
- Explain inline execution and copied observations before modular continuations.
  Preserve both strategies, independent observation schedules and bodyless calls.
- Remove repeated promotion of verified-specification agreement from the
  abstract, contribution list, main figure and discussion. Retain Theorem 3
  and a concise proof as a supporting formal guarantee; preserve its expanded
  argument in supplement/verified-specification-testing.tex.
- Keep the shared decision figure and case-study organization. Mark an explicit
  observation point in the overview and connect its snapshot to the original VC.
- Record editorial priorities in README.md. Coq sources, historical evidence and
  runtime benchmark results are unchanged; build-time audits reuse their hashes.
- Final PDF returns to 12 pages. Checked the revised opening, method, theory,
  discussion, conclusion and overview at readable resolution, plus the complete
  page contact sheet. No LaTeX errors, overfull boxes, undefined references or
  bibliography warnings; the two underfull diagnostics were visually checked.
