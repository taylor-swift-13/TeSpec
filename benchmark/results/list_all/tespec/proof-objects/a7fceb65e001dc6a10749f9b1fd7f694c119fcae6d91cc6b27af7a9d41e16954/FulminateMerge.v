From Coq Require Import ZArith List Lia Program.Wf.
Import ListNotations.
Open Scope Z_scope.
Fixpoint cn_split (xs : list Z) : list Z * list Z :=
 match xs with
 | [] => ([],[])
 | [a] => ([],[a])
 | a::b::tl => let '(l,r) := cn_split tl in (a::l,b::r)
 end.
Definition cn_split_fst xs := fst (cn_split xs).
Definition cn_split_snd xs := snd (cn_split xs).
Lemma split_bounds : forall xs, (length (fst (cn_split xs)) <= length xs)%nat /\ (length (snd (cn_split xs)) <= length xs)%nat.
Proof.
 fix IH 1; intros [|a [|b tl]]; simpl; try lia.
 specialize (IH tl); destruct (cn_split tl) as [l r] eqn:E; simpl in *; lia.
Qed.
Fixpoint cn_merge (xs ys : list Z) {struct xs} : list Z :=
 match xs with
 | [] => ys
 | x::xt => (fix merge_y (ys : list Z) : list Z :=
    match ys with
    | [] => x::xt
    | y::yt => if Z.ltb x y then x :: cn_merge xt (y::yt) else y :: merge_y yt
    end) ys
 end.
Program Fixpoint cn_mergesort (xs : list Z) {measure (length xs)} : list Z :=
 match xs with
 | [] => []
 | [a] => [a]
 | a::b::tl => cn_merge (cn_mergesort (cn_split_fst (a::b::tl))) (cn_mergesort (cn_split_snd (a::b::tl)))
 end.
Next Obligation.
 unfold cn_split_fst; simpl; pose proof (split_bounds tl); destruct (cn_split tl); simpl in *; lia.
Qed.
Next Obligation.
 unfold cn_split_snd; simpl; pose proof (split_bounds tl); destruct (cn_split tl); simpl in *; lia.
Qed.

Lemma cn_mergesort_equation : forall xs,
 cn_mergesort xs = match xs with
 | [] => [] | [a] => [a]
 | a::b::tl => cn_merge (cn_mergesort (cn_split_fst (a::b::tl))) (cn_mergesort (cn_split_snd (a::b::tl)))
 end.
Proof.
 intros xs; WfExtensionality.unfold_sub cn_mergesort (cn_mergesort xs).
 destruct xs as [|a [|b tl]]; simpl; reflexivity.
Qed.
Lemma cn_mergesort_split : forall xs, cn_mergesort xs = cn_merge (cn_mergesort (cn_split_fst xs)) (cn_mergesort (cn_split_snd xs)).
Proof.
 intros [|a [|b tl]]; rewrite cn_mergesort_equation; simpl cn_split_fst; simpl cn_split_snd; try reflexivity.
Qed.
