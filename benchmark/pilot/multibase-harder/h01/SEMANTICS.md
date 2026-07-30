# h01 semantic contract

`BinaryJobHeap::full(job,left,right,scratch,output,output_len)` owns the
non-null `BinaryJob`, both complete read-only input arrays, and both complete
mutable buffers.  `left` and `right` are the input sequences in most-
significant-bit-first order.  `scratch` and `output` denote their complete
capacity-sized buffers, not merely initialized prefixes.  The scalar fields
equal the corresponding logical lengths, common capacity, and `output_len`.

All four buffers and the job object are pairwise disjoint.  A post-state
occurrence fixes the same job and buffer addresses, preserves both inputs and
capacity, and exposes every buffer byte and scalar field.  `Prefix` relates a
meaningful result sequence to the beginning of the complete output buffer.
Unconstrained buffer suffixes remain observable but are identical between the
two implementations whenever their meaningful result is identical.

`BinaryJobCapacitySafe` requires nonempty canonical inputs, capacity at least
`max(left_len,right_len)+1`, lengths and the return within `int`, and all
address arithmetic valid.  The helpers have ordinary C call semantics.
`definitions.v` supplies the pure predicates used by the candidate.
