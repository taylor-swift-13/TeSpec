Require Import ReadCounterHeap ReadUnknown03Goal.
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



Theorem case_03_return_refuted : ~ ReadUnknown03Goal.read_return_wit_1.
Proof.
  unfold ReadUnknown03Goal.read_return_wit_1.
  intros [H | H].
  - specialize (H 4096 1 eq_refl eq_refl).
    pose proof (H (st (cell 0 0 0 1)) cell_value_3) as HE.
    destruct HE as [_ HE].
    exact (cell_not_emp 0 0 0 1 HE).
  - assert (Hmax : 1 <= INT_MAX) by (vm_compute; congruence).
    assert (Hmin : 1 >= INT_MIN) by (vm_compute; congruence).
    specialize (H 4096 1 Hmax Hmin eq_refl eq_refl).
    pose proof (H (st (cell 0 0 0 1)) cell_value_3) as HE.
    destruct HE as [_ HE].
    exact (cell_not_emp 0 0 0 1 HE).
Qed.

Theorem case_03_spatial_refuted : ~ ReadUnknown03Goal.read_return_wit_1_split_goal_spatial.
Proof.
  unfold ReadUnknown03Goal.read_return_wit_1_split_goal_spatial.
  intro H.
  assert (Hmax : 1 <= INT_MAX) by (vm_compute; congruence).
  assert (Hmin : 1 >= INT_MIN) by (vm_compute; congruence).
  specialize (H 4096 1 Hmax Hmin eq_refl eq_refl).
  pose proof (H (st (cell 0 0 0 1)) cell_value_3) as HE.
  destruct HE as [_ HE].
  exact (cell_not_emp 0 0 0 1 HE).
Qed.

Theorem case_03_entry_sat : ReadUnknown03Goal.read_precondition_wit_1.
Proof.
  unfold ReadUnknown03Goal.read_precondition_wit_1.
  exists 4096, 1.
  intro H.
  apply (H (st (cell 0 0 0 1))).
  repeat first [exact cell_value_3 | split | reflexivity].
Qed.
Print Assumptions case_03_return_refuted.
Print Assumptions case_03_spatial_refuted.
Print Assumptions case_03_entry_sat.
