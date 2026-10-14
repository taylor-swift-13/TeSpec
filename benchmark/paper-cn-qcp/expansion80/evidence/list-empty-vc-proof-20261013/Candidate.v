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
Local Open Scope Z_scope.

Require Import Goal.
Module Proofs.
Lemma proof_of_reverse_safety_wit_1 : Goal.reverse_safety_wit_1.
Proof.
  unfold Goal.reverse_safety_wit_1. intros m Hm.
  cbv [naive_C_Rules.andp naive_C_Rules.coq_prop].
  vm_compute. split; discriminate.
Qed.
Lemma proof_of_reverse_return_wit_1 : Goal.reverse_return_wit_1.
Proof. unfold Goal.reverse_return_wit_1. intros m Hm. exact Hm. Qed.
Lemma proof_of_reverse_precondition_wit_1 : Goal.reverse_precondition_wit_1.
Proof.
  unfold Goal.reverse_precondition_wit_1. intro H.
  apply (H (@ConAssertion.empty_state ConAssertion.naive_S)).
  cbn [sll naive_C_Rules.andp naive_C_Rules.coq_prop].
  repeat first [apply ConAssertion.empty_state_is_empty | reflexivity | split].
Qed.
End Proofs.
Print Assumptions Proofs.proof_of_reverse_safety_wit_1.
Print Assumptions Proofs.proof_of_reverse_return_wit_1.
Print Assumptions Proofs.proof_of_reverse_precondition_wit_1.
