Require Import ExecutionGoal.
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
Local Open Scope sac.
Local Open Scope Z_scope.


(* Reduce only the finite array structure, keeping the cell predicates opaque. *)
Ltac finite_array_pred fuel P :=
  lazymatch fuel with
  | O => constr:(P)
  | S ?fuel' =>
    lazymatch P with
    | (?a # Char |-> ?v) => constr:(P)
    | (?a # Char |->_) => constr:(P)
    | emp => constr:(P)
    | TT => constr:(P)
    | “ ?p ” => constr:(P)
    | ?A ** ?B =>
        let A' := finite_array_pred fuel' A in
        let B' := finite_array_pred fuel' B in
        constr:(A' ** B')
    | ?A && ?B =>
        let A' := finite_array_pred fuel' A in
        let B' := finite_array_pred fuel' B in
        constr:(A' && B')
    | _ => let P' := eval red in P in finite_array_pred fuel' P'
    end
  end.

Ltac finite_array_entail :=
  lazymatch goal with
  | |- ?P |-- ?Q =>
      let fuel := constr:(32%nat) in
      let P' := finite_array_pred fuel P in
      let Q' := finite_array_pred fuel Q in
      change (P' |-- Q'); cbn [repeat_Z]; entailer!
  end.

Theorem resolved_init_array2_entail_wit_1_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
  finite_array_entail.
Qed.
Theorem resolved_init_array2_entail_wit_1 : ExecutionGoal.init_array2_entail_wit_1.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_1.
  right; exact resolved_init_array2_entail_wit_1_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_2_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
  finite_array_entail.
Qed.
Theorem resolved_init_array2_entail_wit_2 : ExecutionGoal.init_array2_entail_wit_2.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_2.
  right; exact resolved_init_array2_entail_wit_2_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_3_split_goal_1 : ExecutionGoal.init_array2_entail_wit_3_split_goal_1.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_3_split_goal_1.
  cbn [repeat_Z]; entailer!.
Qed.
Theorem resolved_init_array2_entail_wit_3_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
  finite_array_entail.
Qed.
Theorem resolved_init_array2_entail_wit_3 : ExecutionGoal.init_array2_entail_wit_3.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_3.
  right.
  finite_array_entail.
Qed.
Theorem resolved_init_array2_return_wit_1 : ExecutionGoal.init_array2_return_wit_1.
Proof.
  unfold ExecutionGoal.init_array2_return_wit_1.
  right; intros n_pre p_pre H1 H2 H3 Hp Hn H6 H7.
  subst p_pre; subst n_pre.
  intros h Hh; exists (0 :: 0 :: nil).
  revert h Hh.
  change (
    (((4096 + ((0 + 1) * sizeof(CHAR)))) # Char |-> 0)
    ** (((4096 + (0 * sizeof(CHAR)))) # Char |-> 0)
    |-- CharArray.full 4096 2 (0 :: 0 :: nil)).
  finite_array_entail.
Qed.
Print Assumptions resolved_init_array2_entail_wit_1_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_1.
Print Assumptions resolved_init_array2_entail_wit_2_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_2.
Print Assumptions resolved_init_array2_entail_wit_3_split_goal_1.
Print Assumptions resolved_init_array2_entail_wit_3_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_3.
Print Assumptions resolved_init_array2_return_wit_1.
