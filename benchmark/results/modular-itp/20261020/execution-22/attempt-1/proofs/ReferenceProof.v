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



Theorem entry_cell : (4096 # Int |-> (2147483645)) (st (cell 127 255 255 253)).
Proof.
  unfold store_int; split.
  - change (isvalidptr_int 4096 /\ 2147483645 <= Int.max_signed /\ 2147483645 >= Int.min_signed).
    vm_compute; intuition congruence.
  - unfold store_4byte.
    exists 127, 255, 255, 253; split.
    + change (merge_int 127 255 255 253 2147483645).
      vm_compute; intuition congruence.
    + exists (st (single_byte_mem 4096 127)), (st (tail1 255 255 253)).
      split; [apply st_join; apply join0 |].
      split; [apply byte_at |].
      exists (st (single_byte_mem 4097 255)), (st (tail2 255 253)).
      split; [apply st_join; apply join1 |].
      split; [apply byte_at |].
      exists (st (single_byte_mem 4098 255)), (st (single_byte_mem 4099 253)).
      split; [apply st_join; apply join2 |].
      split; apply byte_at.
Qed.
Theorem exit_cell : (4096 # Int |-> (2147483646)) (st (cell 127 255 255 254)).
Proof.
  unfold store_int; split.
  - change (isvalidptr_int 4096 /\ 2147483646 <= Int.max_signed /\ 2147483646 >= Int.min_signed).
    vm_compute; intuition congruence.
  - unfold store_4byte.
    exists 127, 255, 255, 254; split.
    + change (merge_int 127 255 255 254 2147483646).
      vm_compute; intuition congruence.
    + exists (st (single_byte_mem 4096 127)), (st (tail1 255 255 254)).
      split; [apply st_join; apply join0 |].
      split; [apply byte_at |].
      exists (st (single_byte_mem 4097 255)), (st (tail2 255 254)).
      split; [apply st_join; apply join1 |].
      split; [apply byte_at |].
      exists (st (single_byte_mem 4098 255)), (st (single_byte_mem 4099 254)).
      split; [apply st_join; apply join2 |].
      split; apply byte_at.
Qed.
Theorem refute_incr_return_wit_1_split_goal_spatial : ~ ExecutionGoal.incr_return_wit_1_split_goal_spatial.
Proof.
  unfold ExecutionGoal.incr_return_wit_1_split_goal_spatial.
  intro H.
  assert (Hmax : 2147483645 + 1 <= INT_MAX) by (change (2147483645 + 1 <= 2147483647); lia).
  assert (Hmin : 2147483645 + 1 >= INT_MIN) by (change (2147483645 + 1 >= -2147483648); lia).
  assert (Hlt : 2147483645 < INT_MAX) by (change (2147483645 < 2147483647); lia).
  specialize (H 4096 2147483645 Hmax Hmin eq_refl eq_refl Hlt).
  specialize (H (st (cell 127 255 255 254)) exit_cell).
  destruct H as [_ Hemp].
  exact (cell_not_emp 127 255 255 254 Hemp).
Qed.
Theorem refute_incr_return_wit_1 : ~ ExecutionGoal.incr_return_wit_1.
Proof.
  unfold ExecutionGoal.incr_return_wit_1.
  intros [H | H].
  - assert (Hlt : 2147483645 < INT_MAX) by (change (2147483645 < 2147483647); lia).
    specialize (H 4096 2147483645 eq_refl eq_refl Hlt).
    specialize (H (st (cell 127 255 255 254)) exit_cell).
    destruct H as [_ Hemp].
    exact (cell_not_emp 127 255 255 254 Hemp).
  - apply refute_incr_return_wit_1_split_goal_spatial.
    exact H.
Qed.
Theorem entry_sat : ExecutionGoal.incr_precondition_wit_1.
Proof.
  unfold ExecutionGoal.incr_precondition_wit_1.
  exists 4096, 2147483645.
  intro H.
  apply (H (st (cell 127 255 255 253))).
  split.
  - split.
    + split.
      * change (4096 = 4096); reflexivity.
      * change (2147483645 = 2147483645); reflexivity.
    + change (2147483645 < 2147483647); lia.
  - exact entry_cell.
Qed.
Print Assumptions entry_cell.
Print Assumptions exit_cell.
Print Assumptions refute_incr_return_wit_1_split_goal_spatial.
Print Assumptions refute_incr_return_wit_1.
Print Assumptions entry_sat.
