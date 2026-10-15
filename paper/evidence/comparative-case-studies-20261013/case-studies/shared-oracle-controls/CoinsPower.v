From Coq Require Import ZArith Lia.
Local Open Scope Z_scope.
(* Semantic control matching pinned COINS HumanEval/76. It does not run the
   COINS agent pipeline and does not certify any C implementation. *)
Definition coins_power (x n : Z) (result : bool) : Prop :=
  result = true <-> exists k : nat, x = n ^ Z.of_nat k.
Lemma positive_power (x n : Z) (k : nat) (H : x = n ^ Z.of_nat k) :
  coins_power x n true.
Proof. unfold coins_power. split; [intros _;exists k;exact H|reflexivity]. Qed.
Lemma no_power_3_2 : ~ exists k : nat, 3 = 2 ^ Z.of_nat k.
Proof.
  intros [k H]. destruct k as [|k].
  - vm_compute in H. discriminate.
  - rewrite Nat2Z.inj_succ, Z.pow_succ_r in H by lia. lia.
Qed.
Lemma no_power_5_3 : ~ exists k : nat, 5 = 3 ^ Z.of_nat k.
Proof.
  intros [k H]. destruct k as [|k].
  - vm_compute in H. discriminate.
  - rewrite Nat2Z.inj_succ, Z.pow_succ_r in H by lia. lia.
Qed.
Lemma no_power_3_1 : ~ exists k : nat, 3 = 1 ^ Z.of_nat k.
Proof. intros [k H]. rewrite Z.pow_1_l in H by lia. lia. Qed.
Lemma negative_power (x n : Z) (H : ~ exists k : nat, x = n ^ Z.of_nat k) :
  coins_power x n false.
Proof. unfold coins_power. split;[discriminate|intros Hp;contradiction]. Qed.
Theorem example_1_4 : coins_power 1 4 true.
Proof. apply (positive_power 1 4 0). reflexivity. Qed.
Theorem example_2_2 : coins_power 2 2 true.
Proof. apply (positive_power 2 2 1). reflexivity. Qed.
Theorem example_8_2 : coins_power 8 2 true.
Proof. apply (positive_power 8 2 3). reflexivity. Qed.
Theorem example_3_2 : coins_power 3 2 false.
Proof. apply negative_power. exact no_power_3_2. Qed.
Theorem example_3_1 : coins_power 3 1 false.
Proof. apply negative_power. exact no_power_3_1. Qed.
Theorem example_5_3 : coins_power 5 3 false.
Proof. apply negative_power. exact no_power_5_3. Qed.
Theorem reject_wrong_false : ~ coins_power 8 2 false.
Proof. unfold coins_power. intros [_ H]. assert (Hp : exists k : nat, 8 = 2 ^ Z.of_nat k) by (exists 3%nat; reflexivity). specialize (H Hp). discriminate. Qed.
Theorem reject_wrong_true : ~ coins_power 3 2 true.
Proof. unfold coins_power. intros [H _]. apply no_power_3_2. apply H. reflexivity. Qed.
Print Assumptions example_8_2.
Print Assumptions example_3_2.
Print Assumptions reject_wrong_false.
Print Assumptions reject_wrong_true.
