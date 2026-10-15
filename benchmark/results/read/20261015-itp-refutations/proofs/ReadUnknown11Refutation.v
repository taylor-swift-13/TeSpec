Require Import ReadCounterHeap ReadUnknown11Goal.
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


Theorem original_VC_refuted : ~ read_return_wit_1.
Proof. unfold read_return_wit_1; intros [H|H]; apply (cell_not_emp 127 255 255 255).
 - pose proof (H 4096 (2147483647) ltac:(vm_compute; intuition congruence) ltac:(vm_compute; intuition congruence) (st (cell 127 255 255 255)) cell_value_5) as K; exact (proj2 K).
 - pose proof (H 4096 (2147483647) ltac:(vm_compute; intuition congruence) ltac:(vm_compute; intuition congruence) ltac:(vm_compute; intuition congruence) ltac:(vm_compute; intuition congruence) (st (cell 127 255 255 255)) cell_value_5) as K; exact (proj2 K).
Qed.
Theorem spatial_VC_refuted : ~ read_return_wit_1_split_goal_spatial.
Proof. unfold read_return_wit_1_split_goal_spatial; intro H; apply (cell_not_emp 127 255 255 255); pose proof (H 4096 (2147483647) ltac:(vm_compute; intuition congruence) ltac:(vm_compute; intuition congruence) ltac:(vm_compute; intuition congruence) ltac:(vm_compute; intuition congruence) (st (cell 127 255 255 255)) cell_value_5) as K; exact (proj2 K). Qed.
Theorem entry_satisfiable : read_precondition_wit_1.
Proof. unfold read_precondition_wit_1; exists 4096, (2147483647); intro H; apply (H (st (cell 127 255 255 255))); split; [split; vm_compute; reflexivity|exact cell_value_5]. Qed.
Print Assumptions original_VC_refuted.
Print Assumptions spatial_VC_refuted.
Print Assumptions entry_satisfiable.
