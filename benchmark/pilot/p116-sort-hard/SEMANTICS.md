# Local semantics supplied with the task

`p116_sort_array` is evaluated under the following deterministic contracts:

- `malloc_int_array_struct()` returns a fresh non-null `IntArray` object.
- `malloc_int_array(n)` returns a fresh non-null writable block of exactly
  `n` integers for every legal `n`.
- `free_int_array(p,n)` deallocates that temporary block.

Consequently, the null-return branches in both implementations are unreachable
on the benchmark domain. Fresh pointer identities are canonicalized, so two
behaviors do not differ merely because allocators chose different numerical
addresses.

QCP heap notation:

- `IntArray::full(arr,n,l)` owns an integer block with contents `l`.
- `data_at(&(p->data),d) * data_at(&(p->size),n)` owns the two fields.
- The separating conjunction `*` means the owned cells/blocks are disjoint.
- The final returned structure, its output array, and preservation of the
  input array are all observable.

The mathematical definitions used by the candidate are in `definitions.v`.
All input values are non-negative and below `INT_MAX`.
