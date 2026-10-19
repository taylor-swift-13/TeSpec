Require Import ReadCounterHeap ReadUnknown07Goal.
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



Theorem case_07_return_refuted : ~ ReadUnknown07Goal.read_return_wit_1.
Proof.
  unfold ReadUnknown07Goal.read_return_wit_1.
  intros [H | H].
  - pose proof (H 4096 (-1) eq_refl eq_refl
      (st (cell 255 255 255 255)) cell_value_1) as HC.
    change ((-1 = -1) /\ emp (st (cell 255 255 255 255))) in HC.
    exact (cell_not_emp 255 255 255 255 (proj2 HC)).
  - assert (Hmax : -1 <= INT_MAX) by (vm_compute; congruence).
    assert (Hmin : -1 >= INT_MIN) by (vm_compute; congruence).
    pose proof (H 4096 (-1) Hmax Hmin eq_refl eq_refl
      (st (cell 255 255 255 255)) cell_value_1) as HC.
    change (True /\ emp (st (cell 255 255 255 255))) in HC.
    exact (cell_not_emp 255 255 255 255 (proj2 HC)).
Qed.

Theorem case_07_spatial_refuted : ~ ReadUnknown07Goal.read_return_wit_1_split_goal_spatial.
Proof.
  unfold ReadUnknown07Goal.read_return_wit_1_split_goal_spatial.
  intro H.
  assert (Hmax : -1 <= INT_MAX) by (vm_compute; congruence).
  assert (Hmin : -1 >= INT_MIN) by (vm_compute; congruence).
  pose proof (H 4096 (-1) Hmax Hmin eq_refl eq_refl
    (st (cell 255 255 255 255)) cell_value_1) as HC.
  change (True /\ emp (st (cell 255 255 255 255))) in HC.
  exact (cell_not_emp 255 255 255 255 (proj2 HC)).
Qed.

Theorem case_07_entry_sat : ReadUnknown07Goal.read_precondition_wit_1.
Proof.
  unfold ReadUnknown07Goal.read_precondition_wit_1.
  exists 4096, (-1).
  intro H.
  apply (H (st (cell 255 255 255 255))).
  unfold naive_C_Rules.andp, naive_C_Rules.coq_prop.
  repeat first [ exact cell_value_1 | reflexivity | split ].
Qed.
Print Assumptions case_07_return_refuted.
Print Assumptions case_07_spatial_refuted.
Print Assumptions case_07_entry_sat.
