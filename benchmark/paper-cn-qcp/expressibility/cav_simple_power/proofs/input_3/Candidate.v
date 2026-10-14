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
Lemma instance_relation : is_simple_power_spec 3 1 0.
Proof. unfold is_simple_power_spec.
split; [lia |]. intros [k H]. rewrite Z.pow_1_l in H by lia. lia.
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
Lemma proof_of_p076_is_simple_power_safety_wit_5 : Goal.p076_is_simple_power_safety_wit_5.
Proof. unfold Goal.p076_is_simple_power_safety_wit_5.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_6 : Goal.p076_is_simple_power_safety_wit_6.
Proof. unfold Goal.p076_is_simple_power_safety_wit_6.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_7 : Goal.p076_is_simple_power_safety_wit_7.
Proof. unfold Goal.p076_is_simple_power_safety_wit_7.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_8 : Goal.p076_is_simple_power_safety_wit_8.
Proof. unfold Goal.p076_is_simple_power_safety_wit_8.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_9 : Goal.p076_is_simple_power_safety_wit_9.
Proof. unfold Goal.p076_is_simple_power_safety_wit_9.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_10 : Goal.p076_is_simple_power_safety_wit_10.
Proof. unfold Goal.p076_is_simple_power_safety_wit_10.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_11 : Goal.p076_is_simple_power_safety_wit_11.
Proof. unfold Goal.p076_is_simple_power_safety_wit_11.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_12 : Goal.p076_is_simple_power_safety_wit_12.
Proof. unfold Goal.p076_is_simple_power_safety_wit_12.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_13 : Goal.p076_is_simple_power_safety_wit_13.
Proof. unfold Goal.p076_is_simple_power_safety_wit_13.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_14 : Goal.p076_is_simple_power_safety_wit_14.
Proof. unfold Goal.p076_is_simple_power_safety_wit_14.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_15 : Goal.p076_is_simple_power_safety_wit_15.
Proof. unfold Goal.p076_is_simple_power_safety_wit_15.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_16 : Goal.p076_is_simple_power_safety_wit_16.
Proof. unfold Goal.p076_is_simple_power_safety_wit_16.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_17 : Goal.p076_is_simple_power_safety_wit_17.
Proof. unfold Goal.p076_is_simple_power_safety_wit_17.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_18 : Goal.p076_is_simple_power_safety_wit_18.
Proof. unfold Goal.p076_is_simple_power_safety_wit_18.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_19 : Goal.p076_is_simple_power_safety_wit_19.
Proof. unfold Goal.p076_is_simple_power_safety_wit_19.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_20 : Goal.p076_is_simple_power_safety_wit_20.
Proof. unfold Goal.p076_is_simple_power_safety_wit_20.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_21 : Goal.p076_is_simple_power_safety_wit_21.
Proof. unfold Goal.p076_is_simple_power_safety_wit_21.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_22 : Goal.p076_is_simple_power_safety_wit_22.
Proof. unfold Goal.p076_is_simple_power_safety_wit_22.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_23 : Goal.p076_is_simple_power_safety_wit_23.
Proof. unfold Goal.p076_is_simple_power_safety_wit_23.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_24 : Goal.p076_is_simple_power_safety_wit_24.
Proof. unfold Goal.p076_is_simple_power_safety_wit_24.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_25 : Goal.p076_is_simple_power_safety_wit_25.
Proof. unfold Goal.p076_is_simple_power_safety_wit_25.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_26 : Goal.p076_is_simple_power_safety_wit_26.
Proof. unfold Goal.p076_is_simple_power_safety_wit_26.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_27 : Goal.p076_is_simple_power_safety_wit_27.
Proof. unfold Goal.p076_is_simple_power_safety_wit_27.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_28 : Goal.p076_is_simple_power_safety_wit_28.
Proof. unfold Goal.p076_is_simple_power_safety_wit_28.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_29 : Goal.p076_is_simple_power_safety_wit_29.
Proof. unfold Goal.p076_is_simple_power_safety_wit_29.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_30 : Goal.p076_is_simple_power_safety_wit_30.
Proof. unfold Goal.p076_is_simple_power_safety_wit_30.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_31 : Goal.p076_is_simple_power_safety_wit_31.
Proof. unfold Goal.p076_is_simple_power_safety_wit_31.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_32 : Goal.p076_is_simple_power_safety_wit_32.
Proof. unfold Goal.p076_is_simple_power_safety_wit_32.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_33 : Goal.p076_is_simple_power_safety_wit_33.
Proof. unfold Goal.p076_is_simple_power_safety_wit_33.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_34 : Goal.p076_is_simple_power_safety_wit_34.
Proof. unfold Goal.p076_is_simple_power_safety_wit_34.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_35 : Goal.p076_is_simple_power_safety_wit_35.
Proof. unfold Goal.p076_is_simple_power_safety_wit_35.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_36 : Goal.p076_is_simple_power_safety_wit_36.
Proof. unfold Goal.p076_is_simple_power_safety_wit_36.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_37 : Goal.p076_is_simple_power_safety_wit_37.
Proof. unfold Goal.p076_is_simple_power_safety_wit_37.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_38 : Goal.p076_is_simple_power_safety_wit_38.
Proof. unfold Goal.p076_is_simple_power_safety_wit_38.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_39 : Goal.p076_is_simple_power_safety_wit_39.
Proof. unfold Goal.p076_is_simple_power_safety_wit_39.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_40 : Goal.p076_is_simple_power_safety_wit_40.
Proof. unfold Goal.p076_is_simple_power_safety_wit_40.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_41 : Goal.p076_is_simple_power_safety_wit_41.
Proof. unfold Goal.p076_is_simple_power_safety_wit_41.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_42 : Goal.p076_is_simple_power_safety_wit_42.
Proof. unfold Goal.p076_is_simple_power_safety_wit_42.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_43 : Goal.p076_is_simple_power_safety_wit_43.
Proof. unfold Goal.p076_is_simple_power_safety_wit_43.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_44 : Goal.p076_is_simple_power_safety_wit_44.
Proof. unfold Goal.p076_is_simple_power_safety_wit_44.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_45 : Goal.p076_is_simple_power_safety_wit_45.
Proof. unfold Goal.p076_is_simple_power_safety_wit_45.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_46 : Goal.p076_is_simple_power_safety_wit_46.
Proof. unfold Goal.p076_is_simple_power_safety_wit_46.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_47 : Goal.p076_is_simple_power_safety_wit_47.
Proof. unfold Goal.p076_is_simple_power_safety_wit_47.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_48 : Goal.p076_is_simple_power_safety_wit_48.
Proof. unfold Goal.p076_is_simple_power_safety_wit_48.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_49 : Goal.p076_is_simple_power_safety_wit_49.
Proof. unfold Goal.p076_is_simple_power_safety_wit_49.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_50 : Goal.p076_is_simple_power_safety_wit_50.
Proof. unfold Goal.p076_is_simple_power_safety_wit_50.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_51 : Goal.p076_is_simple_power_safety_wit_51.
Proof. unfold Goal.p076_is_simple_power_safety_wit_51.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_52 : Goal.p076_is_simple_power_safety_wit_52.
Proof. unfold Goal.p076_is_simple_power_safety_wit_52.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_53 : Goal.p076_is_simple_power_safety_wit_53.
Proof. unfold Goal.p076_is_simple_power_safety_wit_53.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_54 : Goal.p076_is_simple_power_safety_wit_54.
Proof. unfold Goal.p076_is_simple_power_safety_wit_54.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_55 : Goal.p076_is_simple_power_safety_wit_55.
Proof. unfold Goal.p076_is_simple_power_safety_wit_55.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_56 : Goal.p076_is_simple_power_safety_wit_56.
Proof. unfold Goal.p076_is_simple_power_safety_wit_56.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_57 : Goal.p076_is_simple_power_safety_wit_57.
Proof. unfold Goal.p076_is_simple_power_safety_wit_57.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_58 : Goal.p076_is_simple_power_safety_wit_58.
Proof. unfold Goal.p076_is_simple_power_safety_wit_58.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_59 : Goal.p076_is_simple_power_safety_wit_59.
Proof. unfold Goal.p076_is_simple_power_safety_wit_59.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_60 : Goal.p076_is_simple_power_safety_wit_60.
Proof. unfold Goal.p076_is_simple_power_safety_wit_60.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_61 : Goal.p076_is_simple_power_safety_wit_61.
Proof. unfold Goal.p076_is_simple_power_safety_wit_61.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_62 : Goal.p076_is_simple_power_safety_wit_62.
Proof. unfold Goal.p076_is_simple_power_safety_wit_62.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_63 : Goal.p076_is_simple_power_safety_wit_63.
Proof. unfold Goal.p076_is_simple_power_safety_wit_63.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_64 : Goal.p076_is_simple_power_safety_wit_64.
Proof. unfold Goal.p076_is_simple_power_safety_wit_64.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_65 : Goal.p076_is_simple_power_safety_wit_65.
Proof. unfold Goal.p076_is_simple_power_safety_wit_65.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_66 : Goal.p076_is_simple_power_safety_wit_66.
Proof. unfold Goal.p076_is_simple_power_safety_wit_66.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_67 : Goal.p076_is_simple_power_safety_wit_67.
Proof. unfold Goal.p076_is_simple_power_safety_wit_67.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_68 : Goal.p076_is_simple_power_safety_wit_68.
Proof. unfold Goal.p076_is_simple_power_safety_wit_68.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_69 : Goal.p076_is_simple_power_safety_wit_69.
Proof. unfold Goal.p076_is_simple_power_safety_wit_69.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_70 : Goal.p076_is_simple_power_safety_wit_70.
Proof. unfold Goal.p076_is_simple_power_safety_wit_70.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_71 : Goal.p076_is_simple_power_safety_wit_71.
Proof. unfold Goal.p076_is_simple_power_safety_wit_71.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_72 : Goal.p076_is_simple_power_safety_wit_72.
Proof. unfold Goal.p076_is_simple_power_safety_wit_72.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_73 : Goal.p076_is_simple_power_safety_wit_73.
Proof. unfold Goal.p076_is_simple_power_safety_wit_73.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_74 : Goal.p076_is_simple_power_safety_wit_74.
Proof. unfold Goal.p076_is_simple_power_safety_wit_74.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_75 : Goal.p076_is_simple_power_safety_wit_75.
Proof. unfold Goal.p076_is_simple_power_safety_wit_75.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_76 : Goal.p076_is_simple_power_safety_wit_76.
Proof. unfold Goal.p076_is_simple_power_safety_wit_76.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_77 : Goal.p076_is_simple_power_safety_wit_77.
Proof. unfold Goal.p076_is_simple_power_safety_wit_77.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_78 : Goal.p076_is_simple_power_safety_wit_78.
Proof. unfold Goal.p076_is_simple_power_safety_wit_78.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_79 : Goal.p076_is_simple_power_safety_wit_79.
Proof. unfold Goal.p076_is_simple_power_safety_wit_79.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_80 : Goal.p076_is_simple_power_safety_wit_80.
Proof. unfold Goal.p076_is_simple_power_safety_wit_80.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_81 : Goal.p076_is_simple_power_safety_wit_81.
Proof. unfold Goal.p076_is_simple_power_safety_wit_81.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_82 : Goal.p076_is_simple_power_safety_wit_82.
Proof. unfold Goal.p076_is_simple_power_safety_wit_82.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_83 : Goal.p076_is_simple_power_safety_wit_83.
Proof. unfold Goal.p076_is_simple_power_safety_wit_83.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_84 : Goal.p076_is_simple_power_safety_wit_84.
Proof. unfold Goal.p076_is_simple_power_safety_wit_84.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_85 : Goal.p076_is_simple_power_safety_wit_85.
Proof. unfold Goal.p076_is_simple_power_safety_wit_85.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_86 : Goal.p076_is_simple_power_safety_wit_86.
Proof. unfold Goal.p076_is_simple_power_safety_wit_86.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_87 : Goal.p076_is_simple_power_safety_wit_87.
Proof. unfold Goal.p076_is_simple_power_safety_wit_87.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_88 : Goal.p076_is_simple_power_safety_wit_88.
Proof. unfold Goal.p076_is_simple_power_safety_wit_88.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_89 : Goal.p076_is_simple_power_safety_wit_89.
Proof. unfold Goal.p076_is_simple_power_safety_wit_89.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_90 : Goal.p076_is_simple_power_safety_wit_90.
Proof. unfold Goal.p076_is_simple_power_safety_wit_90.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_91 : Goal.p076_is_simple_power_safety_wit_91.
Proof. unfold Goal.p076_is_simple_power_safety_wit_91.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_92 : Goal.p076_is_simple_power_safety_wit_92.
Proof. unfold Goal.p076_is_simple_power_safety_wit_92.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_93 : Goal.p076_is_simple_power_safety_wit_93.
Proof. unfold Goal.p076_is_simple_power_safety_wit_93.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_94 : Goal.p076_is_simple_power_safety_wit_94.
Proof. unfold Goal.p076_is_simple_power_safety_wit_94.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_95 : Goal.p076_is_simple_power_safety_wit_95.
Proof. unfold Goal.p076_is_simple_power_safety_wit_95.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_96 : Goal.p076_is_simple_power_safety_wit_96.
Proof. unfold Goal.p076_is_simple_power_safety_wit_96.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_97 : Goal.p076_is_simple_power_safety_wit_97.
Proof. unfold Goal.p076_is_simple_power_safety_wit_97.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_98 : Goal.p076_is_simple_power_safety_wit_98.
Proof. unfold Goal.p076_is_simple_power_safety_wit_98.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_99 : Goal.p076_is_simple_power_safety_wit_99.
Proof. unfold Goal.p076_is_simple_power_safety_wit_99.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_100 : Goal.p076_is_simple_power_safety_wit_100.
Proof. unfold Goal.p076_is_simple_power_safety_wit_100.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_101 : Goal.p076_is_simple_power_safety_wit_101.
Proof. unfold Goal.p076_is_simple_power_safety_wit_101.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_102 : Goal.p076_is_simple_power_safety_wit_102.
Proof. unfold Goal.p076_is_simple_power_safety_wit_102.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_103 : Goal.p076_is_simple_power_safety_wit_103.
Proof. unfold Goal.p076_is_simple_power_safety_wit_103.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_104 : Goal.p076_is_simple_power_safety_wit_104.
Proof. unfold Goal.p076_is_simple_power_safety_wit_104.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_105 : Goal.p076_is_simple_power_safety_wit_105.
Proof. unfold Goal.p076_is_simple_power_safety_wit_105.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_106 : Goal.p076_is_simple_power_safety_wit_106.
Proof. unfold Goal.p076_is_simple_power_safety_wit_106.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_107 : Goal.p076_is_simple_power_safety_wit_107.
Proof. unfold Goal.p076_is_simple_power_safety_wit_107.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_108 : Goal.p076_is_simple_power_safety_wit_108.
Proof. unfold Goal.p076_is_simple_power_safety_wit_108.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_109 : Goal.p076_is_simple_power_safety_wit_109.
Proof. unfold Goal.p076_is_simple_power_safety_wit_109.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_110 : Goal.p076_is_simple_power_safety_wit_110.
Proof. unfold Goal.p076_is_simple_power_safety_wit_110.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_111 : Goal.p076_is_simple_power_safety_wit_111.
Proof. unfold Goal.p076_is_simple_power_safety_wit_111.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_112 : Goal.p076_is_simple_power_safety_wit_112.
Proof. unfold Goal.p076_is_simple_power_safety_wit_112.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_113 : Goal.p076_is_simple_power_safety_wit_113.
Proof. unfold Goal.p076_is_simple_power_safety_wit_113.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_114 : Goal.p076_is_simple_power_safety_wit_114.
Proof. unfold Goal.p076_is_simple_power_safety_wit_114.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_115 : Goal.p076_is_simple_power_safety_wit_115.
Proof. unfold Goal.p076_is_simple_power_safety_wit_115.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_116 : Goal.p076_is_simple_power_safety_wit_116.
Proof. unfold Goal.p076_is_simple_power_safety_wit_116.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_117 : Goal.p076_is_simple_power_safety_wit_117.
Proof. unfold Goal.p076_is_simple_power_safety_wit_117.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_118 : Goal.p076_is_simple_power_safety_wit_118.
Proof. unfold Goal.p076_is_simple_power_safety_wit_118.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_119 : Goal.p076_is_simple_power_safety_wit_119.
Proof. unfold Goal.p076_is_simple_power_safety_wit_119.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_120 : Goal.p076_is_simple_power_safety_wit_120.
Proof. unfold Goal.p076_is_simple_power_safety_wit_120.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_121 : Goal.p076_is_simple_power_safety_wit_121.
Proof. unfold Goal.p076_is_simple_power_safety_wit_121.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_122 : Goal.p076_is_simple_power_safety_wit_122.
Proof. unfold Goal.p076_is_simple_power_safety_wit_122.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_123 : Goal.p076_is_simple_power_safety_wit_123.
Proof. unfold Goal.p076_is_simple_power_safety_wit_123.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_124 : Goal.p076_is_simple_power_safety_wit_124.
Proof. unfold Goal.p076_is_simple_power_safety_wit_124.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_125 : Goal.p076_is_simple_power_safety_wit_125.
Proof. unfold Goal.p076_is_simple_power_safety_wit_125.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_126 : Goal.p076_is_simple_power_safety_wit_126.
Proof. unfold Goal.p076_is_simple_power_safety_wit_126.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_127 : Goal.p076_is_simple_power_safety_wit_127.
Proof. unfold Goal.p076_is_simple_power_safety_wit_127.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_128 : Goal.p076_is_simple_power_safety_wit_128.
Proof. unfold Goal.p076_is_simple_power_safety_wit_128.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_129 : Goal.p076_is_simple_power_safety_wit_129.
Proof. unfold Goal.p076_is_simple_power_safety_wit_129.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_130 : Goal.p076_is_simple_power_safety_wit_130.
Proof. unfold Goal.p076_is_simple_power_safety_wit_130.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_131 : Goal.p076_is_simple_power_safety_wit_131.
Proof. unfold Goal.p076_is_simple_power_safety_wit_131.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_132 : Goal.p076_is_simple_power_safety_wit_132.
Proof. unfold Goal.p076_is_simple_power_safety_wit_132.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_133 : Goal.p076_is_simple_power_safety_wit_133.
Proof. unfold Goal.p076_is_simple_power_safety_wit_133.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_134 : Goal.p076_is_simple_power_safety_wit_134.
Proof. unfold Goal.p076_is_simple_power_safety_wit_134.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_135 : Goal.p076_is_simple_power_safety_wit_135.
Proof. unfold Goal.p076_is_simple_power_safety_wit_135.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_136 : Goal.p076_is_simple_power_safety_wit_136.
Proof. unfold Goal.p076_is_simple_power_safety_wit_136.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_137 : Goal.p076_is_simple_power_safety_wit_137.
Proof. unfold Goal.p076_is_simple_power_safety_wit_137.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_138 : Goal.p076_is_simple_power_safety_wit_138.
Proof. unfold Goal.p076_is_simple_power_safety_wit_138.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_139 : Goal.p076_is_simple_power_safety_wit_139.
Proof. unfold Goal.p076_is_simple_power_safety_wit_139.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_140 : Goal.p076_is_simple_power_safety_wit_140.
Proof. unfold Goal.p076_is_simple_power_safety_wit_140.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_141 : Goal.p076_is_simple_power_safety_wit_141.
Proof. unfold Goal.p076_is_simple_power_safety_wit_141.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_142 : Goal.p076_is_simple_power_safety_wit_142.
Proof. unfold Goal.p076_is_simple_power_safety_wit_142.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_143 : Goal.p076_is_simple_power_safety_wit_143.
Proof. unfold Goal.p076_is_simple_power_safety_wit_143.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_144 : Goal.p076_is_simple_power_safety_wit_144.
Proof. unfold Goal.p076_is_simple_power_safety_wit_144.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_145 : Goal.p076_is_simple_power_safety_wit_145.
Proof. unfold Goal.p076_is_simple_power_safety_wit_145.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_146 : Goal.p076_is_simple_power_safety_wit_146.
Proof. unfold Goal.p076_is_simple_power_safety_wit_146.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_147 : Goal.p076_is_simple_power_safety_wit_147.
Proof. unfold Goal.p076_is_simple_power_safety_wit_147.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_148 : Goal.p076_is_simple_power_safety_wit_148.
Proof. unfold Goal.p076_is_simple_power_safety_wit_148.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_149 : Goal.p076_is_simple_power_safety_wit_149.
Proof. unfold Goal.p076_is_simple_power_safety_wit_149.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_150 : Goal.p076_is_simple_power_safety_wit_150.
Proof. unfold Goal.p076_is_simple_power_safety_wit_150.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_151 : Goal.p076_is_simple_power_safety_wit_151.
Proof. unfold Goal.p076_is_simple_power_safety_wit_151.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_152 : Goal.p076_is_simple_power_safety_wit_152.
Proof. unfold Goal.p076_is_simple_power_safety_wit_152.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_153 : Goal.p076_is_simple_power_safety_wit_153.
Proof. unfold Goal.p076_is_simple_power_safety_wit_153.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_154 : Goal.p076_is_simple_power_safety_wit_154.
Proof. unfold Goal.p076_is_simple_power_safety_wit_154.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_155 : Goal.p076_is_simple_power_safety_wit_155.
Proof. unfold Goal.p076_is_simple_power_safety_wit_155.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_156 : Goal.p076_is_simple_power_safety_wit_156.
Proof. unfold Goal.p076_is_simple_power_safety_wit_156.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_157 : Goal.p076_is_simple_power_safety_wit_157.
Proof. unfold Goal.p076_is_simple_power_safety_wit_157.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_158 : Goal.p076_is_simple_power_safety_wit_158.
Proof. unfold Goal.p076_is_simple_power_safety_wit_158.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_159 : Goal.p076_is_simple_power_safety_wit_159.
Proof. unfold Goal.p076_is_simple_power_safety_wit_159.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_160 : Goal.p076_is_simple_power_safety_wit_160.
Proof. unfold Goal.p076_is_simple_power_safety_wit_160.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_161 : Goal.p076_is_simple_power_safety_wit_161.
Proof. unfold Goal.p076_is_simple_power_safety_wit_161.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_162 : Goal.p076_is_simple_power_safety_wit_162.
Proof. unfold Goal.p076_is_simple_power_safety_wit_162.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_163 : Goal.p076_is_simple_power_safety_wit_163.
Proof. unfold Goal.p076_is_simple_power_safety_wit_163.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_164 : Goal.p076_is_simple_power_safety_wit_164.
Proof. unfold Goal.p076_is_simple_power_safety_wit_164.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_165 : Goal.p076_is_simple_power_safety_wit_165.
Proof. unfold Goal.p076_is_simple_power_safety_wit_165.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_166 : Goal.p076_is_simple_power_safety_wit_166.
Proof. unfold Goal.p076_is_simple_power_safety_wit_166.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_167 : Goal.p076_is_simple_power_safety_wit_167.
Proof. unfold Goal.p076_is_simple_power_safety_wit_167.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_168 : Goal.p076_is_simple_power_safety_wit_168.
Proof. unfold Goal.p076_is_simple_power_safety_wit_168.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_169 : Goal.p076_is_simple_power_safety_wit_169.
Proof. unfold Goal.p076_is_simple_power_safety_wit_169.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_170 : Goal.p076_is_simple_power_safety_wit_170.
Proof. unfold Goal.p076_is_simple_power_safety_wit_170.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_171 : Goal.p076_is_simple_power_safety_wit_171.
Proof. unfold Goal.p076_is_simple_power_safety_wit_171.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_172 : Goal.p076_is_simple_power_safety_wit_172.
Proof. unfold Goal.p076_is_simple_power_safety_wit_172.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_173 : Goal.p076_is_simple_power_safety_wit_173.
Proof. unfold Goal.p076_is_simple_power_safety_wit_173.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_174 : Goal.p076_is_simple_power_safety_wit_174.
Proof. unfold Goal.p076_is_simple_power_safety_wit_174.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_175 : Goal.p076_is_simple_power_safety_wit_175.
Proof. unfold Goal.p076_is_simple_power_safety_wit_175.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_176 : Goal.p076_is_simple_power_safety_wit_176.
Proof. unfold Goal.p076_is_simple_power_safety_wit_176.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_177 : Goal.p076_is_simple_power_safety_wit_177.
Proof. unfold Goal.p076_is_simple_power_safety_wit_177.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_178 : Goal.p076_is_simple_power_safety_wit_178.
Proof. unfold Goal.p076_is_simple_power_safety_wit_178.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_179 : Goal.p076_is_simple_power_safety_wit_179.
Proof. unfold Goal.p076_is_simple_power_safety_wit_179.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_180 : Goal.p076_is_simple_power_safety_wit_180.
Proof. unfold Goal.p076_is_simple_power_safety_wit_180.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_181 : Goal.p076_is_simple_power_safety_wit_181.
Proof. unfold Goal.p076_is_simple_power_safety_wit_181.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_182 : Goal.p076_is_simple_power_safety_wit_182.
Proof. unfold Goal.p076_is_simple_power_safety_wit_182.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_183 : Goal.p076_is_simple_power_safety_wit_183.
Proof. unfold Goal.p076_is_simple_power_safety_wit_183.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_184 : Goal.p076_is_simple_power_safety_wit_184.
Proof. unfold Goal.p076_is_simple_power_safety_wit_184.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_185 : Goal.p076_is_simple_power_safety_wit_185.
Proof. unfold Goal.p076_is_simple_power_safety_wit_185.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_186 : Goal.p076_is_simple_power_safety_wit_186.
Proof. unfold Goal.p076_is_simple_power_safety_wit_186.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_187 : Goal.p076_is_simple_power_safety_wit_187.
Proof. unfold Goal.p076_is_simple_power_safety_wit_187.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_188 : Goal.p076_is_simple_power_safety_wit_188.
Proof. unfold Goal.p076_is_simple_power_safety_wit_188.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_189 : Goal.p076_is_simple_power_safety_wit_189.
Proof. unfold Goal.p076_is_simple_power_safety_wit_189.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_190 : Goal.p076_is_simple_power_safety_wit_190.
Proof. unfold Goal.p076_is_simple_power_safety_wit_190.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_191 : Goal.p076_is_simple_power_safety_wit_191.
Proof. unfold Goal.p076_is_simple_power_safety_wit_191.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_192 : Goal.p076_is_simple_power_safety_wit_192.
Proof. unfold Goal.p076_is_simple_power_safety_wit_192.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_193 : Goal.p076_is_simple_power_safety_wit_193.
Proof. unfold Goal.p076_is_simple_power_safety_wit_193.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_194 : Goal.p076_is_simple_power_safety_wit_194.
Proof. unfold Goal.p076_is_simple_power_safety_wit_194.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_195 : Goal.p076_is_simple_power_safety_wit_195.
Proof. unfold Goal.p076_is_simple_power_safety_wit_195.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_196 : Goal.p076_is_simple_power_safety_wit_196.
Proof. unfold Goal.p076_is_simple_power_safety_wit_196.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_197 : Goal.p076_is_simple_power_safety_wit_197.
Proof. unfold Goal.p076_is_simple_power_safety_wit_197.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_198 : Goal.p076_is_simple_power_safety_wit_198.
Proof. unfold Goal.p076_is_simple_power_safety_wit_198.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_199 : Goal.p076_is_simple_power_safety_wit_199.
Proof. unfold Goal.p076_is_simple_power_safety_wit_199.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_200 : Goal.p076_is_simple_power_safety_wit_200.
Proof. unfold Goal.p076_is_simple_power_safety_wit_200.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_201 : Goal.p076_is_simple_power_safety_wit_201.
Proof. unfold Goal.p076_is_simple_power_safety_wit_201.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_202 : Goal.p076_is_simple_power_safety_wit_202.
Proof. unfold Goal.p076_is_simple_power_safety_wit_202.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_203 : Goal.p076_is_simple_power_safety_wit_203.
Proof. unfold Goal.p076_is_simple_power_safety_wit_203.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_204 : Goal.p076_is_simple_power_safety_wit_204.
Proof. unfold Goal.p076_is_simple_power_safety_wit_204.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_205 : Goal.p076_is_simple_power_safety_wit_205.
Proof. unfold Goal.p076_is_simple_power_safety_wit_205.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_206 : Goal.p076_is_simple_power_safety_wit_206.
Proof. unfold Goal.p076_is_simple_power_safety_wit_206.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_207 : Goal.p076_is_simple_power_safety_wit_207.
Proof. unfold Goal.p076_is_simple_power_safety_wit_207.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_208 : Goal.p076_is_simple_power_safety_wit_208.
Proof. unfold Goal.p076_is_simple_power_safety_wit_208.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_209 : Goal.p076_is_simple_power_safety_wit_209.
Proof. unfold Goal.p076_is_simple_power_safety_wit_209.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_210 : Goal.p076_is_simple_power_safety_wit_210.
Proof. unfold Goal.p076_is_simple_power_safety_wit_210.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_211 : Goal.p076_is_simple_power_safety_wit_211.
Proof. unfold Goal.p076_is_simple_power_safety_wit_211.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_212 : Goal.p076_is_simple_power_safety_wit_212.
Proof. unfold Goal.p076_is_simple_power_safety_wit_212.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_213 : Goal.p076_is_simple_power_safety_wit_213.
Proof. unfold Goal.p076_is_simple_power_safety_wit_213.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_214 : Goal.p076_is_simple_power_safety_wit_214.
Proof. unfold Goal.p076_is_simple_power_safety_wit_214.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_215 : Goal.p076_is_simple_power_safety_wit_215.
Proof. unfold Goal.p076_is_simple_power_safety_wit_215.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_216 : Goal.p076_is_simple_power_safety_wit_216.
Proof. unfold Goal.p076_is_simple_power_safety_wit_216.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_217 : Goal.p076_is_simple_power_safety_wit_217.
Proof. unfold Goal.p076_is_simple_power_safety_wit_217.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_218 : Goal.p076_is_simple_power_safety_wit_218.
Proof. unfold Goal.p076_is_simple_power_safety_wit_218.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_219 : Goal.p076_is_simple_power_safety_wit_219.
Proof. unfold Goal.p076_is_simple_power_safety_wit_219.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_220 : Goal.p076_is_simple_power_safety_wit_220.
Proof. unfold Goal.p076_is_simple_power_safety_wit_220.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_221 : Goal.p076_is_simple_power_safety_wit_221.
Proof. unfold Goal.p076_is_simple_power_safety_wit_221.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_222 : Goal.p076_is_simple_power_safety_wit_222.
Proof. unfold Goal.p076_is_simple_power_safety_wit_222.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_223 : Goal.p076_is_simple_power_safety_wit_223.
Proof. unfold Goal.p076_is_simple_power_safety_wit_223.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_224 : Goal.p076_is_simple_power_safety_wit_224.
Proof. unfold Goal.p076_is_simple_power_safety_wit_224.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_225 : Goal.p076_is_simple_power_safety_wit_225.
Proof. unfold Goal.p076_is_simple_power_safety_wit_225.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_226 : Goal.p076_is_simple_power_safety_wit_226.
Proof. unfold Goal.p076_is_simple_power_safety_wit_226.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_227 : Goal.p076_is_simple_power_safety_wit_227.
Proof. unfold Goal.p076_is_simple_power_safety_wit_227.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_228 : Goal.p076_is_simple_power_safety_wit_228.
Proof. unfold Goal.p076_is_simple_power_safety_wit_228.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_229 : Goal.p076_is_simple_power_safety_wit_229.
Proof. unfold Goal.p076_is_simple_power_safety_wit_229.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_230 : Goal.p076_is_simple_power_safety_wit_230.
Proof. unfold Goal.p076_is_simple_power_safety_wit_230.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_231 : Goal.p076_is_simple_power_safety_wit_231.
Proof. unfold Goal.p076_is_simple_power_safety_wit_231.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_232 : Goal.p076_is_simple_power_safety_wit_232.
Proof. unfold Goal.p076_is_simple_power_safety_wit_232.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_233 : Goal.p076_is_simple_power_safety_wit_233.
Proof. unfold Goal.p076_is_simple_power_safety_wit_233.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_234 : Goal.p076_is_simple_power_safety_wit_234.
Proof. unfold Goal.p076_is_simple_power_safety_wit_234.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_235 : Goal.p076_is_simple_power_safety_wit_235.
Proof. unfold Goal.p076_is_simple_power_safety_wit_235.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_236 : Goal.p076_is_simple_power_safety_wit_236.
Proof. unfold Goal.p076_is_simple_power_safety_wit_236.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_237 : Goal.p076_is_simple_power_safety_wit_237.
Proof. unfold Goal.p076_is_simple_power_safety_wit_237.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_238 : Goal.p076_is_simple_power_safety_wit_238.
Proof. unfold Goal.p076_is_simple_power_safety_wit_238.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_239 : Goal.p076_is_simple_power_safety_wit_239.
Proof. unfold Goal.p076_is_simple_power_safety_wit_239.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_240 : Goal.p076_is_simple_power_safety_wit_240.
Proof. unfold Goal.p076_is_simple_power_safety_wit_240.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_241 : Goal.p076_is_simple_power_safety_wit_241.
Proof. unfold Goal.p076_is_simple_power_safety_wit_241.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_242 : Goal.p076_is_simple_power_safety_wit_242.
Proof. unfold Goal.p076_is_simple_power_safety_wit_242.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_243 : Goal.p076_is_simple_power_safety_wit_243.
Proof. unfold Goal.p076_is_simple_power_safety_wit_243.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_244 : Goal.p076_is_simple_power_safety_wit_244.
Proof. unfold Goal.p076_is_simple_power_safety_wit_244.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_245 : Goal.p076_is_simple_power_safety_wit_245.
Proof. unfold Goal.p076_is_simple_power_safety_wit_245.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_246 : Goal.p076_is_simple_power_safety_wit_246.
Proof. unfold Goal.p076_is_simple_power_safety_wit_246.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_247 : Goal.p076_is_simple_power_safety_wit_247.
Proof. unfold Goal.p076_is_simple_power_safety_wit_247.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_248 : Goal.p076_is_simple_power_safety_wit_248.
Proof. unfold Goal.p076_is_simple_power_safety_wit_248.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_249 : Goal.p076_is_simple_power_safety_wit_249.
Proof. unfold Goal.p076_is_simple_power_safety_wit_249.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_250 : Goal.p076_is_simple_power_safety_wit_250.
Proof. unfold Goal.p076_is_simple_power_safety_wit_250.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_251 : Goal.p076_is_simple_power_safety_wit_251.
Proof. unfold Goal.p076_is_simple_power_safety_wit_251.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_252 : Goal.p076_is_simple_power_safety_wit_252.
Proof. unfold Goal.p076_is_simple_power_safety_wit_252.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_253 : Goal.p076_is_simple_power_safety_wit_253.
Proof. unfold Goal.p076_is_simple_power_safety_wit_253.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_254 : Goal.p076_is_simple_power_safety_wit_254.
Proof. unfold Goal.p076_is_simple_power_safety_wit_254.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_255 : Goal.p076_is_simple_power_safety_wit_255.
Proof. unfold Goal.p076_is_simple_power_safety_wit_255.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_256 : Goal.p076_is_simple_power_safety_wit_256.
Proof. unfold Goal.p076_is_simple_power_safety_wit_256.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_257 : Goal.p076_is_simple_power_safety_wit_257.
Proof. unfold Goal.p076_is_simple_power_safety_wit_257.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_258 : Goal.p076_is_simple_power_safety_wit_258.
Proof. unfold Goal.p076_is_simple_power_safety_wit_258.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_259 : Goal.p076_is_simple_power_safety_wit_259.
Proof. unfold Goal.p076_is_simple_power_safety_wit_259.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_260 : Goal.p076_is_simple_power_safety_wit_260.
Proof. unfold Goal.p076_is_simple_power_safety_wit_260.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_261 : Goal.p076_is_simple_power_safety_wit_261.
Proof. unfold Goal.p076_is_simple_power_safety_wit_261.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_262 : Goal.p076_is_simple_power_safety_wit_262.
Proof. unfold Goal.p076_is_simple_power_safety_wit_262.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_263 : Goal.p076_is_simple_power_safety_wit_263.
Proof. unfold Goal.p076_is_simple_power_safety_wit_263.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_264 : Goal.p076_is_simple_power_safety_wit_264.
Proof. unfold Goal.p076_is_simple_power_safety_wit_264.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_265 : Goal.p076_is_simple_power_safety_wit_265.
Proof. unfold Goal.p076_is_simple_power_safety_wit_265.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_266 : Goal.p076_is_simple_power_safety_wit_266.
Proof. unfold Goal.p076_is_simple_power_safety_wit_266.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_267 : Goal.p076_is_simple_power_safety_wit_267.
Proof. unfold Goal.p076_is_simple_power_safety_wit_267.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_268 : Goal.p076_is_simple_power_safety_wit_268.
Proof. unfold Goal.p076_is_simple_power_safety_wit_268.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_269 : Goal.p076_is_simple_power_safety_wit_269.
Proof. unfold Goal.p076_is_simple_power_safety_wit_269.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_270 : Goal.p076_is_simple_power_safety_wit_270.
Proof. unfold Goal.p076_is_simple_power_safety_wit_270.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_271 : Goal.p076_is_simple_power_safety_wit_271.
Proof. unfold Goal.p076_is_simple_power_safety_wit_271.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_272 : Goal.p076_is_simple_power_safety_wit_272.
Proof. unfold Goal.p076_is_simple_power_safety_wit_272.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_273 : Goal.p076_is_simple_power_safety_wit_273.
Proof. unfold Goal.p076_is_simple_power_safety_wit_273.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_274 : Goal.p076_is_simple_power_safety_wit_274.
Proof. unfold Goal.p076_is_simple_power_safety_wit_274.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_275 : Goal.p076_is_simple_power_safety_wit_275.
Proof. unfold Goal.p076_is_simple_power_safety_wit_275.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_276 : Goal.p076_is_simple_power_safety_wit_276.
Proof. unfold Goal.p076_is_simple_power_safety_wit_276.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_277 : Goal.p076_is_simple_power_safety_wit_277.
Proof. unfold Goal.p076_is_simple_power_safety_wit_277.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_278 : Goal.p076_is_simple_power_safety_wit_278.
Proof. unfold Goal.p076_is_simple_power_safety_wit_278.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_279 : Goal.p076_is_simple_power_safety_wit_279.
Proof. unfold Goal.p076_is_simple_power_safety_wit_279.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_280 : Goal.p076_is_simple_power_safety_wit_280.
Proof. unfold Goal.p076_is_simple_power_safety_wit_280.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_281 : Goal.p076_is_simple_power_safety_wit_281.
Proof. unfold Goal.p076_is_simple_power_safety_wit_281.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_282 : Goal.p076_is_simple_power_safety_wit_282.
Proof. unfold Goal.p076_is_simple_power_safety_wit_282.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_283 : Goal.p076_is_simple_power_safety_wit_283.
Proof. unfold Goal.p076_is_simple_power_safety_wit_283.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_284 : Goal.p076_is_simple_power_safety_wit_284.
Proof. unfold Goal.p076_is_simple_power_safety_wit_284.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_285 : Goal.p076_is_simple_power_safety_wit_285.
Proof. unfold Goal.p076_is_simple_power_safety_wit_285.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_286 : Goal.p076_is_simple_power_safety_wit_286.
Proof. unfold Goal.p076_is_simple_power_safety_wit_286.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_287 : Goal.p076_is_simple_power_safety_wit_287.
Proof. unfold Goal.p076_is_simple_power_safety_wit_287.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_288 : Goal.p076_is_simple_power_safety_wit_288.
Proof. unfold Goal.p076_is_simple_power_safety_wit_288.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_289 : Goal.p076_is_simple_power_safety_wit_289.
Proof. unfold Goal.p076_is_simple_power_safety_wit_289.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_290 : Goal.p076_is_simple_power_safety_wit_290.
Proof. unfold Goal.p076_is_simple_power_safety_wit_290.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_291 : Goal.p076_is_simple_power_safety_wit_291.
Proof. unfold Goal.p076_is_simple_power_safety_wit_291.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_292 : Goal.p076_is_simple_power_safety_wit_292.
Proof. unfold Goal.p076_is_simple_power_safety_wit_292.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_293 : Goal.p076_is_simple_power_safety_wit_293.
Proof. unfold Goal.p076_is_simple_power_safety_wit_293.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_294 : Goal.p076_is_simple_power_safety_wit_294.
Proof. unfold Goal.p076_is_simple_power_safety_wit_294.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_295 : Goal.p076_is_simple_power_safety_wit_295.
Proof. unfold Goal.p076_is_simple_power_safety_wit_295.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_296 : Goal.p076_is_simple_power_safety_wit_296.
Proof. unfold Goal.p076_is_simple_power_safety_wit_296.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_297 : Goal.p076_is_simple_power_safety_wit_297.
Proof. unfold Goal.p076_is_simple_power_safety_wit_297.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_298 : Goal.p076_is_simple_power_safety_wit_298.
Proof. unfold Goal.p076_is_simple_power_safety_wit_298.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_299 : Goal.p076_is_simple_power_safety_wit_299.
Proof. unfold Goal.p076_is_simple_power_safety_wit_299.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_300 : Goal.p076_is_simple_power_safety_wit_300.
Proof. unfold Goal.p076_is_simple_power_safety_wit_300.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_301 : Goal.p076_is_simple_power_safety_wit_301.
Proof. unfold Goal.p076_is_simple_power_safety_wit_301.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_302 : Goal.p076_is_simple_power_safety_wit_302.
Proof. unfold Goal.p076_is_simple_power_safety_wit_302.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_303 : Goal.p076_is_simple_power_safety_wit_303.
Proof. unfold Goal.p076_is_simple_power_safety_wit_303.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_304 : Goal.p076_is_simple_power_safety_wit_304.
Proof. unfold Goal.p076_is_simple_power_safety_wit_304.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_305 : Goal.p076_is_simple_power_safety_wit_305.
Proof. unfold Goal.p076_is_simple_power_safety_wit_305.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_306 : Goal.p076_is_simple_power_safety_wit_306.
Proof. unfold Goal.p076_is_simple_power_safety_wit_306.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_307 : Goal.p076_is_simple_power_safety_wit_307.
Proof. unfold Goal.p076_is_simple_power_safety_wit_307.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_308 : Goal.p076_is_simple_power_safety_wit_308.
Proof. unfold Goal.p076_is_simple_power_safety_wit_308.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_309 : Goal.p076_is_simple_power_safety_wit_309.
Proof. unfold Goal.p076_is_simple_power_safety_wit_309.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_310 : Goal.p076_is_simple_power_safety_wit_310.
Proof. unfold Goal.p076_is_simple_power_safety_wit_310.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_311 : Goal.p076_is_simple_power_safety_wit_311.
Proof. unfold Goal.p076_is_simple_power_safety_wit_311.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_312 : Goal.p076_is_simple_power_safety_wit_312.
Proof. unfold Goal.p076_is_simple_power_safety_wit_312.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_313 : Goal.p076_is_simple_power_safety_wit_313.
Proof. unfold Goal.p076_is_simple_power_safety_wit_313.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_314 : Goal.p076_is_simple_power_safety_wit_314.
Proof. unfold Goal.p076_is_simple_power_safety_wit_314.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_315 : Goal.p076_is_simple_power_safety_wit_315.
Proof. unfold Goal.p076_is_simple_power_safety_wit_315.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_316 : Goal.p076_is_simple_power_safety_wit_316.
Proof. unfold Goal.p076_is_simple_power_safety_wit_316.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_317 : Goal.p076_is_simple_power_safety_wit_317.
Proof. unfold Goal.p076_is_simple_power_safety_wit_317.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_318 : Goal.p076_is_simple_power_safety_wit_318.
Proof. unfold Goal.p076_is_simple_power_safety_wit_318.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_319 : Goal.p076_is_simple_power_safety_wit_319.
Proof. unfold Goal.p076_is_simple_power_safety_wit_319.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_320 : Goal.p076_is_simple_power_safety_wit_320.
Proof. unfold Goal.p076_is_simple_power_safety_wit_320.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_321 : Goal.p076_is_simple_power_safety_wit_321.
Proof. unfold Goal.p076_is_simple_power_safety_wit_321.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_322 : Goal.p076_is_simple_power_safety_wit_322.
Proof. unfold Goal.p076_is_simple_power_safety_wit_322.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_323 : Goal.p076_is_simple_power_safety_wit_323.
Proof. unfold Goal.p076_is_simple_power_safety_wit_323.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_324 : Goal.p076_is_simple_power_safety_wit_324.
Proof. unfold Goal.p076_is_simple_power_safety_wit_324.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_325 : Goal.p076_is_simple_power_safety_wit_325.
Proof. unfold Goal.p076_is_simple_power_safety_wit_325.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_326 : Goal.p076_is_simple_power_safety_wit_326.
Proof. unfold Goal.p076_is_simple_power_safety_wit_326.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_327 : Goal.p076_is_simple_power_safety_wit_327.
Proof. unfold Goal.p076_is_simple_power_safety_wit_327.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_328 : Goal.p076_is_simple_power_safety_wit_328.
Proof. unfold Goal.p076_is_simple_power_safety_wit_328.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_329 : Goal.p076_is_simple_power_safety_wit_329.
Proof. unfold Goal.p076_is_simple_power_safety_wit_329.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_330 : Goal.p076_is_simple_power_safety_wit_330.
Proof. unfold Goal.p076_is_simple_power_safety_wit_330.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_331 : Goal.p076_is_simple_power_safety_wit_331.
Proof. unfold Goal.p076_is_simple_power_safety_wit_331.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_332 : Goal.p076_is_simple_power_safety_wit_332.
Proof. unfold Goal.p076_is_simple_power_safety_wit_332.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_333 : Goal.p076_is_simple_power_safety_wit_333.
Proof. unfold Goal.p076_is_simple_power_safety_wit_333.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_334 : Goal.p076_is_simple_power_safety_wit_334.
Proof. unfold Goal.p076_is_simple_power_safety_wit_334.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_335 : Goal.p076_is_simple_power_safety_wit_335.
Proof. unfold Goal.p076_is_simple_power_safety_wit_335.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_336 : Goal.p076_is_simple_power_safety_wit_336.
Proof. unfold Goal.p076_is_simple_power_safety_wit_336.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_337 : Goal.p076_is_simple_power_safety_wit_337.
Proof. unfold Goal.p076_is_simple_power_safety_wit_337.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_338 : Goal.p076_is_simple_power_safety_wit_338.
Proof. unfold Goal.p076_is_simple_power_safety_wit_338.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_339 : Goal.p076_is_simple_power_safety_wit_339.
Proof. unfold Goal.p076_is_simple_power_safety_wit_339.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_340 : Goal.p076_is_simple_power_safety_wit_340.
Proof. unfold Goal.p076_is_simple_power_safety_wit_340.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_341 : Goal.p076_is_simple_power_safety_wit_341.
Proof. unfold Goal.p076_is_simple_power_safety_wit_341.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_342 : Goal.p076_is_simple_power_safety_wit_342.
Proof. unfold Goal.p076_is_simple_power_safety_wit_342.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_343 : Goal.p076_is_simple_power_safety_wit_343.
Proof. unfold Goal.p076_is_simple_power_safety_wit_343.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_344 : Goal.p076_is_simple_power_safety_wit_344.
Proof. unfold Goal.p076_is_simple_power_safety_wit_344.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_345 : Goal.p076_is_simple_power_safety_wit_345.
Proof. unfold Goal.p076_is_simple_power_safety_wit_345.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_346 : Goal.p076_is_simple_power_safety_wit_346.
Proof. unfold Goal.p076_is_simple_power_safety_wit_346.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_347 : Goal.p076_is_simple_power_safety_wit_347.
Proof. unfold Goal.p076_is_simple_power_safety_wit_347.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_348 : Goal.p076_is_simple_power_safety_wit_348.
Proof. unfold Goal.p076_is_simple_power_safety_wit_348.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_349 : Goal.p076_is_simple_power_safety_wit_349.
Proof. unfold Goal.p076_is_simple_power_safety_wit_349.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_350 : Goal.p076_is_simple_power_safety_wit_350.
Proof. unfold Goal.p076_is_simple_power_safety_wit_350.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_351 : Goal.p076_is_simple_power_safety_wit_351.
Proof. unfold Goal.p076_is_simple_power_safety_wit_351.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_352 : Goal.p076_is_simple_power_safety_wit_352.
Proof. unfold Goal.p076_is_simple_power_safety_wit_352.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_353 : Goal.p076_is_simple_power_safety_wit_353.
Proof. unfold Goal.p076_is_simple_power_safety_wit_353.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_354 : Goal.p076_is_simple_power_safety_wit_354.
Proof. unfold Goal.p076_is_simple_power_safety_wit_354.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_355 : Goal.p076_is_simple_power_safety_wit_355.
Proof. unfold Goal.p076_is_simple_power_safety_wit_355.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_356 : Goal.p076_is_simple_power_safety_wit_356.
Proof. unfold Goal.p076_is_simple_power_safety_wit_356.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_357 : Goal.p076_is_simple_power_safety_wit_357.
Proof. unfold Goal.p076_is_simple_power_safety_wit_357.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_358 : Goal.p076_is_simple_power_safety_wit_358.
Proof. unfold Goal.p076_is_simple_power_safety_wit_358.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_359 : Goal.p076_is_simple_power_safety_wit_359.
Proof. unfold Goal.p076_is_simple_power_safety_wit_359.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_360 : Goal.p076_is_simple_power_safety_wit_360.
Proof. unfold Goal.p076_is_simple_power_safety_wit_360.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_361 : Goal.p076_is_simple_power_safety_wit_361.
Proof. unfold Goal.p076_is_simple_power_safety_wit_361.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_362 : Goal.p076_is_simple_power_safety_wit_362.
Proof. unfold Goal.p076_is_simple_power_safety_wit_362.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_363 : Goal.p076_is_simple_power_safety_wit_363.
Proof. unfold Goal.p076_is_simple_power_safety_wit_363.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_364 : Goal.p076_is_simple_power_safety_wit_364.
Proof. unfold Goal.p076_is_simple_power_safety_wit_364.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_365 : Goal.p076_is_simple_power_safety_wit_365.
Proof. unfold Goal.p076_is_simple_power_safety_wit_365.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_366 : Goal.p076_is_simple_power_safety_wit_366.
Proof. unfold Goal.p076_is_simple_power_safety_wit_366.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_367 : Goal.p076_is_simple_power_safety_wit_367.
Proof. unfold Goal.p076_is_simple_power_safety_wit_367.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_368 : Goal.p076_is_simple_power_safety_wit_368.
Proof. unfold Goal.p076_is_simple_power_safety_wit_368.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_369 : Goal.p076_is_simple_power_safety_wit_369.
Proof. unfold Goal.p076_is_simple_power_safety_wit_369.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_370 : Goal.p076_is_simple_power_safety_wit_370.
Proof. unfold Goal.p076_is_simple_power_safety_wit_370.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_371 : Goal.p076_is_simple_power_safety_wit_371.
Proof. unfold Goal.p076_is_simple_power_safety_wit_371.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_372 : Goal.p076_is_simple_power_safety_wit_372.
Proof. unfold Goal.p076_is_simple_power_safety_wit_372.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_373 : Goal.p076_is_simple_power_safety_wit_373.
Proof. unfold Goal.p076_is_simple_power_safety_wit_373.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_374 : Goal.p076_is_simple_power_safety_wit_374.
Proof. unfold Goal.p076_is_simple_power_safety_wit_374.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_375 : Goal.p076_is_simple_power_safety_wit_375.
Proof. unfold Goal.p076_is_simple_power_safety_wit_375.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_376 : Goal.p076_is_simple_power_safety_wit_376.
Proof. unfold Goal.p076_is_simple_power_safety_wit_376.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_377 : Goal.p076_is_simple_power_safety_wit_377.
Proof. unfold Goal.p076_is_simple_power_safety_wit_377.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_378 : Goal.p076_is_simple_power_safety_wit_378.
Proof. unfold Goal.p076_is_simple_power_safety_wit_378.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_379 : Goal.p076_is_simple_power_safety_wit_379.
Proof. unfold Goal.p076_is_simple_power_safety_wit_379.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_380 : Goal.p076_is_simple_power_safety_wit_380.
Proof. unfold Goal.p076_is_simple_power_safety_wit_380.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_381 : Goal.p076_is_simple_power_safety_wit_381.
Proof. unfold Goal.p076_is_simple_power_safety_wit_381.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_382 : Goal.p076_is_simple_power_safety_wit_382.
Proof. unfold Goal.p076_is_simple_power_safety_wit_382.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_383 : Goal.p076_is_simple_power_safety_wit_383.
Proof. unfold Goal.p076_is_simple_power_safety_wit_383.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_384 : Goal.p076_is_simple_power_safety_wit_384.
Proof. unfold Goal.p076_is_simple_power_safety_wit_384.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_385 : Goal.p076_is_simple_power_safety_wit_385.
Proof. unfold Goal.p076_is_simple_power_safety_wit_385.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_386 : Goal.p076_is_simple_power_safety_wit_386.
Proof. unfold Goal.p076_is_simple_power_safety_wit_386.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_387 : Goal.p076_is_simple_power_safety_wit_387.
Proof. unfold Goal.p076_is_simple_power_safety_wit_387.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_388 : Goal.p076_is_simple_power_safety_wit_388.
Proof. unfold Goal.p076_is_simple_power_safety_wit_388.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_389 : Goal.p076_is_simple_power_safety_wit_389.
Proof. unfold Goal.p076_is_simple_power_safety_wit_389.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_390 : Goal.p076_is_simple_power_safety_wit_390.
Proof. unfold Goal.p076_is_simple_power_safety_wit_390.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_391 : Goal.p076_is_simple_power_safety_wit_391.
Proof. unfold Goal.p076_is_simple_power_safety_wit_391.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_392 : Goal.p076_is_simple_power_safety_wit_392.
Proof. unfold Goal.p076_is_simple_power_safety_wit_392.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_393 : Goal.p076_is_simple_power_safety_wit_393.
Proof. unfold Goal.p076_is_simple_power_safety_wit_393.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_394 : Goal.p076_is_simple_power_safety_wit_394.
Proof. unfold Goal.p076_is_simple_power_safety_wit_394.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_395 : Goal.p076_is_simple_power_safety_wit_395.
Proof. unfold Goal.p076_is_simple_power_safety_wit_395.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_396 : Goal.p076_is_simple_power_safety_wit_396.
Proof. unfold Goal.p076_is_simple_power_safety_wit_396.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_397 : Goal.p076_is_simple_power_safety_wit_397.
Proof. unfold Goal.p076_is_simple_power_safety_wit_397.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_398 : Goal.p076_is_simple_power_safety_wit_398.
Proof. unfold Goal.p076_is_simple_power_safety_wit_398.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_399 : Goal.p076_is_simple_power_safety_wit_399.
Proof. unfold Goal.p076_is_simple_power_safety_wit_399.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_400 : Goal.p076_is_simple_power_safety_wit_400.
Proof. unfold Goal.p076_is_simple_power_safety_wit_400.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_401 : Goal.p076_is_simple_power_safety_wit_401.
Proof. unfold Goal.p076_is_simple_power_safety_wit_401.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_402 : Goal.p076_is_simple_power_safety_wit_402.
Proof. unfold Goal.p076_is_simple_power_safety_wit_402.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_403 : Goal.p076_is_simple_power_safety_wit_403.
Proof. unfold Goal.p076_is_simple_power_safety_wit_403.
intros m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_p076_is_simple_power_safety_wit_404 : Goal.p076_is_simple_power_safety_wit_404.
Proof. unfold Goal.p076_is_simple_power_safety_wit_404.
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
