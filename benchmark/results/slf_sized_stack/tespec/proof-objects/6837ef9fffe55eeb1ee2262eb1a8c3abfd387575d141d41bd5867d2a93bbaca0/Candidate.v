From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_cons_precondition_wit_1 : Goal.IntList_cons_precondition_wit_1.
Proof.
  unfold Goal.IntList_cons_precondition_wit_1.
  exists (cons 1 (@nil Z)).
  exists INT_MIN.
  exists INT_MIN.
  exists 8192.
  (* Unresolved: construct a concrete state satisfying sll 8192 [1],
     with data 1 at 8192 and next pointer 0 at 8196, then use that
     state to contradict the entailment to False. *)
Abort.

End Proofs.
