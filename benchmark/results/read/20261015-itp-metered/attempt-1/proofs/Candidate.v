Require Import ReadCounterHeap ReadUnknown00Goal ReadUnknown01Goal ReadUnknown02Goal ReadUnknown03Goal ReadUnknown04Goal ReadUnknown05Goal ReadUnknown06Goal ReadUnknown07Goal ReadUnknown08Goal ReadUnknown09Goal ReadUnknown10Goal ReadUnknown11Goal.
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



Theorem case_00_return_refuted : ~ ReadUnknown00Goal.read_return_wit_1.
Proof.
  unfold ReadUnknown00Goal.read_return_wit_1.
  intros [H | H].
  - specialize (H 4096 (-2147483648) eq_refl eq_refl (st (cell 128 0 0 0)) cell_value_0).
    exact (cell_not_emp 128 0 0 0 (proj2 H)).
  - assert (Hmax : (-2147483648) <= INT_MAX) by (vm_compute; intuition congruence).
    assert (Hmin : (-2147483648) >= INT_MIN) by (vm_compute; intuition congruence).
    specialize (H 4096 (-2147483648) Hmax Hmin eq_refl eq_refl (st (cell 128 0 0 0)) cell_value_0).
    exact (cell_not_emp 128 0 0 0 (proj2 H)).
Qed.

Theorem case_00_spatial_refuted : ~ ReadUnknown00Goal.read_return_wit_1_split_goal_spatial.
Proof.
  unfold ReadUnknown00Goal.read_return_wit_1_split_goal_spatial.
  intro H.
  assert (Hmax : (-2147483648) <= INT_MAX) by (vm_compute; intuition congruence).
  assert (Hmin : (-2147483648) >= INT_MIN) by (vm_compute; intuition congruence).
  specialize (H 4096 (-2147483648) Hmax Hmin eq_refl eq_refl (st (cell 128 0 0 0)) cell_value_0).
  exact (cell_not_emp 128 0 0 0 (proj2 H)).
Qed.

Theorem case_00_entry_sat : ReadUnknown00Goal.read_precondition_wit_1.
Proof.
  unfold ReadUnknown00Goal.read_precondition_wit_1.
  exists 4096, (-2147483648).
  intro H.
  apply (H (st (cell 128 0 0 0))).
  pose proof cell_value_0 as Hv.
  unfold naive_C_Rules.andp, naive_C_Rules.coq_prop.
  intuition congruence.
Qed.

Theorem case_01_return_refuted : ~ ReadUnknown01Goal.read_return_wit_1.
Proof.
  unfold ReadUnknown01Goal.read_return_wit_1.
  intros [H | H].
  - specialize (H 4096 (-1) eq_refl eq_refl (st (cell 255 255 255 255)) cell_value_1).
    exact (cell_not_emp 255 255 255 255 (proj2 H)).
  - assert (Hmax : (-1) <= INT_MAX) by (vm_compute; intuition congruence).
    assert (Hmin : (-1) >= INT_MIN) by (vm_compute; intuition congruence).
    specialize (H 4096 (-1) Hmax Hmin eq_refl eq_refl (st (cell 255 255 255 255)) cell_value_1).
    exact (cell_not_emp 255 255 255 255 (proj2 H)).
Qed.

Theorem case_01_spatial_refuted : ~ ReadUnknown01Goal.read_return_wit_1_split_goal_spatial.
Proof.
  unfold ReadUnknown01Goal.read_return_wit_1_split_goal_spatial.
  intro H.
  assert (Hmax : (-1) <= INT_MAX) by (vm_compute; intuition congruence).
  assert (Hmin : (-1) >= INT_MIN) by (vm_compute; intuition congruence).
  specialize (H 4096 (-1) Hmax Hmin eq_refl eq_refl (st (cell 255 255 255 255)) cell_value_1).
  exact (cell_not_emp 255 255 255 255 (proj2 H)).
Qed.

Theorem case_01_entry_sat : ReadUnknown01Goal.read_precondition_wit_1.
Proof.
  unfold ReadUnknown01Goal.read_precondition_wit_1.
  exists 4096, (-1).
  intro H.
  apply (H (st (cell 255 255 255 255))).
  pose proof cell_value_1 as Hv.
  unfold naive_C_Rules.andp, naive_C_Rules.coq_prop.
  intuition congruence.
