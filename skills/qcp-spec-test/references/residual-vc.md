# Complete VC certificate workflow

`prepare-run-certificates` freezes the automatic report and creates a separate
proof bundle per eligible case. The editable file is `Candidate.v`. Goals,
coverage interface, audit module, dependencies and runtime hashes are immutable.
The complete original `VC_Correct` interface is checked, including automatic
obligations and initial satisfiability. Explicit `--refute-precondition CASE_ID`
requests only the negation of the original initial proposition; see [Require checks](precondition-check.md).
Generated auto proof placeholders are
not evidence for a complete certificate.

The proof controller plans one task per execution. It binds outstanding decisions
to the original Coq targets where the executor and saved artifacts establish an
exact match. If a binding is incomplete, it selects the complete original
interface. It retains the manifest digest and first tries a matching saved proof
source with the current checker. Each execution that still needs an Agent gets
its own request. The Agent reads `Goal.v` and its imports, edits `Candidate.v`,
and can run `coqc` for diagnostics. The C program, inputs, goals, contracts,
manifests and dependencies are fixed for all attempts.

The external controller performs acceptance:

```bash
python3 -m spectest check-run-certificates OUTPUT/proof/run-manifest.json \
  --manifest-sha256 CONTROLLER_HELD_DIGEST --timeout 600
```

This recompiles candidates, checks interface coverage, audits transitive
assumptions and replays the libraries with `coqchk`. The final report is
`OUTPUT/proof/report.json`. Existing automatic results are preserved; a
completed eligible instance becomes PASS when all required decisions have
support in the automatic report or a checked certificate. The proof report
records the exact kernel-checked goals of a decision-only certificate. Execution limits and errors cannot be repaired merely by proving the
VCs emitted before execution stopped.

No `Admitted`, `admit`, new axioms, parameters or hypotheses may remain
in a submitted candidate. `Abort` supplies no theorem: interface coverage
fails and the result remains UNKNOWN. Imported domain axioms also require scrutiny: kernel
compilation alone cannot establish their consistency, and the controller uses
a fixed assumption policy. Do not broaden that policy to make a proof pass.

Use definitions and proved lemmas from staged dependencies and the selected
runtime. Common tactics include `Intros`, `Exists`, `sep_apply`, rewriting and
`lia`, but some runtime tactics use unapproved axioms; inspect `Print Assumptions`
for the final theorem. A failed compilation, timeout or rejected assumption
leaves the result UNKNOWN. Feedback may be returned to the same proof Agent.

The lower-level `prepare-certificate` / `check-certificate` commands support
individual original VC groups and explicit refutation. Legacy `check-proof`
checks residual proofs relative to automatic obligations; its report alone
must not be promoted to a complete run certificate.

## Negative original VCs

The Agent may request a negative proof using the controller's `proof-plan.json`
routing file. The controller checks the positive attempt before preparing the
negative request. `--refute-vc CASE_ID=PROOF_NAME` selects a negative statement
explicitly. Immutable original interfaces and dependencies are checked in both
rounds. A kernel-checked proof of the selected original VC's negation establishes
INVALID for that VC. An execution counterexample also requires evidence
that the failing state is reachable. A checked refutation of a whole Require SAT
goal instead establishes an empty input domain. An unresolved obligation stays
UNKNOWN.
