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



Theorem entry_cell : (4096 # UInt |-> (1)) (st (cell 0 0 0 1)).
Proof.
  unfold store_uint, store_4byte.
  split.
  - change (isvalidptr_int 4096 /\ 1 >= 0 /\ 1 <= Int.max_unsigned).
    vm_compute; intuition congruence.
  - exists 0, 0, 0, 1.
    split.
    + change (merge_int 0 0 0 1 1).
      vm_compute; intuition congruence.
    + exists (st (single_byte_mem 4096 0)), (st (tail1 0 0 1)).
      split; [apply st_join; apply join0 |].
      split; [apply byte_at |].
      exists (st (single_byte_mem 4097 0)), (st (tail2 0 1)).
      split; [apply st_join; apply join1 |].
      split; [apply byte_at |].
      exists (st (single_byte_mem 4098 0)), (st (single_byte_mem 4099 1)).
      split; [apply st_join; apply join2 |].
      split; apply byte_at.
Qed.
Theorem exit_cell : (4096 # UInt |-> (2)) (st (cell 0 0 0 2)).
Proof.
  unfold store_uint, store_4byte.
  split.
  - change (isvalidptr_int 4096 /\ 2 >= 0 /\ 2 <= Int.max_unsigned).
    vm_compute; intuition congruence.
  - exists 0, 0, 0, 2.
    split.
    + change (merge_int 0 0 0 2 2).
      vm_compute; intuition congruence.
    + exists (st (single_byte_mem 4096 0)), (st (tail1 0 0 2)).
      split; [apply st_join; apply join0 |].
      split; [apply byte_at |].
      exists (st (single_byte_mem 4097 0)), (st (tail2 0 2)).
      split; [apply st_join; apply join1 |].
      split; [apply byte_at |].
      exists (st (single_byte_mem 4098 0)), (st (single_byte_mem 4099 2)).
      split; [apply st_join; apply join2 |].
      split; apply byte_at.
Qed.
Theorem refute_incr_return_wit_1_split_goal_spatial : ~ ExecutionGoal.incr_return_wit_1_split_goal_spatial.
Proof.
  unfold ExecutionGoal.incr_return_wit_1_split_goal_spatial.
  intro H.
  assert (Hmax : 1 + 1 <= UINT_MAX) by (vm_compute; congruence).
  assert (Hold : 1 <= UINT_MAX) by (vm_compute; congruence).
  specialize (H 4096 1 Hmax ltac:(lia) eq_refl eq_refl ltac:(lia) Hold).
  specialize (H (st (cell 0 0 0 2)) exit_cell).
  destruct H as [_ Hemp].
  exact (cell_not_emp 0 0 0 2 Hemp).
Qed.
Theorem refute_incr_return_wit_1 : ~ ExecutionGoal.incr_return_wit_1.
Proof.
  unfold ExecutionGoal.incr_return_wit_1.
  intros [H | H].
  - assert (Hold : 1 <= UINT_MAX) by (vm_compute; congruence).
    specialize (H 4096 1 eq_refl eq_refl ltac:(lia) Hold).
    specialize (H (st (cell 0 0 0 2)) exit_cell).
    destruct H as [_ Hemp].
    exact (cell_not_emp 0 0 0 2 Hemp).
  - assert (Hmax : 1 + 1 <= UINT_MAX) by (vm_compute; congruence).
    assert (Hold : 1 <= UINT_MAX) by (vm_compute; congruence).
    specialize (H 4096 1 Hmax ltac:(lia) eq_refl eq_refl ltac:(lia) Hold).
    specialize (H (st (cell 0 0 0 2)) exit_cell).
    destruct H as [_ Hemp].
    exact (cell_not_emp 0 0 0 2 Hemp).
Qed.
Theorem entry_sat : ExecutionGoal.incr_precondition_wit_1.
Proof.
  unfold ExecutionGoal.incr_precondition_wit_1.
  exists 4096, 1.
  intro H.
  apply (H (st (cell 0 0 0 1))).
  split.
  - split.
    + split.
      * split.
        -- change (4096 = 4096); reflexivity.
        -- change (1 = 1); reflexivity.
      * change (0 <= 1); lia.
    + change (1 <= UINT_MAX); vm_compute; congruence.
  - exact entry_cell.
Qed.
Print Assumptions entry_cell.
Print Assumptions exit_cell.
Print Assumptions refute_incr_return_wit_1_split_goal_spatial.
Print Assumptions refute_incr_return_wit_1.
Print Assumptions entry_sat.
