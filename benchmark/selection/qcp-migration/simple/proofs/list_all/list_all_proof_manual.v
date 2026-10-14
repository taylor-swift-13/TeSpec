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
Require Import list_all_def.
Import naive_C_Rules.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Require Import FulminateMerge.
Local Open Scope sac.


Require Import list_all_goal mergesort_proof_manual.
Ltac expose_null := repeat match goal with
| |- context[sll 0 ?l] => sep_apply (sll_zero 0 l ltac:(reflexivity)); Intros; subst
end.
Ltac expose_nonnull := repeat match goal with
| H : ?p <> 0 |- context[sll ?p ?l] =>
  sep_apply (sll_not_zero p l H);
  let y := fresh "tail_ptr" in let a := fresh "head_value" in let tl := fresh "tail_list" in Intros y a tl
end.
Lemma sll_fold : forall p x q l, p <> 0 -> &(p # "list" ->ₛ "data") # Int |-> x ** &(p # "list" ->ₛ "next") # Ptr |-> q ** sll q l |-- sll p (x::l).
Proof. intros; cbn [sll]; Exists q; entailer!. Qed.
Lemma uint_length_step : forall (x:Z) (l:list Z), unsigned_last_nbits (1 + Z.rem (Zlength l) 4294967296) 32 = Z.rem (Zlength (x::l)) 4294967296.
Proof. intros; unfold unsigned_last_nbits; change (2^32) with 4294967296.
rewrite !Z.rem_mod_nonneg by (try lia; apply Zlength_nonneg).
rewrite Z.add_mod_idemp_r by lia; rewrite Zlength_cons; f_equal; lia. Qed.
Lemma uint_acc_step : forall n (x:Z) (l:list Z), 0 <= n -> Z.rem (unsigned_last_nbits (n+1) 32 + Zlength l) 4294967296 = Z.rem (n+Zlength (x::l)) 4294967296.
Proof. intros; unfold unsigned_last_nbits; change (2^32) with 4294967296.
pose proof (Zlength_nonneg l); pose proof (Zlength_nonneg (x::l)); pose proof (Z.mod_pos_bound (n+1) 4294967296 ltac:(lia)).
rewrite !Z.rem_mod_nonneg by lia; rewrite Z.add_mod_idemp_l by lia; rewrite Zlength_cons; f_equal; lia. Qed.
Lemma proof_of_IntList_nil_safety_wit_1 : IntList_nil_safety_wit_1.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_nil_safety_wit_1.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_nil_return_wit_1 : IntList_nil_return_wit_1.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_nil_return_wit_1.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_cons_return_wit_1 : IntList_cons_return_wit_1.
Proof.
 unfold IntList_cons_return_wit_1; try right; intros; subst.
 cbn [sll]; Exists t_pre; entailer!.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_cons_partial_solve_wit_1 : IntList_cons_partial_solve_wit_1.
Proof.
 unfold IntList_cons_partial_solve_wit_1; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_copy_safety_wit_1 : IntList_copy_safety_wit_1.
Proof.
 unfold IntList_copy_safety_wit_1; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_copy_return_wit_1 : IntList_copy_return_wit_1.
Proof.
 unfold IntList_copy_return_wit_1; try right; intros; subst.
 sep_apply (sll_fold xs_pre x y l0 ltac:(assumption)); entailer!.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_copy_return_wit_2 : IntList_copy_return_wit_2.
Proof.
 unfold IntList_copy_return_wit_2; try right; intros; subst.
 expose_null; subst; entailer!.
 all: try (simpl; rewrite ?app_nil_r; try rewrite <- app_assoc; simpl; try reflexivity; try congruence).
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_copy_partial_solve_wit_1 : IntList_copy_partial_solve_wit_1.
Proof.
 unfold IntList_copy_partial_solve_wit_1; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_copy_partial_solve_wit_2 : IntList_copy_partial_solve_wit_2.
Proof.
 unfold IntList_copy_partial_solve_wit_2; try right; intros; subst.
 sep_apply (sll_not_zero xs_pre l ltac:(assumption)); Intros tp hv tl; Exists hv tl tp; entailer!.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_copy_partial_solve_wit_3 : IntList_copy_partial_solve_wit_3.
Proof.
 unfold IntList_copy_partial_solve_wit_3; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_copy_partial_solve_wit_4_pure : IntList_copy_partial_solve_wit_4_pure.
Proof.
 unfold IntList_copy_partial_solve_wit_4_pure; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_copy_partial_solve_wit_4 : IntList_copy_partial_solve_wit_4.
Proof.
 unfold IntList_copy_partial_solve_wit_4; try right; intros; subst.
 unfold IntList_copy_partial_solve_wit_4_aux; intros; subst; entailer!.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_free_list_safety_wit_1 : IntList_free_list_safety_wit_1.
Proof.
 unfold IntList_free_list_safety_wit_1; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_free_list_return_wit_1 : IntList_free_list_return_wit_1.
Proof.
 unfold IntList_free_list_return_wit_1; try right; intros; subst.
 expose_null; subst; entailer!.
 all: try (simpl; rewrite ?app_nil_r; try rewrite <- app_assoc; simpl; try reflexivity; try congruence).
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_free_list_return_wit_2 : IntList_free_list_return_wit_2.
Proof.
 unfold IntList_free_list_return_wit_2; try right; intros; subst.
 expose_null; subst; entailer!.
 all: try (simpl; rewrite ?app_nil_r; try rewrite <- app_assoc; simpl; try reflexivity; try congruence).
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_free_list_partial_solve_wit_1 : IntList_free_list_partial_solve_wit_1.
Proof.
 unfold IntList_free_list_partial_solve_wit_1; try right; intros; subst.
 sep_apply (sll_not_zero xs_pre l ltac:(assumption)); Intros tp hv tl; Exists hv tl tp; entailer!.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_free_list_partial_solve_wit_2 : IntList_free_list_partial_solve_wit_2.
Proof.
 unfold IntList_free_list_partial_solve_wit_2; try right; intros; subst.
 try (sep_apply store_int_undef_store_int); try (sep_apply store_ptr_undef_store_ptr); entailer!.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_free_list_partial_solve_wit_3 : IntList_free_list_partial_solve_wit_3.
Proof.
 unfold IntList_free_list_partial_solve_wit_3; try right; intros; subst.
 try (sep_apply store_int_undef_store_int); try (sep_apply store_ptr_undef_store_ptr); entailer!.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_length_safety_wit_1 : IntList_length_safety_wit_1.
Proof.
 unfold IntList_length_safety_wit_1; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_length_safety_wit_2 : IntList_length_safety_wit_2.
Proof.
 unfold IntList_length_safety_wit_2; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_length_safety_wit_3 : IntList_length_safety_wit_3.
Proof.
 unfold IntList_length_safety_wit_3; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_length_return_wit_1 : IntList_length_return_wit_1.
Proof.
 unfold IntList_length_return_wit_1; try right; intros; subst.
 entailer!; apply uint_length_step.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_length_return_wit_2 : IntList_length_return_wit_2.
Proof.
 unfold IntList_length_return_wit_2; try right; intros; subst.
 expose_null; subst; entailer!.
 all: try (simpl; rewrite ?app_nil_r; try rewrite <- app_assoc; simpl; try reflexivity; try congruence).
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_length_partial_solve_wit_1 : IntList_length_partial_solve_wit_1.
Proof.
 unfold IntList_length_partial_solve_wit_1; try right; intros; subst.
 sep_apply (sll_not_zero xs_pre l ltac:(assumption)); Intros tp hv tl; Exists hv tl tp; entailer!.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_length_partial_solve_wit_2 : IntList_length_partial_solve_wit_2.
Proof.
 unfold IntList_length_partial_solve_wit_2; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_rev_aux_safety_wit_1 : IntList_rev_aux_safety_wit_1.
Proof.
 unfold IntList_rev_aux_safety_wit_1; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_rev_aux_return_wit_1 : IntList_rev_aux_return_wit_1.
Proof.
 unfold IntList_rev_aux_return_wit_1; try right; intros; subst.
 expose_null; subst; entailer!.
 all: try (simpl; rewrite ?app_nil_r; try rewrite <- app_assoc; simpl; try reflexivity; try congruence).
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_rev_aux_return_wit_2 : IntList_rev_aux_return_wit_2.
Proof.
 unfold IntList_rev_aux_return_wit_2; try right; intros; subst.
 expose_null; subst; entailer!.
 all: try (simpl; rewrite ?app_nil_r; try rewrite <- app_assoc; simpl; try reflexivity; try congruence).
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_rev_aux_partial_solve_wit_1 : IntList_rev_aux_partial_solve_wit_1.
Proof.
 unfold IntList_rev_aux_partial_solve_wit_1; try right; intros; subst.
 sep_apply (sll_not_zero ys_pre b ltac:(assumption)); Intros tp hv tl; Exists hv tl tp; entailer!.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_rev_aux_partial_solve_wit_2 : IntList_rev_aux_partial_solve_wit_2.
Proof.
 unfold IntList_rev_aux_partial_solve_wit_2; try right; intros; subst.
 entailer!; sep_apply (sll_fold ys_pre x xs_pre a ltac:(assumption)); entailer!.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_rev_safety_wit_1 : IntList_rev_safety_wit_1.
Proof.
 unfold IntList_rev_safety_wit_1; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_rev_return_wit_1 : IntList_rev_return_wit_1.
Proof.
 unfold IntList_rev_return_wit_1; try right; intros; subst.
 expose_null; subst; entailer!.
 all: try (simpl; rewrite ?app_nil_r; try rewrite <- app_assoc; simpl; try reflexivity; try congruence).
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_rev_partial_solve_wit_1 : IntList_rev_partial_solve_wit_1.
Proof.
 unfold IntList_rev_partial_solve_wit_1; try right; intros; subst.
 cbn [sll]; entailer!.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_append_safety_wit_1 : IntList_append_safety_wit_1.
Proof.
 unfold IntList_append_safety_wit_1; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_append_return_wit_1 : IntList_append_return_wit_1.
Proof.
 unfold IntList_append_return_wit_1; try right; intros; subst.
 expose_null; subst; entailer!.
 all: try (simpl; rewrite ?app_nil_r; try rewrite <- app_assoc; simpl; try reflexivity; try congruence).
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_append_return_wit_2 : IntList_append_return_wit_2.
Proof.
 unfold IntList_append_return_wit_2; try right; intros; subst.
 expose_null; subst; entailer!.
 all: try (simpl; rewrite ?app_nil_r; try rewrite <- app_assoc; simpl; try reflexivity; try congruence).
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_append_partial_solve_wit_1 : IntList_append_partial_solve_wit_1.
Proof.
 unfold IntList_append_partial_solve_wit_1; try right; intros; subst.
 sep_apply (sll_not_zero xs_pre a ltac:(assumption)); Intros tp hv tl; Exists hv tl tp; entailer!.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_append_partial_solve_wit_2 : IntList_append_partial_solve_wit_2.
Proof.
 unfold IntList_append_partial_solve_wit_2; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_append2_safety_wit_1 : IntList_append2_safety_wit_1.
Proof.
 unfold IntList_append2_safety_wit_1; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_append2_return_wit_1 : IntList_append2_return_wit_1.
Proof.
 unfold IntList_append2_return_wit_1; try right; intros; subst.
 expose_null; subst; entailer!.
 all: try (simpl; rewrite ?app_nil_r; try rewrite <- app_assoc; simpl; try reflexivity; try congruence).
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_append2_return_wit_2 : IntList_append2_return_wit_2.
Proof.
 unfold IntList_append2_return_wit_2; try right; intros; subst.
 expose_null; subst; entailer!.
 all: try (simpl; rewrite ?app_nil_r; try rewrite <- app_assoc; simpl; try reflexivity; try congruence).
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_append2_partial_solve_wit_1 : IntList_append2_partial_solve_wit_1.
Proof.
 unfold IntList_append2_partial_solve_wit_1; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_append2_partial_solve_wit_2 : IntList_append2_partial_solve_wit_2.
Proof.
 unfold IntList_append2_partial_solve_wit_2; try right; intros; subst.
 sep_apply (sll_not_zero xs_pre a ltac:(assumption)); Intros tp hv tl; Exists hv tl tp; entailer!.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_append2_partial_solve_wit_3 : IntList_append2_partial_solve_wit_3.
Proof.
 unfold IntList_append2_partial_solve_wit_3; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_append2_partial_solve_wit_4_pure : IntList_append2_partial_solve_wit_4_pure.
Proof.
 unfold IntList_append2_partial_solve_wit_4_pure; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_append2_partial_solve_wit_4 : IntList_append2_partial_solve_wit_4.
Proof.
 unfold IntList_append2_partial_solve_wit_4; try right; intros; subst.
 unfold IntList_append2_partial_solve_wit_4_aux; intros; subst; entailer!.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_rev_loop_safety_wit_1 : IntList_rev_loop_safety_wit_1.
Proof.
 unfold IntList_rev_loop_safety_wit_1; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_rev_loop_safety_wit_2 : IntList_rev_loop_safety_wit_2.
Proof.
 unfold IntList_rev_loop_safety_wit_2; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_rev_loop_safety_wit_3 : IntList_rev_loop_safety_wit_3.
Proof.
 unfold IntList_rev_loop_safety_wit_3; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_rev_loop_entail_wit_1 : IntList_rev_loop_entail_wit_1.
Proof.
 unfold IntList_rev_loop_entail_wit_1; try right; intros; subst.
 expose_null; subst; entailer!.
 all: try (simpl; rewrite ?app_nil_r; try rewrite <- app_assoc; simpl; try reflexivity; try congruence).
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_rev_loop_entail_wit_2 : IntList_rev_loop_entail_wit_2.
Proof.
 unfold IntList_rev_loop_entail_wit_2; try right; intros; subst.
 entailer!; rewrite <- PreH3; simpl; rewrite <- app_assoc; reflexivity.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_rev_loop_return_wit_1 : IntList_rev_loop_return_wit_1.
Proof.
 unfold IntList_rev_loop_return_wit_1; try right; intros; subst.
 expose_null; subst; entailer!.
 all: try (simpl; rewrite ?app_nil_r; try rewrite <- app_assoc; simpl; try reflexivity; try congruence).
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_rev_loop_partial_solve_wit_1 : IntList_rev_loop_partial_solve_wit_1.
Proof.
 unfold IntList_rev_loop_partial_solve_wit_1; try right; intros; subst.
 sep_apply (sll_not_zero cur l2 ltac:(assumption)); Intros tp hv tl; Exists hv tl tp; entailer!.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_split_safety_wit_1 : IntList_split_safety_wit_1.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_split_safety_wit_1.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_split_safety_wit_2 : IntList_split_safety_wit_2.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_split_safety_wit_2.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_split_safety_wit_3 : IntList_split_safety_wit_3.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_split_safety_wit_3.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_split_safety_wit_4 : IntList_split_safety_wit_4.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_split_safety_wit_4.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_split_safety_wit_5 : IntList_split_safety_wit_5.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_split_safety_wit_5.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_split_return_wit_1 : IntList_split_return_wit_1.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_split_return_wit_1.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_split_return_wit_2 : IntList_split_return_wit_2.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_split_return_wit_2.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_split_return_wit_3 : IntList_split_return_wit_3.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_split_return_wit_3.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_split_partial_solve_wit_1 : IntList_split_partial_solve_wit_1.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_split_partial_solve_wit_1.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_split_partial_solve_wit_2 : IntList_split_partial_solve_wit_2.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_split_partial_solve_wit_2.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_split_partial_solve_wit_3 : IntList_split_partial_solve_wit_3.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_split_partial_solve_wit_3.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_split_partial_solve_wit_4 : IntList_split_partial_solve_wit_4.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_split_partial_solve_wit_4.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_split_partial_solve_wit_5 : IntList_split_partial_solve_wit_5.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_split_partial_solve_wit_5.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_split_partial_solve_wit_6 : IntList_split_partial_solve_wit_6.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_split_partial_solve_wit_6.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_split_partial_solve_wit_7 : IntList_split_partial_solve_wit_7.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_split_partial_solve_wit_7.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_merge_safety_wit_1 : IntList_merge_safety_wit_1.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_merge_safety_wit_1.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_merge_safety_wit_2 : IntList_merge_safety_wit_2.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_merge_safety_wit_2.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_merge_return_wit_1 : IntList_merge_return_wit_1.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_merge_return_wit_1.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_merge_return_wit_2 : IntList_merge_return_wit_2.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_merge_return_wit_2.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_merge_return_wit_3 : IntList_merge_return_wit_3.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_merge_return_wit_3.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_merge_return_wit_4 : IntList_merge_return_wit_4.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_merge_return_wit_4.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_merge_partial_solve_wit_1 : IntList_merge_partial_solve_wit_1.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_merge_partial_solve_wit_1.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_merge_partial_solve_wit_2 : IntList_merge_partial_solve_wit_2.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_merge_partial_solve_wit_2.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_merge_partial_solve_wit_3 : IntList_merge_partial_solve_wit_3.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_merge_partial_solve_wit_3.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_merge_partial_solve_wit_4 : IntList_merge_partial_solve_wit_4.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_merge_partial_solve_wit_4.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_mergesort_safety_wit_1 : IntList_mergesort_safety_wit_1.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_mergesort_safety_wit_1.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_mergesort_safety_wit_2 : IntList_mergesort_safety_wit_2.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_mergesort_safety_wit_2.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_mergesort_return_wit_1 : IntList_mergesort_return_wit_1.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_mergesort_return_wit_1.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_mergesort_return_wit_2 : IntList_mergesort_return_wit_2.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_mergesort_return_wit_2.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_mergesort_return_wit_3 : IntList_mergesort_return_wit_3.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_mergesort_return_wit_3.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_mergesort_partial_solve_wit_1 : IntList_mergesort_partial_solve_wit_1.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_mergesort_partial_solve_wit_1.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_mergesort_partial_solve_wit_2 : IntList_mergesort_partial_solve_wit_2.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_mergesort_partial_solve_wit_2.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_mergesort_partial_solve_wit_3 : IntList_mergesort_partial_solve_wit_3.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_mergesort_partial_solve_wit_3.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_mergesort_partial_solve_wit_4 : IntList_mergesort_partial_solve_wit_4.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_mergesort_partial_solve_wit_4.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_mergesort_partial_solve_wit_5 : IntList_mergesort_partial_solve_wit_5.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_mergesort_partial_solve_wit_5.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_mergesort_partial_solve_wit_6 : IntList_mergesort_partial_solve_wit_6.
Proof.
 exact mergesort_proof_manual.proof_of_IntList_mergesort_partial_solve_wit_6.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_refUnsignedInt_return_wit_1 : refUnsignedInt_return_wit_1.
Proof.
 unfold refUnsignedInt_return_wit_1; try right; intros; subst.
 expose_null; subst; entailer!.
 all: try (simpl; rewrite ?app_nil_r; try rewrite <- app_assoc; simpl; try reflexivity; try congruence).
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_refUnsignedInt_partial_solve_wit_1 : refUnsignedInt_partial_solve_wit_1.
Proof.
 unfold refUnsignedInt_partial_solve_wit_1; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_length_acc_aux_safety_wit_1 : IntList_length_acc_aux_safety_wit_1.
Proof.
 unfold IntList_length_acc_aux_safety_wit_1; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_length_acc_aux_safety_wit_2 : IntList_length_acc_aux_safety_wit_2.
Proof.
 unfold IntList_length_acc_aux_safety_wit_2; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_length_acc_aux_return_wit_1 : IntList_length_acc_aux_return_wit_1.
Proof.
 unfold IntList_length_acc_aux_return_wit_1; try right; intros; subst.
 expose_null; subst; entailer!; rewrite Zlength_nil, Z.add_0_r; symmetry; apply Z.rem_small; lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_length_acc_aux_return_wit_2 : IntList_length_acc_aux_return_wit_2.
Proof.
 unfold IntList_length_acc_aux_return_wit_2; try right; intros; subst.
 entailer!; apply uint_acc_step; lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_length_acc_aux_partial_solve_wit_1 : IntList_length_acc_aux_partial_solve_wit_1.
Proof.
 unfold IntList_length_acc_aux_partial_solve_wit_1; try right; intros; subst.
 sep_apply (sll_not_zero xs_pre l ltac:(assumption)); Intros tp hv tl; Exists hv tl tp; entailer!.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_length_acc_aux_partial_solve_wit_2_pure : IntList_length_acc_aux_partial_solve_wit_2_pure.
Proof.
 unfold IntList_length_acc_aux_partial_solve_wit_2_pure; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_length_acc_aux_partial_solve_wit_2 : IntList_length_acc_aux_partial_solve_wit_2.
Proof.
 unfold IntList_length_acc_aux_partial_solve_wit_2; try right; intros; subst.
 unfold IntList_length_acc_aux_partial_solve_wit_2_aux; intros; subst; entailer!.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_length_acc_safety_wit_1 : IntList_length_acc_safety_wit_1.
Proof.
 unfold IntList_length_acc_safety_wit_1; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_length_acc_return_wit_1 : IntList_length_acc_return_wit_1.
Proof.
 unfold IntList_length_acc_return_wit_1; try right; intros; subst.
 expose_null; subst; entailer!.
 all: try (simpl; rewrite ?app_nil_r; try rewrite <- app_assoc; simpl; try reflexivity; try congruence).
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_length_acc_partial_solve_wit_1_pure : IntList_length_acc_partial_solve_wit_1_pure.
Proof.
 unfold IntList_length_acc_partial_solve_wit_1_pure; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_length_acc_partial_solve_wit_1 : IntList_length_acc_partial_solve_wit_1.
Proof.
 unfold IntList_length_acc_partial_solve_wit_1; try right; intros; subst.
 unfold IntList_length_acc_partial_solve_wit_1_aux; intros; subst; entailer!.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_length_acc_partial_solve_wit_2_pure : IntList_length_acc_partial_solve_wit_2_pure.
Proof.
 unfold IntList_length_acc_partial_solve_wit_2_pure; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_length_acc_partial_solve_wit_2 : IntList_length_acc_partial_solve_wit_2.
Proof.
 unfold IntList_length_acc_partial_solve_wit_2; try right; intros; subst.
 unfold IntList_length_acc_partial_solve_wit_2_aux; intros; subst; entailer!.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

Lemma proof_of_IntList_length_acc_partial_solve_wit_3 : IntList_length_acc_partial_solve_wit_3.
Proof.
 unfold IntList_length_acc_partial_solve_wit_3; try right; intros; subst.
 entailer!; apply store_uint_undef_store_uint.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.

