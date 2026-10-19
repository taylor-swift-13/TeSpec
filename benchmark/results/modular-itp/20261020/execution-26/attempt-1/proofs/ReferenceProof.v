Require Import ReadCounterHeap ReadUnknown00Goal.
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
  - specialize (H 4096 INT_MIN eq_refl eq_refl).
    specialize (H (st (cell 128 0 0 0)) cell_value_0).
    destruct H as [_ Hempty].
    exact (cell_not_emp 128 0 0 0 Hempty).
  - specialize (H 4096 INT_MIN ltac:(vm_compute; congruence)
                  ltac:(vm_compute; congruence) eq_refl eq_refl).
    specialize (H (st (cell 128 0 0 0)) cell_value_0).
    destruct H as [_ Hempty].
    exact (cell_not_emp 128 0 0 0 Hempty).
Qed.

Theorem case_00_spatial_refuted : ~ ReadUnknown00Goal.read_return_wit_1_split_goal_spatial.
Proof.
  unfold ReadUnknown00Goal.read_return_wit_1_split_goal_spatial.
  intro H.
  specialize (H 4096 INT_MIN ltac:(vm_compute; congruence)
                ltac:(vm_compute; congruence) eq_refl eq_refl).
  specialize (H (st (cell 128 0 0 0)) cell_value_0).
  destruct H as [_ Hempty].
  exact (cell_not_emp 128 0 0 0 Hempty).
Qed.

Theorem case_00_entry_sat : ReadUnknown00Goal.read_precondition_wit_1.
Proof.
  unfold ReadUnknown00Goal.read_precondition_wit_1.
  exists 4096, INT_MIN.
  intro H.
  apply (H (st (cell 128 0 0 0))).
  pose proof cell_value_0 as Hcell.
  unfold naive_C_Rules.andp, naive_C_Rules.coq_prop.
  repeat first [assumption | reflexivity | apply conj].
Qed.
Print Assumptions case_00_return_refuted.
Print Assumptions case_00_spatial_refuted.
Print Assumptions case_00_entry_sat.
