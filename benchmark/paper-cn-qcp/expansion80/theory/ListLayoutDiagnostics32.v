(* Diagnose missing field-layout premises; no runtime axioms are added here. *)
Require Import Coq.ZArith.ZArith Coq.Lists.List Coq.Strings.String Coq.micromega.Lia.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import Logic.LogicGenerator.demo932.Interface.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Import naive_C_Rules.
Import ListNotations.
Local Open Scope Z_scope.
Local Open Scope string_scope.
Local Open Scope sac.

Theorem collapsed_fields_refute_nonempty_sll : forall p value tail,
  &(p # "list" ->ₛ "data") = &(p # "list" ->ₛ "next") ->
  sll p (value :: tail) |-- “ False ”.
Proof.
  intros p value tail Hsame. cbn [sll]. Intros next.
  rewrite <- Hsame.
  sep_apply (store_int_undef_store_int &(p # "list" ->ₛ "data") value).
  Intros.
  sep_apply (store_ptr_undef_store_ptr &(p # "list" ->ₛ "data") next).
  Intros.
  unfold undef_store_int, undef_store_ptr. Intros.
  sep_apply (dup_store_4bytes_noninit &(p # "list" ->ₛ "data")).
  entailer!.
Qed.

Theorem singleton_sll_matches_concrete_layout : forall p value,
  p <> 0 ->
  &(p # "list" ->ₛ "data") = p ->
  &(p # "list" ->ₛ "next") = p + 4 ->
  sll p [value] --||-- (store_int p value ** store_ptr (p + 4) 0).
Proof.
  intros p value Hnonnull Hdata Hnext.
  cbn [sll]. rewrite Hdata, Hnext. split.
  - Intros next. subst next. entailer!.
  - Exists 0. entailer!.
Qed.

Print Assumptions collapsed_fields_refute_nonempty_sll.
Print Assumptions singleton_sll_matches_concrete_layout.