Qed.

Theorem case_02_return_refuted : ~ ReadUnknown02Goal.read_return_wit_1.
Proof.
  unfold ReadUnknown02Goal.read_return_wit_1.
  intros [H | H].
  - specialize (H 4096 0 eq_refl eq_refl (st (cell 0 0 0 0)) cell_value_2).
    exact (cell_not_emp 0 0 0 0 (proj2 H)).
  - assert (Hmax : 0 <= INT_MAX) by (vm_compute; intuition congruence).
    assert (Hmin : 0 >= INT_MIN) by (vm_compute; intuition congruence).
    specialize (H 4096 0 Hmax Hmin eq_refl eq_refl (st (cell 0 0 0 0)) cell_value_2).
    exact (cell_not_emp 0 0 0 0 (proj2 H)).
Qed.

Theorem case_02_spatial_refuted : ~ ReadUnknown02Goal.read_return_wit_1_split_goal_spatial.
Proof.
  unfold ReadUnknown02Goal.read_return_wit_1_split_goal_spatial.
  intro H.
  assert (Hmax : 0 <= INT_MAX) by (vm_compute; intuition congruence).
  assert (Hmin : 0 >= INT_MIN) by (vm_compute; intuition congruence).
  specialize (H 4096 0 Hmax Hmin eq_refl eq_refl (st (cell 0 0 0 0)) cell_value_2).
  exact (cell_not_emp 0 0 0 0 (proj2 H)).
Qed.

Theorem case_02_entry_sat : ReadUnknown02Goal.read_precondition_wit_1.
Proof.
  unfold ReadUnknown02Goal.read_precondition_wit_1.
  exists 4096, 0.
  intro H.
  apply (H (st (cell 0 0 0 0))).
  pose proof cell_value_2 as Hv.
  unfold naive_C_Rules.andp, naive_C_Rules.coq_prop.
  intuition congruence.
Qed.

Theorem case_03_return_refuted : ~ ReadUnknown03Goal.read_return_wit_1.
Proof.
  unfold ReadUnknown03Goal.read_return_wit_1.
  intros [H | H].
  - specialize (H 4096 1 eq_refl eq_refl (st (cell 0 0 0 1)) cell_value_3).
    exact (cell_not_emp 0 0 0 1 (proj2 H)).
  - assert (Hmax : 1 <= INT_MAX) by (vm_compute; intuition congruence).
    assert (Hmin : 1 >= INT_MIN) by (vm_compute; intuition congruence).
    specialize (H 4096 1 Hmax Hmin eq_refl eq_refl (st (cell 0 0 0 1)) cell_value_3).
    exact (cell_not_emp 0 0 0 1 (proj2 H)).
Qed.

Theorem case_03_spatial_refuted : ~ ReadUnknown03Goal.read_return_wit_1_split_goal_spatial.
Proof.
  unfold ReadUnknown03Goal.read_return_wit_1_split_goal_spatial.
  intro H.
  assert (Hmax : 1 <= INT_MAX) by (vm_compute; intuition congruence).
  assert (Hmin : 1 >= INT_MIN) by (vm_compute; intuition congruence).
  specialize (H 4096 1 Hmax Hmin eq_refl eq_refl (st (cell 0 0 0 1)) cell_value_3).
  exact (cell_not_emp 0 0 0 1 (proj2 H)).
Qed.

Theorem case_03_entry_sat : ReadUnknown03Goal.read_precondition_wit_1.
Proof.
  unfold ReadUnknown03Goal.read_precondition_wit_1.
  exists 4096, 1.
  intro H.
  apply (H (st (cell 0 0 0 1))).
  pose proof cell_value_3 as Hv.
  unfold naive_C_Rules.andp, naive_C_Rules.coq_prop.
  intuition congruence.
Qed.

