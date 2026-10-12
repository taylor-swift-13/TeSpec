From Coq Require Import ZArith List Bool.
Import ListNotations.

(* Denotation-level contract for the finite list Z comparison. The C closure
   check, constructor identities and integer decoding remain refinement gates. *)
Fixpoint integer_list_eqb (xs ys : list Z) : bool :=
  match xs, ys with
  | [], [] => true
  | x :: rest, y :: tail => Z.eqb x y && integer_list_eqb rest tail
  | _, _ => false
  end.

Theorem integer_list_eqb_true_iff xs ys :
  integer_list_eqb xs ys = true <-> xs = ys.
Proof.
  revert ys. induction xs as [|x xs IH]; intros [|y ys]; simpl.
  - tauto.
  - split; intro H; discriminate.
  - split; intro H; discriminate.
  - rewrite andb_true_iff, Z.eqb_eq, IH.
    split.
    + intros [Hhead Htail]; subst; reflexivity.
    + intro H; inversion H; auto.
Qed.

Theorem integer_list_eqb_false_iff xs ys :
  integer_list_eqb xs ys = false <-> xs <> ys.
Proof.
  split.
  - intros Hfalse Heq. apply integer_list_eqb_true_iff in Heq.
    rewrite Heq in Hfalse; discriminate.
  - intros Hneq. destruct (integer_list_eqb xs ys) eqn:Hbool; [|reflexivity].
    apply integer_list_eqb_true_iff in Hbool. contradiction.
Qed.

Theorem closed_append_reverse_comparison xs ys zs :
  zs = xs ++ rev ys <-> integer_list_eqb zs (xs ++ rev ys) = true.
Proof. symmetry; apply integer_list_eqb_true_iff. Qed.

Theorem different_lengths_refute_equality xs ys :
  length xs <> length ys -> integer_list_eqb xs ys = false.
Proof.
  intros Hlength. apply integer_list_eqb_false_iff.
  intros Heq; subst; contradiction.
Qed.

Theorem list_comparison_preserves_heap_observation {Heap : Type}
    (owned : Heap -> Prop) xs ys h :
  (xs = ys /\ owned h) <-> (integer_list_eqb xs ys = true /\ owned h).
Proof. rewrite integer_list_eqb_true_iff; reflexivity. Qed.

Print Assumptions integer_list_eqb_true_iff.
Print Assumptions integer_list_eqb_false_iff.
Print Assumptions closed_append_reverse_comparison.
Print Assumptions different_lengths_refute_equality.
Print Assumptions list_comparison_preserves_heap_observation.
