Require Import ExecutionGoal.
Require Import Coq.ZArith.ZArith.
Require Import Coq.Bool.Bool.
Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Lists.List.
Require Import Coq.Classes.RelationClasses.
Require Import Coq.Classes.Morphisms.
Require Import Coq.micromega.Psatz.
Require Import Coq.Sorting.Permutation.
From AUXLib Require Import int_auto Axioms Feq Idents ListLib VMap.
Require Import SetsClass.SetsClass. Import SetsNotation.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.


Lemma candidate_refl (P : CRules.expr) : P |-- P.
Proof. intros h H; exact H. Qed.

Lemma candidate_trans (P Q R : CRules.expr) :
  (P |-- Q) -> (Q |-- R) -> (P |-- R).
Proof. intros H1 H2 h H; apply H2, H1, H. Qed.

Lemma candidate_map (P Q R S : CRules.expr) :
  (P |-- R) -> (Q |-- S) -> (P ** Q |-- R ** S).
Proof.
  intros HP HQ h (a & b & J & HA & HB).
  exists a, b; split; [exact J | split; [apply HP | apply HQ]; assumption].
Qed.

Lemma candidate_reverse2 (P Q : CRules.expr) : P ** Q |-- Q ** P.
Proof.
  intros h (a & b & J & HA & HB).
  exists b, a; split; [apply join_comm; exact J | split; assumption].
Qed.

Lemma candidate_reverse3 (P Q R : CRules.expr) :
  P ** (Q ** R) |-- R ** (Q ** P).
Proof.
  intros h (a & bc & J & HA & b & c & K & HB & HC).
  pose proof (join_comm _ _ _ J) as J'.
  destruct (join_assoc _ _ _ _ _ K J') as (ca & Kca & Kh).
  pose proof (join_comm _ _ _ Kh) as Kh'.
  destruct (join_assoc _ _ _ _ _ Kca Kh') as (ab & Kab & Kall).
  exists c, ab; split; [exact Kall | split; [exact HC |]].
  exists b, a; split; [apply join_comm; exact Kab | split; assumption].
Qed.

Lemma candidate_associate (P Q R : CRules.expr) :
  (P ** Q) ** R |-- P ** (Q ** R).
Proof.
  intros h (ab & c & J & (a & b & K & HA & HB) & HC).
  destruct (join_assoc _ _ _ _ _ K J) as (bc & Kbc & Kh).
  exists a, bc; split; [exact Kh | split; [exact HA |]].
  exists b, c; split; [exact Kbc | split; assumption].
Qed.

Ltac candidate_reverse_three :=
  first
    [ eapply candidate_trans; [apply candidate_reverse3 |]
    | eapply candidate_trans; [apply candidate_associate |];
      eapply candidate_trans; [apply candidate_reverse3 |] ].

Lemma candidate_tail (P T : CRules.expr) :
  (emp |-- T) -> (P |-- P ** T).
Proof.
  intros HT h HP.
  destruct (unit_join h) as (u & Hu & J).
  exists h, u; split; [exact J | split; [exact HP | apply HT; exact Hu]].
Qed.

Theorem resolved_init_array2_entail_wit_1_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
  unfold CharArray.full, store_array.
  cbn [repeat_Z store_array_rec StoreCharAsElement.storeA StoreCharAsElement.sizeA].
  rewrite ?sizeof_char.
  candidate_reverse_three.
  apply candidate_map; [apply candidate_refl |].
  apply candidate_map; [apply candidate_refl |].
  apply candidate_tail.
  intros h H.
  first [change ((3 = 3) /\ ((@nil Z) = nil) /\ emp h)
        | change (((3 = 3) /\ ((@nil Z) = nil)) /\ emp h)].
  first [split; [reflexivity | split; [reflexivity | exact H]]
        | split; [split; reflexivity | exact H]].
Qed.
Theorem resolved_init_array2_entail_wit_1 : ExecutionGoal.init_array2_entail_wit_1.
Proof.
  right; exact resolved_init_array2_entail_wit_1_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_2_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
  unfold CharArray.full, store_array.
  cbn [repeat_Z store_array_rec StoreCharAsElement.storeA StoreCharAsElement.sizeA].
  rewrite ?sizeof_char.
  eapply candidate_trans; [apply candidate_reverse2 |].
  apply candidate_map; [apply candidate_refl |].
  apply candidate_tail.
  intros h H.
  first [change ((2 = 2) /\ ((@nil Z) = nil) /\ emp h)
        | change (((2 = 2) /\ ((@nil Z) = nil)) /\ emp h)].
  first [split; [reflexivity | split; [reflexivity | exact H]]
        | split; [split; reflexivity | exact H]].
Qed.
Theorem resolved_init_array2_entail_wit_2 : ExecutionGoal.init_array2_entail_wit_2.
Proof.
  right; exact resolved_init_array2_entail_wit_2_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_3_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
  unfold CharArray.full, store_array.
  cbn [repeat_Z store_array_rec StoreCharAsElement.storeA StoreCharAsElement.sizeA].
  rewrite ?sizeof_char.
  apply candidate_tail.
  intros h H.
  first [change ((1 = 1) /\ ((@nil Z) = nil) /\ emp h)
        | change (((1 = 1) /\ ((@nil Z) = nil)) /\ emp h)].
  first [split; [reflexivity | split; [reflexivity | exact H]]
        | split; [split; reflexivity | exact H]].
Qed.
Theorem resolved_init_array2_entail_wit_3 : ExecutionGoal.init_array2_entail_wit_3.
Proof.
  right; exact resolved_init_array2_entail_wit_3_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_4_split_goal_1 : ExecutionGoal.init_array2_entail_wit_4_split_goal_1.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_4_split_goal_1.
  intros h H; change (repeat_Z 0 0 = (@nil Z)); reflexivity.
Qed.
Theorem resolved_init_array2_entail_wit_4_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial.
  unfold CharArray.undef_full, store_undef_array.
  cbn [store_undef_array_rec StoreCharAsElement.undefstoreA StoreCharAsElement.sizeA].
  rewrite ?sizeof_char.
  candidate_reverse_three.
  apply candidate_map; [apply candidate_refl |].
  apply candidate_map; [apply candidate_refl |].
  apply candidate_tail.
  intros h H; change ((3 = 3) /\ emp h).
  split; [reflexivity | exact H].
Qed.
Theorem resolved_init_array2_entail_wit_4 : ExecutionGoal.init_array2_entail_wit_4.
Proof.
  right; intros h H; split.
  - exact (resolved_init_array2_entail_wit_4_split_goal_1 h H).
  - exact (resolved_init_array2_entail_wit_4_split_goal_spatial h H).
Qed.
Theorem resolved_init_array2_return_wit_1 : ExecutionGoal.init_array2_return_wit_1.
Proof.
  right; intros n p H1 H2 H3 H4 Hp Hn H7 H8.
  subst p; subst n.
  rewrite ?sizeof_char.
  intros h H.
  exists (repeat_Z 0 3).
  apply resolved_init_array2_entail_wit_1_split_goal_spatial.
  exact H.
Qed.
Print Assumptions resolved_init_array2_entail_wit_1_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_1.
Print Assumptions resolved_init_array2_entail_wit_2_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_2.
Print Assumptions resolved_init_array2_entail_wit_3_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_3.
Print Assumptions resolved_init_array2_entail_wit_4_split_goal_1.
Print Assumptions resolved_init_array2_entail_wit_4_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_4.
Print Assumptions resolved_init_array2_return_wit_1.
