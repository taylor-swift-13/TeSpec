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

Require Import Primary.
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
Lemma length_push : forall (l:list Z), unsigned_last_nbits (Z.rem (Zlength l) 4294967296+1) 32 = Z.rem (Zlength l+1) 4294967296.
Proof. intros; unfold unsigned_last_nbits; change (2^32) with 4294967296; rewrite !Z.rem_mod_nonneg by (pose proof (Zlength_nonneg l); lia); rewrite Z.add_mod_idemp_l by lia; reflexivity. Qed.
Lemma length_pop : forall (l:list Z), Z.rem (Zlength l+1) 4294967296 > 0 -> Z.rem (Zlength l+1) 4294967296 - 1 = Z.rem (Zlength l) 4294967296.
Proof. intros l H; pose proof (Zlength_nonneg l); rewrite !Z.rem_mod_nonneg in * by lia.
rewrite <- (Z.add_mod_idemp_l (Zlength l) 1 4294967296 ltac:(lia)) in *.
pose proof (Z.mod_pos_bound (Zlength l) 4294967296 ltac:(lia)).
destruct (Z.eq_dec (Zlength l mod 4294967296) 4294967295) as [E|E].
- rewrite E in H; change (0 > 0) in H; lia.
- rewrite Z.mod_small in * by lia; lia.
Qed.
Module Certificate : Primary.VC_Correct.
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
Lemma proof_of_create_safety_wit_1 : create_safety_wit_1.
Proof.
unfold create_safety_wit_1; intros; subst.
 entailer!; try lia.
Qed.
Lemma proof_of_create_safety_wit_2 : create_safety_wit_2.
Proof.
unfold create_safety_wit_2; intros; subst.
 entailer!; try lia.
Qed.
Lemma proof_of_create_return_wit_1 : create_return_wit_1.
Proof.
unfold create_return_wit_1; intros; subst.
 Exists 0 0; entailer!.
Qed.
Lemma proof_of_create_partial_solve_wit_1 : create_partial_solve_wit_1.
Proof.
unfold create_partial_solve_wit_1; intros; subst.
 entailer!; try lia.
Qed.
Lemma proof_of_sizeOf_return_wit_1 : sizeOf_return_wit_1.
Proof.
unfold sizeOf_return_wit_1; intros; subst.
 Exists (Z.rem (Zlength l) 4294967296); entailer!.
Qed.
Lemma proof_of_push_return_wit_1 : push_return_wit_1.
Proof.
unfold push_return_wit_1; intros; subst.
 right; intros; subst; entailer!; apply length_push.
Qed.
Lemma proof_of_push_partial_solve_wit_1_pure : push_partial_solve_wit_1_pure.
Proof.
unfold push_partial_solve_wit_1_pure; intros; subst.
 entailer!; try lia.
Qed.
Lemma proof_of_push_partial_solve_wit_1 : push_partial_solve_wit_1.
Proof.
unfold push_partial_solve_wit_1; intros; subst.
 unfold push_partial_solve_wit_1_aux; intros; subst; entailer!.
Qed.
Lemma proof_of_top_safety_wit_1 : top_safety_wit_1.
Proof.
unfold top_safety_wit_1; intros; subst.
 entailer!; try lia.
Qed.
Lemma proof_of_top_safety_wit_2 : top_safety_wit_2.
Proof.
unfold top_safety_wit_2; intros; subst.
 entailer!; try lia.
Qed.
Lemma proof_of_top_return_wit_1 : top_return_wit_1.
Proof.
unfold top_return_wit_1; intros; subst.
 left; intros; subst; sep_apply (sll_zero 0 (h::l) ltac:(reflexivity)); Intros; discriminate.
Qed.
Lemma proof_of_top_return_wit_2 : top_return_wit_2.
Proof.
unfold top_return_wit_2; intros; subst.
 sep_apply (sll_fold d h y l ltac:(assumption)); Exists (Z.rem (Zlength l+1) 4294967296); entailer!.
Qed.
Lemma proof_of_top_partial_solve_wit_1 : top_partial_solve_wit_1.
Proof.
unfold top_partial_solve_wit_1; intros; subst.
 cbn [sll]; Intros; Intros tp; Exists tp; entailer!.
Qed.
Lemma proof_of_pop_safety_wit_1 : pop_safety_wit_1.
Proof.
unfold pop_safety_wit_1; intros; subst.
 entailer!; try lia.
Qed.
Lemma proof_of_pop_safety_wit_2 : pop_safety_wit_2.
Proof.
unfold pop_safety_wit_2; intros; subst.
 entailer!; try lia.