Theorem case_04_return_refuted : ~ ReadUnknown04Goal.read_return_wit_1.
Proof.
  unfold ReadUnknown04Goal.read_return_wit_1.
  intros [H | H].
  - specialize (H 4096 7 eq_refl eq_refl (st (cell 0 0 0 7)) cell_value_4).
    exact (cell_not_emp 0 0 0 7 (proj2 H)).
  - assert (Hmax : 7 <= INT_MAX) by (vm_compute; intuition congruence).
    assert (Hmin : 7 >= INT_MIN) by (vm_compute; intuition congruence).
    specialize (H 4096 7 Hmax Hmin eq_refl eq_refl (st (cell 0 0 0 7)) cell_value_4).
    exact (cell_not_emp 0 0 0 7 (proj2 H)).
Qed.

Theorem case_04_spatial_refuted : ~ ReadUnknown04Goal.read_return_wit_1_split_goal_spatial.
Proof.
  unfold ReadUnknown04Goal.read_return_wit_1_split_goal_spatial.
  intro H.
  assert (Hmax : 7 <= INT_MAX) by (vm_compute; intuition congruence).
  assert (Hmin : 7 >= INT_MIN) by (vm_compute; intuition congruence).
  specialize (H 4096 7 Hmax Hmin eq_refl eq_refl (st (cell 0 0 0 7)) cell_value_4).
  exact (cell_not_emp 0 0 0 7 (proj2 H)).
Qed.

Theorem case_04_entry_sat : ReadUnknown04Goal.read_precondition_wit_1.
Proof.
  unfold ReadUnknown04Goal.read_precondition_wit_1.
  exists 4096, 7.
  intro H.
  apply (H (st (cell 0 0 0 7))).
  pose proof cell_value_4 as Hv.
  unfold naive_C_Rules.andp, naive_C_Rules.coq_prop.
  intuition congruence.
Qed.

Theorem case_05_return_refuted : ~ ReadUnknown05Goal.read_return_wit_1.
Proof.
  unfold ReadUnknown05Goal.read_return_wit_1.
  intros [H | H].
  - specialize (H 4096 2147483647 eq_refl eq_refl (st (cell 127 255 255 255)) cell_value_5).
    exact (cell_not_emp 127 255 255 255 (proj2 H)).
  - assert (Hmax : 2147483647 <= INT_MAX) by (vm_compute; intuition congruence).
    assert (Hmin : 2147483647 >= INT_MIN) by (vm_compute; intuition congruence).
    specialize (H 4096 2147483647 Hmax Hmin eq_refl eq_refl (st (cell 127 255 255 255)) cell_value_5).
    exact (cell_not_emp 127 255 255 255 (proj2 H)).
Qed.

Theorem case_05_spatial_refuted : ~ ReadUnknown05Goal.read_return_wit_1_split_goal_spatial.
Proof.
  unfold ReadUnknown05Goal.read_return_wit_1_split_goal_spatial.
  intro H.
  assert (Hmax : 2147483647 <= INT_MAX) by (vm_compute; intuition congruence).
  assert (Hmin : 2147483647 >= INT_MIN) by (vm_compute; intuition congruence).
  specialize (H 4096 2147483647 Hmax Hmin eq_refl eq_refl (st (cell 127 255 255 255)) cell_value_5).
  exact (cell_not_emp 127 255 255 255 (proj2 H)).
Qed.

Theorem case_05_entry_sat : ReadUnknown05Goal.read_precondition_wit_1.
Proof.
  unfold ReadUnknown05Goal.read_precondition_wit_1.
  exists 4096, 2147483647.
  intro H.
  apply (H (st (cell 127 255 255 255))).
  pose proof cell_value_5 as Hv.
  unfold naive_C_Rules.andp, naive_C_Rules.coq_prop.
  intuition congruence.
Qed.

Theorem case_06_return_refuted : ~ ReadUnknown06Goal.read_return_wit_1.
Proof.
  unfold ReadUnknown06Goal.read_return_wit_1.
  intros [H | H].
  - specialize (H 4096 (-2147483648) eq_refl eq_refl (st (cell 128 0 0 0)) cell_value_0).
    exact (cell_not_emp 128 0 0 0 (proj2 H)).
  - assert (Hmax : (-2147483648) <= INT_MAX) by (vm_compute; intuition congruence).
    assert (Hmin : (-2147483648) >= INT_MIN) by (vm_compute; intuition congruence).
    specialize (H 4096 (-2147483648) Hmax Hmin eq_refl eq_refl (st (cell 128 0 0 0)) cell_value_0).
    exact (cell_not_emp 128 0 0 0 (proj2 H)).
