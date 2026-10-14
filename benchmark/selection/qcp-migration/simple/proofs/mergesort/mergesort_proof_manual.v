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
Require Import mergesort_def.
Import naive_C_Rules.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Require Import FulminateMerge.
Local Open Scope sac.


Require Import mergesort_goal.
Ltac expose_null := repeat match goal with
| |- context[sll 0 ?l] => sep_apply (sll_zero 0 l ltac:(reflexivity)); Intros; subst
end.
Ltac expose_nonnull := repeat match goal with
| H : ?p <> 0 |- context[sll ?p ?l] =>
  sep_apply (sll_not_zero p l H);
  let y := fresh "tail_ptr" in let a := fresh "head_value" in let tl := fresh "tail_list" in Intros y a tl
end.
Lemma proof_of_IntList_nil_safety_wit_1 : IntList_nil_safety_wit_1.
Proof.
 unfold IntList_nil_safety_wit_1; try right; intros; subst.
 unfold UndefStructPredint_list_pair,StructPredint_list_pair; simpl; entailer!; try lia.
Qed.

Lemma proof_of_IntList_nil_return_wit_1 : IntList_nil_return_wit_1.
Proof.
 unfold IntList_nil_return_wit_1; try right; intros; subst.
 cbn [sll]; entailer!.
Qed.

Lemma proof_of_IntList_cons_return_wit_1 : IntList_cons_return_wit_1.
Proof.
 unfold IntList_cons_return_wit_1; try right; intros; subst.
 cbn [sll]; Exists t_pre; entailer!.
Qed.

Lemma proof_of_IntList_cons_partial_solve_wit_1 : IntList_cons_partial_solve_wit_1.
Proof.
 unfold IntList_cons_partial_solve_wit_1; try right; intros; subst.
 unfold UndefStructPredint_list_pair,StructPredint_list_pair; simpl; entailer!; try lia.
Qed.

Lemma proof_of_IntList_split_safety_wit_1 : IntList_split_safety_wit_1.
Proof.
 unfold IntList_split_safety_wit_1; try right; intros; subst.
 unfold UndefStructPredint_list_pair,StructPredint_list_pair; simpl; entailer!; try lia.
Qed.

Lemma proof_of_IntList_split_safety_wit_2 : IntList_split_safety_wit_2.
Proof.
 unfold IntList_split_safety_wit_2; try right; intros; subst.
 unfold UndefStructPredint_list_pair,StructPredint_list_pair; simpl; entailer!; try lia.
Qed.

Lemma proof_of_IntList_split_safety_wit_3 : IntList_split_safety_wit_3.
Proof.
 unfold IntList_split_safety_wit_3; try right; intros; subst.
 unfold UndefStructPredint_list_pair,StructPredint_list_pair; simpl; entailer!; try lia.
Qed.

Lemma proof_of_IntList_split_safety_wit_4 : IntList_split_safety_wit_4.
Proof.
 unfold IntList_split_safety_wit_4; try right; intros; subst.
 unfold UndefStructPredint_list_pair,StructPredint_list_pair; simpl; entailer!; try lia.
Qed.

Lemma proof_of_IntList_split_safety_wit_5 : IntList_split_safety_wit_5.
Proof.
 unfold IntList_split_safety_wit_5; try right; intros; subst.
 unfold UndefStructPredint_list_pair,StructPredint_list_pair; simpl; entailer!; try lia.
Qed.

Lemma proof_of_IntList_split_return_wit_1 : IntList_split_return_wit_1.
Proof.
 unfold IntList_split_return_wit_1; try right; intros; subst.
 expose_null; subst; cbn [cn_split_fst cn_split_snd cn_split]; entailer!.
 all: try (unfold cn_split_fst,cn_split_snd; simpl; destruct (cn_split l0_2); reflexivity).
Qed.

Lemma proof_of_IntList_split_return_wit_2 : IntList_split_return_wit_2.
Proof.
 unfold IntList_split_return_wit_2; try right; intros; subst.
 expose_null; subst; cbn [cn_split_fst cn_split_snd cn_split]; entailer!.
 all: try (unfold cn_split_fst,cn_split_snd; simpl; destruct (cn_split l0_2); reflexivity).
Qed.

Lemma proof_of_IntList_split_return_wit_3 : IntList_split_return_wit_3.
Proof.
 unfold IntList_split_return_wit_3; try right; intros; subst.
 expose_null; subst; cbn [cn_split_fst cn_split_snd cn_split]; entailer!.
 all: try (unfold cn_split_fst,cn_split_snd; simpl; destruct (cn_split l0_2); reflexivity).
Qed.

