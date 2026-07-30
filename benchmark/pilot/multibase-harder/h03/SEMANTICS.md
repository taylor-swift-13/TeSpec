# h03 semantic contract

`DLL4QueueHeap::full(queue,nodes,values,stamps,mutations)` owns one non-null
`Queue` and exactly four distinct non-null `DNode` objects.  Each of the three
lists has length four and is indexed in traversal order from `queue->head` to
`queue->tail`.  The first and last links are null, every adjacent `next` and
`previous` link agrees, and `nodes` contains the concrete node addresses.
`values` and `stamps` contain the payloads stored at those same positions.

A post-state occurrence can reorder the owned nodes, but it must describe the
actual order, matching payload order, matching stamps, queue endpoints, every
link, and the mutation counter.  Pointer identity, topology, payloads, stamps,
the counter, and return are all observable.

`QueueArithmeticSafe` guarantees the four-node precondition of both helper
calls, excludes unsigned-counter wrap and signed overflow in the returned
sum, but imposes no ordering on payload values.  The helpers have ordinary C
call semantics.  The list relations are defined in `definitions.v`.