Qed.

Theorem case_06_spatial_refuted : ~ ReadUnknown06Goal.read_return_wit_1_split_goal_spatial.
Proof.
  unfold ReadUnknown06Goal.read_return_wit_1_split_goal_spatial.
  intro H.
  assert (Hmax : (-2147483648) <= INT_MAX) by (vm_compute; intuition congruence).
  assert (Hmin : (-2147483648) >= INT_MIN) by (vm_compute; intuition congruence).
  specialize (H 4096 (-2147483648) Hmax Hmin eq_refl eq_refl (st (cell 128 0 0 0)) cell_value_0).
  exact (cell_not_emp 128 0 0 0 (proj2 H)).
Qed.

Theorem case_06_entry_sat : ReadUnknown06Goal.read_precondition_wit_1.
Proof.
  unfold ReadUnknown06Goal.read_precondition_wit_1.
  exists 4096, (-2147483648).
  intro H.
  apply (H (st (cell 128 0 0 0))).
  pose proof cell_value_0 as Hv.
  unfold naive_C_Rules.andp, naive_C_Rules.coq_prop.
  intuition congruence.
Qed.

Theorem case_07_return_refuted : ~ ReadUnknown07Goal.read_return_wit_1.
Proof.
  unfold ReadUnknown07Goal.read_return_wit_1.
  intros [H | H].
  - specialize (H 4096 (-1) eq_refl eq_refl (st (cell 255 255 255 255)) cell_value_1).
    exact (cell_not_emp 255 255 255 255 (proj2 H)).
  - assert (Hmax : (-1) <= INT_MAX) by (vm_compute; intuition congruence).
    assert (Hmin : (-1) >= INT_MIN) by (vm_compute; intuition congruence).
    specialize (H 4096 (-1) Hmax Hmin eq_refl eq_refl (st (cell 255 255 255 255)) cell_value_1).
    exact (cell_not_emp 255 255 255 255 (proj2 H)).
Qed.

Theorem case_07_spatial_refuted : ~ ReadUnknown07Goal.read_return_wit_1_split_goal_spatial.
Proof.
  unfold ReadUnknown07Goal.read_return_wit_1_split_goal_spatial.
  intro H.
  assert (Hmax : (-1) <= INT_MAX) by (vm_compute; intuition congruence).
  assert (Hmin : (-1) >= INT_MIN) by (vm_compute; intuition congruence).
  specialize (H 4096 (-1) Hmax Hmin eq_refl eq_refl (st (cell 255 255 255 255)) cell_value_1).
  exact (cell_not_emp 255 255 255 255 (proj2 H)).
Qed.

Theorem case_07_entry_sat : ReadUnknown07Goal.read_precondition_wit_1.
Proof.
  unfold ReadUnknown07Goal.read_precondition_wit_1.
  exists 4096, (-1).
  intro H.
  apply (H (st (cell 255 255 255 255))).
  pose proof cell_value_1 as Hv.
  unfold naive_C_Rules.andp, naive_C_Rules.coq_prop.
  intuition congruence.
Qed.

Theorem case_08_return_refuted : ~ ReadUnknown08Goal.read_return_wit_1.
Proof.
  unfold ReadUnknown08Goal.read_return_wit_1.
  intros [H | H].
  - specialize (H 4096 0 eq_refl eq_refl (st (cell 0 0 0 0)) cell_value_2).
    exact (cell_not_emp 0 0 0 0 (proj2 H)).
  - assert (Hmax : 0 <= INT_MAX) by (vm_compute; intuition congruence).
    assert (Hmin : 0 >= INT_MIN) by (vm_compute; intuition congruence).
    specialize (H 4096 0 Hmax Hmin eq_refl eq_refl (st (cell 0 0 0 0)) cell_value_2).
    exact (cell_not_emp 0 0 0 0 (proj2 H)).
Qed.

