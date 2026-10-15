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


(* Pointwise transformations preserve the supplied heap and its joins. *)
Lemma candidate_refl (P : model -> Prop) : P |-- P.
Proof. intros ? HP; exact HP. Qed.
Lemma candidate_trans (P Q R : model -> Prop) :
  (P |-- Q) -> (Q |-- R) -> (P |-- R).
Proof. intros HP HQ ? H; exact (HQ _ (HP _ H)). Qed.
Lemma candidate_frame (P Q R S : model -> Prop) :
  (P |-- R) -> (Q |-- S) -> (P ** Q |-- R ** S).
Proof.
  intros HP HQ h [a [b [HJ [HA HB]]]].
  exists a, b; split; [exact HJ|]. split; [apply HP|apply HQ]; assumption.
Qed.
Lemma candidate_assoc (P Q R : model -> Prop) :
  (P ** Q) ** R |-- P ** (Q ** R).
Proof.
  intros h [ab [c [HJ [[a [b [HK [HA HB]]]] HC]]]].
  destruct (join_assoc _ _ _ _ _ HK HJ) as [bc [HL HM]].
  exists a, bc; split; [exact HM|]. split; [exact HA|].
  exists b, c; split; [exact HL|]. split; assumption.
Qed.
Lemma candidate_rotate (P Q R : model -> Prop) :
  P ** (Q ** R) |-- Q ** (P ** R).