Lemma proof_of_IntList_split_partial_solve_wit_1 : IntList_split_partial_solve_wit_1.
Proof.
 unfold IntList_split_partial_solve_wit_1; try right; intros; subst.
 unfold UndefStructPredint_list_pair,StructPredint_list_pair; simpl; entailer!; try lia.
Qed.

Lemma proof_of_IntList_split_partial_solve_wit_2 : IntList_split_partial_solve_wit_2.
Proof.
 unfold IntList_split_partial_solve_wit_2; try right; intros; subst.
 sep_apply (sll_not_zero xs_pre l ltac:(assumption)); Intros tp hv tl; Exists hv tl tp; entailer!.
Qed.

Lemma proof_of_IntList_split_partial_solve_wit_3 : IntList_split_partial_solve_wit_3.
Proof.
 unfold IntList_split_partial_solve_wit_3; try right; intros; subst.
 unfold UndefStructPredint_list_pair,StructPredint_list_pair; simpl; entailer!; try lia.
Qed.

Lemma proof_of_IntList_split_partial_solve_wit_4 : IntList_split_partial_solve_wit_4.
Proof.
 unfold IntList_split_partial_solve_wit_4; try right; intros; subst.
 sep_apply (sll_not_zero y l0 ltac:(assumption)); Intros tp hv tl; Exists hv tl tp; entailer!.
Qed.

Lemma proof_of_IntList_split_partial_solve_wit_5 : IntList_split_partial_solve_wit_5.
Proof.
 unfold IntList_split_partial_solve_wit_5; try right; intros; subst.
 unfold UndefStructPredint_list_pair,StructPredint_list_pair; simpl; entailer!; try lia.
Qed.

Lemma proof_of_IntList_split_partial_solve_wit_6 : IntList_split_partial_solve_wit_6.
Proof.
 unfold IntList_split_partial_solve_wit_6; try right; intros; subst.
 unfold UndefStructPredint_list_pair,StructPredint_list_pair; simpl; entailer!; try lia.
Qed.

Lemma proof_of_IntList_split_partial_solve_wit_7 : IntList_split_partial_solve_wit_7.
Proof.
 unfold IntList_split_partial_solve_wit_7; try right; intros; subst.
 unfold UndefStructPredint_list_pair,StructPredint_list_pair; simpl; entailer!; try lia.
Qed.

Lemma proof_of_IntList_merge_safety_wit_1 : IntList_merge_safety_wit_1.
Proof.
 unfold IntList_merge_safety_wit_1; try right; intros; subst.
 unfold UndefStructPredint_list_pair,StructPredint_list_pair; simpl; entailer!; try lia.
Qed.

Lemma proof_of_IntList_merge_safety_wit_2 : IntList_merge_safety_wit_2.
Proof.
 unfold IntList_merge_safety_wit_2; try right; intros; subst.
 unfold UndefStructPredint_list_pair,StructPredint_list_pair; simpl; entailer!; try lia.
Qed.

Lemma proof_of_IntList_merge_return_wit_1 : IntList_merge_return_wit_1.
Proof.
 unfold IntList_merge_return_wit_1; try right; intros; subst.
 expose_null; subst; cbn [cn_merge]; try (destruct (x <? x_2) eqn:Hcmp; [apply Z.ltb_lt in Hcmp | apply Z.ltb_ge in Hcmp]); try lia; entailer!.
 all: try (destruct l; reflexivity).
Qed.

Lemma proof_of_IntList_merge_return_wit_2 : IntList_merge_return_wit_2.
Proof.
 unfold IntList_merge_return_wit_2; try right; intros; subst.
 expose_null; subst; cbn [cn_merge]; try (destruct (x <? x_2) eqn:Hcmp; [apply Z.ltb_lt in Hcmp | apply Z.ltb_ge in Hcmp]); try lia; entailer!.
 all: try (destruct l; reflexivity).
Qed.

Lemma proof_of_IntList_merge_return_wit_3 : IntList_merge_return_wit_3.
Proof.
 unfold IntList_merge_return_wit_3; try right; intros; subst.
 expose_null; subst; cbn [cn_merge]; try (destruct (x <? x_2) eqn:Hcmp; [apply Z.ltb_lt in Hcmp | apply Z.ltb_ge in Hcmp]); try lia; entailer!.
 all: try (destruct l; reflexivity).
Qed.

Lemma proof_of_IntList_merge_return_wit_4 : IntList_merge_return_wit_4.
Proof.
 unfold IntList_merge_return_wit_4; try right; intros; subst.
 expose_null; subst; cbn [cn_merge]; try (destruct (x <? x_2) eqn:Hcmp; [apply Z.ltb_lt in Hcmp | apply Z.ltb_ge in Hcmp]); try lia; entailer!.
 all: try (destruct l; reflexivity).
Qed.

