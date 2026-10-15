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



(* Pointwise transformations retain the supplied heap and its joins. *)
Lemma finite_identity (P : CRules.expr) : P |-- P.
Proof. intros h H; exact H. Qed.
Lemma finite_trans (P Q R : CRules.expr) :
  (P |-- Q) -> (Q |-- R) -> (P |-- R).
Proof. intros H1 H2 h H; apply H2, H1, H. Qed.
Lemma finite_comm (P Q : CRules.expr) : P ** Q |-- Q ** P.
Proof.
  intros h (a & b & J & A & B).
  exists b, a; split; [apply join_comm; exact J|].
  split; assumption.
Qed.
Lemma finite_assoc (P Q R : CRules.expr) :
  (P ** Q) ** R |-- P ** (Q ** R).
Proof.
  intros h (ab & c & J & (a & b & K & A & B) & C).
  destruct (join_assoc _ _ _ _ _ K J) as (bc & L & M).
  exists a, bc; split; [exact M|]. split; [exact A|].
  exists b, c; split; [exact L|]. split; assumption.
Qed.
Lemma finite_frame (P Q R : CRules.expr) :
  (P |-- Q) -> P ** R |-- Q ** R.
Proof.
  intros F h (a & b & J & A & B).
  exists a, b; split; [exact J|]. split; [apply F; exact A|exact B].
Qed.
Lemma finite_frame_right (P Q R : CRules.expr) :
  (Q |-- R) -> P ** Q |-- P ** R.
Proof.
  intros F h (a & b & J & A & B).
  exists a, b; split; [exact J|]. split; [exact A|apply F; exact B].
Qed.
Lemma finite_take_left (A B P R : CRules.expr) :
  (A |-- P ** R) -> A ** B |-- P ** (R ** B).
Proof.
  intro F; eapply finite_trans; [apply finite_frame; exact F|apply finite_assoc].
Qed.
Lemma finite_take_right (A B P R : CRules.expr) :
  (B |-- P ** R) -> A ** B |-- P ** (A ** R).
Proof.
  intros F h (a & b & J & A0 & B0).
  destruct (F _ B0) as (p & r & K & P0 & R0).
  pose proof (join_comm _ _ _ J) as J0.
  destruct (join_assoc _ _ _ _ _ K J0) as (ra & L & M).
  exists p, ra; split; [exact M|]. split; [exact P0|].
  exists a, r; split; [apply join_comm; exact L|]. split; assumption.
Qed.
Lemma finite_append_unit (P : CRules.expr) : P |-- P ** emp.
Proof.
  intros h H; destruct (unit_join h) as (u & U & J).
  exists h, u; split; [exact J|]. split; assumption.
Qed.
Ltac finite_take :=
  first [apply finite_identity
        |apply finite_comm
        |eapply finite_take_left; finite_take
        |eapply finite_take_right; finite_take
        |apply finite_append_unit].
Ltac finite_pure := first [assumption | reflexivity | split; finite_pure].
Ltac finite_finish :=
  first [apply finite_identity
        |lazymatch goal with
         | |- ?S |-- ?P ** ?Q =>
           eapply finite_trans with (Q := (P ** _));
           [finite_take|apply finite_frame_right; finite_finish]
         end
        |intros h H; finite_pure].
Ltac finite_array :=
  unfold CharArray.full, store_array;
  unfold repeat_Z;
  cbn [store_array_rec];
  unfold StoreCharAsElement.storeA;
  rewrite ?sizeof_char;
  cbn;
  finite_finish.

Theorem resolved_init_array2_entail_wit_1_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
  finite_array.
Qed.
Theorem resolved_init_array2_entail_wit_1 : ExecutionGoal.init_array2_entail_wit_1.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_1; right.
  exact resolved_init_array2_entail_wit_1_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_2_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
  finite_array.
Qed.
Theorem resolved_init_array2_entail_wit_2 : ExecutionGoal.init_array2_entail_wit_2.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_2; right.
  exact resolved_init_array2_entail_wit_2_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_3_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
  finite_array.
Qed.
Theorem resolved_init_array2_entail_wit_3 : ExecutionGoal.init_array2_entail_wit_3.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_3; right.
  exact resolved_init_array2_entail_wit_3_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_4_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial.
  finite_array.
Qed.
Theorem resolved_init_array2_entail_wit_4 : ExecutionGoal.init_array2_entail_wit_4.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_4; right.
  exact resolved_init_array2_entail_wit_4_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_5_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_5_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_5_split_goal_spatial.
  finite_array.
Qed.
Theorem resolved_init_array2_entail_wit_5 : ExecutionGoal.init_array2_entail_wit_5.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_5; right.
  exact resolved_init_array2_entail_wit_5_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_6_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_6_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_6_split_goal_spatial.
  finite_array.
Qed.
Theorem resolved_init_array2_entail_wit_6 : ExecutionGoal.init_array2_entail_wit_6.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_6; right.
  exact resolved_init_array2_entail_wit_6_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_7_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_7_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_7_split_goal_spatial.
  finite_array.
Qed.
Theorem resolved_init_array2_entail_wit_7 : ExecutionGoal.init_array2_entail_wit_7.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_7; right.
  exact resolved_init_array2_entail_wit_7_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_8_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_8_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_8_split_goal_spatial.
  finite_array.
Qed.
Theorem resolved_init_array2_entail_wit_8 : ExecutionGoal.init_array2_entail_wit_8.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_8; right.
  exact resolved_init_array2_entail_wit_8_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_9_split_goal_1 : ExecutionGoal.init_array2_entail_wit_9_split_goal_1.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_9_split_goal_1.
  intros h H; reflexivity.
Qed.
Theorem resolved_init_array2_entail_wit_9_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_9_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_9_split_goal_spatial.
  unfold CharArray.undef_full, store_undef_array.
  cbn [store_undef_array_rec].
  unfold StoreCharAsElement.undefstoreA.
  rewrite ?sizeof_char; cbn; finite_finish.
Qed.
Theorem resolved_init_array2_entail_wit_9 : ExecutionGoal.init_array2_entail_wit_9.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_9; right.
  intros h H; split.
  - reflexivity.
  - exact (resolved_init_array2_entail_wit_9_split_goal_spatial h H).
Qed.
Theorem resolved_init_array2_return_wit_1 : ExecutionGoal.init_array2_return_wit_1.
Proof.
  unfold ExecutionGoal.init_array2_return_wit_1; right.
  intros n p H1 H2 H3 H4 H5 H6 H7 H8 H9 Hp Hn Hlo Hhi.
  subst p; subst n.
  intros h H; exists (repeat_Z 0 8).
  revert h H.
  finite_array.
Qed.
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
