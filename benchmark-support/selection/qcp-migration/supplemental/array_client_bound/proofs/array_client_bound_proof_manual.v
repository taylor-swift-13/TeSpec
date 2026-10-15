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
Require Import array_client_bound_goal.

Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
Local Open Scope sac.

Lemma proof_of_verify_main_entail_wit_1 : verify_main_entail_wit_1.
Proof. unfold verify_main_entail_wit_1; right; intros; subst; cbn [Znth] in *; entailer!; try reflexivity. Qed.
Lemma proof_of_verify_main_entail_wit_2 : verify_main_entail_wit_2.
Proof. unfold verify_main_entail_wit_2; right; intros; subst; cbn [Znth] in *; entailer!; try reflexivity. Qed.
Lemma proof_of_verify_main_entail_wit_3 : verify_main_entail_wit_3.
Proof. unfold verify_main_entail_wit_3; right; intros; subst; cbn [Znth] in *; entailer!; try reflexivity. Qed.
Lemma proof_of_verify_main_entail_wit_4 : verify_main_entail_wit_4.
Proof. unfold verify_main_entail_wit_4; right; intros; subst; cbn [Znth] in *; entailer!; try reflexivity. Qed.
Lemma proof_of_verify_main_entail_wit_5 : verify_main_entail_wit_5.
Proof. unfold verify_main_entail_wit_5; right; intros; subst; cbn [Znth] in *; entailer!; try reflexivity. Qed.
Lemma proof_of_verify_main_entail_wit_6 : verify_main_entail_wit_6.
Proof. unfold verify_main_entail_wit_6; right; intros; subst; cbn [Znth] in *; entailer!; try reflexivity. Qed.
