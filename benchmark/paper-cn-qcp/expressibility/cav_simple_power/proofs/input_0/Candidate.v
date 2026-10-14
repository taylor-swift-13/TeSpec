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
Require Import p076_is_simple_power.
Require Import Goal.
Local Open Scope sac.
Module Proofs.
Lemma instance_relation : is_simple_power_spec 1 4 1.
Proof. unfold is_simple_power_spec.
split; intro H; [exists 0%nat; reflexivity | lia].
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_1 : Goal.p076_is_simple_power_safety_wit_1.
Proof. unfold Goal.p076_is_simple_power_safety_wit_1.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_2 : Goal.p076_is_simple_power_safety_wit_2.
Proof. unfold Goal.p076_is_simple_power_safety_wit_2.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_3 : Goal.p076_is_simple_power_safety_wit_3.
Proof. unfold Goal.p076_is_simple_power_safety_wit_3.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_4 : Goal.p076_is_simple_power_safety_wit_4.
Proof. unfold Goal.p076_is_simple_power_safety_wit_4.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_return_wit_1 : Goal.p076_is_simple_power_return_wit_1.
Proof. unfold Goal.p076_is_simple_power_return_wit_1.
left. intros m Hm. split; [apply instance_relation | exact (proj2 Hm)].
Qed.
Lemma proof_of_p076_is_simple_power_precondition_wit_1 : Goal.p076_is_simple_power_precondition_wit_1.
Proof. unfold Goal.p076_is_simple_power_precondition_wit_1.
intro H. apply (H (@ConAssertion.empty_state ConAssertion.naive_S)). split.
- vm_compute. repeat split; try reflexivity; discriminate.
- apply ConAssertion.empty_state_is_empty.
Qed.
End Proofs.
