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
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Local Open Scope sac.

Require Import Goal.
Module Proofs.
Lemma proof_of_sample_safety_wit_1 : Goal.sample_safety_wit_1.
Proof. unfold Goal.sample_safety_wit_1. intros. entailer!; try lia. Qed.
Lemma proof_of_sample_safety_wit_2 : Goal.sample_safety_wit_2.
Proof. unfold Goal.sample_safety_wit_2. intros. entailer!; try lia. Qed.
Lemma proof_of_sample_safety_wit_3 : Goal.sample_safety_wit_3.
Proof. unfold Goal.sample_safety_wit_3. intros. entailer!; try lia. Qed.
Lemma proof_of_sample_safety_wit_4 : Goal.sample_safety_wit_4.
Proof. unfold Goal.sample_safety_wit_4. intros. entailer!; try lia. Qed.
Lemma proof_of_sample_safety_wit_5 : Goal.sample_safety_wit_5.
Proof. unfold Goal.sample_safety_wit_5. intros. entailer!; try lia. Qed.
Lemma proof_of_sample_safety_wit_6 : Goal.sample_safety_wit_6.
Proof. unfold Goal.sample_safety_wit_6. intros. entailer!; try lia. Qed.
Lemma proof_of_sample_safety_wit_7 : Goal.sample_safety_wit_7.
Proof. unfold Goal.sample_safety_wit_7. intros. entailer!; try lia. Qed.
Lemma proof_of_sample_safety_wit_8 : Goal.sample_safety_wit_8.
Proof. unfold Goal.sample_safety_wit_8. intros. entailer!; try lia. Qed.
Lemma proof_of_sample_safety_wit_9 : Goal.sample_safety_wit_9.
Proof. unfold Goal.sample_safety_wit_9. intros. entailer!; try lia. Qed.
Lemma proof_of_sample_safety_wit_10 : Goal.sample_safety_wit_10.
Proof. unfold Goal.sample_safety_wit_10. intros. entailer!; try lia. Qed.
Lemma proof_of_sample_safety_wit_11 : Goal.sample_safety_wit_11.
Proof. unfold Goal.sample_safety_wit_11. intros. entailer!; try lia. Qed.
Lemma proof_of_sample_return_wit_3 : Goal.sample_return_wit_3.
Proof. unfold Goal.sample_return_wit_3. left. intros p Hp s Hsll.
  cbn [sll] in Hsll. destruct Hsll as [Hnonzero _]. contradiction.
Qed.
End Proofs.