Lemma proof_of_IntList_merge_partial_solve_wit_1 : IntList_merge_partial_solve_wit_1.
Proof.
 unfold IntList_merge_partial_solve_wit_1; try right; intros; subst.
 sep_apply (sll_not_zero xs_pre l ltac:(assumption)); Intros tp hv tl; Exists hv tl tp; entailer!.
Qed.

Lemma proof_of_IntList_merge_partial_solve_wit_2 : IntList_merge_partial_solve_wit_2.
Proof.
 unfold IntList_merge_partial_solve_wit_2; try right; intros; subst.
 sep_apply (sll_not_zero ys_pre r ltac:(assumption)); Intros tp hv tl; Exists hv tl tp; entailer!.
Qed.

Lemma proof_of_IntList_merge_partial_solve_wit_3 : IntList_merge_partial_solve_wit_3.
Proof.
 unfold IntList_merge_partial_solve_wit_3; try right; intros; subst.
 cbn [sll]; Exists y_2; entailer!.
Qed.

Lemma proof_of_IntList_merge_partial_solve_wit_4 : IntList_merge_partial_solve_wit_4.
Proof.
 unfold IntList_merge_partial_solve_wit_4; try right; intros; subst.
 cbn [sll]; Exists y_2; entailer!.
Qed.

Lemma proof_of_IntList_mergesort_safety_wit_1 : IntList_mergesort_safety_wit_1.
Proof.
 unfold IntList_mergesort_safety_wit_1; try right; intros; subst.
 unfold UndefStructPredint_list_pair,StructPredint_list_pair; simpl; entailer!; try lia.
Qed.

Lemma proof_of_IntList_mergesort_safety_wit_2 : IntList_mergesort_safety_wit_2.
Proof.
 unfold IntList_mergesort_safety_wit_2; try right; intros; subst.
 unfold UndefStructPredint_list_pair,StructPredint_list_pair; simpl; entailer!; try lia.
Qed.

Lemma proof_of_IntList_mergesort_return_wit_1 : IntList_mergesort_return_wit_1.
Proof.
 unfold IntList_mergesort_return_wit_1; try right; intros; subst.
 rewrite <- cn_mergesort_split; entailer!.
Qed.

Lemma proof_of_IntList_mergesort_return_wit_2 : IntList_mergesort_return_wit_2.
Proof.
 unfold IntList_mergesort_return_wit_2; try right; intros; subst.
 expose_null; subst; rewrite cn_mergesort_equation; simpl; entailer!.
Qed.

Lemma proof_of_IntList_mergesort_return_wit_3 : IntList_mergesort_return_wit_3.
Proof.
 unfold IntList_mergesort_return_wit_3; try right; intros; subst.
 expose_null; subst; rewrite cn_mergesort_equation; simpl; entailer!.
Qed.

Lemma proof_of_IntList_mergesort_partial_solve_wit_1 : IntList_mergesort_partial_solve_wit_1.
Proof.
 unfold IntList_mergesort_partial_solve_wit_1; try right; intros; subst.
 sep_apply (sll_not_zero xs_pre l ltac:(assumption)); Intros tp hv tl; Exists hv tl tp; entailer!.
Qed.

Lemma proof_of_IntList_mergesort_partial_solve_wit_2 : IntList_mergesort_partial_solve_wit_2.
Proof.
 unfold IntList_mergesort_partial_solve_wit_2; try right; intros; subst.
 cbn [sll]; Exists y; entailer!.
Qed.

Lemma proof_of_IntList_mergesort_partial_solve_wit_3 : IntList_mergesort_partial_solve_wit_3.
Proof.
 unfold IntList_mergesort_partial_solve_wit_3; try right; intros; subst.
 unfold UndefStructPredint_list_pair,StructPredint_list_pair; simpl; entailer!; try lia.
Qed.

Lemma proof_of_IntList_mergesort_partial_solve_wit_4 : IntList_mergesort_partial_solve_wit_4.
Proof.
 unfold IntList_mergesort_partial_solve_wit_4; try right; intros; subst.
 unfold UndefStructPredint_list_pair,StructPredint_list_pair; simpl; entailer!; try lia.
Qed.

Lemma proof_of_IntList_mergesort_partial_solve_wit_5 : IntList_mergesort_partial_solve_wit_5.
Proof.
 unfold IntList_mergesort_partial_solve_wit_5; try right; intros; subst.
 unfold UndefStructPredint_list_pair,StructPredint_list_pair; simpl; entailer!; try lia.
Qed.

Lemma proof_of_IntList_mergesort_partial_solve_wit_6 : IntList_mergesort_partial_solve_wit_6.
Proof.
 unfold IntList_mergesort_partial_solve_wit_6; try right; intros; subst.
 unfold UndefStructPredint_list_pair,StructPredint_list_pair; simpl; entailer!; try lia.
Qed.

