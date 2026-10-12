# ITP replay with QCP's original list definitions and strategies

This audit uses the paired two-node list inputs, the original
`SimpleC.EE.QCP_demos_human.sll_lib` module, and the shipped `sll.strategies`.
It changes neither the predicate nor the strategies. The logical input is
`xs = [1,2]`; pointer addresses remain symbolic.

`CandidateValid.v` proves eleven safety obligations and the original
`sample_return_wit_3`. For the latter, unfolding `sll 0 [1,2]` in Rocq exposes
`0 <> 0`, eliminating the null-head branch. These twelve selected proofs do
not establish a complete PASS: the generated interface has sixteen obligations.

`CandidateWrongPost.v` refutes the original `sample_return_wit_1`, including
both sides of its disjunction. It constructs a logical heap and derives the
contradiction `2 = 3`. This establishes an invalid VC. An execution FAIL also
requires a reachable witness from the original precondition; that evidence
is not provided by this certificate.

The original strategy can weaken a symbolic state when it unfolds a
predicate. Such weakening is sound for a positive proof, but its reverse
direction does not establish execution reachability. The run-certificate
controller therefore records `VC_REFUTED` separately and retains UNKNOWN
without a reachability certificate.

Replay both proof attempts, assumption audits, and independent kernel checks:

```sh
python3 scripts/replay-list-itp-audit.py --output /tmp/list-itp-original-replay
```

The replay compiles the original runtime module in an isolated copy. It pins
the generated obligations before allowing edits to `Candidate.v`. No layout
re-elaboration or custom unfolding rule is used. `evidence/summary.json`
records the completed checks and distinguishes proof coverage from the
execution verdict.
