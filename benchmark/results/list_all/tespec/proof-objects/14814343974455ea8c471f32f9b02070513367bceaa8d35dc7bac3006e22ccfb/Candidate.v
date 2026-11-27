From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Require Import TeSpecLayout_17cfb40defe94e3d4b7fa3ed.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_length_precondition_wit_1 : Goal.IntList_length_precondition_wit_1.
Proof.
  unfold Goal.IntList_length_precondition_wit_1.
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
