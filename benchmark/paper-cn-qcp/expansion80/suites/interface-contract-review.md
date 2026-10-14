# GCD and returned sorting-array interface review

Each subject has 128 unique shared inputs and witnessed spec/implementation
mutants. Both CN and QCP use matched executable bodies. Mutations run on every
input, including survivors. This review and the mathematical helper checks are
separate from final held-out admission and C VC proof completion.

## GCD with a concrete abs helper

The paired original precondition excludes INT_MIN for both int32 parameters.
That makes absolute value and signed remainder defined: the INT_MIN/-1 division
exception cannot occur, and recursive arguments stay representable. The
independent oracle is Python's mathematical nonnegative `math.gcd`.

Inputs include (0,0), either argument zero, equal arguments, all four sign
combinations, full-range extremes, seeded values and successive Fibonacci
numbers. The maximum concrete Euclidean recursion is 44 steps, within the
recorded 128-call-depth budget. The spec mutant requires gcd+1; the C mutant
returns zero in the base case. Only (0,0) survives that implementation mutation.

The fixture previously declared abs without a body. Both sources now include
the same standard helper implementation, under the original contract. GCD's
body is unchanged. QCP also declared Zgcd/Zabs without available Rocq bindings;
`gcd_spec.v` now binds them to `Z.gcd` and `Z.abs`. Independent kernel checks
accept those definitions and the zero-base lemma. `theory/GcdRemainder.v`
checks that both Euclidean modulo and C-style signed remainder preserve gcd
for nonzero divisors. These pure proofs have no axioms and are not C proof
completion; receipts are in `evidence/gcd-definition-20261013/`.

The final QCP groups use the explicit definition import. Earlier unbound-symbol
runs are not in the final selected denominator. All final GCD references and
mutants match the native/Fulminate oracle; the three ATP groups remain UNKNOWN.

## Sort returning an array pointer and output length

Inputs own a nonempty int32 array and a distinct writable returnSize cell,
with numsSize<=50000. Initial cell contents are unconstrained by the logical
precondition. The postcondition owns the returned sorted multiset permutation
and sets the length cell to numsSize. The original implementation returns its
actual input-array pointer. Native controls compare pointer identity with the
allocated array, not a symbolic numeric address, and check every array element
and the final length cell on both ABIs.

The spec mutant requires output length numsSize+1 in both languages. The C
mutant sorts in descending order by reversing the insertion comparison;
repeated-value/singleton arrays can survive and are correctly expected PASS.
There are 82 concrete implementation violation witnesses.

CN uses the equivalent adjacent-order and finite-support multiset assertions
already kernel checked in `theory/FiniteMultiset.v`. Both paired C sources use
scoped loop-declaration normalization for the current Fulminate frontend.
The original returned-array ownership and output-length interface are retained.

Fulminate and both native ABIs pass all reference inputs and Fulminate matches
all mutant outcomes. ATP rejects all 128 false-length spec executions. The
reference and implementation groups retain 256 UNKNOWN expected verdicts.
The final evidence is `suites/interface-replay-evidence.json`.
