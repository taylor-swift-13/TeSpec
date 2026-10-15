# An original mathematical postcondition: least integer square root

The existing `control_unbounded_root` subject computes the least nonnegative
integer whose square is at least the input, writes it into its owned cell and
returns it. The shared functional contract is:

```
0 <= r /\ forall k : Z, 0 <= k -> (r <= k <-> n <= k*k)
```

The quantifier ranges over all nonnegative mathematical integers, even though
the concrete test supplies `n = 13`. Its expected return and final cell value
are both 4. The original CN assertion is:

```
each(integer k; 0 <= k) {(return <= k) == (x <= k*k)};
```

The QCP contract imports `least_root`, with the same quantified definition.
Execution visits four loop iterations and five invariant states. The ITP
certificate covers the complete 26-VC return-contract group, including entry
and safety obligations. Intermediate-assertion proof coverage is not recorded
by this receipt.

## Fresh evidence on 2026-10-13

| Configuration | Outcome |
|---|---|
| Fulminate, original CN assertion | Instrumentation rejected: `Cannot infer upper bound for permission` |
| teSpec, ATP only | UNKNOWN |
| teSpec, complete ITP certificate | PASS; `coqchk` accepted the complete original VC group |
| Fulminate, equivalent finite arithmetic assertion | Instrumentation, compilation and execution succeeded |

The executable alternative is:

```
0 <= r /\ n <= r*r /\ (r = 0 \/ (r-1)*(r-1) < n)
```

`paper/theory/LeastRootRewrite.v` proves the equivalence over mathematical
integers. Thus the demonstrated benefit is verifying the original quantified
specification without first deriving and implementing its finite monitor.
Fulminate can check the rewritten specification. This example does not claim
that integer square-root correctness is impossible to check at runtime.

The packaged executor used here has SHA-256
`4b6a46f38aafbac9f9de679133c69a22aac1f6eb7c634dcc1de7ddca211a32cc`.
The certificate's sole audited assumption is the existing QCP address
interpretation parameter `SimpleC.SL.CNotation.eval_addr_expr`.

Sources and proofs are in `benchmark/comparison/proof-oriented/least-root/`.
Fresh raw reports, compressed diagnostics, full kernel replay log and hashes
are in [`evidence/least-root-20261013/`](evidence/least-root-20261013/).
This is one concrete test and a reused archived proof checked against freshly
generated VCs; it is not a universal program-verification or proof-search
performance result.

Reproduce from the teSpec repository:

```sh
python3 scripts/run-cn-assertion-variants.py \
  benchmark/comparison/proof-oriented/least-root/subject.cn.c \
  benchmark/comparison/proof-oriented/least-root/subject.finite.cn.c \
  --output /tmp/least-root-cn-fresh --timeout 60
python3 scripts/replay-certificate-case.py \
  --case benchmark/comparison/proof-oriented/least-root \
  --output /tmp/least-root-proof-fresh --run-level --timeout 300
```
