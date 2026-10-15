Require Import Coq.ZArith.ZArith Coq.micromega.Lia.
Local Open Scope Z_scope.

Definition byte_range (start finish address : Z) : Prop := start <= address < finish.
Definition disjoint_byte_ranges (start1 finish1 start2 finish2 : Z) : Prop :=
  forall address, byte_range start1 finish1 address ->
                  byte_range start2 finish2 address -> False.

Theorem shared_byte_refutes_separation : forall start1 finish1 start2 finish2 address,
  byte_range start1 finish1 address -> byte_range start2 finish2 address ->
  ~ disjoint_byte_ranges start1 finish1 start2 finish2.
Proof. intros s1 e1 s2 e2 a H1 H2 Hdisjoint. exact (Hdisjoint a H1 H2). Qed.

(* A larger allocator block's zero-part owns every tail byte after its
   own list header. A separately owned tail-page header owns its first byte. *)
Theorem subsumed_header_overlaps_parent_zero_part : forall root child block_bytes header_bytes,
  0 < header_bytes -> root + header_bytes <= child -> child < root + block_bytes ->
  ~ disjoint_byte_ranges (root + header_bytes) (root + block_bytes)
                          child (child + header_bytes).
Proof.
  intros root child block_bytes header_bytes Hsize Hlower Hupper.
  apply (shared_byte_refutes_separation _ _ _ _ child); unfold byte_range; lia.
Qed.

Definition original_root_guard (refs order : Z) : Prop := refs = 0 /\ order <> 255.
Definition removed_order_guard (refs : Z) : Prop := refs = 0.

Theorem removed_guard_includes_subsumed_page :
  removed_order_guard 0 /\ ~ original_root_guard 0 255.
Proof. unfold removed_order_guard, original_root_guard. intuition congruence. Qed.

(* Exact cast/shift behaviour of the invalid order is unnecessary here:
   AllocatorPage separately requires the list header regardless of ZeroPart. *)
Print Assumptions subsumed_header_overlaps_parent_zero_part.
Print Assumptions removed_guard_includes_subsumed_page.
