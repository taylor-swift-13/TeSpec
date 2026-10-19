# Formalization and proof scope

The manuscript's semantic state includes control/call context, program storage,
immutable root bindings, and live logical values. A VC record retains its check
identity, source state predicate, and target predicate. A recorded proposition
is immutable even as execution proceeds.

| Manuscript item | Argument and existing support | Interface to the implementation |
| --- | --- | --- |
| Instance and candidate-tree definitions | Paper definitions for the selected domain, actual transfer, observation records, and joint normalization | Root domain fidelity, control/frame interpretation, resource-bound diagnostics |
| Faithful resolution | Paper interface equating the resolved predicate with the original annotation at represented states | Invocation bindings, witness-dependent frames, exact owned resources |
| Boundary completeness | Paper projection from ordered symbolic records to concrete `(check identity, state)` events | Correct boundary selection, repeated visits, and emitted-check identity |
| Theorem 1: erasure and lifting | Induction on the reference monitored rules; `theory/ObservationTrace.v` proves the existing trace and inventory properties | Observations preserve the program continuation; budget exhaustion remains incomplete |
| Proposition 1: oracle soundness | Paper derivation from countermodel-preserving encoding, original-model validation, and sound proof checking | Concrete SMT encodings, exported-goal identity, dependency interpretation |
| Theorem 2: nonvacuous acceptance | Finite-tree induction supported by `theory/InstanceChecking.v` and the reference observation inventory | Safety/progress/coverage, faithful resolution, complete schedule, terminal checks |
| Proposition 2: reachable-refutation soundness | Paper composition of original-predicate failure with a trace to the matching check; reference countermodel/reachability distinction in `theory/InstanceChecking.v` | Candidate-specific reachability; coverage/normalization side conditions are not program violations |
| Exact local frames | `theory/HeapObservation.v` characterizes exact frames and witness-dependent observations | Eligible local mask and source memory model |
| Joint normalization | `theory/DefinitionNormalization.v` preserves the joint heap/live-value denotation for licensed reductions | Rule licensing, root-binding preservation, fresh typed witnesses |
| Entry and scalar calls | `theory/PreconditionOracle.v`, `theory/CallFrames.v` | Initial-query polarity, argument binding, aliases, and lifetime modeling |

The existing replay receipt is `evidence/theory-review-20261012/report.json`:
11 modules and 88 principal statements. This revision hash-checks the sources
against that receipt; it does not rerun or extend their kernel replay.
The integrated frontend-to-oracle construction is specified and reasoned about
in the paper. The manuscript does not claim an end-to-end mechanically checked
refinement of the C frontend or the concrete SMT adapters.

The final cross-review repaired two gaps: generated predicates must be faithful
to the original annotation, and symbolic obligation records must be explicitly
instantiated before comparison with the concrete observation inventory. Both
interfaces are premises of the corresponding acceptance/refutation arguments.

## 2026-10-19: two execution strategies

The main paper now distinguishes inline body execution from modular
contract/invariant/assertion sampling, independently of entry-exit and
all-boundaries schedules. `sections/mode-correspondence.tex` states Theorem 3:
a boundary bisimulation with matching observations transfers finite traces,
reachable failure, semantic boundary termination, and nonvacuous total
acceptance. `theory/ModeCorrespondence.v` supplies 14 closed principal statements,
including a counterexample to unconditional agreement.

Two-way successor coverage and matching safety/check/terminality are explicit
premises. The current sampler is not proved to satisfy them. C-level lifting
additionally needs finite segments with no hidden divergence or stuckness.
The semantic theorem does not establish equal finite-resource tool statuses.
A new full replay checks 12 modules and 102 principal statements:
`evidence/strategy-correspondence-20261019/theory/report.json`.
This supersedes the historical 11-module count above for the current revision;
the historical receipt is unchanged.
