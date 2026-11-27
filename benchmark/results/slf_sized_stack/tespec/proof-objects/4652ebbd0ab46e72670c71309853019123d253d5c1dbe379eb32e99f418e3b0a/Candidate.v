From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_sizeOf_precondition_wit_1 : Goal.sizeOf_precondition_wit_1.
Proof.
  unfold Goal.sizeOf_precondition_wit_1.
  exists (@nil Z), 0, 4096.
  (* Unresolved: construct a concrete heap containing disjoint UInt and Ptr
     cells at addresses 4096 and 4100, both storing zero, and an empty
     list segment. The empty state cannot satisfy these points-to cells. *)
Abort.

End Proofs.
