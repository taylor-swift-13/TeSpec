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


Lemma finite_trans (P Q R : Assertion) :
  (P |-- Q) -> (Q |-- R) -> (P |-- R).
Proof. intros H1 H2 h H; apply H2, H1, H. Qed.

Lemma finite_frame (P P' Q Q' : Assertion) :
  (P |-- P') -> (Q |-- Q') -> (P ** Q |-- P' ** Q').
Proof.
  intros HP HQ h (a & b & Hj & Ha & Hb).
  exists a, b; split; [exact Hj | split; [apply HP | apply HQ]; assumption].
Qed.

Lemma finite_swap (P Q : Assertion) : P ** Q |-- Q ** P.
Proof.
  intros h (a & b & Hj & Ha & Hb).
  exists b, a; split; [apply join_comm; exact Hj | split; assumption].
Qed.

Lemma finite_assoc (P Q R : Assertion) :
  (P ** Q) ** R |-- P ** (Q ** R).
Proof.
  intros h (ab & c & Hj & (a & b & Hab & Ha & Hb) & Hc).
  destruct (join_assoc _ _ _ _ _ Hab Hj) as (bc & Hbc & Habc).
  exists a, bc; split; [exact Habc | split; [exact Ha |]].
  exists b, c; split; [exact Hbc | split; assumption].
Qed.

Lemma finite_unit (P : Assertion) : P |-- P ** emp.
Proof.
  intros h H; destruct (unit_join h) as (u & Hu & Hj).
  exists h, u; split; [exact Hj | split; assumption].
Qed.

Ltac finite_reverse :=
  lazymatch goal with
  | |- ?P ** ?Q |-- _ =>
      eapply finite_trans; [apply finite_swap |];
      eapply finite_frame; [finite_reverse | apply (fun h H => H)]
  | |- ?P |-- _ => apply (fun h H => H)
  end.

Ltac finite_right :=
  lazymatch goal with
  | |- (?P ** ?Q) ** ?R |-- _ =>
      eapply finite_trans; [apply finite_assoc |]; finite_right
  | |- ?P ** ?Q |-- _ =>
      apply finite_frame; [apply (fun h H => H) | finite_right]
  | |- ?P |-- _ => apply (fun h H => H)
  end.

Ltac finite_finish :=
  lazymatch goal with
  | |- ?P ** ?Q |-- ?P ** ?R =>
      apply finite_frame; [apply (fun h H => H) | finite_finish]
  | |- ?P |-- ?P ** ?R =>
      eapply finite_trans; [apply finite_unit |];
      apply finite_frame; [apply (fun h H => H) |];
      intros h H; repeat split; try reflexivity; exact H
  end.

Ltac finite_cells :=
  eapply finite_trans; [finite_reverse |];
  eapply finite_trans; [finite_right |]; finite_finish.

Ltac finite_full :=
  unfold CharArray.full, store_array, repeat_Z;
  cbn [store_array_rec StoreCharAsElement.storeA StoreCharAsElement.sizeA];
  rewrite ?sizeof_char; cbn; finite_cells.

Ltac finite_undef :=
  unfold CharArray.undef_full, store_undef_array;
  cbn [store_undef_array_rec StoreCharAsElement.undefstoreA StoreCharAsElement.sizeA];
  rewrite ?sizeof_char; cbn; finite_cells.

Theorem resolved_init_array2_entail_wit_1_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial. finite_full. Qed.
Theorem resolved_init_array2_entail_wit_1 : ExecutionGoal.init_array2_entail_wit_1.
Proof. unfold ExecutionGoal.init_array2_entail_wit_1. right. exact resolved_init_array2_entail_wit_1_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_2_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial. finite_full. Qed.
Theorem resolved_init_array2_entail_wit_2 : ExecutionGoal.init_array2_entail_wit_2.
Proof. unfold ExecutionGoal.init_array2_entail_wit_2. right. exact resolved_init_array2_entail_wit_2_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_3_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial. finite_full. Qed.
Theorem resolved_init_array2_entail_wit_3 : ExecutionGoal.init_array2_entail_wit_3.
Proof. unfold ExecutionGoal.init_array2_entail_wit_3. right. exact resolved_init_array2_entail_wit_3_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_4_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial. finite_full. Qed.
Theorem resolved_init_array2_entail_wit_4 : ExecutionGoal.init_array2_entail_wit_4.
Proof. unfold ExecutionGoal.init_array2_entail_wit_4. right. exact resolved_init_array2_entail_wit_4_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_5_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_5_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_5_split_goal_spatial. finite_full. Qed.
Theorem resolved_init_array2_entail_wit_5 : ExecutionGoal.init_array2_entail_wit_5.
Proof. unfold ExecutionGoal.init_array2_entail_wit_5. right. exact resolved_init_array2_entail_wit_5_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_6_split_goal_1 : ExecutionGoal.init_array2_entail_wit_6_split_goal_1.
Proof. unfold ExecutionGoal.init_array2_entail_wit_6_split_goal_1. intros h H. change ((repeat_Z 0 0) = (@nil Z)). unfold repeat_Z. reflexivity. Qed.
Theorem resolved_init_array2_entail_wit_6_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_6_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_6_split_goal_spatial. finite_undef. Qed.
Theorem resolved_init_array2_entail_wit_6 : ExecutionGoal.init_array2_entail_wit_6.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_6. right.
  intros h H; split.
  - exact (resolved_init_array2_entail_wit_6_split_goal_1 h H).
  - exact (resolved_init_array2_entail_wit_6_split_goal_spatial h H).
Qed.
Theorem resolved_init_array2_return_wit_1 : ExecutionGoal.init_array2_return_wit_1.
Proof.
  unfold ExecutionGoal.init_array2_return_wit_1. right.
  intros n p H1 H2 H3 H4 H5 H6 Hp Hn H9 H10.
  subst p; subst n.
  intros h H. exists (repeat_Z 0 5).
  revert h H.
  rewrite sizeof_char; cbn.
  exact resolved_init_array2_entail_wit_1_split_goal_spatial.
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
Print Assumptions resolved_init_array2_entail_wit_6_split_goal_1.
Print Assumptions resolved_init_array2_entail_wit_6_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_6.
Print Assumptions resolved_init_array2_return_wit_1.
