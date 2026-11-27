From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_cons_return_wit_1 : Goal.IntList_cons_return_wit_1.
Proof.
  unfold Goal.IntList_cons_return_wit_1.
  right.
  intros.
  subst l___tespec_entry.
  subst y_3.
  subst t_pre.
  cbn [sll].
  Exists y y_2 0.
  entailer!.
Qed.

Lemma proof_of_IntList_cons_precondition_wit_1 : Goal.IntList_cons_precondition_wit_1.
Proof.
Abort.

End Proofs.
