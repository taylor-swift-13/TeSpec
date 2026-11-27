From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_IntList_cons_precondition_wit_1 : Goal.IntList_cons_precondition_wit_1.
Proof.
  unfold Goal.IntList_cons_precondition_wit_1.
  exists (@nil Z), 7%Z, 7%Z, 0%Z.
  intro H.
  assert (Hem : emp (@ConAssertion.empty_state naive_C_Rules.sts)).
  { exact (@ConAssertion.empty_state_is_empty naive_C_Rules.sts). }
  apply (H (@ConAssertion.empty_state naive_C_Rules.sts)).
  cbn [sll].
  repeat first [exact Hem | reflexivity | split].
Qed.

End Proofs.
