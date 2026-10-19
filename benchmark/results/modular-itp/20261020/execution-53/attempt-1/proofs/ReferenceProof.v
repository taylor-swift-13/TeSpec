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



Theorem entry_cell : (4096 # Int |-> (0)) (st (cell 0 0 0 0)).
Proof.
  unfold store_int.
  split.
  - change (isvalidptr_int 4096 /\ 0 <= Int.max_signed /\ 0 >= Int.min_signed).
    vm_compute; intuition congruence.
  - unfold store_4byte.
    exists 0, 0, 0, 0.
    split.
    + change (merge_int 0 0 0 0 0).
      vm_compute; intuition congruence.
    + exists (st (single_byte_mem 4096 0)), (st (tail1 0 0 0)).
      split; [apply st_join; apply join0 |].
      split; [apply byte_at |].
      exists (st (single_byte_mem 4097 0)), (st (tail2 0 0)).
      split; [apply st_join; apply join1 |].
      split; [apply byte_at |].
      exists (st (single_byte_mem 4098 0)), (st (single_byte_mem 4099 0)).
      split; [apply st_join; apply join2 |].
      split; apply byte_at.
Qed.
Theorem exit_cell : (4096 # Int |-> (0)) (st (cell 0 0 0 0)).
Proof.
  unfold store_int.
  split.
  - change (isvalidptr_int 4096 /\ 0 <= Int.max_signed /\ 0 >= Int.min_signed).
    vm_compute; intuition congruence.
  - unfold store_4byte.
    exists 0, 0, 0, 0.
    split.
    + change (merge_int 0 0 0 0 0).
      vm_compute; intuition congruence.
    + exists (st (single_byte_mem 4096 0)), (st (tail1 0 0 0)).
      split; [apply st_join; apply join0 |].
      split; [apply byte_at |].
      exists (st (single_byte_mem 4097 0)), (st (tail2 0 0)).
      split; [apply st_join; apply join1 |].
      split; [apply byte_at |].
      exists (st (single_byte_mem 4098 0)), (st (single_byte_mem 4099 0)).
      split; [apply st_join; apply join2 |].
      split; apply byte_at.
Qed.
Theorem refute_inplace_double_return_wit_1_split_goal_spatial : ~ ExecutionGoal.inplace_double_return_wit_1_split_goal_spatial.
Proof.
  unfold ExecutionGoal.inplace_double_return_wit_1_split_goal_spatial.
  intro H.
  assert (Hmax : 0 + 0 <= INT_MAX) by (vm_compute; congruence).
  assert (Hmin : 0 + 0 >= INT_MIN) by (vm_compute; congruence).
  specialize (H 4096 0 Hmax Hmin eq_refl eq_refl ltac:(lia) ltac:(lia)).
  specialize (H (st (cell 0 0 0 0)) exit_cell).
  apply (cell_not_emp 0 0 0 0).
  exact (proj2 H).
Qed.
Theorem refute_inplace_double_return_wit_1 : ~ ExecutionGoal.inplace_double_return_wit_1.
Proof.
  unfold ExecutionGoal.inplace_double_return_wit_1.
  intros [H | H].
  - specialize (H 4096 0 eq_refl eq_refl ltac:(lia) ltac:(lia)).
    specialize (H (st (cell 0 0 0 0)) exit_cell).
    apply (cell_not_emp 0 0 0 0).
    exact (proj2 H).
  - apply refute_inplace_double_return_wit_1_split_goal_spatial.
    exact H.
Qed.
Theorem entry_sat : ExecutionGoal.inplace_double_precondition_wit_1.
Proof.
  unfold ExecutionGoal.inplace_double_precondition_wit_1.
  exists 4096, 0.
  intro H.
  change (forall s,
    ((((4096 = 4096 /\ 0 = 0) /\ -1073741824 <= 0) /\
       0 <= 1073741823) /\ (4096 # Int |-> 0) s) -> False) in H.
  apply (H (st (cell 0 0 0 0))).
  split.
  - repeat split; lia.
  - exact entry_cell.
Qed.
Print Assumptions entry_cell.
Print Assumptions exit_cell.
Print Assumptions refute_inplace_double_return_wit_1_split_goal_spatial.
Print Assumptions refute_inplace_double_return_wit_1.
Print Assumptions entry_sat.
