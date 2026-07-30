# q04 semantic contract

`ByteStructHeap::full(state, bytes, old_checksum)` owns one non-null
`ChecksumState`, the complete `len`-element byte array reached through `pkv`,
and no other memory.  It means:

- `state->len` is the mathematical length of `bytes`;
- the array cells equal `bytes` in order;
- `state->chksum` equals `old_checksum`;
- `state`, `pkv`, `len`, and all byte-array cells are observable.

In a post-state occurrence, the first two arguments identify the same struct
and the same unchanged byte sequence; only the checksum argument may differ.
`AllBytes` gives each input element its ordinary unsigned-byte range.

Both programs use standard C unsigned arithmetic.  Assignment to `u8` reduces
the value modulo 256.  The input domain contains every finite byte sequence
whose length is representable by `u32`; loop execution is terminating and
memory-safe.  Ignore resource limits and compare mathematical behavior on this
domain.

The Coq definitions in `definitions.v` define the pure predicates used by the
candidate.  All owned fields and cells described above are observable when
deciding whether the two programs diverge.
