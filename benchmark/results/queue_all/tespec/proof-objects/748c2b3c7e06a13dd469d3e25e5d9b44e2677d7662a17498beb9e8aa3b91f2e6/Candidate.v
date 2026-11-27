From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_push_induction_precondition_wit_1 : Goal.push_induction_precondition_wit_1.
Proof.
  unfold Goal.push_induction_precondition_wit_1.
  exists (@nil Z), 16384, 7, 12288, 12288.
  (* Unresolved: establish satisfiability using disjoint concrete storage
     for the Int at 12288 holding 7 and Ptr at 12292 holding 16384.
     The concrete empty state does not satisfy this assertion. *)
Abort.

End Proofs.
