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
Local Open Scope Z_scope.


Require Import Goal.
Module Proofs.
Lemma proof_of_is_multiple_safety_wit_1 : Goal.is_multiple_safety_wit_1.
Proof. unfold Goal.is_multiple_safety_wit_1. intros; entailer!; vm_compute in *; lia. Qed.

Lemma proof_of_is_multiple_safety_wit_2 : Goal.is_multiple_safety_wit_2.
Proof. unfold Goal.is_multiple_safety_wit_2. intros; entailer!; vm_compute in *; lia. Qed.

Lemma proof_of_is_multiple_safety_wit_3 : Goal.is_multiple_safety_wit_3.
Proof. unfold Goal.is_multiple_safety_wit_3. intros; entailer!; vm_compute in *; lia. Qed.

Lemma proof_of_is_multiple_safety_wit_4 : Goal.is_multiple_safety_wit_4.
Proof. unfold Goal.is_multiple_safety_wit_4. intros; entailer!; vm_compute in *; lia. Qed.

Lemma proof_of_is_multiple_return_wit_1 : Goal.is_multiple_return_wit_1.
Proof. unfold Goal.is_multiple_return_wit_1. intros m [_ Hemp]. right. exists 2. split; [split; reflexivity | exact Hemp]. Qed.

Lemma proof_of_is_multiple_precondition_wit_1 : Goal.is_multiple_precondition_wit_1.
Proof. unfold Goal.is_multiple_precondition_wit_1. intro H. apply (H (@ConAssertion.empty_state ConAssertion.naive_S)). split; [repeat split; lia | apply ConAssertion.empty_state_is_empty]. Qed.
End Proofs.
