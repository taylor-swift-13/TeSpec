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


Theorem resolved_init_array2_entail_wit_1_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
  unfold CharArray.full, store_array, repeat_Z.
  simpl store_array_rec.
  unfold StoreCharAsElement.storeA.
  cbn [Z.add Z.mul].
  unfold derivable1, sepcon, andp, coq_prop, emp.
  intros m [hi [lo [J [Hhi Hlo]]]].
  destruct (unit_join hi) as [u [Hu Ju]].
  exists lo, hi. split.
  - apply join_comm. exact J.
  - split; [exact Hlo |].
    exists hi, u. split; [exact Ju |].
    split; [exact Hhi |].
    repeat first [exact Hu | reflexivity | split | lia].
Qed.
Theorem resolved_init_array2_entail_wit_1 : ExecutionGoal.init_array2_entail_wit_1.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_1.
  right. exact resolved_init_array2_entail_wit_1_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_2_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
  unfold CharArray.full, store_array, repeat_Z.
  simpl store_array_rec.
  unfold StoreCharAsElement.storeA.
  cbn [Z.add Z.mul].
  unfold derivable1, sepcon, andp, coq_prop, emp.
  intros m Hm.
  destruct (unit_join m) as [u [Hu Ju]].
  exists m, u. split; [exact Ju |].
  split; [exact Hm |].
  repeat first [exact Hu | reflexivity | split | lia].
Qed.
Theorem resolved_init_array2_entail_wit_2 : ExecutionGoal.init_array2_entail_wit_2.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_2.
  right. exact resolved_init_array2_entail_wit_2_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_3_split_goal_1 : ExecutionGoal.init_array2_entail_wit_3_split_goal_1.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_3_split_goal_1.
  unfold derivable1, coq_prop, repeat_Z. intros. reflexivity.
Qed.
Theorem resolved_init_array2_entail_wit_3_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
  unfold CharArray.undef_full, store_undef_array.
  simpl store_undef_array_rec.
  unfold StoreCharAsElement.undefstoreA.
  cbn [Z.add Z.mul].
  unfold derivable1, sepcon, andp, coq_prop, emp.
  intros m [hi [lo [J [Hhi Hlo]]]].
  destruct (unit_join hi) as [u [Hu Ju]].
  exists lo, hi. split.
  - apply join_comm. exact J.
  - split; [exact Hlo |].
    exists hi, u. split; [exact Ju |].
    split; [exact Hhi |].
    repeat first [exact Hu | reflexivity | split | lia].
Qed.
Theorem resolved_init_array2_entail_wit_3 : ExecutionGoal.init_array2_entail_wit_3.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_3.
  right. unfold derivable1, andp.
  intros m Hm. split.
  - exact (resolved_init_array2_entail_wit_3_split_goal_1 m Hm).
  - exact (resolved_init_array2_entail_wit_3_split_goal_spatial m Hm).
Qed.
Theorem resolved_init_array2_return_wit_1 : ExecutionGoal.init_array2_return_wit_1.
Proof.
  unfold ExecutionGoal.init_array2_return_wit_1.
  right. intros n p H1 H2 H3 Hp Hn H6 H7.
  subst p. subst n.
  change (
    (((4096 + (1 * 1))) # Char |-> 0) ** ((4096) # Char |-> 0)
    |-- EX (l2 : list Z), CharArray.full 4096 2 l2).
  unfold derivable1, exp. intros m Hm.
  exists (repeat_Z 0 2).
  exact (resolved_init_array2_entail_wit_1_split_goal_spatial m Hm).
Qed.
Print Assumptions resolved_init_array2_entail_wit_1_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_1.
Print Assumptions resolved_init_array2_entail_wit_2_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_2.
Print Assumptions resolved_init_array2_entail_wit_3_split_goal_1.
Print Assumptions resolved_init_array2_entail_wit_3_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_3.
Print Assumptions resolved_init_array2_return_wit_1.
