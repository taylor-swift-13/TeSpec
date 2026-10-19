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



Theorem entry_cell : (4096 # Int |-> (-2147483648)) (st (cell 128 0 0 0)).
Proof.
  unfold store_int; split.
  - cbn; vm_compute; intuition congruence.
  - unfold store_4byte.
    exists 128, 0, 0, 0; split.
    + cbn; vm_compute; intuition congruence.
    + exists (st (single_byte_mem 4096 128)), (st (tail1 0 0 0)).
      split; [apply st_join; apply join0|].
      split; [apply byte_at|].
      exists (st (single_byte_mem 4097 0)), (st (tail2 0 0)).
      split; [apply st_join; apply join1|].
      split; [apply byte_at|].
      exists (st (single_byte_mem 4098 0)), (st (single_byte_mem 4099 0)).
      split; [apply st_join; apply join2|].
      split; apply byte_at.
Qed.
Theorem exit_cell : (4096 # Int |-> (-2147483647)) (st (cell 128 0 0 1)).
Proof.
  unfold store_int; split.
  - cbn; vm_compute; intuition congruence.
  - unfold store_4byte.
    exists 128, 0, 0, 1; split.
    + cbn; vm_compute; intuition congruence.
    + exists (st (single_byte_mem 4096 128)), (st (tail1 0 0 1)).
      split; [apply st_join; apply join0|].
      split; [apply byte_at|].
      exists (st (single_byte_mem 4097 0)), (st (tail2 0 1)).
      split; [apply st_join; apply join1|].
      split; [apply byte_at|].
      exists (st (single_byte_mem 4098 0)), (st (single_byte_mem 4099 1)).
      split; [apply st_join; apply join2|].
      split; apply byte_at.
Qed.
Theorem refute_incr_return_wit_1_split_goal_spatial : ~ ExecutionGoal.incr_return_wit_1_split_goal_spatial.
Proof.
  unfold ExecutionGoal.incr_return_wit_1_split_goal_spatial.
  intro H.
  assert (Hupper : -2147483648 + 1 <= INT_MAX) by
    (change (-2147483648 + 1 <= 2147483647); lia).
  assert (Hlower : -2147483648 + 1 >= INT_MIN) by
    (change (-2147483648 + 1 >= -2147483648); lia).
  assert (Hlt : -2147483648 < INT_MAX) by
    (change (-2147483648 < 2147483647); lia).
  specialize (H 4096 (-2147483648) Hupper Hlower eq_refl eq_refl Hlt
    (st (cell 128 0 0 1)) exit_cell).
  destruct H as [_ Hempty].
  exact (cell_not_emp 128 0 0 1 Hempty).
Qed.
Theorem refute_incr_return_wit_1 : ~ ExecutionGoal.incr_return_wit_1.
Proof.
  unfold ExecutionGoal.incr_return_wit_1.
  intros [H | H].
  - assert (Hlt : -2147483648 < INT_MAX) by
      (change (-2147483648 < 2147483647); lia).
    specialize (H 4096 (-2147483648) eq_refl eq_refl Hlt
      (st (cell 128 0 0 1)) exit_cell).
    destruct H as [_ Hempty].
    exact (cell_not_emp 128 0 0 1 Hempty).
  - exact (refute_incr_return_wit_1_split_goal_spatial H).
Qed.
Theorem entry_sat : ExecutionGoal.incr_precondition_wit_1.
Proof.
  unfold ExecutionGoal.incr_precondition_wit_1.
  exists 4096, (-2147483648).
  intro H.
  apply (H (st (cell 128 0 0 0))).
  split.
  - split.
    + split.
      * change (4096 = 4096); reflexivity.
      * change (-2147483648 = -2147483648); reflexivity.
    + change (-2147483648 < 2147483647); lia.
  - exact entry_cell.
Qed.
Print Assumptions entry_cell.
Print Assumptions exit_cell.
Print Assumptions refute_incr_return_wit_1_split_goal_spatial.
Print Assumptions refute_incr_return_wit_1.
Print Assumptions entry_sat.
