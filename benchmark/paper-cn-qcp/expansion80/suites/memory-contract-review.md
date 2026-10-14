# Indexed reads and owned-cell/byte-block correspondence

The five subjects have matched C bodies after removing annotations and ABI
includes. All spec mutations retain the C body; all implementation mutations
retain the original annotations. Native controls check full final memory and
return values. Mutation expectations use each original or mutated contract.

| Subject | Shared original pre/postcondition | Spec mutation | Implementation mutation |
|---|---|---|---|
| cn_double_it | Own uint32 P at p; 2P<=UINT_MAX; return=2P and preserve P | require return=2P+1 | return P |
| cn_five_six | Own two separate uint32 cells; return=5 and retain ownership with unconstrained final values | require return=6 | return *q after writing q=6 |
| cn_array_load2 | Own n int32 cells; 0<=i<n; preserve full array and return its original element i | require element i+1 as return | read element n-1 |
| cn_array_read_two | Own n uint32 cells; i/j in range, i!=j, mathematical A[i]+A[j]<=UINT_MAX; preserve array and return the sum | require sum+1 | return only the first loaded element |
| qcp_chars_initialize | Own a writable n-byte block, n>=0 and n<INT_MAX; every final signed-char byte equals m | every byte must equal mathematical m+1 | write zero instead of m |

CN `RW` cells correspond to the QCP `data_at` resources. CN indexed `each`
resources correspond to full QCP array predicates with a list of exactly n
values. CN `W<char>` corresponds to the QCP undefined-byte-array resource;
there is no logical initial list binder in the byte initialization test.
Byte-suite uniqueness is counted by address, length and write value; changes
in unbound initial backing bytes alone do not create additional paired inputs.
The native driver's initialized backing bytes are merely concrete storage:
reference code writes every element and never relies on the initial values.
An n=0 block owns no elements and both final elementwise predicates are true.

`five_six` intentionally lacks an exact final-value contract. Its Python
reference model checks the actual writes to 5/6, while mutation labelling checks
the specified return and retained ownership. Both pointers point to distinct
valid cells throughout native replay; the C mutant changes only the return.

Signed-char fixtures compile with `-fsigned-char`. Preparation explicitly
includes m=-128 and m=127 in empty, singleton and 16-byte blocks, plus control
bytes, arbitrary signed values and mixed initial storage. The mathematical
spec mutation m+1 may equal 128; this is a false postcondition on a nonempty
signed-char block, not a request to execute an out-of-range C addition.
Unsigned arrays include UINT_MAX with a zero partner, repeated values and
admitted mixed sums. Indexed-read mutations that happen to return the same
value survive and expect PASS. All mutations run on the full positive-input
suite, including such survivors.

These are correspondence and input-domain checks. Full held-out admission and
ATP/ITP proof completion are tracked separately in `coverage-status.json`.
