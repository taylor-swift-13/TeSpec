From Coq Require Import ZArith List Lia Classes.RelationClasses Sorting.Permutation Sorting.Sorted.
Import ListNotations.
Definition finite_counts (a b : list Z) : Prop :=
  (forall v, In v a -> count_occ Z.eq_dec a v = count_occ Z.eq_dec b v) /\
  (forall v, In v b -> count_occ Z.eq_dec a v = count_occ Z.eq_dec b v).
Theorem finite_counts_iff_universal a b :
  finite_counts a b <-> forall v, count_occ Z.eq_dec a v = count_occ Z.eq_dec b v.
Proof.
  split.
  - intros [Ha Hb] v.
    destruct (in_dec Z.eq_dec v a) as [Hin|Hna]; [now apply Ha|].
    destruct (in_dec Z.eq_dec v b) as [Hin|Hnb]; [now apply Hb|].
    apply (proj1 (count_occ_not_In Z.eq_dec a v)) in Hna.
    apply (proj1 (count_occ_not_In Z.eq_dec b v)) in Hnb.
    now rewrite Hna, Hnb.
  - intros H; split; intros v _; apply H.
Qed.
Theorem finite_counts_iff_permutation a b :
  finite_counts a b <-> Permutation a b.
Proof.
  rewrite finite_counts_iff_universal.
  symmetry; apply Permutation_count_occ.
Qed.
Theorem merge_finite_counts_iff a b out :
  finite_counts (a ++ b) out <->
  forall v, count_occ Z.eq_dec out v =
    (count_occ Z.eq_dec a v + count_occ Z.eq_dec b v)%nat.
Proof.
  rewrite finite_counts_iff_universal.
  split; intros H v; specialize (H v);
  rewrite count_occ_app in H || rewrite count_occ_app;
  symmetry; exact H.
Qed.
Print Assumptions finite_counts_iff_permutation.
Print Assumptions merge_finite_counts_iff.

Local Open Scope Z_scope.
Lemma sorted_head_lower x xs y :
  StronglySorted Z.le (x :: xs) -> In y (x :: xs) -> x <= y.
Proof.
  intros H [<-|Hin]; [apply Z.le_refl|].
  inversion H as [|? ? Hsort Hbound]; subst.
  now apply (proj1 (Forall_forall (Z.le x) xs) Hbound).
Qed.
Theorem sorted_permutation_unique a b :
  StronglySorted Z.le a -> StronglySorted Z.le b -> Permutation a b -> a = b.
Proof.
  revert b; induction a as [|x xs IH]; intros b Ha Hb Hp.
  - now apply Permutation_nil in Hp.
  - destruct b as [|y ys].
    + apply Permutation_sym, Permutation_nil in Hp; discriminate.
    + assert (Hx : x <= y).
      { eapply sorted_head_lower; [exact Ha|].
        eapply Permutation_in; [apply Permutation_sym; exact Hp|now left]. }
      assert (Hy : y <= x).
      { eapply sorted_head_lower; [exact Hb|].
        eapply Permutation_in; [exact Hp|now left]. }
      assert (x = y) by (apply Z.le_antisymm; assumption); subst y.
      f_equal; apply IH.
      * now apply StronglySorted_inv in Ha as [Ha _].
      * now apply StronglySorted_inv in Hb as [Hb _].
      * now apply Permutation_cons_inv in Hp.
Qed.
Print Assumptions sorted_permutation_unique.
Theorem adjacent_order_iff_pairwise l :
  Sorted Z.le l <-> StronglySorted Z.le l.
Proof.
  split.
  - apply Sorted_StronglySorted. exact Z.le_trans.
  - apply StronglySorted_Sorted.
Qed.
Print Assumptions adjacent_order_iff_pairwise.