Proof.
  intros h [a [bc [HJ [HA [b [c [HK [HB HC]]]]]]]].
  pose proof (join_comm _ _ _ HJ) as HJ'.
  destruct (join_assoc _ _ _ _ _ HK HJ') as [ca [HL HM]].
  pose proof (join_comm _ _ _ HM) as HM'.
  destruct (join_assoc _ _ _ _ _ HL HM') as [ab [HN HO]].
  pose proof (join_comm _ _ _ HN) as HN'.
  pose proof (join_comm _ _ _ HO) as HO'.
  destruct (join_assoc _ _ _ _ _ HN' HO') as [ac [HP HQ]].
  exists b, ac; split; [exact HQ|]. split; [exact HB|].
  exists a, c; split; [exact HP|]. split; assumption.
Qed.
Lemma candidate_unit (P : model -> Prop) : P |-- P ** emp.
Proof.
  intros h HA. destruct (unit_join h) as [u [HU HJ]].
  exists h, u; split; [exact HJ|]. split; [exact HA|exact HU].
Qed.
Ltac candidate_pure :=
  first [assumption | reflexivity |
    match goal with |- _ /\ _ => split; candidate_pure end].
Ltac candidate_bring P :=
  lazymatch goal with
  | |- (?A ** ?B) |-- _ =>
    first [unify A P; apply candidate_refl | lazymatch A with
    | ?X ** ?Y =>
      eapply candidate_trans; [apply candidate_assoc|candidate_bring P]
    | _ =>
      first [unify A P; apply candidate_refl |
        eapply candidate_trans;
        [apply candidate_frame; [apply candidate_refl|candidate_bring P] |
         apply candidate_rotate]]
    end]
  | |- ?A |-- _ => unify A P; apply candidate_unit
  end.
Ltac candidate_collect :=
  first [apply candidate_refl |
    lazymatch goal with
    | |- _ |-- (?P ** ?Q) =>
      eapply candidate_trans; [candidate_bring P|];
      apply candidate_frame; [apply candidate_refl|candidate_collect]
    | |- _ => intros ? Hheap; cbn [andp coq_prop]; candidate_pure
    end].
Ltac candidate_arrays :=
  try unfold CharArray.seg; try unfold CharArray.full;
  try unfold CharArray.undef_full; try unfold CharArray.undef_seg;
  try unfold store_array; try unfold store_undef_array;
  cbn [repeat_Z store_array_rec store_undef_array_rec];
  try unfold StoreCharAsElement.storeA;
  try unfold StoreCharAsElement.undefstoreA;
  repeat rewrite sizeof_char;
  cbn; candidate_collect.


Theorem resolved_init_array2_entail_wit_1_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial. candidate_arrays. Qed.
Theorem resolved_init_array2_entail_wit_1 : ExecutionGoal.init_array2_entail_wit_1.
Proof. unfold ExecutionGoal.init_array2_entail_wit_1. right. exact resolved_init_array2_entail_wit_1_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_2_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial. candidate_arrays. Qed.
Theorem resolved_init_array2_entail_wit_2 : ExecutionGoal.init_array2_entail_wit_2.
Proof. unfold ExecutionGoal.init_array2_entail_wit_2. right. exact resolved_init_array2_entail_wit_2_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_3_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial. candidate_arrays. Qed.
Theorem resolved_init_array2_entail_wit_3 : ExecutionGoal.init_array2_entail_wit_3.
Proof. unfold ExecutionGoal.init_array2_entail_wit_3. right. exact resolved_init_array2_entail_wit_3_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_4_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial. candidate_arrays. Qed.
Theorem resolved_init_array2_entail_wit_4 : ExecutionGoal.init_array2_entail_wit_4.
Proof. unfold ExecutionGoal.init_array2_entail_wit_4. right. exact resolved_init_array2_entail_wit_4_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_5_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_5_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_5_split_goal_spatial. candidate_arrays. Qed.
Theorem resolved_init_array2_entail_wit_5 : ExecutionGoal.init_array2_entail_wit_5.
Proof. unfold ExecutionGoal.init_array2_entail_wit_5. right. exact resolved_init_array2_entail_wit_5_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_6_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_6_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_6_split_goal_spatial. candidate_arrays. Qed.
Theorem resolved_init_array2_entail_wit_6 : ExecutionGoal.init_array2_entail_wit_6.
Proof. unfold ExecutionGoal.init_array2_entail_wit_6. right. exact resolved_init_array2_entail_wit_6_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_7_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_7_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_7_split_goal_spatial. candidate_arrays. Qed.
Theorem resolved_init_array2_entail_wit_7 : ExecutionGoal.init_array2_entail_wit_7.
Proof. unfold ExecutionGoal.init_array2_entail_wit_7. right. exact resolved_init_array2_entail_wit_7_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_8_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_8_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_8_split_goal_spatial. candidate_arrays. Qed.
Theorem resolved_init_array2_entail_wit_8 : ExecutionGoal.init_array2_entail_wit_8.
Proof. unfold ExecutionGoal.init_array2_entail_wit_8. right. exact resolved_init_array2_entail_wit_8_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_9_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_9_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_9_split_goal_spatial. candidate_arrays. Qed.
Theorem resolved_init_array2_entail_wit_9 : ExecutionGoal.init_array2_entail_wit_9.
Proof. unfold ExecutionGoal.init_array2_entail_wit_9. right. exact resolved_init_array2_entail_wit_9_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_10_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_10_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_10_split_goal_spatial. candidate_arrays. Qed.
Theorem resolved_init_array2_entail_wit_10 : ExecutionGoal.init_array2_entail_wit_10.
Proof. unfold ExecutionGoal.init_array2_entail_wit_10. right. exact resolved_init_array2_entail_wit_10_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_11_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_11_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_11_split_goal_spatial. candidate_arrays. Qed.
Theorem resolved_init_array2_entail_wit_11 : ExecutionGoal.init_array2_entail_wit_11.
Proof. unfold ExecutionGoal.init_array2_entail_wit_11. right. exact resolved_init_array2_entail_wit_11_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_12_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_12_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_12_split_goal_spatial. candidate_arrays. Qed.
Theorem resolved_init_array2_entail_wit_12 : ExecutionGoal.init_array2_entail_wit_12.
Proof. unfold ExecutionGoal.init_array2_entail_wit_12. right. exact resolved_init_array2_entail_wit_12_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_13_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_13_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_13_split_goal_spatial. candidate_arrays. Qed.
Theorem resolved_init_array2_entail_wit_13 : ExecutionGoal.init_array2_entail_wit_13.
Proof. unfold ExecutionGoal.init_array2_entail_wit_13. right. exact resolved_init_array2_entail_wit_13_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_14_split_goal_1 : ExecutionGoal.init_array2_entail_wit_14_split_goal_1.
Proof. unfold ExecutionGoal.init_array2_entail_wit_14_split_goal_1. intros ? Hheap. cbn [andp coq_prop repeat_Z]. reflexivity. Qed.
Theorem resolved_init_array2_entail_wit_14_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_14_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_14_split_goal_spatial. candidate_arrays. Qed.
Theorem resolved_init_array2_entail_wit_14 : ExecutionGoal.init_array2_entail_wit_14.
Proof. unfold ExecutionGoal.init_array2_entail_wit_14. right. intros h Hheap. split.
  - reflexivity.
  - exact (resolved_init_array2_entail_wit_14_split_goal_spatial h Hheap). Qed.
Theorem resolved_init_array2_return_wit_1 : ExecutionGoal.init_array2_return_wit_1.
Proof. unfold ExecutionGoal.init_array2_return_wit_1. left.
  intros n_pre p_pre PreH1 PreH2 PreH3 PreH4 PreH5 PreH6 PreH7 PreH8 PreH9 PreH10 PreH11 PreH12 PreH13 PreH14 PreH15 PreH16 PreH17 PreH18 PreH19.
  subst n_pre; subst p_pre. repeat rewrite sizeof_char.
  intros h Hheap. exists (repeat_Z 0 13).
  unfold CharArray.full, store_array.
  exact (resolved_init_array2_entail_wit_1_split_goal_spatial h Hheap). Qed.
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
