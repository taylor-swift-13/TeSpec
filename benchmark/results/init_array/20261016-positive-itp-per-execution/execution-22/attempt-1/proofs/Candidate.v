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

Lemma finite_trans (P Q R : model -> Prop) :
  (P |-- Q) -> (Q |-- R) -> (P |-- R).
Proof. intros HP HQ h H; apply HQ, HP, H. Qed.
Lemma finite_id (P : model -> Prop) : P |-- P.
Proof. intros h H; exact H. Qed.
Lemma finite_frame (P P' Q Q' : model -> Prop) :
  (P |-- P') -> (Q |-- Q') -> (P ** Q |-- P' ** Q').
Proof.
  intros HP HQ h H.
  destruct H as [a [b H]].
  assert (J : join a b h) by tauto.
  assert (HA : P a) by tauto.
  assert (HB : Q b) by tauto.
  pose proof (HP a HA) as HA'.
  pose proof (HQ b HB) as HB'.
  exists a, b; repeat first [assumption | match goal with |- _ /\ _ => split end].
Qed.
Lemma finite_assoc (P Q R : model -> Prop) :
  (P ** Q) ** R |-- P ** (Q ** R).
Proof.
  intros h H; destruct H as [ab [c H]].
  assert (HPQ : (P ** Q) ab) by tauto.
  assert (HC : R c) by tauto.
  assert (J : join ab c h) by tauto.
  destruct HPQ as [a [b K]].
  assert (KJ : join a b ab) by tauto.
  assert (HA : P a) by tauto.
  assert (HB : Q b) by tauto.
  destruct (join_assoc _ _ _ _ _ KJ J) as [bc [L M]].
  exists a, bc; repeat first [assumption | match goal with |- _ /\ _ => split end].
  exists b, c; repeat first [assumption | match goal with |- _ /\ _ => split end].
Qed.
Lemma finite_comm (P Q : model -> Prop) : P ** Q |-- Q ** P.
Proof.
  intros h H; destruct H as [a [b H]].
  assert (J : join a b h) by tauto.
  assert (HA : P a) by tauto.
  assert (HB : Q b) by tauto.
  pose proof (join_comm _ _ _ J) as K.
  exists b, a; repeat first [assumption | match goal with |- _ /\ _ => split end].
Qed.
Lemma finite_rotate (P Q R : model -> Prop) :
  P ** (Q ** R) |-- Q ** (P ** R).
Proof.
  eapply finite_trans; [apply finite_comm|].
  eapply finite_trans; [apply finite_assoc|].
  apply finite_frame; [apply finite_id|apply finite_comm].
Qed.
Lemma finite_assoc_back (P Q R : model -> Prop) :
  P ** (Q ** R) |-- (P ** Q) ** R.
Proof.
  eapply finite_trans;
    [apply finite_frame; [apply finite_id|apply finite_comm]|].
  eapply finite_trans; [apply finite_comm|].
  eapply finite_trans; [apply finite_assoc|].
  eapply finite_trans;
    [apply finite_frame; [apply finite_id|apply finite_comm]|apply finite_comm].
Qed.
Lemma finite_unit (P : model -> Prop) : P |-- P ** emp.
Proof.
  intros h H; destruct (unit_join h) as [u [HU J]].
  exists h, u; repeat first [assumption | match goal with |- _ /\ _ => split end].
Qed.
Lemma finite_pure (A : Prop) (P Q : model -> Prop) :
  A -> (P |-- Q) -> (P |-- “ A ” && Q).
Proof. intros HA HP h H; change (A /\ Q h); split; [exact HA|apply HP, H]. Qed.

Lemma finite_and (P Q R : model -> Prop) :
  (P |-- Q) -> (P |-- R) -> (P |-- Q && R).
Proof.
  intros HQ HR h H; change (Q h /\ R h).
  split; [apply HQ, H|apply HR, H].
Qed.
Lemma finite_fact (P : model -> Prop) (A : Prop) :
  A -> (P |-- “ A ”).
Proof. intros HA h H; change A; exact HA. Qed.

