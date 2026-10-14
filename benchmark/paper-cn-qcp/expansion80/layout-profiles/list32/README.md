# Explicit 32-bit list representation

This experimental profile replaces the abstract field-address list predicate
with `sll32`, whose data and next resources use offsets 0 and 4. It preserves
the original C bodies, input bindings and mathematical list contracts. A native
GCC probe checks the structure sizes and offsets before preparing the profile.
It does not change the official suites or their archived ATP counts.

```sh
python3 prepare-profile.py --case qcp_list_reverse --input-ids input_001 \
  --output /tmp/list32-reverse
```

`ListLayoutDiagnostics32.v` explains the original representation gap: coincident
data/next field addresses make a nonempty list impossible. It also proves the
singleton correspondence under explicit offset hypotheses.
`ListLayoutModel32.v` proves correspondence for arbitrary list lengths under
those hypotheses. Neither proof adds field-layout axioms to the original
runtime. The new runtime module supplies explicit definitions for lists and
segments; the original `sll_lib` remains unchanged.

The QCP byte encoding is big endian; the native probe establishes structure
layout, not byte-for-byte heap equivalence. Full admission also requires a
representation correspondence between CN and QCP ownership semantics.

The single-node prototype uses `INT_MIN` and a NULL next pointer. Its reference
implementation has four checked original VCs, including an explicit heap
witness for entry SAT. The implementation mutation adds a harmless operation
on this input and has five checked original VCs: it is a contract survivor and
must PASS. The specification mutation appends a nonexistent list element.
Its complete return VC is a disjunction; refuting a split subgoal alone is
insufficient. The negative certificate constructs a concrete source heap and
reads its NULL pointer bytes to refute both branches of the complete VC.

Refuting a path VC does not by itself certify an execution counterexample from
the original entry state. The result controller retains UNKNOWN until that
reachability evidence is checked. Positive and negative certificate results
are separate from full-suite admission and end-to-end strong-negative success.

## Generate entry satisfiability proofs

`SparseByteWitness.v` constructs a heap for any finite set of distinct byte
addresses. It supports gaps between nodes and arbitrary address order.
`DistinctAddressCheck.v` proves that a computational uniqueness check implies
`NoDup`; checking large graphs does not require expanding a propositional case
tree. Both are generic proofs independent of function names and input IDs.

`prepare-entry-proof.py` reads an original report and its suite, checks exact
argument/value bindings, traverses each owned list, rejects cycles, shared or
unaccounted nodes and overlapping byte addresses, and emits a selected entry
SAT certificate. It supports multiple disjoint list heads and empty lists.
The certificate still needs `spectest check-certificate`; it assigns no
execution verdict and proves no safety or return VC.

`run-profile.py` runs all original bindings for each requested subject and all
three variants. Reports record actual tool outcomes; mutation labels do not
determine those outcomes. These experimental runs keep their own denominator.
