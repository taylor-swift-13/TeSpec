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


(* Work on the finite predicates themselves, retaining the witnesses from
   the input byte assertion.  No extensional spatial laws are used. *)
Ltac finite_components :=
  repeat match goal with
  | H : ex _ |- _ => destruct H
  | H : _ /\ _ |- _ => destruct H
  end.
Ltac finite_rebuild fuel :=
  first [ assumption | eassumption | reflexivity | congruence
  | lazymatch fuel with
    | S ?k =>
      first [ solve [split; finite_rebuild k]
            | solve [left; finite_rebuild k]
            | solve [right; finite_rebuild k]
            | solve [match goal with
                     | x : ?T |- @ex ?T _ => exists x; finite_rebuild k
                     end]
            | solve [exists (fun _ => None); finite_rebuild k]
            | solve [eexists; finite_rebuild k]
            | solve [intro; finite_rebuild k]
            | solve [match goal with
                     | |- context [match ?x with Some _ => _ | None => _ end] =>
                         destruct x; cbn in *; finite_rebuild k
                     end] ]
    end ].
Ltac finite_byte :=
  intros h H;
  cbv in H |- *;
  finite_components;
  finite_rebuild constr:(24%nat).

Theorem resolved_init_array2_entail_wit_1_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
  finite_byte.
Qed.
Theorem resolved_init_array2_entail_wit_1 : ExecutionGoal.init_array2_entail_wit_1.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_1.
  left; exact resolved_init_array2_entail_wit_1_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_2_split_goal_1 : ExecutionGoal.init_array2_entail_wit_2_split_goal_1.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_2_split_goal_1.
  intros h H. cbv. reflexivity.
Qed.
Theorem resolved_init_array2_entail_wit_2_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
  finite_byte.
Qed.
Theorem resolved_init_array2_entail_wit_2 : ExecutionGoal.init_array2_entail_wit_2.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_2.
  right. intros h H. split.
  - exact (resolved_init_array2_entail_wit_2_split_goal_1 h H).
  - exact (resolved_init_array2_entail_wit_2_split_goal_spatial h H).
Qed.
Theorem resolved_init_array2_return_wit_1 : ExecutionGoal.init_array2_return_wit_1.
Proof.
  unfold ExecutionGoal.init_array2_return_wit_1.
  left. intros n p Hge Hpos Hp Hn Hnonneg Hmax.
  subst p; subst n.
  replace (4096 + 0 * sizeof(CHAR)) with 4096 by ring.
  intros h H. exists (repeat_Z 0 1).
  exact (resolved_init_array2_entail_wit_1_split_goal_spatial h H).
Qed.
Print Assumptions resolved_init_array2_entail_wit_1_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_1.
Print Assumptions resolved_init_array2_entail_wit_2_split_goal_1.
Print Assumptions resolved_init_array2_entail_wit_2_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_2.
Print Assumptions resolved_init_array2_return_wit_1.
