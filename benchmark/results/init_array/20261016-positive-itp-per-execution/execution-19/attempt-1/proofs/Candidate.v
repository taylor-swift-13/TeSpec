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


(* All transformations below act on the original separating witnesses. *)
Lemma finite_id (P : model -> Prop) : P |-- P.
Proof. intros m H; exact H. Qed.

Lemma finite_trans (P Q R : model -> Prop) :
  (P |-- Q) -> (Q |-- R) -> (P |-- R).
Proof. intros H K m HP; exact (K m (H m HP)). Qed.

Lemma finite_frame (P P' Q Q' : model -> Prop) :
  (P |-- P') -> (Q |-- Q') -> (P ** Q |-- P' ** Q').
Proof.
  intros HP HQ m [a [b [J [HA HB]]]].
  exists a, b; split; [exact J | split; [apply HP | apply HQ]; assumption].
Qed.

Lemma finite_assoc (P Q R : model -> Prop) :
  (P ** Q) ** R |-- P ** (Q ** R).
Proof.
  intros m [ab [c [J [[a [b [K [HA HB]]]] HC]]]].
  destruct (join_assoc _ _ _ _ _ K J) as [bc [L M]].
  exists a, bc; split; [exact M | split; [exact HA |]].
  exists b, c; split; [exact L | split; assumption].
Qed.

Lemma finite_pull (P Q R : model -> Prop) :
  P ** (Q ** R) |-- Q ** (P ** R).
Proof.
  intros m [a [bc [J [HA [b [c [K [HB HC]]]]]]]].
  pose proof (join_comm _ _ _ J) as J'.
  destruct (join_assoc _ _ _ _ _ K J') as [ca [L M]].
  exists b, ca; split; [exact M | split; [exact HB |]].
  exists a, c; split; [apply join_comm; exact L | split; assumption].
Qed.

Lemma finite_append_unit (P : model -> Prop) : P |-- P ** emp.
Proof.
  intros m HP; destruct (unit_join m) as [u [HU J]].
  exists m, u; split; [exact J | split; assumption].
Qed.

Ltac finite_normalize :=
  repeat match goal with
  | |- ((?P ** ?Q) ** ?R) |-- ?S =>
      eapply finite_trans; [apply finite_assoc |]
  end.

(* Pick one leaf, keeping the rest of the actual heap as the frame. *)
Ltac finite_pick :=
  finite_normalize;
  match goal with
  | |- (?P ** ?Q) |-- (?R ** ?S) =>
      first [unify P R; apply finite_id
      | eapply (finite_trans _ (P ** (R ** _)) _);
        [apply finite_frame; [apply finite_id | finite_pick]
        | apply finite_pull]]
  end.

Ltac finite_finish :=
  finite_normalize;
  first [apply finite_id
  | match goal with
    | |- ?P |-- (?Q ** ?R) =>
        eapply (finite_trans _ (Q ** _) _);
        [finite_pick | apply finite_frame; [apply finite_id | finite_finish]]
    end
  | intros ? HU;
    first [exact HU
    | split; [reflexivity | exact HU]
    | split; [reflexivity | split; [reflexivity | exact HU]]]].

Ltac finite_cells :=
  cbn [CharArray.seg CharArray.full store_array store_array_rec
       StoreCharAsElement.storeA repeat_Z];
  repeat rewrite sizeof_char;
  eapply finite_trans; [apply finite_append_unit | finite_finish].

Theorem resolved_init_array2_entail_wit_1_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial; finite_cells. Qed.
Theorem resolved_init_array2_entail_wit_1 : ExecutionGoal.init_array2_entail_wit_1.
Proof. right; exact resolved_init_array2_entail_wit_1_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_2_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
  change (_ |-- CharArray.undef_seg 4096 0 1 ** CharArray.seg 4096 1 5 (repeat_Z 0 4)).
  finite_cells.
Qed.
Theorem resolved_init_array2_entail_wit_2 : ExecutionGoal.init_array2_entail_wit_2.
Proof. right; exact resolved_init_array2_entail_wit_2_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_3_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
  change (_ |-- CharArray.undef_seg 4096 0 2 ** CharArray.seg 4096 2 5 (repeat_Z 0 3)).
  finite_cells.
Qed.
Theorem resolved_init_array2_entail_wit_3 : ExecutionGoal.init_array2_entail_wit_3.
Proof. right; exact resolved_init_array2_entail_wit_3_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_4_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial.
  change (_ |-- CharArray.undef_seg 4096 0 3 ** CharArray.seg 4096 3 5 (repeat_Z 0 2)).
  finite_cells.
Qed.
Theorem resolved_init_array2_entail_wit_4 : ExecutionGoal.init_array2_entail_wit_4.
Proof. right; exact resolved_init_array2_entail_wit_4_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_5_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_5_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_5_split_goal_spatial.
  change (_ |-- CharArray.undef_seg 4096 0 4 ** CharArray.seg 4096 4 5 (repeat_Z 0 1)).
  finite_cells.
Qed.
Theorem resolved_init_array2_entail_wit_5 : ExecutionGoal.init_array2_entail_wit_5.
Proof. right; exact resolved_init_array2_entail_wit_5_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_6_split_goal_1 : ExecutionGoal.init_array2_entail_wit_6_split_goal_1.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_6_split_goal_1.
  intros m H; change (repeat_Z 0 0 = (@nil Z)); reflexivity.
Qed.
Theorem resolved_init_array2_entail_wit_6_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_6_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_6_split_goal_spatial.
  cbn [CharArray.undef_full store_undef_array store_undef_array_rec
       StoreCharAsElement.undefstoreA];
  repeat rewrite sizeof_char.
  eapply finite_trans; [apply finite_append_unit | finite_finish].
Qed.
Theorem resolved_init_array2_entail_wit_6 : ExecutionGoal.init_array2_entail_wit_6.
Proof.
  right; intros m H; split.
  - exact (resolved_init_array2_entail_wit_6_split_goal_1 m H).
  - exact (resolved_init_array2_entail_wit_6_split_goal_spatial m H).
Qed.
Theorem resolved_init_array2_return_wit_1 : ExecutionGoal.init_array2_return_wit_1.
Proof.
  left; intros n p Hbound H4 H3 H2 H1 H0 Hp Hn Hnonneg Hmax Hpos.
  subst n; subst p.
  intros m H; exists (repeat_Z 0 5).
  revert m H; finite_cells.
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
