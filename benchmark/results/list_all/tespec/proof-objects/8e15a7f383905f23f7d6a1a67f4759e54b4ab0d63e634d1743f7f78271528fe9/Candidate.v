From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_cons_precondition_wit_1 : Goal.IntList_cons_precondition_wit_1.
Proof.
  unfold Goal.IntList_cons_precondition_wit_1.
  exists (@nil Z), 7, 7, 0.
  intro H.
  cbv in H.
  eapply H.
  repeat split; intros; reflexivity.
Qed.

End Proofs.
