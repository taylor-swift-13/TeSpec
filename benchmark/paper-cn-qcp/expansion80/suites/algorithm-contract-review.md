# Sum, insertion-sort and sorted-merge correspondence

All reference C bodies are preserved. CN and QCP variants have matched bodies;
spec mutants preserve executable code, and implementation mutants preserve
all annotations. The three suites contain 128 unique paired inputs each.

| Subject | Shared contract | Spec mutation | Implementation mutation |
|---|---|---|---|
| cav_array_sum | Own/preserve n int32 cells; 0<=n<=10000 and every element in [-10000,10000]; return the mathematical sum | require sum+1 | subtract each element |
| cav_insertion_sort | Own n int32 cells; final array is nondecreasing and has the same element multiplicities | require the array to remain unchanged | reverse the insertion comparison |
| cav_merge_sorted_arrays | Own three separate arrays of lengths n,m,n+m; the input arrays are sorted and preserved; output is their sorted union with multiplicity | require output to retain its original values | choose the larger head in the merge comparison |

Sum admission bounds every intermediate partial sum by 100,000,000 in
absolute value, ensuring both original addition and mutated subtraction stay
in signed int32. Inputs include empty arrays, repeated/cancelling sums,
element extrema and seeded mixed values. Sorting inputs cover empty/singleton,
repeated values, signed int32 extrema, ascending/descending and arbitrary data.
Merge has both one-sided empty inputs, duplicates across inputs, mixed unequal
lengths, arbitrary initialized output storage and preserved source buffers.

The previous CN ordering syntax nested `each` assertions and was rejected by
the parser. Adjacent comparisons use one bounded `each`; their equivalence to
pairwise ordering follows transitivity of integer order. The upper bound is
written `i < length-1`, which the bound extractor accepts. C bodies and admitted
input domains are unchanged.

The previous CN multiplicity syntax enumerated all int32 values. The finite
monitor checks counts at every input and output element instead. Values absent
from both arrays have zero count, so this finite support check is equivalent
to the universal count relation. Both input and output support are checked;
no assumption about which values a mutant may produce is made.

The supplied `insertion_sort.v` defines the missing original relation as
permutation and strong nondecreasing order. `merge_sorted_arrays.v` defines an
independent pure merge and proves length, permutation and sortedness. The
`MergeContract.v` theorem proves that its result equals exactly the sorted
multiset union, establishing the intended CN/QCP correspondence. The theory
and definitions passed standalone `coqc` and independent `coqchk`, without
axioms; receipts are in `evidence/algorithm-contract-theory-20261013/`.
These mathematical results do not discharge C execution VCs.

Mutation expectations are evaluated from the actual contracts. Unchanged
sorting on already sorted inputs is a surviving spec mutation, as is unchanged
merge output when it already equals the correct result. Descending output is
not rejected when repeated values also make it nondecreasing. Counter-based
Python multiset checks and complete native final-array controls provide
independent concrete violation witnesses.

All final native ABI and Fulminate outcomes match the independent expectations.
teSpec ATP matches the sum suite; sorting and merge retain 694 UNKNOWN
expected-verdict mismatches. Earlier parser/bound-extractor failures are
excluded from final selected tool groups and remain in external raw reports.
