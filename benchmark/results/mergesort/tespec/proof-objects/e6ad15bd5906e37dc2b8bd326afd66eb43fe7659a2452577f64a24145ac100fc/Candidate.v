From SimpleC.Verification Require Import VCPrelude.
Require Import Goal FulminateMerge.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_mergesort_return_wit_1 : Goal.IntList_mergesort_return_wit_1.
Proof.
  unfold Goal.IntList_mergesort_return_wit_1.
  left.
  intros l xs y y2 rs rf r2 r3 r
    H1 H2 H3 H4 H5 H6 H7 H8 H9 H10 H11 H12 H13 H14 H15 H16 H17 H18.
  subst l.
  rewrite <- cn_mergesort_split.
  entailer!.
Qed.

Lemma proof_of_IntList_mergesort_precondition_wit_1 : Goal.IntList_mergesort_precondition_wit_1.
Proof.
Abort.

End Proofs.
