(* Explicit field-address interpretation for the standard 32-bit list ABI.
   Not substituted into archived VCs or benchmark suites. *)
Require Import Coq.ZArith.ZArith Coq.Lists.List Coq.Strings.String.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import Logic.LogicGenerator.demo932.Interface.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Import naive_C_Rules.
Import ListNotations.
Local Open Scope Z_scope.
Local Open Scope string_scope.
Local Open Scope sac.

Require Import SimpleC.EE.QCP_demos_human.sll_layout32.

Theorem sll32_corresponds_under_field_layout :
  (forall p, &(p # "list" ->ₛ "data") = p) ->
  (forall p, &(p # "list" ->ₛ "next") = p + 4) ->
  forall values p, sll p values --||-- sll32 p values.
Proof.
  intros Hdata Hnext values. induction values as [| element tail IH]; intro p.
  - cbn [sll sll32]. split; apply derivable1_refl.
  - cbn [sll sll32]. rewrite Hdata, Hnext. split.
    + Intros next. Exists next.
      sep_apply (proj1 (IH next)). entailer!.
    + Intros next. Exists next.
      sep_apply (proj2 (IH next)). entailer!.
Qed.

Print Assumptions sll32_corresponds_under_field_layout.