Theorem case_08_spatial_refuted : ~ ReadUnknown08Goal.read_return_wit_1_split_goal_spatial.
Proof.
  unfold ReadUnknown08Goal.read_return_wit_1_split_goal_spatial.
  intro H.
  assert (Hmax : 0 <= INT_MAX) by (vm_compute; intuition congruence).
  assert (Hmin : 0 >= INT_MIN) by (vm_compute; intuition congruence).
  specialize (H 4096 0 Hmax Hmin eq_refl eq_refl (st (cell 0 0 0 0)) cell_value_2).
  exact (cell_not_emp 0 0 0 0 (proj2 H)).
Qed.

Theorem case_08_entry_sat : ReadUnknown08Goal.read_precondition_wit_1.
Proof.
  unfold ReadUnknown08Goal.read_precondition_wit_1.
  exists 4096, 0.
  intro H.
  apply (H (st (cell 0 0 0 0))).
  pose proof cell_value_2 as Hv.
  unfold naive_C_Rules.andp, naive_C_Rules.coq_prop.
  intuition congruence.
Qed.

Theorem case_09_return_refuted : ~ ReadUnknown09Goal.read_return_wit_1.
Proof.
  unfold ReadUnknown09Goal.read_return_wit_1.
  intros [H | H].
  - specialize (H 4096 1 eq_refl eq_refl (st (cell 0 0 0 1)) cell_value_3).
    exact (cell_not_emp 0 0 0 1 (proj2 H)).
  - assert (Hmax : 1 <= INT_MAX) by (vm_compute; intuition congruence).
    assert (Hmin : 1 >= INT_MIN) by (vm_compute; intuition congruence).
    specialize (H 4096 1 Hmax Hmin eq_refl eq_refl (st (cell 0 0 0 1)) cell_value_3).
    exact (cell_not_emp 0 0 0 1 (proj2 H)).
Qed.

Theorem case_09_spatial_refuted : ~ ReadUnknown09Goal.read_return_wit_1_split_goal_spatial.
Proof.
  unfold ReadUnknown09Goal.read_return_wit_1_split_goal_spatial.
  intro H.
  assert (Hmax : 1 <= INT_MAX) by (vm_compute; intuition congruence).
  assert (Hmin : 1 >= INT_MIN) by (vm_compute; intuition congruence).
  specialize (H 4096 1 Hmax Hmin eq_refl eq_refl (st (cell 0 0 0 1)) cell_value_3).
  exact (cell_not_emp 0 0 0 1 (proj2 H)).
Qed.

Theorem case_09_entry_sat : ReadUnknown09Goal.read_precondition_wit_1.
Proof.
  unfold ReadUnknown09Goal.read_precondition_wit_1.
  exists 4096, 1.
  intro H.
  apply (H (st (cell 0 0 0 1))).
  pose proof cell_value_3 as Hv.
  unfold naive_C_Rules.andp, naive_C_Rules.coq_prop.
  intuition congruence.
Qed.

Theorem case_10_return_refuted : ~ ReadUnknown10Goal.read_return_wit_1.
Proof.
  unfold ReadUnknown10Goal.read_return_wit_1.
  intros [H | H].
  - specialize (H 4096 7 eq_refl eq_refl (st (cell 0 0 0 7)) cell_value_4).
    exact (cell_not_emp 0 0 0 7 (proj2 H)).
  - assert (Hmax : 7 <= INT_MAX) by (vm_compute; intuition congruence).
    assert (Hmin : 7 >= INT_MIN) by (vm_compute; intuition congruence).
    specialize (H 4096 7 Hmax Hmin eq_refl eq_refl (st (cell 0 0 0 7)) cell_value_4).
    exact (cell_not_emp 0 0 0 7 (proj2 H)).
Qed.

Theorem case_10_spatial_refuted : ~ ReadUnknown10Goal.read_return_wit_1_split_goal_spatial.
Proof.
  unfold ReadUnknown10Goal.read_return_wit_1_split_goal_spatial.
  intro H.
  assert (Hmax : 7 <= INT_MAX) by (vm_compute; intuition congruence).
  assert (Hmin : 7 >= INT_MIN) by (vm_compute; intuition congruence).
  specialize (H 4096 7 Hmax Hmin eq_refl eq_refl (st (cell 0 0 0 7)) cell_value_4).
  exact (cell_not_emp 0 0 0 7 (proj2 H)).