Ltac finite_pull A :=
  lazymatch goal with
  | |- ?L |-- _ =>
    lazymatch L with
    | A ** ?R => apply finite_id
    | A => apply finite_unit
    | (?P ** ?Q) ** ?R =>
        eapply finite_trans; [apply finite_assoc|finite_pull A]
    | ?P ** ?Q =>
        eapply finite_trans;
        [apply finite_frame; [apply finite_id|finite_pull A]|apply finite_rotate]
    end
  end.
Ltac finite_heap :=
  first [apply finite_id |
    lazymatch goal with
    | |- ?P |-- “ ?A ” && ?Q =>
        apply finite_pure; [reflexivity|finite_heap]
    | |- ?P |-- “ ?A ” => apply finite_fact; reflexivity
    | |- ?P |-- ?Q && ?R => apply finite_and; finite_heap
    | |- ?L |-- (?P ** ?Q) ** ?R =>
        eapply finite_trans; [|apply finite_assoc_back]; finite_heap
    | |- (?P ** ?Q) ** ?R |-- ?T =>
        eapply finite_trans; [apply finite_assoc|finite_heap]
    | |- ?L |-- ?A ** ?B =>
        first [eapply finite_trans; [finite_pull A|];
               apply finite_frame; [apply finite_id|finite_heap]
              |eapply finite_trans; [apply finite_unit|];
               apply finite_frame; [apply finite_id|finite_heap]]
    end].
Ltac finite_normalize :=
  cbn [CharArray.seg CharArray.full CharArray.undef_seg
    CharArray.undef_full store_array store_undef_array
    repeat_Z List.repeat Z.to_nat store_array_rec store_undef_array_rec
       StoreCharAsElement.storeA StoreCharAsElement.undefstoreA
       StoreCharAsElement.sizeA];
  repeat rewrite sizeof_char; cbn.


