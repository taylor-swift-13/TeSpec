From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.

Module Proofs.

Lemma proof_of_IntList_cons_precondition_wit_1 : Goal.IntList_cons_precondition_wit_1.
Proof.
  unfold Goal.IntList_cons_precondition_wit_1.
  exists (nil : list Z), 7%Z, 7%Z, 0%Z.
  intro H.
  cbv in H.
  eapply H; repeat split; reflexivity.
Qed.

End Proofs.
