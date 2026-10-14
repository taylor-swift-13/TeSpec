From Coq Require Import ZArith List Lia.
Import ListNotations.
Local Open Scope Z_scope.

(* Definition required by the original CAV contract's imported relation. *)
Fixpoint array_count_nonzero_spec (l : list Z) : Z :=
  match l with
  | [] => 0
  | x :: xs => (if Z.eqb x 0 then 0 else 1) + array_count_nonzero_spec xs
  end.

Lemma count_nonzero_app (xs ys : list Z) :
  array_count_nonzero_spec (xs ++ ys) =
  array_count_nonzero_spec xs + array_count_nonzero_spec ys.
Proof. induction xs; simpl; [lia|rewrite IHxs; lia]. Qed.

(* CN consumes the last cell first; order does not change the count. *)
Theorem count_nonzero_reverse (l : list Z) :
  array_count_nonzero_spec (rev l) = array_count_nonzero_spec l.
Proof.
  induction l; simpl; [reflexivity|].
  rewrite count_nonzero_app, IHl. simpl. lia.
Qed.

Theorem count_nonzero_range (l : list Z) :
  0 <= array_count_nonzero_spec l <= Z.of_nat (length l).
Proof.
  induction l as [|x xs IH]; [cbn; lia|].
  change (0 <= (if Z.eqb x 0 then 0 else 1) + array_count_nonzero_spec xs <= Z.of_nat (S (length xs))).
  rewrite Nat2Z.inj_succ. destruct (Z.eqb x 0); lia.
Qed.
Print Assumptions count_nonzero_reverse.
Print Assumptions count_nonzero_range.
