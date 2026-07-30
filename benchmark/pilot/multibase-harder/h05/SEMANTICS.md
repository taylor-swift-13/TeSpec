# h05 semantic contract

`MergeHeap::split(context,left_items,right_items,old_trace,old_used)` owns one
non-null `MergeContext`, two disjoint acyclic null-terminated input lists, all
their `Item` nodes, and the complete trace buffer.  Each `ItemModel` contains
the key, both payload lanes, origin, and serial of one node in traversal order.
`context->merged` is initially null.  The trace list denotes the meaningful
prefix of length `old_used`.

`MergeHeap::joined(context,merged_items,trace_after)` owns the same context,
same trace buffer, and exactly the same set of node addresses, now reachable
as one null-terminated list from `merged`; both input heads are null.  It
describes the actual traversal-order item models and the meaningful trace
prefix of length `context->used`.  The abstraction deliberately does not pair
a trace bit with a particular node.  All node identities, links, fields,
context fields, trace bytes, and return values remain observable.

`MergeCapacityAndArithmeticSafe` gives enough trace capacity, finite disjoint
lists, and excludes signed overflow in the key sum and address/counter wrap.
It does not require keys from different lists to be distinct.  Input lists are
sorted by `item_key`; origins are zero or one.  The helper calls have ordinary
C semantics.  `definitions.v` defines the pure relations used by the
candidate.
