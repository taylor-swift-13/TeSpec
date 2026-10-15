Require Import ReadCounterHeap ReadUnknown05Goal.
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



Theorem case_05_return_refuted : ~ ReadUnknown05Goal.read_return_wit_1.
Proof.
  unfold ReadUnknown05Goal.read_return_wit_1.
  intros [H | H].
  - pose proof (H 4096 2147483647 eq_refl eq_refl
      (st (cell 127 255 255 255)) cell_value_5) as HH.
    destruct HH as [_ HE].
    exact (cell_not_emp 127 255 255 255 HE).
  - assert (Hmax : 2147483647 <= INT_MAX) by (vm_compute; congruence).
    assert (Hmin : 2147483647 >= INT_MIN) by (vm_compute; congruence).
    pose proof (H 4096 2147483647 Hmax Hmin eq_refl eq_refl
      (st (cell 127 255 255 255)) cell_value_5) as HH.
    destruct HH as [_ HE].
    exact (cell_not_emp 127 255 255 255 HE).
Qed.

Theorem case_05_spatial_refuted : ~ ReadUnknown05Goal.read_return_wit_1_split_goal_spatial.
Proof.
  unfold ReadUnknown05Goal.read_return_wit_1_split_goal_spatial.
  intro H.
  assert (Hmax : 2147483647 <= INT_MAX) by (vm_compute; congruence).
  assert (Hmin : 2147483647 >= INT_MIN) by (vm_compute; congruence).
  pose proof (H 4096 2147483647 Hmax Hmin eq_refl eq_refl
    (st (cell 127 255 255 255)) cell_value_5) as HH.
  destruct HH as [_ HE].
  exact (cell_not_emp 127 255 255 255 HE).
Qed.

Theorem case_05_entry_sat : ReadUnknown05Goal.read_precondition_wit_1.
Proof.
  unfold ReadUnknown05Goal.read_precondition_wit_1.
  exists 4096, 2147483647.
  intro H.
  apply (H (st (cell 127 255 255 255))).
  unfold naive_C_Rules.andp, naive_C_Rules.coq_prop.
  repeat first [exact cell_value_5 | reflexivity | split].
Qed.
Print Assumptions case_05_return_refuted.
Print Assumptions case_05_spatial_refuted.
Print Assumptions case_05_entry_sat.
