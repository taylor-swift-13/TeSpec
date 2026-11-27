From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_rev_loop_entail_wit_1 : Goal.IntList_rev_loop_entail_wit_1.
Proof.
  unfold Goal.IntList_rev_loop_entail_wit_1.
  left.
  intros y y_2 PreH1 PreH2.
  Exists (@nil Z) (cons (-1) (cons 2 (@nil Z))).
  simpl sll.
  Exists 8192 0.
  entailer!.
Qed.

Lemma proof_of_IntList_rev_loop_entail_wit_2 : Goal.IntList_rev_loop_entail_wit_2.
Proof. Abort.

Lemma proof_of_IntList_rev_loop_return_wit_2 : Goal.IntList_rev_loop_return_wit_2.
Proof. Abort.

Lemma proof_of_IntList_rev_loop_precondition_wit_1 : Goal.IntList_rev_loop_precondition_wit_1.
Proof. Abort.

End Proofs.
