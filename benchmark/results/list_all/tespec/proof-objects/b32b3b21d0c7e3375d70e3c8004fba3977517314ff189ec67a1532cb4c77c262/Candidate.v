From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Require Import TeSpecLayout_2bd3caf24386db6c22522ec8.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_copy_precondition_wit_1 : Goal.IntList_copy_precondition_wit_1.
Proof.
  unfold Goal.IntList_copy_precondition_wit_1.
  exists (@nil Z), 0.
  intro H.
  apply (H (@ConAssertion.empty_state naive_C_Rules.sts)).
  cbn [sll].
  repeat first
    [ exact (@ConAssertion.empty_state_is_empty naive_C_Rules.sts)
    | split
    | reflexivity ].
Qed.

End Proofs.
