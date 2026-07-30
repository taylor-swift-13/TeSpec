# Local semantics

`BundleHeap::full_two_single_two_double(b,m)` precisely owns one `bundle`, a
two-node null-terminated singly-linked list, and a two-node null-terminated
doubly-linked list with correct `previous` links. The twelve scalar fields in
`BundleModel` are exactly their two totals, two lanes and tag per node.
Pointer topology, all second lanes, and all tags are observable.

The candidate definition in `definitions.v` is functional: for fixed
`pre,sd,dd` it determines all modified fields and the return. Arithmetic is
mathematical because the domain excludes machine overflow.
