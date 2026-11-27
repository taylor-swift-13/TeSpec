From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_push_precondition_wit_1 : Goal.push_precondition_wit_1.
Proof.
  unfold Goal.push_precondition_wit_1.
  exists (@nil Z), 7%Z, 0%Z, 4096%Z, 7%Z.
  (* Unresolved: construct a concrete heap containing disjoint UInt and Ptr
     cells at addresses 4096 and 4100, both storing zero. The assertion
     contains these cells, so the empty-state helper does not apply. *)
Abort.

End Proofs.
