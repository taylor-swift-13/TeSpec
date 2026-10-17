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
