Require Import ResourceCounterHeap succ_attempt_leak_neg_goal.
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


Theorem succ_attempt_leak_VC_refuted : ~ succ_using_incr_attempt_return_wit_1.
Proof. unfold succ_using_incr_attempt_return_wit_1; intros [H|H]; apply (witness_not_emp 1).
 - pose proof (H 0 0 4 ltac:(lia) ltac:(lia) eq_refl (st (m4567 1)) (uint_witness 1 ltac:(lia))) as K; exact (proj2 K).
 - pose proof (H 0 0 4 ltac:(vm_compute; intuition congruence) ltac:(vm_compute; intuition congruence) ltac:(lia) ltac:(lia) eq_refl (st (m4567 1)) (uint_witness 1 ltac:(lia))) as K; exact (proj2 K).
Qed.
