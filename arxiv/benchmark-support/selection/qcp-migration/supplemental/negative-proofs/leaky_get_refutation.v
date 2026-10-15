Require Import ResourceCounterHeap leaky_get_neg_goal.
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


Theorem leaky_get_VC_refuted : ~ leaky_get_return_wit_1.
Proof. unfold leaky_get_return_wit_1; intros [H|H]; apply (witness_not_emp 0).
 - pose proof (H 4 0 (st (m4567 0)) (uint_witness 0 ltac:(lia))) as K; exact (proj2 K).
 - pose proof (H 4 0 ltac:(lia) ltac:(lia) (st (m4567 0)) (uint_witness 0 ltac:(lia))) as K; exact (proj2 K).
Qed.
