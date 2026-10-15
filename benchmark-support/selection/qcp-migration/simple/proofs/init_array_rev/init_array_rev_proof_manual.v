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
Require Import init_array_rev_goal.

Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
Local Open Scope sac.

Lemma proof_of_init_array2_safety_wit_1 : init_array2_safety_wit_1.
Proof.
 unfold init_array2_safety_wit_1.
 intros; entailer!.
Qed.

Lemma proof_of_init_array2_safety_wit_2 : init_array2_safety_wit_2.
Proof.
 unfold init_array2_safety_wit_2.
 intros; entailer!.
Qed.

Lemma proof_of_init_array2_safety_wit_3 : init_array2_safety_wit_3.
Proof.
 unfold init_array2_safety_wit_3.
 intros; entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_1 : init_array2_entail_wit_1.
Proof.
 unfold init_array2_entail_wit_1.
 right; intros; unfold repeat_Z; simpl; entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_2 : init_array2_entail_wit_2.
Proof.
 unfold init_array2_entail_wit_2.
 left; intros; assert (Hr : repeat_Z 0 (j+1) = 0 :: repeat_Z 0 j). { unfold repeat_Z; rewrite Z2Nat.inj_add by lia; simpl; rewrite Nat.add_1_r; reflexivity. } rewrite Hr; entailer!.
Qed.

Lemma proof_of_init_array2_return_wit_1 : init_array2_return_wit_1.
Proof.
 unfold init_array2_return_wit_1.
 right; intros; assert (j = n_pre) by lia; subst j; replace (n_pre-n_pre) with 0 by lia; sep_apply (CharArray.seg_to_full p_pre 0 n_pre (repeat_Z 0 n_pre)); simpl; rewrite Z.add_0_r, Z.sub_0_r; Exists (repeat_Z 0 n_pre); entailer!.
Qed.

Lemma proof_of_init_array2_partial_solve_wit_1 : init_array2_partial_solve_wit_1.
Proof.
 unfold init_array2_partial_solve_wit_1.
 intros; sep_apply (CharArray.undef_seg_split_to_undef_missing_i p_pre 0 (n_pre-(j+1)) (n_pre-j)); try lia; simpl; entailer!.
Qed.

