From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_push_induction_precondition_wit_1 : Goal.push_induction_precondition_wit_1.
Proof.
  unfold Goal.push_induction_precondition_wit_1.
  exists (@nil Z), 16384, 7, 12288, 12288.
  (* Unresolved: construct a concrete model containing the disjoint
     Int cell at 12288 storing 7 and Ptr cell at 12292 storing 16384.
     The empty model does not satisfy these spatial assertions. *)
Abort.

End Proofs.
