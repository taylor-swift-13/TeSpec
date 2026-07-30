# p116 sort hard pilot

One held-out-style question derived from CAV `p116_sort_array`. It combines
dynamic allocation, a returned structure, multiple heap blocks, nested loops,
an internal helper, a quantified Coq relation, and a paired sorting mutant.

`gold.json` is evaluator-only. The OpenHands baseline runner copies only the
public files named in `questions.json` into its temporary workspace.
