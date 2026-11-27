From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_mergesort_return_wit_1 : Goal.IntList_mergesort_return_wit_1.
Proof.
  unfold Goal.IntList_mergesort_return_wit_1.
  right.
  intros l xs y Hy Hy' Hxs Haddr Hl.
  subst l.
  rewrite cn_mergesort_equation.
  entailer!.
Qed.

Lemma proof_of_IntList_mergesort_precondition_wit_1 : Goal.IntList_mergesort_precondition_wit_1.
Proof.
Abort.

End Proofs.
