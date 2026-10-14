# Finite executable multiset checks

`FiniteMultiset.v` proves that count equality on both lists' finite supports is
equivalent to count equality over all mathematical integers and to permutation.
It also proves uniqueness of a nondecreasing permutation and equivalence of
adjacent and pairwise order. No bounded sampling of the value domain is used.

`MergeContract.v`, using the supplied pure merge definition, proves exact
correspondence between the QCP merge function and CN's sorted multiset-union
postcondition on sorted inputs. The original executable bodies are untouched.

The compile and independent kernel replay receipt is in
`../evidence/algorithm-contract-theory-20261013/receipt.json`; these are pure
contract theorems, separate from C execution VC completion.

From this expansion directory, using the installed Rocq 8.20 switch:

```sh
coqc theory/FiniteMultiset.v
coqc paired-drafts/cav_insertion_sort/insertion_sort.v
coqc paired-drafts/cav_merge_sorted_arrays/merge_sorted_arrays.v
coqc -Q theory '' -Q paired-drafts/cav_merge_sorted_arrays '' theory/MergeContract.v
coqchk -Q theory '' -Q paired-drafts/cav_insertion_sort '' \
  -Q paired-drafts/cav_merge_sorted_arrays '' \
  FiniteMultiset insertion_sort merge_sorted_arrays MergeContract
```