Theorem resolved_init_array2_entail_wit_1_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial; finite_normalize; finite_heap. Qed.
Theorem resolved_init_array2_entail_wit_1 : ExecutionGoal.init_array2_entail_wit_1.
Proof. unfold ExecutionGoal.init_array2_entail_wit_1. right. exact resolved_init_array2_entail_wit_1_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_2_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial; finite_normalize; finite_heap. Qed.
Theorem resolved_init_array2_entail_wit_2 : ExecutionGoal.init_array2_entail_wit_2.
Proof. unfold ExecutionGoal.init_array2_entail_wit_2. right. exact resolved_init_array2_entail_wit_2_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_3_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial; finite_normalize; finite_heap. Qed.
Theorem resolved_init_array2_entail_wit_3 : ExecutionGoal.init_array2_entail_wit_3.
Proof. unfold ExecutionGoal.init_array2_entail_wit_3. right. exact resolved_init_array2_entail_wit_3_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_4_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial; finite_normalize; finite_heap. Qed.
Theorem resolved_init_array2_entail_wit_4 : ExecutionGoal.init_array2_entail_wit_4.
Proof. unfold ExecutionGoal.init_array2_entail_wit_4. right. exact resolved_init_array2_entail_wit_4_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_5_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_5_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_5_split_goal_spatial; finite_normalize; finite_heap. Qed.
Theorem resolved_init_array2_entail_wit_5 : ExecutionGoal.init_array2_entail_wit_5.
Proof. unfold ExecutionGoal.init_array2_entail_wit_5. right. exact resolved_init_array2_entail_wit_5_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_6_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_6_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_6_split_goal_spatial; finite_normalize; finite_heap. Qed.
Theorem resolved_init_array2_entail_wit_6 : ExecutionGoal.init_array2_entail_wit_6.
Proof. unfold ExecutionGoal.init_array2_entail_wit_6. right. exact resolved_init_array2_entail_wit_6_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_7_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_7_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_7_split_goal_spatial; finite_normalize; finite_heap. Qed.
Theorem resolved_init_array2_entail_wit_7 : ExecutionGoal.init_array2_entail_wit_7.
Proof. unfold ExecutionGoal.init_array2_entail_wit_7. right. exact resolved_init_array2_entail_wit_7_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_8_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_8_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_8_split_goal_spatial; finite_normalize; finite_heap. Qed.
Theorem resolved_init_array2_entail_wit_8 : ExecutionGoal.init_array2_entail_wit_8.
Proof. unfold ExecutionGoal.init_array2_entail_wit_8. right. exact resolved_init_array2_entail_wit_8_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_9_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_9_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_9_split_goal_spatial; finite_normalize; finite_heap. Qed.
Theorem resolved_init_array2_entail_wit_9 : ExecutionGoal.init_array2_entail_wit_9.
Proof. unfold ExecutionGoal.init_array2_entail_wit_9. right. exact resolved_init_array2_entail_wit_9_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_10_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_10_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_10_split_goal_spatial; finite_normalize; finite_heap. Qed.
Theorem resolved_init_array2_entail_wit_10 : ExecutionGoal.init_array2_entail_wit_10.
Proof. unfold ExecutionGoal.init_array2_entail_wit_10. right. exact resolved_init_array2_entail_wit_10_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_11_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_11_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_11_split_goal_spatial; finite_normalize; finite_heap. Qed.
Theorem resolved_init_array2_entail_wit_11 : ExecutionGoal.init_array2_entail_wit_11.
Proof. unfold ExecutionGoal.init_array2_entail_wit_11. right. exact resolved_init_array2_entail_wit_11_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_12_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_12_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_12_split_goal_spatial; finite_normalize; finite_heap. Qed.
Theorem resolved_init_array2_entail_wit_12 : ExecutionGoal.init_array2_entail_wit_12.
Proof. unfold ExecutionGoal.init_array2_entail_wit_12. right. exact resolved_init_array2_entail_wit_12_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_13_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_13_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_13_split_goal_spatial; finite_normalize; finite_heap. Qed.
Theorem resolved_init_array2_entail_wit_13 : ExecutionGoal.init_array2_entail_wit_13.
Proof. unfold ExecutionGoal.init_array2_entail_wit_13. right. exact resolved_init_array2_entail_wit_13_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_14_split_goal_1 : ExecutionGoal.init_array2_entail_wit_14_split_goal_1.
Proof. unfold ExecutionGoal.init_array2_entail_wit_14_split_goal_1. intros h H. change (repeat_Z 0 0 = @nil Z). reflexivity. Qed.
Theorem resolved_init_array2_entail_wit_14_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_14_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_14_split_goal_spatial; finite_normalize; finite_heap. Qed.
Theorem resolved_init_array2_entail_wit_14 : ExecutionGoal.init_array2_entail_wit_14.
Proof. unfold ExecutionGoal.init_array2_entail_wit_14. right. apply finite_pure; [reflexivity|exact resolved_init_array2_entail_wit_14_split_goal_spatial]. Qed.
Theorem resolved_init_array2_return_wit_1 : ExecutionGoal.init_array2_return_wit_1.
Proof. unfold ExecutionGoal.init_array2_return_wit_1. left.
  intros n_pre p_pre PreH1 PreH2 PreH3 PreH4 PreH5 PreH6 PreH7 PreH8 PreH9 PreH10 PreH11 PreH12 PreH13 PreH14 PreH15 PreH16 PreH17 PreH18 PreH19.
  subst n_pre; subst p_pre.
  intros h H. exists (repeat_Z 0 13).
  revert h H. finite_normalize; finite_heap. Qed.
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
Print Assumptions resolved_init_array2_entail_wit_6_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_6.
Print Assumptions resolved_init_array2_entail_wit_7_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_7.
Print Assumptions resolved_init_array2_entail_wit_8_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_8.
Print Assumptions resolved_init_array2_entail_wit_9_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_9.
Print Assumptions resolved_init_array2_entail_wit_10_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_10.
Print Assumptions resolved_init_array2_entail_wit_11_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_11.
Print Assumptions resolved_init_array2_entail_wit_12_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_12.
Print Assumptions resolved_init_array2_entail_wit_13_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_13.
Print Assumptions resolved_init_array2_entail_wit_14_split_goal_1.
Print Assumptions resolved_init_array2_entail_wit_14_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_14.
Print Assumptions resolved_init_array2_return_wit_1.
