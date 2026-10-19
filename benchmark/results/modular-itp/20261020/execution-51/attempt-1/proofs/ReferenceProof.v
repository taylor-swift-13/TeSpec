Require Import ConcreteCell ExecutionGoal.
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



Theorem entry_cell : (4096 # Int |-> (-1)) (st (cell 255 255 255 255)).
Proof.
  unfold store_int.
  split.
  - change (isvalidptr_int 4096 /\ -1 <= Int.max_signed /\ -1 >= Int.min_signed).
    vm_compute; repeat split; congruence.
  - unfold store_4byte.
    exists 255, 255, 255, 255.
    split.
    + change (merge_int 255 255 255 255 (-1)).
      vm_compute; repeat split; congruence.
    + unfold naive_C_Rules.sepcon.
      exists (st (single_byte_mem 4096 255)), (st (tail1 255 255 255)).
      split; [apply st_join; apply join0|].
      split; [apply byte_at|].
      exists (st (single_byte_mem 4097 255)), (st (tail2 255 255)).
      split; [apply st_join; apply join1|].
      split; [apply byte_at|].
      exists (st (single_byte_mem 4098 255)), (st (single_byte_mem 4099 255)).
      split; [apply st_join; apply join2|].
      split; apply byte_at.
Qed.
Theorem exit_cell : (4096 # Int |-> (-2)) (st (cell 255 255 255 254)).
Proof.
  unfold store_int.
  split.
  - change (isvalidptr_int 4096 /\ -2 <= Int.max_signed /\ -2 >= Int.min_signed).
    vm_compute; repeat split; congruence.
  - unfold store_4byte.
    exists 255, 255, 255, 254.
    split.
    + change (merge_int 255 255 255 254 (-2)).
      vm_compute; repeat split; congruence.
    + unfold naive_C_Rules.sepcon.
      exists (st (single_byte_mem 4096 255)), (st (tail1 255 255 254)).
      split; [apply st_join; apply join0|].
      split; [apply byte_at|].
      exists (st (single_byte_mem 4097 255)), (st (tail2 255 254)).
      split; [apply st_join; apply join1|].
      split; [apply byte_at|].
      exists (st (single_byte_mem 4098 255)), (st (single_byte_mem 4099 254)).
      split; [apply st_join; apply join2|].
      split; apply byte_at.
Qed.
Theorem refute_inplace_double_return_wit_1_split_goal_spatial : ~ ExecutionGoal.inplace_double_return_wit_1_split_goal_spatial.
Proof.
  unfold ExecutionGoal.inplace_double_return_wit_1_split_goal_spatial.
  intro H.
  specialize (H 4096 (-1) ltac:(vm_compute; congruence)
    ltac:(vm_compute; congruence) eq_refl eq_refl ltac:(lia) ltac:(lia)).
  specialize (H (st (cell 255 255 255 254)) exit_cell).
  destruct H as [_ H].
  exact (cell_not_emp 255 255 255 254 H).
Qed.
Theorem refute_inplace_double_return_wit_1 : ~ ExecutionGoal.inplace_double_return_wit_1.
Proof.
  unfold ExecutionGoal.inplace_double_return_wit_1.
  intros [H | H].
  - specialize (H 4096 (-1) eq_refl eq_refl ltac:(lia) ltac:(lia)).
    specialize (H (st (cell 255 255 255 254)) exit_cell).
    destruct H as [_ H].
    exact (cell_not_emp 255 255 255 254 H).
  - apply refute_inplace_double_return_wit_1_split_goal_spatial.
    exact H.
Qed.
Theorem entry_sat : ExecutionGoal.inplace_double_precondition_wit_1.
Proof.
  unfold ExecutionGoal.inplace_double_precondition_wit_1.
  exists 4096, (-1).
  intro H.
  apply (H (st (cell 255 255 255 255))).
  change ((((4096 = 4096 /\ -1 = -1) /\ -1073741824 <= -1)
    /\ -1 <= 1073741823) /\
    (4096 # Int |-> (-1)) (st (cell 255 255 255 255))).
  split.
  - repeat split; lia.
  - exact entry_cell.
Qed.
Print Assumptions entry_cell.
Print Assumptions exit_cell.
Print Assumptions refute_inplace_double_return_wit_1_split_goal_spatial.
Print Assumptions refute_inplace_double_return_wit_1.
Print Assumptions entry_sat.
