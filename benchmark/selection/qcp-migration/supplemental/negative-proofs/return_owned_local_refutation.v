Require Import ResourceCounterHeap ResourceDoubleHeap return_owned_local_neg_goal.
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

Theorem return_owned_local_main_VC_refuted : ~ main_return_wit_1.
Proof. unfold main_return_wit_1; intros [H|H]; apply two_words_not_emp.
 - pose proof (H 4 5 12 eq_refl ltac:(lia) (st two_words) two_word_witness) as K; exact (proj2 K).
 - pose proof (H 4 5 12 ltac:(lia) ltac:(lia) eq_refl ltac:(lia) (st two_words) two_word_witness) as K; exact (proj2 K).
Qed.
