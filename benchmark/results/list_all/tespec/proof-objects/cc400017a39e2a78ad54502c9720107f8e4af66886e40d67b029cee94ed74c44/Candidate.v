From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_IntList_cons_precondition_wit_1 : Goal.IntList_cons_precondition_wit_1.
Proof.
  unfold Goal.IntList_cons_precondition_wit_1.
  exists (cons 1 (@nil Z)), INT_MIN, INT_MIN, 8192.
  (* Unresolved: construct a concrete nonempty heap satisfying
     sll 8192 [1], then use it to contradict the entailment to False. *)
Abort.

End Proofs.
