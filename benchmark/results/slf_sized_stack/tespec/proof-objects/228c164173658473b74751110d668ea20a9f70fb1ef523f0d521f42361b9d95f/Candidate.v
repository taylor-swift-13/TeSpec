From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_push_precondition_wit_1 : Goal.push_precondition_wit_1.
Proof.
  unfold Goal.push_precondition_wit_1.
  exists (@nil Z), 7, 0, 4096, 7.
  (* Unresolved: construct a concrete heap satisfying the two disjoint
     four-byte stores at addresses 4096 and 4100, both containing zero. *)
Abort.

End Proofs.
