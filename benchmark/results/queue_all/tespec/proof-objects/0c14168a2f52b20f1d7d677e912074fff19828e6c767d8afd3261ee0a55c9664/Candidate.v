From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_push_induction_precondition_wit_1 : Goal.push_induction_precondition_wit_1.
Proof.
  unfold Goal.push_induction_precondition_wit_1.
  exists (@nil Z), 16384, 7, 12288, 12288.
  (* Unresolved: exhibit a concrete state satisfying the separated
     Int field at 12288 and Ptr field at 12292, then use that state
     to contradict the assumed entailment to False. *)
Abort.

End Proofs.
