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


Lemma cand_id (P : Assertion) : P |-- P.
Proof. intros h H; exact H. Qed.
Lemma cand_trans (P Q R : Assertion) : (P |-- Q) -> (Q |-- R) -> (P |-- R).
Proof. intros H K h HP; apply K, H, HP. Qed.
Lemma cand_comm (P Q : Assertion) : P ** Q |-- Q ** P.
Proof.
  intros h (a & b & H). destruct H as [J [HP HQ]].
  exists b, a. split; [apply join_comm; exact J | split; assumption].
Qed.
Lemma cand_assoc (P Q R : Assertion) : (P ** Q) ** R |-- P ** (Q ** R).
Proof.
  intros h (ab & c & J & (a & b & K & HP & HQ) & HR).
  destruct (join_assoc _ _ _ _ _ K J) as (bc & L & M).
  exists a, bc. split; [exact M | split; [exact HP |]].
  exists b, c. split; [exact L | split; assumption].
Qed.
Lemma cand_frame (P Q R S : Assertion) : (P |-- R) -> (Q |-- S) -> P ** Q |-- R ** S.
Proof.
  intros F G h (a & b & J & HP & HQ).
  exists a, b. split; [exact J | split; [apply F | apply G]; assumption].
Qed.
Lemma cand_lift (A B T R : Assertion) : (B |-- T ** R) -> A ** B |-- T ** (A ** R).
Proof.
  intros F h (a & b & J & HA & HB).
  destruct (F _ HB) as (t & r & K & HT & HR).
  pose proof (join_comm _ _ _ J) as J'.
  destruct (join_assoc _ _ _ _ _ K J') as (ra & L & M).
  exists t, ra. split; [exact M | split; [exact HT |]].
  exists a, r. split; [apply join_comm; exact L | split; assumption].
Qed.
Lemma cand_unit (P : Assertion) : P |-- P ** emp.
Proof.
  intros h H. destruct (unit_join h) as (u & U & J).
  exists h, u. split; [exact J | split; assumption].
Qed.
Ltac cand_extract :=
  first [apply cand_id | apply cand_comm |
    eapply cand_lift; cand_extract].
Ltac cand_arrange :=
  first [apply cand_id |
    lazymatch goal with
    | |- ((?A ** ?B) ** ?C) |-- ?D =>
      eapply cand_trans; [apply cand_assoc | cand_arrange]
    | |- (?A ** ?B) |-- (?A ** ?C) =>
      apply cand_frame; [apply cand_id | cand_arrange]
    | |- ?A |-- (?T ** ?R) =>
      first [solve [eapply cand_trans; [apply cand_unit | apply cand_frame; [apply cand_id | intros h H; cbn [andp coq_prop] in *; repeat first [assumption | reflexivity | split]]]] |
        eapply cand_trans with (Q := T ** _);
        [cand_extract | apply cand_frame; [apply cand_id | cand_arrange]]]
    end].
Ltac cand_normalize :=
  cbn [CharArray.full CharArray.undef_full store_array store_undef_array
       store_array_rec store_undef_array_rec repeat_Z
       StoreCharAsElement.storeA StoreCharAsElement.undefstoreA];
  repeat rewrite sizeof_char;
  cbn [Z.add Z.mul Z.to_nat Pos.to_nat];
  solve [cand_arrange].

Theorem resolved_init_array2_entail_wit_1_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial. cand_normalize. Qed.
Theorem resolved_init_array2_entail_wit_1 : ExecutionGoal.init_array2_entail_wit_1.
Proof. unfold ExecutionGoal.init_array2_entail_wit_1. right. exact resolved_init_array2_entail_wit_1_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_2_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial. cand_normalize. Qed.
Theorem resolved_init_array2_entail_wit_2 : ExecutionGoal.init_array2_entail_wit_2.
Proof. unfold ExecutionGoal.init_array2_entail_wit_2. right. exact resolved_init_array2_entail_wit_2_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_3_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial. cand_normalize. Qed.
Theorem resolved_init_array2_entail_wit_3 : ExecutionGoal.init_array2_entail_wit_3.
Proof. unfold ExecutionGoal.init_array2_entail_wit_3. right. exact resolved_init_array2_entail_wit_3_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_4_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial. cand_normalize. Qed.
Theorem resolved_init_array2_entail_wit_4 : ExecutionGoal.init_array2_entail_wit_4.
Proof. unfold ExecutionGoal.init_array2_entail_wit_4. right. exact resolved_init_array2_entail_wit_4_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_5_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_5_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_5_split_goal_spatial. cand_normalize. Qed.
Theorem resolved_init_array2_entail_wit_5 : ExecutionGoal.init_array2_entail_wit_5.
Proof. unfold ExecutionGoal.init_array2_entail_wit_5. right. exact resolved_init_array2_entail_wit_5_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_6_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_6_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_6_split_goal_spatial. cand_normalize. Qed.
Theorem resolved_init_array2_entail_wit_6 : ExecutionGoal.init_array2_entail_wit_6.
Proof. unfold ExecutionGoal.init_array2_entail_wit_6. right. exact resolved_init_array2_entail_wit_6_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_7_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_7_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_7_split_goal_spatial. cand_normalize. Qed.
Theorem resolved_init_array2_entail_wit_7 : ExecutionGoal.init_array2_entail_wit_7.
Proof. unfold ExecutionGoal.init_array2_entail_wit_7. right. exact resolved_init_array2_entail_wit_7_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_8_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_8_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_8_split_goal_spatial. cand_normalize. Qed.
Theorem resolved_init_array2_entail_wit_8 : ExecutionGoal.init_array2_entail_wit_8.
Proof. unfold ExecutionGoal.init_array2_entail_wit_8. right. exact resolved_init_array2_entail_wit_8_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_9_split_goal_1 : ExecutionGoal.init_array2_entail_wit_9_split_goal_1.
Proof. unfold ExecutionGoal.init_array2_entail_wit_9_split_goal_1. intros h H. change (repeat_Z 0 0 = @nil Z). reflexivity. Qed.
Theorem resolved_init_array2_entail_wit_9_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_9_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_9_split_goal_spatial. cand_normalize. Qed.
Theorem resolved_init_array2_entail_wit_9 : ExecutionGoal.init_array2_entail_wit_9.
Proof. unfold ExecutionGoal.init_array2_entail_wit_9. right. intros h H. split. - exact (resolved_init_array2_entail_wit_9_split_goal_1 h H). - exact (resolved_init_array2_entail_wit_9_split_goal_spatial h H). Qed.
Theorem resolved_init_array2_return_wit_1 : ExecutionGoal.init_array2_return_wit_1.
Proof. unfold ExecutionGoal.init_array2_return_wit_1. right. intros; subst. intros h H. exists (repeat_Z 0 8). revert h H. cand_normalize. Qed.
Print Assumptions resolved_init_array2_entail_wit_1_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_1.
Print Assumptions resolved_init_array2_entail_wit_2_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_2.
Print Assumptions resolved_init_array2_entail_wit_3_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_3.
Print Assumptions resolved_init_array2_entail_wit_4_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_4.
Print Assumptions resolved_init_array2_entail_wit_5_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_5.
Print Assumptions resolved_init_array2_entail_wit_6_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_6.
Print Assumptions resolved_init_array2_entail_wit_7_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_7.
Print Assumptions resolved_init_array2_entail_wit_8_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_8.
Print Assumptions resolved_init_array2_entail_wit_9_split_goal_1.
Print Assumptions resolved_init_array2_entail_wit_9_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_9.
Print Assumptions resolved_init_array2_return_wit_1.
