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
Require Import init_array2_goal.

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

Lemma proof_of_init_array2_entail_wit_1 : init_array2_entail_wit_1.
Proof.
 unfold init_array2_entail_wit_1.
 right; intros; unfold repeat_Z; simpl; entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_2 : init_array2_entail_wit_2.
Proof.
 unfold init_array2_entail_wit_2.
 right; intros; rewrite repeat_Z_tail by lia; entailer!.
Qed.

Lemma proof_of_init_array2_return_wit_1 : init_array2_return_wit_1.
Proof.
 unfold init_array2_return_wit_1.
 right; intros; assert (j = n_pre) by lia; subst j; Exists (repeat_Z 0 n_pre); entailer!.
Qed.

Lemma proof_of_init_array2_partial_solve_wit_1 : init_array2_partial_solve_wit_1.
Proof.
 unfold init_array2_partial_solve_wit_1.
 intros; sep_apply (CharArray.undef_seg_split_to_undef_missing_i p_pre j j n_pre); try lia; simpl; entailer!.
Qed.

