From Coq Require Import ZArith List Lia Sorting.Permutation Sorting.Sorted.
Import ListNotations.
Fixpoint merge_fuel (fuel : nat) (a b : list Z) : list Z :=
  match fuel with
  | O => []
  | S remaining =>
    match a, b with
    | [], _ => b
    | _, [] => a
    | x :: xs, y :: ys =>
      if Z.leb x y then x :: merge_fuel remaining xs b
      else y :: merge_fuel remaining a ys
    end
  end.
Definition merge_sorted_arrays_spec (a b : list Z) : list Z :=
  merge_fuel (length a + length b) a b.
Lemma merge_fuel_permutation fuel a b :
  length a + length b <= fuel -> Permutation (merge_fuel fuel a b) (a ++ b).
Proof.
  revert a b; induction fuel as [|fuel IH]; intros a b H;
  destruct a as [|x xs], b as [|y ys]; simpl in *; try lia;
  try apply Permutation_refl.
  - rewrite app_nil_r; apply Permutation_refl.
  - destruct (Z.leb x y).
    + apply perm_skip; apply IH; simpl; lia.
    + eapply Permutation_trans.
      * apply perm_skip; apply IH; simpl; lia.
      * apply Permutation_middle.
Qed.
Theorem merge_sorted_arrays_permutation a b :
  Permutation (merge_sorted_arrays_spec a b) (a ++ b).
Proof. unfold merge_sorted_arrays_spec; apply merge_fuel_permutation; lia. Qed.
Theorem merge_sorted_arrays_length a b :
  length (merge_sorted_arrays_spec a b) = length a + length b.
Proof.
  pose proof (Permutation_length (merge_sorted_arrays_permutation a b)) as H.
  rewrite length_app in H; exact H.
Qed.
Print Assumptions merge_sorted_arrays_length.

Lemma merge_fuel_bound fuel a b lo :
  Forall (Z.le lo) a -> Forall (Z.le lo) b ->
  Forall (Z.le lo) (merge_fuel fuel a b).
Proof.
  revert a b; induction fuel as [|fuel IH]; intros a b Ha Hb; simpl.
  - constructor.
  - destruct a as [|x xs], b as [|y ys]; simpl; try assumption; try constructor.
    inversion Ha; inversion Hb; subst.
    destruct (Z.leb x y); constructor; auto using IH.
Qed.
Lemma merge_fuel_sorted fuel a b :
  StronglySorted Z.le a -> StronglySorted Z.le b ->
  StronglySorted Z.le (merge_fuel fuel a b).
Proof.
  revert a b; induction fuel as [|fuel IH]; intros a b Ha Hb; simpl.
  - constructor.
  - destruct a as [|x xs], b as [|y ys]; simpl; try assumption; try constructor.
    inversion Ha as [|? ? Hxs Hxb]; subst.
    inversion Hb as [|? ? Hys Hyb]; subst.
    destruct (Z.leb x y) eqn:Hcmp.
    + apply Z.leb_le in Hcmp; constructor.
      * apply IH; assumption.
      * apply merge_fuel_bound; [exact Hxb|].
        constructor; [exact Hcmp|].
        eapply Forall_impl; [|exact Hyb]. intros z Hz; lia.
    + apply Z.leb_gt in Hcmp; constructor.
      * apply IH; assumption.
      * apply merge_fuel_bound; [|exact Hyb].
        constructor; [lia|].
        eapply Forall_impl; [|exact Hxb]. intros z Hz; lia.
Qed.
Theorem merge_sorted_arrays_sorted a b :
  StronglySorted Z.le a -> StronglySorted Z.le b ->
  StronglySorted Z.le (merge_sorted_arrays_spec a b).
Proof. unfold merge_sorted_arrays_spec; apply merge_fuel_sorted. Qed.
Print Assumptions merge_sorted_arrays_sorted.
