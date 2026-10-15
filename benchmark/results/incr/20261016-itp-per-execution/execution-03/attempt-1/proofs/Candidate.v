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



Theorem entry_cell : (4096 # UInt |-> (2147483648)) (st (cell 128 0 0 0)).
Proof.
  unfold store_uint.
  split.
  - change (isvalidptr_int 4096 /\ 2147483648 >= 0 /\ 2147483648 <= Int.max_unsigned).
    vm_compute; intuition congruence.
  - unfold store_4byte.
    exists 128, 0, 0, 0.
    split.
    + change (merge_int 128 0 0 0 2147483648).
      vm_compute; intuition congruence.
    + exists (st (single_byte_mem 4096 128)), (st (tail1 0 0 0)).
      split; [apply st_join; apply join0 |].
      split; [apply byte_at |].
      exists (st (single_byte_mem 4097 0)), (st (tail2 0 0)).
      split; [apply st_join; apply join1 |].
      split; [apply byte_at |].
      exists (st (single_byte_mem 4098 0)), (st (single_byte_mem 4099 0)).
      split; [apply st_join; apply join2 |].
      split; apply byte_at.
Qed.
Theorem exit_cell : (4096 # UInt |-> (2147483649)) (st (cell 128 0 0 1)).
Proof.
  unfold store_uint.
  split.
  - change (isvalidptr_int 4096 /\ 2147483649 >= 0 /\ 2147483649 <= Int.max_unsigned).
    vm_compute; intuition congruence.
  - unfold store_4byte.
    exists 128, 0, 0, 1.
    split.
    + change (merge_int 128 0 0 1 2147483649).
      vm_compute; intuition congruence.
    + exists (st (single_byte_mem 4096 128)), (st (tail1 0 0 1)).
      split; [apply st_join; apply join0 |].
      split; [apply byte_at |].
      exists (st (single_byte_mem 4097 0)), (st (tail2 0 1)).
      split; [apply st_join; apply join1 |].
      split; [apply byte_at |].
      exists (st (single_byte_mem 4098 0)), (st (single_byte_mem 4099 1)).
      split; [apply st_join; apply join2 |].
      split; apply byte_at.
Qed.
Theorem refute_incr_return_wit_1_split_goal_spatial : ~ ExecutionGoal.incr_return_wit_1_split_goal_spatial.
Proof.
  unfold ExecutionGoal.incr_return_wit_1_split_goal_spatial.
  intro H.
  assert (Hupper : 2147483648 + 1 <= UINT_MAX) by (change (2147483648 + 1 <= 4294967295); lia).
  assert (Hlower : 2147483648 + 1 >= 0) by lia.
  assert (Holdlower : 0 <= 2147483648) by lia.
  assert (Holdupper : 2147483648 <= UINT_MAX) by (change (2147483648 <= 4294967295); lia).
  specialize (H 4096 2147483648 Hupper Hlower eq_refl eq_refl Holdlower Holdupper).
  specialize (H (st (cell 128 0 0 1)) exit_cell).
  destruct H as [_ Hemp].
  exact (ConcreteCell.cell_not_emp 128 0 0 1 Hemp).
Qed.
Theorem refute_incr_return_wit_1 : ~ ExecutionGoal.incr_return_wit_1.
Proof.
  unfold ExecutionGoal.incr_return_wit_1.
  intros [H | H].
  - assert (Hlower : 0 <= 2147483648) by lia.
    assert (Hupper : 2147483648 <= UINT_MAX) by (change (2147483648 <= 4294967295); lia).
    specialize (H 4096 2147483648 eq_refl eq_refl Hlower Hupper).
    specialize (H (st (cell 128 0 0 1)) exit_cell).
    destruct H as [_ Hemp].
    exact (ConcreteCell.cell_not_emp 128 0 0 1 Hemp).
  - assert (Hupper : 2147483648 + 1 <= UINT_MAX) by (change (2147483648 + 1 <= 4294967295); lia).
    assert (Hlower : 2147483648 + 1 >= 0) by lia.
    assert (Holdlower : 0 <= 2147483648) by lia.
    assert (Holdupper : 2147483648 <= UINT_MAX) by (change (2147483648 <= 4294967295); lia).
    specialize (H 4096 2147483648 Hupper Hlower eq_refl eq_refl Holdlower Holdupper).
    specialize (H (st (cell 128 0 0 1)) exit_cell).
    destruct H as [_ Hemp].
    exact (ConcreteCell.cell_not_emp 128 0 0 1 Hemp).
Qed.
Theorem entry_sat : ExecutionGoal.incr_precondition_wit_1.
Proof.
  unfold ExecutionGoal.incr_precondition_wit_1.
  exists 4096, 2147483648.
  intro H.
  assert (Hentry :
    ( “ (4096 = 4096) ”
      && “ (2147483648 = 2147483648) ”
      && “ (0 <= 2147483648) ”
      && “ (2147483648 <= UINT_MAX) ”
      && (4096 # UInt |-> 2147483648)) (st (cell 128 0 0 0))).
  { split.
    - split.
      + split.
        * split.
          -- change (4096 = 4096); reflexivity.
          -- change (2147483648 = 2147483648); reflexivity.
        * change (0 <= 2147483648); lia.
      + change (2147483648 <= 4294967295); lia.
    - exact entry_cell.
  }
  specialize (H (st (cell 128 0 0 0)) Hentry).
  exact H.
Qed.
Print Assumptions entry_cell.
Print Assumptions exit_cell.
Print Assumptions refute_incr_return_wit_1_split_goal_spatial.
Print Assumptions refute_incr_return_wit_1.
Print Assumptions entry_sat.
