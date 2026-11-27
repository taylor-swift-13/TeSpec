From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_74fb3d745f6d13fbc8497186.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_free_list_precondition_wit_1 : Goal.IntList_free_list_precondition_wit_1.
Proof.
  unfold Goal.IntList_free_list_precondition_wit_1.
  exists (@nil Z), 0.
  intro H.
  apply (H (@ConAssertion.empty_state naive_C_Rules.sts)).
  simpl sll.
  repeat first [exact (@ConAssertion.empty_state_is_empty naive_C_Rules.sts) | reflexivity | split].
Qed.

End Proofs.
