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


Local Lemma finite_refl (P : (model -> Prop)) : P |-- P.
Proof. intros h H; exact H. Qed.
Local Lemma finite_trans (P Q R : (model -> Prop)) :
  (P |-- Q) -> (Q |-- R) -> (P |-- R).
Proof. intros H1 H2 h H; exact (H2 h (H1 h H)). Qed.
Local Lemma finite_frame (P P' Q Q' : (model -> Prop)) :
  (P |-- P') -> (Q |-- Q') -> (P ** Q |-- P' ** Q').
Proof.
  intros HP HQ h [a [b [J [A B]]]].
  exists a, b; split; [exact J|split; [apply HP; exact A|apply HQ; exact B]].
Qed.
Local Lemma finite_unit (P : (model -> Prop)) : P |-- P ** emp.
Proof.
  intros h H. destruct (unit_join h) as [u [U J]].
  exists h, u; split; [exact J|split; assumption].
Qed.
Local Lemma finite_assoc (P Q R : (model -> Prop)) :
  (P ** Q) ** R |-- P ** (Q ** R).
Proof.
  intros h [ab [c [J [ [a [b [K [A B]]]] C]]]].
  destruct (join_assoc _ _ _ _ _ K J) as [bc [L M]].
  exists a, bc; split; [exact M|split; [exact A|]].
  exists b, c; split; [exact L|split; assumption].
Qed.
Local Lemma finite_swap (P Q R : (model -> Prop)) :
  P ** (Q ** R) |-- Q ** (P ** R).
Proof.
  intros h [a [bc [J [A [b [c [K [B C]]]]]]]].
  pose proof (join_comm _ _ _ J) as J'.
  destruct (join_assoc _ _ _ _ _ K J') as [ca [L M]].
  exists b, ca; split; [exact M|split; [exact B|]].
  exists a, c; split; [apply join_comm; exact L|split; assumption].
Qed.

Ltac finite_chain s tail :=
  lazymatch s with
  | ?a ** ?b => let t := finite_chain b tail in finite_chain a t
  | _ => constr:(s ** tail)
  end.
Ltac finite_normalize :=
  lazymatch goal with
  | |- (?a ** ?b) ** ?tail |-- _ =>
      let bt := finite_chain b tail in
      eapply finite_trans; [apply finite_assoc|];
      eapply finite_trans with (Q := a ** bt);
      [apply finite_frame; [apply finite_refl|finite_normalize]|finite_normalize]
  | |- _ => apply finite_refl
  end.
Ltac finite_remove x s :=
  lazymatch s with
  | ?a ** ?b =>
      lazymatch a with
      | x => constr:(b)
      | _ => let r := finite_remove x b in constr:(a ** r)
      end
  end.
Ltac finite_pick :=
  lazymatch goal with
  | |- ?s |-- ?x ** ?r =>
      lazymatch s with
      | ?a ** ?b =>
          tryif unify a x then apply finite_refl
          else let br := finite_remove x b in
            eapply finite_trans with (Q := a ** (x ** br));
            [apply finite_frame; [apply finite_refl|finite_pick]|apply finite_swap]
      end
  end.
Ltac finite_arrange :=
  first [apply finite_refl |
    lazymatch goal with
    | |- ?s |-- ?a ** ?b =>
        let r := finite_remove a s in
        eapply finite_trans with (Q := a ** r);
        [finite_pick|apply finite_frame; [apply finite_refl|finite_arrange]]
    | |- _ => intros h H; cbn [andp coq_prop];
        repeat first [exact H | reflexivity | split]
    end].
Ltac finite_cells :=
  lazymatch goal with
  | |- ?s |-- _ =>
      let t := finite_chain s emp in
      eapply finite_trans with (Q := t);
      [eapply finite_trans; [apply finite_unit|finite_normalize]|finite_arrange]
  end.
Ltac finite_full :=
  repeat match goal with
  | |- context [repeat_Z ?v ?n] =>
      let l := eval compute in (repeat_Z v n) in
      change (repeat_Z v n) with l
  end;
  cbv beta iota zeta delta
    [CharArray.full store_array store_array_rec StoreCharAsElement.storeA];
  rewrite ?sizeof_char; finite_cells.
Ltac finite_undef :=
  cbv beta iota zeta delta
    [CharArray.undef_full store_undef_array];
  change (Z.to_nat 5) with 5%nat;
  cbv beta iota zeta delta
    [store_undef_array_rec StoreCharAsElement.undefstoreA];
  rewrite ?sizeof_char; finite_cells.

Theorem resolved_init_array2_entail_wit_1_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial; finite_full.
Qed.
Theorem resolved_init_array2_entail_wit_1 : ExecutionGoal.init_array2_entail_wit_1.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_1; right; exact resolved_init_array2_entail_wit_1_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_2_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial; finite_full.
Qed.
Theorem resolved_init_array2_entail_wit_2 : ExecutionGoal.init_array2_entail_wit_2.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_2; right; exact resolved_init_array2_entail_wit_2_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_3_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial; finite_full.
Qed.
Theorem resolved_init_array2_entail_wit_3 : ExecutionGoal.init_array2_entail_wit_3.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_3; right; exact resolved_init_array2_entail_wit_3_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_4_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial; finite_full.
Qed.
Theorem resolved_init_array2_entail_wit_4 : ExecutionGoal.init_array2_entail_wit_4.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_4; right; exact resolved_init_array2_entail_wit_4_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_5_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_5_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_5_split_goal_spatial; finite_full.
Qed.
Theorem resolved_init_array2_entail_wit_5 : ExecutionGoal.init_array2_entail_wit_5.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_5; right; exact resolved_init_array2_entail_wit_5_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_6_split_goal_1 : ExecutionGoal.init_array2_entail_wit_6_split_goal_1.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_6_split_goal_1.
  intros h H; cbn [coq_prop repeat_Z]; reflexivity.
Qed.
Theorem resolved_init_array2_entail_wit_6_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_6_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_6_split_goal_spatial; finite_undef.
Qed.
Theorem resolved_init_array2_entail_wit_6 : ExecutionGoal.init_array2_entail_wit_6.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_6; right.
  intros h H; split.
  - exact (resolved_init_array2_entail_wit_6_split_goal_1 h H).
  - exact (resolved_init_array2_entail_wit_6_split_goal_spatial h H).
Qed.
Theorem resolved_init_array2_return_wit_1 : ExecutionGoal.init_array2_return_wit_1.
Proof.
  unfold ExecutionGoal.init_array2_return_wit_1; right.
  intros n_pre p_pre H1 H2 H3 H4 H5 H6 Hp Hn H9 H10.
  subst n_pre; subst p_pre.
  rewrite sizeof_char.
  intros h H; exists (repeat_Z 0 5).
  apply resolved_init_array2_entail_wit_1_split_goal_spatial.
  exact H.
Qed.
Print Assumptions resolved_init_array2_entail_wit_1_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_1.
Print Assumptions resolved_init_array2_entail_wit_2_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_2.
Print Assumptions resolved_init_array2_entail_wit_3_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_3.
Print Assumptions resolved_init_array2_entail_wit_4_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_4.
Print Assumptions resolved_init_array2_entail_wit_5_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_5.
Print Assumptions resolved_init_array2_entail_wit_6_split_goal_1.
Print Assumptions resolved_init_array2_entail_wit_6_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_6.
Print Assumptions resolved_init_array2_return_wit_1.
