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
  change (store_char 4096 0 ** store_char 4097 0 |--
    store_char (4096 + 0 * sizeof(CHAR)) 0 **
    (store_char (4096 + 1 * sizeof(CHAR)) 0 **
      (“ (2 = 2) ” && “ ((@nil Z) = nil) ” && emp))).
  rewrite sizeof_char. cbn.
  intros h [h1 [h2 [Hj [H1 H2]]]].
  destruct (unit_join h2) as [u [Hu Ju]].
  exists h1, h2. split; [exact Hj |]. split; [exact H1 |].
  exists h2, u. split; [exact Ju |]. split; [exact H2 |].
  split; [reflexivity |]. split; [reflexivity | exact Hu].
Qed.
Theorem resolved_init_array2_entail_wit_1 : ExecutionGoal.init_array2_entail_wit_1.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_1.
  right. exact resolved_init_array2_entail_wit_1_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_2_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
  change (CharArray.undef_seg 4096 0 1 ** store_char 4097 0 |--
    CharArray.undef_seg 4096 0 1 **
    (store_char (4096 + 1 * sizeof(CHAR)) 0 **
      (“ (2 = 2) ” && “ ((@nil Z) = nil) ” && emp))).
  rewrite sizeof_char. cbn.
  intros h [h1 [h2 [Hj [H1 H2]]]].
  destruct (unit_join h2) as [u [Hu Ju]].
  exists h1, h2. split; [exact Hj |]. split; [exact H1 |].
  exists h2, u. split; [exact Ju |]. split; [exact H2 |].
  split; [reflexivity |]. split; [reflexivity | exact Hu].
Qed.
Theorem resolved_init_array2_entail_wit_2 : ExecutionGoal.init_array2_entail_wit_2.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_2.
  right. exact resolved_init_array2_entail_wit_2_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_3_split_goal_1 : ExecutionGoal.init_array2_entail_wit_3_split_goal_1.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_3_split_goal_1.
  intros h H. change (repeat_Z 0 0 = (@nil Z)).
  reflexivity.
Qed.
Theorem resolved_init_array2_entail_wit_3_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
  change (undef_store_char 4097 ** undef_store_char 4096 |--
    undef_store_char (4096 + 0 * sizeof(CHAR)) **
    (undef_store_char (4096 + 1 * sizeof(CHAR)) **
      (“ (2 = 2) ” && emp))).
  rewrite sizeof_char. cbn.
  intros h [h1 [h2 [Hj [H1 H2]]]].
  destruct (unit_join h1) as [u [Hu Ju]].
  exists h2, h1. split; [apply join_comm; exact Hj |].
  split; [exact H2 |].
  exists h1, u. split; [exact Ju |]. split; [exact H1 |].
  split; [reflexivity | exact Hu].
Qed.
Theorem resolved_init_array2_entail_wit_3 : ExecutionGoal.init_array2_entail_wit_3.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_3.
  right. intros h H. split.
  - change (repeat_Z 0 0 = (@nil Z)). reflexivity.
  - exact (resolved_init_array2_entail_wit_3_split_goal_spatial h H).
Qed.
Theorem resolved_init_array2_return_wit_1 : ExecutionGoal.init_array2_return_wit_1.
Proof.
  unfold ExecutionGoal.init_array2_return_wit_1.
  left. intros n p H1 H2 H3 Hp Hn H6 H7 H8.
  subst p. subst n. rewrite sizeof_char.
  intros h H. exists (0 :: 0 :: nil).
  change (CharArray.seg 4096 0 2 (repeat_Z 0 2) h).
  apply resolved_init_array2_entail_wit_1_split_goal_spatial.
  exact H.
Qed.
Print Assumptions resolved_init_array2_entail_wit_1_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_1.
Print Assumptions resolved_init_array2_entail_wit_2_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_2.
Print Assumptions resolved_init_array2_entail_wit_3_split_goal_1.
Print Assumptions resolved_init_array2_entail_wit_3_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_3.
Print Assumptions resolved_init_array2_return_wit_1.