Qed.

Theorem case_10_entry_sat : ReadUnknown10Goal.read_precondition_wit_1.
Proof.
  unfold ReadUnknown10Goal.read_precondition_wit_1.
  exists 4096, 7.
  intro H.
  apply (H (st (cell 0 0 0 7))).
  pose proof cell_value_4 as Hv.
  unfold naive_C_Rules.andp, naive_C_Rules.coq_prop.
  intuition congruence.
Qed.

Theorem case_11_return_refuted : ~ ReadUnknown11Goal.read_return_wit_1.
Proof.
  unfold ReadUnknown11Goal.read_return_wit_1.
  intros [H | H].
  - specialize (H 4096 2147483647 eq_refl eq_refl (st (cell 127 255 255 255)) cell_value_5).
    exact (cell_not_emp 127 255 255 255 (proj2 H)).
  - assert (Hmax : 2147483647 <= INT_MAX) by (vm_compute; intuition congruence).
    assert (Hmin : 2147483647 >= INT_MIN) by (vm_compute; intuition congruence).
    specialize (H 4096 2147483647 Hmax Hmin eq_refl eq_refl (st (cell 127 255 255 255)) cell_value_5).
    exact (cell_not_emp 127 255 255 255 (proj2 H)).
Qed.

Theorem case_11_spatial_refuted : ~ ReadUnknown11Goal.read_return_wit_1_split_goal_spatial.
Proof.
  unfold ReadUnknown11Goal.read_return_wit_1_split_goal_spatial.
  intro H.
  assert (Hmax : 2147483647 <= INT_MAX) by (vm_compute; intuition congruence).
  assert (Hmin : 2147483647 >= INT_MIN) by (vm_compute; intuition congruence).
  specialize (H 4096 2147483647 Hmax Hmin eq_refl eq_refl (st (cell 127 255 255 255)) cell_value_5).
  exact (cell_not_emp 127 255 255 255 (proj2 H)).
Qed.

Theorem case_11_entry_sat : ReadUnknown11Goal.read_precondition_wit_1.
Proof.
  unfold ReadUnknown11Goal.read_precondition_wit_1.
  exists 4096, 2147483647.
  intro H.
  apply (H (st (cell 127 255 255 255))).
  pose proof cell_value_5 as Hv.
  unfold naive_C_Rules.andp, naive_C_Rules.coq_prop.
  intuition congruence.
Qed.
Print Assumptions case_00_return_refuted.
Print Assumptions case_00_spatial_refuted.
Print Assumptions case_00_entry_sat.
Print Assumptions case_01_return_refuted.
Print Assumptions case_01_spatial_refuted.
Print Assumptions case_01_entry_sat.
Print Assumptions case_02_return_refuted.
Print Assumptions case_02_spatial_refuted.
Print Assumptions case_02_entry_sat.
Print Assumptions case_03_return_refuted.
Print Assumptions case_03_spatial_refuted.
Print Assumptions case_03_entry_sat.
Print Assumptions case_04_return_refuted.
Print Assumptions case_04_spatial_refuted.
Print Assumptions case_04_entry_sat.
Print Assumptions case_05_return_refuted.
Print Assumptions case_05_spatial_refuted.
Print Assumptions case_05_entry_sat.
Print Assumptions case_06_return_refuted.
Print Assumptions case_06_spatial_refuted.
Print Assumptions case_06_entry_sat.
Print Assumptions case_07_return_refuted.
Print Assumptions case_07_spatial_refuted.
Print Assumptions case_07_entry_sat.
Print Assumptions case_08_return_refuted.
Print Assumptions case_08_spatial_refuted.
Print Assumptions case_08_entry_sat.
Print Assumptions case_09_return_refuted.
Print Assumptions case_09_spatial_refuted.
Print Assumptions case_09_entry_sat.
Print Assumptions case_10_return_refuted.
Print Assumptions case_10_spatial_refuted.
Print Assumptions case_10_entry_sat.
Print Assumptions case_11_return_refuted.
Print Assumptions case_11_spatial_refuted.
Print Assumptions case_11_entry_sat.
