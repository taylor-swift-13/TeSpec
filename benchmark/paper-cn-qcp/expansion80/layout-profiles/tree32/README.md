# Explicit ABI32 tree profile

`prepare-profile.py` prepares all 128 original `control_tree_size` bindings and
its reference, specification mutation and implementation mutation. It checks
that the C bodies are unchanged and probes the actual GCC 32-bit layout:
16-byte nodes with key, value, left and right at offsets 0, 4, 8 and 12.

`TreeLayout32.v` preserves the original tree datatype and `TreeMeasure.v`
function, including the original key range and non-NULL node condition. Its
correspondence theorem is conditional on those four field offsets. The
conditions are explicit theorem arguments, not added field-layout axioms.
The profile keeps the original 0–100 node domain and does not impose BST order.

The unfolding strategies preserve the node's pointer guard and key bounds,
then expose both child trees and all four fields. The cancellation rule keeps
the original tree strategy's equality obligation.

This profile is experimental. Native layout, a conditional representation
proof and automatic execution results are separate gates; none establishes
complete CN/QCP admission alone.

Compile auxiliary libraries into an isolated directory while certificate
checks are running. The certificate controller pins both runtime `.v` and
`.vo` files, so adding a compiled library to the shared runtime changes its
hash even when its source is unchanged.