Qed.
Lemma proof_of_pop_return_wit_1 : pop_return_wit_1.
Proof.
unfold pop_return_wit_1; intros; subst.
 left; intros; subst; sep_apply (sll_zero 0 (h::l) ltac:(reflexivity)); Intros; discriminate.
Qed.
Lemma proof_of_pop_return_wit_2 : pop_return_wit_2.
Proof.
unfold pop_return_wit_2; intros; subst.
 right; intros; subst; entailer!; apply length_pop; assumption.
Qed.
Lemma proof_of_pop_partial_solve_wit_1 : pop_partial_solve_wit_1.
Proof.
unfold pop_partial_solve_wit_1; intros; subst.
 cbn [sll]; Intros; Intros tp; Exists tp; entailer!.
Qed.
Lemma proof_of_pop_partial_solve_wit_2 : pop_partial_solve_wit_2.
Proof.
unfold pop_partial_solve_wit_2; intros; subst.
 sep_apply store_int_undef_store_int; sep_apply store_ptr_undef_store_ptr; entailer!.
Qed.
Lemma proof_of_IntList_nil_safety_wit_1 : IntList_nil_safety_wit_1.
Proof.
unfold IntList_nil_safety_wit_1; try right; intros; subst.
 simpl; entailer!; try lia.
Qed.
Lemma proof_of_IntList_nil_return_wit_1 : IntList_nil_return_wit_1.
Proof.
unfold IntList_nil_return_wit_1; try right; intros; subst.
 cbn [sll]; entailer!.
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
 sep_apply (sll_not_zero xs_pre l ltac:(assumption)); Intros tp hv tl; Exists tp tl hv; entailer!.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.
Lemma proof_of_IntList_length_partial_solve_wit_2 : IntList_length_partial_solve_wit_2.
Proof.
unfold IntList_length_partial_solve_wit_2; try right; intros; subst.
 entailer!; try lia.
 all: try match goal with |- context[unsigned_last_nbits ?v 32] => unfold unsigned_last_nbits; change (2^32) with 4294967296; pose proof (Z.mod_pos_bound v 4294967296 ltac:(lia)); lia end.
Qed.
End Certificate.
Print Assumptions Certificate.proof_of_IntList_cons_return_wit_1.
Print Assumptions Certificate.proof_of_IntList_cons_partial_solve_wit_1.
Print Assumptions Certificate.proof_of_create_safety_wit_1.
Print Assumptions Certificate.proof_of_create_safety_wit_2.
Print Assumptions Certificate.proof_of_create_return_wit_1.
Print Assumptions Certificate.proof_of_create_partial_solve_wit_1.
Print Assumptions Certificate.proof_of_sizeOf_return_wit_1.
Print Assumptions Certificate.proof_of_push_return_wit_1.
Print Assumptions Certificate.proof_of_push_partial_solve_wit_1_pure.
Print Assumptions Certificate.proof_of_push_partial_solve_wit_1.
Print Assumptions Certificate.proof_of_top_safety_wit_1.
Print Assumptions Certificate.proof_of_top_safety_wit_2.
Print Assumptions Certificate.proof_of_top_return_wit_1.
Print Assumptions Certificate.proof_of_top_return_wit_2.
Print Assumptions Certificate.proof_of_top_partial_solve_wit_1.
Print Assumptions Certificate.proof_of_pop_safety_wit_1.
Print Assumptions Certificate.proof_of_pop_safety_wit_2.
Print Assumptions Certificate.proof_of_pop_return_wit_1.
Print Assumptions Certificate.proof_of_pop_return_wit_2.
Print Assumptions Certificate.proof_of_pop_partial_solve_wit_1.
Print Assumptions Certificate.proof_of_pop_partial_solve_wit_2.
Print Assumptions Certificate.proof_of_IntList_nil_safety_wit_1.
Print Assumptions Certificate.proof_of_IntList_nil_return_wit_1.
Print Assumptions Certificate.proof_of_IntList_length_safety_wit_1.
Print Assumptions Certificate.proof_of_IntList_length_safety_wit_2.
Print Assumptions Certificate.proof_of_IntList_length_safety_wit_3.
Print Assumptions Certificate.proof_of_IntList_length_return_wit_1.
Print Assumptions Certificate.proof_of_IntList_length_return_wit_2.
Print Assumptions Certificate.proof_of_IntList_length_partial_solve_wit_1.
Print Assumptions Certificate.proof_of_IntList_length_partial_solve_wit_2.
