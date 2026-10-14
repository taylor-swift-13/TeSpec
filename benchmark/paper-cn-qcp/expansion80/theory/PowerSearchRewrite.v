Require Import Coq.ZArith.ZArith Coq.micromega.Lia.
Local Open Scope Z_scope.

Fixpoint power_search (fuel : nat) (x n p : Z) : bool :=
  if Z.eqb p x then true else
  if Z.gtb p x then false else
  match fuel with
  | O => false
  | S rest => power_search rest x n (p * n)
  end.

Lemma power_at_least_one : forall n k, 1 <= n -> 1 <= n ^ Z.of_nat k.
Proof.
  intros n k Hn.
  pose proof (Z.pow_pos_nonneg n (Z.of_nat k) ltac:(lia) ltac:(lia)).
  lia.
Qed.

Lemma power_search_exact : forall fuel x n p,
  1 <= n -> 1 <= p ->
  (power_search fuel x n p = true <->
   exists k : nat, (k <= fuel)%nat /\ x = p * n ^ Z.of_nat k).
Proof.
  induction fuel as [|fuel IH]; intros x n p Hn Hp; simpl;
    destruct (Z.eqb p x) eqn:E.
  - apply Z.eqb_eq in E. split.
    + intros _. exists O. simpl. split; [lia|nia].
    + intros _. reflexivity.
  - apply Z.eqb_neq in E. destruct (Z.gtb p x) eqn:G; split; try discriminate;
      intros [k [Hk Heq]]; assert (k = O) by lia; subst k; simpl in Heq; nia.
  - apply Z.eqb_eq in E. split.
    + intros _. exists O. simpl. split; [lia|nia].
    + intros _. reflexivity.
  - apply Z.eqb_neq in E. destruct (Z.gtb p x) eqn:G.
    + apply Z.gtb_lt in G. split; [discriminate|].
      intros [k [Hk Heq]]. pose proof (power_at_least_one n k Hn). nia.
    + rewrite IH by nia. split.
      * intros [k [Hk Heq]]. exists (S k). split; [lia|].
        rewrite Nat2Z.inj_succ, Z.pow_succ_r by lia. nia.
      * intros [k [Hk Heq]]. destruct k as [|k].
        -- simpl in Heq. nia.
        -- exists k. split; [lia|].
           rewrite Nat2Z.inj_succ, Z.pow_succ_r in Heq by lia. nia.
Qed.

Lemma positive_int32_power_bounded : forall x n,
  1 <= x <= 2147483647 -> 1 <= n ->
  ((exists k : nat, x = n ^ Z.of_nat k) <->
   (exists k : nat, (k <= 31)%nat /\ x = n ^ Z.of_nat k)).
Proof.
  intros x n Hx Hn. split; [|intros [k [_ Hk]]; now exists k].
  intros [k Hk]. destruct (Z.eq_dec n 1) as [->|Hne].
  - rewrite Z.pow_1_l in Hk by lia. exists O. simpl. split; lia.
  - assert (2 <= n) by lia.
    assert (k <= 31)%nat.
    { destruct (le_gt_dec k 31); [assumption|].
      assert (Hbase : 2 ^ Z.of_nat k <= n ^ Z.of_nat k).
      { apply Z.pow_le_mono_l; lia. }
      assert (Hexp : 2 ^ 31 <= 2 ^ Z.of_nat k).
      { apply Z.pow_le_mono_r; lia. }
      change (2147483648 <= 2 ^ Z.of_nat k) in Hexp. lia. }
    exists k. auto.
Qed.

Theorem original_power_contract_equivalent : forall x n r,
  1 <= x <= 2147483647 -> 1 <= n ->
  ((r <> 0 <-> exists k : nat, x = n ^ Z.of_nat k) <->
   (r <> 0 <-> power_search 31 x n 1 = true)).
Proof.
  intros x n r Hx Hn.
  rewrite power_search_exact by lia.
  setoid_rewrite Z.mul_1_l.
  rewrite <- positive_int32_power_bounded by lia.
  reflexivity.
Qed.

Print Assumptions original_power_contract_equivalent.

Definition cn_power_search_value (fuel : nat) (x n p : Z) : Z :=
  if power_search fuel x n p then 1 else 0.

Theorem cn_integer_encoding_exact : forall fuel x n p,
  cn_power_search_value fuel x n p <> 0 <-> power_search fuel x n p = true.
Proof.
  intros. unfold cn_power_search_value.
  destruct (power_search fuel x n p); simpl; intuition congruence.
Qed.

Theorem cn_qcp_power_postconditions_equivalent : forall x n r,
  1 <= x <= 2147483647 -> 1 <= n ->
  ((r <> 0 <-> exists k : nat, x = n ^ Z.of_nat k) <->
   (r <> 0 <-> cn_power_search_value 31 x n 1 <> 0)).
Proof.
  intros. rewrite cn_integer_encoding_exact.
  now apply original_power_contract_equivalent.
Qed.

Print Assumptions cn_qcp_power_postconditions_equivalent.
