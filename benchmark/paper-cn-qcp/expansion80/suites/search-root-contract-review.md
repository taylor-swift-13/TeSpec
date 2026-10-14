# Search-index, in-place reversal and least-root correspondence

These suites reuse the historical paired C bodies. Reversal and binary search
also preserve the exact original CN/QCP fixtures. Least-root CN uses a recorded,
proved annotation rewrite; the original fixture remains available unchanged.

## Binary search accepts every matching index

The shared precondition owns a sorted int32 array of size n>=0. A valid result
is -1 exactly when the target is absent, or any in-range index containing the
target. Both forms preserve the array. CN's flattened pairwise comparison
covers all i<=j positions (with an empty quantifier at n=0); QCP expresses the
same ordering as a bounded two-variable universal assertion.

The independent Python oracle uses linear membership and lookup; it does not
copy binary-search control flow. Its first-match value is only a representative.
Native controls verify the actual return against membership/range/value and
check the complete final array. Twenty of the 128 reference returns differ
from the representative first index and correctly pass both native ABIs.

Inputs cover empty arrays, duplicates, singletons, mixed signs, int32 extrema,
ascending/random-sorted data and present/absent targets. The spec mutant changes
the -1 branch to require every input value to equal the target. Correct absent
results on nonempty arrays witness its failure; empty and successful searches
survive. The C mutant returns -1 when it finds a target, leaving absent cases
valid. There are 53 spec and 63 implementation violation witnesses.

## In-place array reversal

The precondition owns n>=0 int32 cells; every final element is the corresponding
original reversed element. The independent model uses list reversal. The spec
mutant requires unchanged storage, and the C mutant copies the newly updated
left element onto the right, losing the original left value. Empty, singleton,
uniform and palindromic arrays are surviving cases. Each mutation has 89
concrete violation witnesses among 128 inputs. Every final element is checked.

## Exhaustive finite least-root contents

At a canonical valid owned int32 address, every admitted original cell content
0..100 is tested (101 distinct inputs). This exhausts the logical content
domain, not all physical addresses or complete C executions. The independent
model is ceil(sqrt(n)), calculated with integer isqrt; both return and final
cell must equal it.

QCP retains its original unbounded mathematical least_root relation. CN's
original unbounded assertion is replaced by the equivalent finite predicate:

```
r >= 0 && n <= r*r && (r == 0 || (r-1)*(r-1) < n)
```

The fixture records the exact annotation replacement and the theorem/source
hash; executable code, owned-cell relation and input precondition are preserved.
`least_root_finite_characterization` was compiled and independently kernel
checked again without axioms. The receipt is in
`evidence/root-finite-domain-20261013/`. This pure correspondence is separate
from C execution proof completion.

The spec mutant asks the successor of the actual return to satisfy least_root
in both languages, retaining the actual return/final-cell equality. It fails
on every admitted content. The C mutant writes r+1 but still returns r, also
violating every input's actual postcondition. Both arithmetic operations remain
representable (root<=10 and mutant write<=11).

## Current outcomes

Both native ABIs and Fulminate pass every original input; Fulminate matches
all mutant witness and survivor expectations. ATP matches every reversal
outcome. Search has 384 UNKNOWN results because its precondition requires
proof, even though execution completes. Least-root preconditions are SAT:
101 original and 101 false-spec results retain unresolved VCs, while all 101
incorrect-write executions are FAIL. All final groups have zero false passes
and zero missing results. The selected evidence is
`suites/search-root-replay-evidence.json` with 586 UNKNOWN strong mismatches.
