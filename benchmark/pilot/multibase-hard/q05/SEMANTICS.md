# q05 semantic contract

`DLL2Heap::full(head, tail, h0, h1, hd, t0, t1, td)` owns exactly two
distinct non-null `DNode` objects:

- `head->previous` is null and `head->following` is `tail`;
- `tail->previous` is `head` and `tail->following` is null;
- the head payload is `readings = [h0,h1]`, `delta = hd`;
- the tail payload is `readings = [t0,t1]`, `delta = td`.

A post-state occurrence requires the same two node addresses and the same
topology.  Its scalar arguments give the post-state payload cells.  Thus the
predicate permits a payload change only where its arguments change.

`TwoNodeArithmeticSafe` excludes all signed overflow in the additions executed
by either program and in the arithmetic expressions of the candidate.  It
places no parity restriction on inputs.  Function-local variables are not
observable.  Return values, both nodes, their links, and every payload cell are
observable.

The helper call has ordinary C call semantics and updates the supplied
payload's first reading.  The Coq definition in `definitions.v` supplies the
pure predicate used by the candidate.
