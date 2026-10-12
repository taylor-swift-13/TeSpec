# Require satisfiability

The automatic stage instantiates selected logical inputs and checks Require
before using it as an initial symbolic state. Pointer addresses can remain
symbolic. SAT requires a nonempty represented state class; UNSAT makes the
test FAIL. UNKNOWN permits further proof work but is not evidence of
existence or inconsistency.

For an unresolved positive satisfiability VC, use the complete run-certificate
workflow in [residual-vc.md](residual-vc.md). A proof may construct a mathematical
heap witness internally without adding numerical pointer bindings to the test.
Use the actual selected runtime's typed storage and separation definitions.
Do not assume fields are disjoint, invent layout facts, or assume Require as
a premise of its own satisfiability proof.

For an unresolved initial satisfiability VC, the controller can select a
negative certificate before handing the frozen bundle to the proof Agent:

```bash
python3 -m spectest prepare-run-certificates OUTPUT/report.json \
  --output OUTPUT/refutation --refute-precondition CASE_ID
```

The option is repeatable and is also accepted by `run-agent.sh`. It requires
one original initial-satisfiability goal for each selected case. A disjunction
inside that goal is refuted as a whole; refuting only one alternative is
insufficient. Already negated precondition goals cannot be selected again.
The prepared candidate negates the selected original proposition and retains
the other interface obligations. The Agent must preserve these statements.

The controller runs `check-run-certificates` with its held preparation digest.
An accepted negative initial certificate sets Require to UNSAT and the case to
FAIL, recording `CHECKED_PRECONDITION_REFUTATION`. This establishes an empty
initial domain, not a program execution error. The command exits 1 for FAIL;
inspect the report to distinguish it from a failed certificate. Failed proofs
remain UNKNOWN. Declaration-only cases retain their specification-only scope.

The Agent first assesses each original VC and attempts a positive proof. If it
judges a VC false, it can write `proof-plan.json` with
`{"refute_vcs": {"CASE_ID": "PROOF_NAME"}, "refute_preconditions": ["CASE_ID"]}`.
This plan only selects proof polarity. The controller first checks the positive
attempt, then prepares immutable negative statements for unresolved cases.
A second attempt must prove the original statement's negation. Neither judgement
nor an unsuccessful positive attempt establishes INVALID.

Explicit `--refute-vc CASE_ID=PROOF_NAME` is accepted by the runner and
`prepare-run-certificates`. It freezes one selected original VC; a checked
negative proof sets that VC to INVALID and the case to FAIL, while unrelated
VCs may remain UNKNOWN. A standalone negative certificate reports VC validity
without claiming that a complete execution was checked. Failed attempts remain
UNKNOWN. Entry UNSAT and other VC INVALID remain distinct obligation results.

One proof Agent handles the requested positive and negative candidates; the
external controller handles acceptance. Failed attempts remain UNKNOWN. If
both polarities appear accepted for the same frozen proposition, keep the case
unresolved and investigate dependency consistency and proof scope.

Both execution modes actually execute loops and available function bodies.
They differ in intermediate checking boundaries. A declaration-only target
can perform a Require-only check; success retains `specification-only` scope.
