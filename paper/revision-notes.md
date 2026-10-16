# ICSE manuscript revision — 2026-10-16

This revision changes only paper files. It does not change the executor, solver,
benchmark programs, expected outcomes, or raw experimental results.

## Main changes

- Retitled the paper around proof-based testing of separation-logic specifications.
- Rebuilt the introduction around non-executable logical assertions and preservation
  of the execution state being tested.
- Moved the checking method before the formal guarantees and replaced the main
  graphic with one execution/proof workflow.
- Clarified the instance domain, copied observation rule, fixed root bindings in
  normalization, boundary coverage, relative acceptance, and reachable violations.
- Replaced the mixed seven-case narrative with four completed evidence-backed
  case studies, led by the read INT_MIN discrepancy.
- Moved prospective COINS/Gillian comparisons and cost accounting into the evaluation
  design, leaving full QCP verification of the original primary contract as its
  own comparison. Repeated historical cost figures were removed from the abstract.

## Case-selection result

The evidence supports one observed false acceptance: the read negation mutant at
INT_MIN in the recorded Fulminate configuration. Least-root and divisibility expose
quantifier-instrumentation limitations; their finite equivalent controls pass.
Read's missing-ownership variants are detected by both tools and explain how
spatial SMT removes twelve unresolved TeSpec verdicts. No unsupported-instrumentation
result or incomplete baseline run is labelled an incorrect runtime answer.

The old pKVM, COINS and VERINA investigations remain archived under paper evidence.
Their incomplete matched tool results are no longer used as completed main-text
case studies. They remain useful candidates for the broader study.

## Writing model

The argument follows a concrete example, the missing information, an explicit
workflow, and a formal property before discussing broader comparisons. This
organization is informed by the primary-paper reading already completed for
[Towards Optimal Concolic Testing](https://zbchen.github.io/files/icse2018-2.pdf),
[SymTuner](https://prl.korea.ac.kr/papers/SymTuner.pdf), and
[Sibyl](https://leeson.prof/assets/pdf/Sibyl.pdf). Their empirical results are not
used as evidence for TeSpec.

## Validation boundary

`revision-validation.json` records the final PDF and evidence checks. Historical
Coq sources are hash-matched against their existing replay receipt; no new theory
replay or benchmark run is claimed. The earlier review in `review-response.txt`
is dated 2026-10-12 and describes that historical revision.

## Follow-up: solver, VC, proof, and path result flow

The main workflow now distinguishes the negated SMT query from the original
entailment. UNSAT establishes VALID under a sound encoding; SAT establishes
INVALID only after original-model validation. Unresolved VCs enter ITP, where
a checked proof of either polarity establishes VALID or INVALID and an
uncompleted attempt remains UNKNOWN. Automatic decisions bypass proof search.

Path aggregation separately checks reachable negative evidence. A reachable
violation dominates unresolved VCs; PASS requires feasible, complete execution
and every required VC to be VALID. The diagram also shows whole-instance
aggregation and the distinct polarity of entry existence. The revised paper
is nine pages including references. No implementation or experiment was changed.

## Follow-up: three complementary method figures

The method now separates three reading tasks. Figure 1 gives the complete
execution/checking workflow without expanding solver branches. Figure 2 shows
copied observation using `root_cell`: the reached values `n = 13, r = 4` and
owned cell are copied for checking, while execution still writes and returns 4.
The original `LeastRoot(13, 4)` and mutated `LeastRoot(13, 3)` assertions change
the obligations, with no feedback edge into the continuing execution.

Figure 3 expands SMT answers, original-VC status, ITP completion, and ordered
path/instance aggregation. It retains model validation for SAT, reachability for
path FAIL, and nonempty entry plus complete coverage for instance PASS. The
separate entry-existence query has its own polarity. The overview checks entry
before execution, and the result diagram records empty-entry FAIL separately
from a reachable execution violation. Each figure has a shared
TikZ source and a standalone PDF export, built by `build.sh`.

Figures 1 and 2 appear on page 3 and Figure 3 on page 5. The manuscript remains
nine pages including references. All pages and the three standalone figures
were visually inspected, with no clipping or overlap. The final build has no
overfull or underfull boxes and no unresolved references. No new experiments
or theory replay were performed.


## Follow-up: formal derivations and artifact-oriented figures

The revision now starts from a concrete obstacle: fixing program inputs does
not necessarily make the remaining assertion executable. Its central mechanism
is stated once: execution supplies states; proof checks their specifications.
The introduction and method follow this mechanism into its preservation and
oracle obligations instead of repeating implementation safeguards.

The formal section defines state/control context, assertion syntax, instance
domains, candidate execution/observation/normalization rules, and evidence
interfaces. Faithful resolution relates generated predicates to original
annotations. Typed records preserve each check identity and its source/target
predicates; their trace-instantiated inventory must match the selected schedule.
Two theorems and two propositions establish reference trace preservation,
nonvacuous acceptance, oracle soundness, and reachable-refutation soundness.
The integrated derivations are distinguished from existing mechanized components
in `formalization-map.md`. No Coq source or experimental result was changed.

The figure redesign follows information-organization principles from the
requested primary papers:

- [Agentless, Figure 1, published PDF page 6](https://lingming.cs.illinois.edu/publications/fse2025.pdf): separate stages and show the artifacts transformed between them. TeSpec now shows the binding, state spine, logical snapshot, and frozen VC.
- [Rango, Figure 1, PDF page 4](https://www.cs.cornell.edu/~lerner/papers/rango-final.pdf): make a component interface concrete and show how it contributes to the larger process. TeSpec now pairs one-obligation evidence with a schematic multi-path ledger. Rango is also cited for its actual proof-synthesis contribution in related work.
- [MAE](https://arxiv.org/abs/2111.06377) and [ResNet](https://arxiv.org/abs/1512.03385): the writing review follows their progression from a precise obstacle to a compact mechanism and evidence that tests it. These are writing references, not technical dependencies of TeSpec.

The figures were independently redrawn in TikZ. No source artwork, experimental
results, retrieval component, or training claim was imported. Figures 1 and 2
remain on page 3; Figure 3 is on page 5. The revised manuscript is ten pages
including references. The visual review covers the full document and all three
standalone figures. The final log has no overfull boxes or unresolved references;
one underfull vertical box was visually checked.
