# Citation audit - 2026-10-17

Compiled manuscript: **17 -> 39 cited works**. BibTeX library: **33 -> 49 entries**.
The increase is 16 new primary references plus 6 relevant, previously uncited entries.
Outside Related Work, the cited source set grows from 4 to 17.

## Placement

| Included section | Distinct cited works before | Distinct cited works now |
| --- | ---: | ---: |
| introduction | 2 | 6 |
| motivation | 0 | 0 |
| approach | 0 | 5 |
| normalization-algorithm | 0 | 0 |
| semantics | 1 | 2 |
| case-studies | 1 | 1 |
| evaluation | 0 | 5 |
| discussion | 0 | 0 |
| related-work | 15 | 37 |

Counts are section-local and must not be summed: sources can appear in more than one section.

## Added and restored citations

Each source below was checked against a primary paper or official publication record.
The scope column records the reason for citing it, not a claim of implementation reuse.

| Key | Change | Supported scope | Primary source |
| --- | --- | --- | --- |
| barr2015oracle | new | Input generation and outcome classification are distinct problems. | [paper/record](https://philmcminn.com/publications/barr2015.pdf) |
| king1976symbolic | new | Symbolic execution represents paths using symbolic values and constraints. | [paper/record](https://research.ibm.com/publications/symbolic-execution-and-program-testing) |
| godefroid2005dart | new | DART combines concrete execution and symbolic constraints to generate tests. | [paper/record](https://people.eecs.berkeley.edu/~ksen/papers/dart.pdf) |
| sen2005cute | new | CUTE combines concrete and symbolic unit testing for C. | [paper/record](https://osl.cs.illinois.edu/media/papers/sen-2005-sigsoft-cute.pdf) |
| cadar2008klee | new | KLEE applies symbolic test generation to systems code. | [paper/record](https://www.usenix.org/legacy/events/osdi08/tech/full_papers/cadar/cadar.pdf) |
| signoles2017eacsl | new | E-ACSL instruments C for an executable subset of ACSL; RV-CuBES workshop paper. | [paper/record](https://easychair.org/publications/paper/t6tV) |
| petiot2018stady | new | StaDy diagnoses noncompliance, weak subcontracts and prover incapacity; complete-domain conditions matter. | [paper/record](https://nikolai-kosmatov.eu/publications/petiot_kbgj_faoc_2018.pdf) |
| piskac2013smt | new | SMT-based procedures automate supported separation-logic fragments. | [paper/record](https://cs.yale.edu/homes/piskac/papers/2013PiskacWiesZuffreySepLog.pdf) |
| jacobs2011verifast | new | VeriFast verifies C and Java using separation-logic contracts. | [paper/record](https://people.cs.kuleuven.be/~bart.jacobs/nfm2011.pdf) |
| leino2010dafny | new | Dafny integrates specifications and automatic functional verification. | [paper/record](https://link.springer.com/chapter/10.1007/978-3-642-17511-4_20) |
| czajka2018coqhammer | new | External proof search is followed by proof reconstruction in Coq. | [paper/record](https://link.springer.com/article/10.1007/s10817-018-9458-4) |
| ekici2017smtcoq | new | SMTCoq checks certificates with a verified checker; LNCS 10427, 126-133. | [paper/record](https://mebsout.github.io/papers/cav2017.pdf) |
| blaauwbroek2020tactician | new | Tactician learns and searches over tactics; this is the CICM 2020 paper. | [paper/record](https://arxiv.org/abs/2008.00120) |
| sanchezstern2020proverbot | new | Proverbot9001 guides tactic-level proof search. | [paper/record](https://proverbot9001.ucsd.edu/papers/proverbot9001.pdf) |
| kozyrev2024coqpilot | new | CoqPilot combines proof candidate generation, checking and repair. | [paper/record](https://arxiv.org/abs/2410.19605) |
| brucker2009holtestgen | new | HOL-TestGen derives test theorems/data and records generalization hypotheses. | [paper/record](https://logicalhacking.com/publications/brucker.ea-hol-testgen-2009/) |
| nguyen2008slick | restored | SLICK runtime checking addresses implicit footprints and existential witnesses. | [paper/record](https://lara.epfl.ch/~kuncak/papers/NguyenETAL08RuntimeCheckingSeparationLogic.pdf) |
| brotherston2016model | restored | Model checking means satisfaction of symbolic-heap assertions on a given concrete state. | [paper/record](https://www.cs.rhul.ac.uk/home/rrowe/assets/pdf/sl-model-checking.pdf) |
| claessen2000quickcheck | restored | QuickCheck evaluates executable properties on generated inputs. | [paper/record](https://www.cis.upenn.edu/~bcpierce/courses/552-2008/resources/icfp-quickcheck.pdf) |
| lampropoulos2019fuzzchick | restored | FuzzChick adds coverage-guided, type-aware mutation; article 181, 29 pages. | [paper/record](https://mhicks.me/papers/fuzzchick.pdf) |
| pham2019csf | restored | CSF combines valid-heap generation and concolic exploration; not a ready-made C baseline. | [paper/record](https://qsphan.github.io/papers/fm19.pdf) |
| app2011vst | restored | VST composes semantic guarantees across verification components. | [paper/record](https://www.cs.princeton.edu/~appel/papers/vst.pdf) |

## Interpretation checks

- [COINS, Section 3.2](https://arxiv.org/html/2608.13077v1) produces admission evidence; failed proof search does not certify rejection. Related work and comparison design preserve that distinction.
- [StaDy, Section 6.1](https://nikolai-kosmatov.eu/publications/petiot_kbgj_faoc_2018.pdf) needs complete exploration of the original domain to confirm prover incapacity. Incomplete exploration is inconclusive.
- Symbolic-heap model checking concerns a given stack/heap state, not full program verification.
- CSF is cited for concolic heap generation, not introduced as an already available C comparator.
- CoqHammer, SMTCoq, Tactician, Proverbot9001, CoqPilot and Rango motivate proof production/checking choices; no integration or experimental result is claimed.
- TeSpec-specific theorems remain supported by their own definitions and derivations, not by attaching background citations.

## Build consistency

All 39 compiled citation keys resolve. No duplicate BibTeX keys, missing entries,
or BibTeX warnings were reported. Ten library entries remain uncited; they are not counted
as references in the manuscript.
