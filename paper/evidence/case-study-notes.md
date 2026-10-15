# Case-study evidence and claim scope

This revision reads existing evidence and changes only the paper. No new benchmark,
compiler, solver, or proof-agent run is reported. `case-study-audit.json` pins 99
files; the build verifies those hashes and the declared controls.

## Read negation: recorded missed violation

- Variant: `constructed:case_0b5de543ec816188`.
- Paired source: `benchmark/programs/read/variants/constructed_case_0b5de543ec816188/`.
- Contract: own an int cell, preserve its value and ownership, return the old value.
- Body: `return -*p;`.
- Input: `value_0`, old = -2147483648, QCP address = 4096; the native harness
  initializes an owned local int cell with `(-2147483647-1)`.
- Raw evidence: `benchmark/results/read/20261015-variants/results.json` and
  `constructed_case_0b5de543ec816188/value_0/` below the same directory.
- Fulminate: `cn instrument --run --cc=/usr/bin/gcc`; pipeline exit 0, generated
  executable exit 0, empty executable stdout/stderr. The pipeline warns only
  that `Owned` is deprecated. The receipt does not expose the complete internal
  GCC invocation or a native return-value trace.
- TeSpec: entry SAT, invalid arithmetic-safety VC, FAIL; solver evidence is
  `NOT_CHECKED`, not an independent kernel certificate.
- Controls: both accept 0; both reject -1, 1, 7 and INT_MAX. The correct read
  implementation accepts INT_MIN.

The mathematical negation 2147483648 is outside the target signed-int range.
C11 draft N1570, 6.5 paragraph 5 supplies the language-semantics basis for the
unsafe-execution label. The observed claim is a missed violation in this recorded
runtime configuration. The paper does not claim a measured native wrapped return,
universal Fulminate unsoundness, or that adding sanitizers would leave the result
unchanged. The evaluation protocol retains a separate sanitizer configuration.

## Quantified least-root and divisibility

Receipts are in `comparative-case-studies-20261013/evidence/least-root-20261013/`
and `comparative-case-studies-20261013/case-studies/divisibility/`.
The least-root postcondition-only replay checks 26 obligations. The distinct
intermediate-observation archive has 27 obligations; its negative receipt checks
a VC refutation without a full admitted execution-counterexample certificate.
Divisibility (6,3) and (7,3) are both positive conformance tests, with six original
obligations each. These certificates use the recorded runtime interpretation;
no claim of axiom-free complete C verification is made. The separate finite-form
equivalence lemma has its own assumption audit.

Instrumentation rejects the original unbounded formulations with quantifier-bound
inference diagnostics. The finite controls pass. These are assertion-support
limitations, not false acceptances or failures of the C inputs themselves.

## Read spatial controls

`benchmark/results/read/20261015-spatial-smt/statistics.json` records the paired
61-case OFF/ON run. Twelve UNKNOWN cases (two missing-ownership variants, six
inputs each) become FAIL with spatial SMT; 49 raw classifications are unchanged.
All 22 positive cases remain accepted. Independent per-execution ITP receipts
and proof files are in `benchmark/results/read/20261015-itp-per-execution/`.
The automatic SMT result retains its own evidence status, even where it agrees
with an existing kernel-checked refutation. Fulminate also detects these defects.

Only one actual false acceptance is established in these selected comparisons.
No additional runtime false acceptance is inferred from an instrumentation error,
a proof timeout, a native allocator probe, or an unfinished baseline experiment.
