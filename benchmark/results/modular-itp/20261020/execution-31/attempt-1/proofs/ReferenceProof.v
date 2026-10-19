Require Import ReadCounterHeap ReadUnknown02Goal.
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



Theorem case_02_return_refuted : ~ ReadUnknown02Goal.read_return_wit_1.
Proof.
  unfold ReadUnknown02Goal.read_return_wit_1.
  intros [H | H].
  - specialize (H 4096 0 eq_refl eq_refl
      (st (cell 0 0 0 0)) cell_value_2).
    destruct H as [_ Hemp].
    exact (cell_not_emp 0 0 0 0 Hemp).
  - assert (Hmax : 0 <= INT_MAX) by (vm_compute; congruence).
    assert (Hmin : 0 >= INT_MIN) by (vm_compute; congruence).
    specialize (H 4096 0 Hmax Hmin eq_refl eq_refl
      (st (cell 0 0 0 0)) cell_value_2).
    destruct H as [_ Hemp].
    exact (cell_not_emp 0 0 0 0 Hemp).
Qed.

Theorem case_02_spatial_refuted : ~ ReadUnknown02Goal.read_return_wit_1_split_goal_spatial.
Proof.
  unfold ReadUnknown02Goal.read_return_wit_1_split_goal_spatial.
  intro H.
  assert (Hmax : 0 <= INT_MAX) by (vm_compute; congruence).
  assert (Hmin : 0 >= INT_MIN) by (vm_compute; congruence).
  specialize (H 4096 0 Hmax Hmin eq_refl eq_refl
    (st (cell 0 0 0 0)) cell_value_2).
  destruct H as [_ Hemp].
  exact (cell_not_emp 0 0 0 0 Hemp).
Qed.

Theorem case_02_entry_sat : ReadUnknown02Goal.read_precondition_wit_1.
Proof.
  unfold ReadUnknown02Goal.read_precondition_wit_1.
  exists 4096, 0.
  intro H.
  apply (H (st (cell 0 0 0 0))).
  unfold naive_C_Rules.andp, naive_C_Rules.coq_prop.
  pose proof cell_value_2 as Hcell.
  tauto.
Qed.
Print Assumptions case_02_return_refuted.
Print Assumptions case_02_spatial_refuted.
Print Assumptions case_02_entry_sat.
