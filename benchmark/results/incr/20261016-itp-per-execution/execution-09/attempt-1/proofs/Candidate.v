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



Theorem entry_cell : (4096 # Int |-> (1)) (st (cell 0 0 0 1)).
Proof.
  unfold store_int.
  split.
  - cbn [coq_prop].
    vm_compute; intuition congruence.
  - unfold store_4byte.
    exists 0, 0, 0, 1.
    split.
    + cbn [coq_prop].
      vm_compute; intuition congruence.
    + change ((store_byte 4096 0 **
        (store_byte 4097 0 **
          (store_byte 4098 0 ** store_byte 4099 1)))
        (st (cell 0 0 0 1))).
      unfold naive_C_Rules.sepcon.
      exists (st (single_byte_mem 4096 0)), (st (tail1 0 0 1)).
      repeat first [solve [apply st_join; apply join0] |
                    solve [apply byte_at] | match goal with |- _ /\ _ => split end].
      exists (st (single_byte_mem 4097 0)), (st (tail2 0 1)).
      repeat first [solve [apply st_join; apply join1] |
                    solve [apply byte_at] | match goal with |- _ /\ _ => split end].
      exists (st (single_byte_mem 4098 0)), (st (single_byte_mem 4099 1)).
      repeat first [solve [apply st_join; apply join2] |
                    solve [apply byte_at] | match goal with |- _ /\ _ => split end].
Qed.
Theorem exit_cell : (4096 # Int |-> (2)) (st (cell 0 0 0 2)).
Proof.
  unfold store_int.
  split.
  - cbn [coq_prop].
    vm_compute; intuition congruence.
  - unfold store_4byte.
    exists 0, 0, 0, 2.
    split.
    + cbn [coq_prop].
      vm_compute; intuition congruence.
    + change ((store_byte 4096 0 **
        (store_byte 4097 0 **
          (store_byte 4098 0 ** store_byte 4099 2)))
        (st (cell 0 0 0 2))).
      unfold naive_C_Rules.sepcon.
      exists (st (single_byte_mem 4096 0)), (st (tail1 0 0 2)).
      repeat first [solve [apply st_join; apply join0] |
                    solve [apply byte_at] | match goal with |- _ /\ _ => split end].
      exists (st (single_byte_mem 4097 0)), (st (tail2 0 2)).
      repeat first [solve [apply st_join; apply join1] |
                    solve [apply byte_at] | match goal with |- _ /\ _ => split end].
      exists (st (single_byte_mem 4098 0)), (st (single_byte_mem 4099 2)).
      repeat first [solve [apply st_join; apply join2] |
                    solve [apply byte_at] | match goal with |- _ /\ _ => split end].
Qed.
Theorem refute_incr_return_wit_1_split_goal_spatial : ~ ExecutionGoal.incr_return_wit_1_split_goal_spatial.
Proof.
  unfold ExecutionGoal.incr_return_wit_1_split_goal_spatial.
  intro H.
  assert (Hmax : 1 + 1 <= INT_MAX) by (change (1 + 1 <= 2147483647); lia).
  assert (Hmin : 1 + 1 >= INT_MIN) by (change (1 + 1 >= -2147483648); lia).
  assert (Hlt : 1 < INT_MAX) by (change (1 < 2147483647); lia).
  specialize (H 4096 1 Hmax Hmin eq_refl eq_refl Hlt
    (st (cell 0 0 0 2)) exit_cell).
  destruct H as [_ Hemp].
  exact (cell_not_emp 0 0 0 2 Hemp).
Qed.
Theorem refute_incr_return_wit_1 : ~ ExecutionGoal.incr_return_wit_1.
Proof.
  unfold ExecutionGoal.incr_return_wit_1.
  intros [H | H].
  - assert (Hlt : 1 < INT_MAX) by (change (1 < 2147483647); lia).
    specialize (H 4096 1 eq_refl eq_refl Hlt
      (st (cell 0 0 0 2)) exit_cell).
    destruct H as [_ Hemp].
    exact (cell_not_emp 0 0 0 2 Hemp).
  - assert (Hmax : 1 + 1 <= INT_MAX) by (change (1 + 1 <= 2147483647); lia).
    assert (Hmin : 1 + 1 >= INT_MIN) by (change (1 + 1 >= -2147483648); lia).
    assert (Hlt : 1 < INT_MAX) by (change (1 < 2147483647); lia).
    specialize (H 4096 1 Hmax Hmin eq_refl eq_refl Hlt
      (st (cell 0 0 0 2)) exit_cell).
    destruct H as [_ Hemp].
    exact (cell_not_emp 0 0 0 2 Hemp).
Qed.
Theorem entry_sat : ExecutionGoal.incr_precondition_wit_1.
Proof.
  unfold ExecutionGoal.incr_precondition_wit_1.
  exists 4096, 1.
  intro H.
  assert (Hentry :
    ( “ (4096 = 4096) ” && “ (1 = 1) ” &&
      “ (1 < INT_MAX) ” && (4096 # Int |-> 1))
      (st (cell 0 0 0 1))).
  { split.
    - split.
      + split.
        * change (4096 = 4096). reflexivity.
        * change (1 = 1). reflexivity.
      + change (1 < 2147483647). lia.
    - exact entry_cell. }
  specialize (H (st (cell 0 0 0 1)) Hentry).
  change False in H.
  exact H.
Qed.
Print Assumptions entry_cell.
Print Assumptions exit_cell.
Print Assumptions refute_incr_return_wit_1_split_goal_spatial.
Print Assumptions refute_incr_return_wit_1.
Print Assumptions entry_sat.
