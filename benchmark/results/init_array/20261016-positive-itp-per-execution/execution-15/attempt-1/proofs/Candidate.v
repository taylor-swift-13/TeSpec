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


Ltac finite_arrays :=
  cbn [CharArray.seg CharArray.full CharArray.undef_seg CharArray.undef_full
       store_array store_array_rec store_undef_array store_undef_array_rec
       repeat_Z StoreCharAsElement.storeA StoreCharAsElement.undefstoreA
       StoreCharAsElement.sizeA];
  try rewrite !sizeof_char;
  cbn.

Ltac finite_empty Hu :=
  first [exact Hu | split; [reflexivity | finite_empty Hu]].

Ltac append_finite_terminal :=
  intros h (h1 & h2 & Hj & H1 & H2);
  destruct (unit_join h2) as [u [Hu Ju]];
  exists h1, h2; split; [exact Hj |];
  split; [exact H1 |];
  exists h2, u; split; [exact Ju |];
  split; [exact H2 |]; finite_empty Hu.

Theorem resolved_init_array2_entail_wit_1_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
  finite_arrays.
  append_finite_terminal.
Qed.
Theorem resolved_init_array2_entail_wit_1 : ExecutionGoal.init_array2_entail_wit_1.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_1.
  right. exact resolved_init_array2_entail_wit_1_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_2_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
  finite_arrays.
  append_finite_terminal.
Qed.
Theorem resolved_init_array2_entail_wit_2 : ExecutionGoal.init_array2_entail_wit_2.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_2.
  right. exact resolved_init_array2_entail_wit_2_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_3_split_goal_1 : ExecutionGoal.init_array2_entail_wit_3_split_goal_1.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_3_split_goal_1.
  intros h H. change (repeat_Z 0 0 = @nil Z).
  unfold repeat_Z. reflexivity.
Qed.
Theorem resolved_init_array2_entail_wit_3_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
  finite_arrays.
  intros h (h1 & h2 & Hj & H1 & H2).
  destruct (unit_join h1) as [u [Hu Ju]].
  exists h2, h1. split.
  - apply join_comm. exact Hj.
  - split; [exact H2 |].
    exists h1, u. split; [exact Ju |].
    split; [exact H1 |]. finite_empty Hu.
Qed.
Theorem resolved_init_array2_entail_wit_3 : ExecutionGoal.init_array2_entail_wit_3.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_3.
  right. intros h H. split.
  - change (repeat_Z 0 0 = @nil Z). unfold repeat_Z. reflexivity.
  - exact (resolved_init_array2_entail_wit_3_split_goal_spatial h H).
Qed.
Theorem resolved_init_array2_return_wit_1 : ExecutionGoal.init_array2_return_wit_1.
Proof.
  unfold ExecutionGoal.init_array2_return_wit_1.
  left. intros n p H1 H2 H3 Hp Hn H6 H7 H8.
  subst n p.
  intros h H. exists (0 :: 0 :: nil).
  revert h H.
  finite_arrays.
  append_finite_terminal.
Qed.
Print Assumptions resolved_init_array2_entail_wit_1_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_1.
Print Assumptions resolved_init_array2_entail_wit_2_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_2.
Print Assumptions resolved_init_array2_entail_wit_3_split_goal_1.
Print Assumptions resolved_init_array2_entail_wit_3_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_3.
Print Assumptions resolved_init_array2_return_wit_1.
