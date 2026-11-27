From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_copy_precondition_wit_1 : Goal.IntList_copy_precondition_wit_1.
Proof.
  unfold Goal.IntList_copy_precondition_wit_1.
  exists (@nil Z), 0.
  intro H.
  cbv in H.
  eapply H;
    repeat split;
    try reflexivity;
    try discriminate;
    try congruence;
    auto.
Qed.

End Proofs.
