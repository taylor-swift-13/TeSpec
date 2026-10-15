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


(* Pointwise transformations retain the concrete separating witnesses. *)
Lemma finite_trans (P Q R : model -> Prop) :
  (P |-- Q) -> (Q |-- R) -> (P |-- R).
Proof. intros HP HQ h Hh. apply HQ, HP, Hh. Qed.

Lemma finite_frame (P Q R S : model -> Prop) :
  (P |-- R) -> (Q |-- S) -> (P ** Q |-- R ** S).
Proof.
  intros HP HQ h Hh.
  destruct Hh as [a [b [HJ [HA HB]]]].
  exists a, b. split; [exact HJ | split; [apply HP | apply HQ]; assumption].
Qed.

Lemma finite_assoc (P Q R : model -> Prop) :
  (P ** Q) ** R |-- P ** (Q ** R).
Proof.
  intros h [ab [c [HJ [Hab HC]]]].
  destruct Hab as [a [b [HAB [HA HB]]]].
  destruct (join_assoc _ _ _ _ _ HAB HJ) as [bc [HBC HABC]].
  exists a, bc. split; [exact HABC | split; [exact HA |]].
  exists b, c. split; [exact HBC | split; assumption].
Qed.

Lemma finite_rotate (P Q A R : model -> Prop) :
  (Q |-- A ** R) -> (P ** Q |-- A ** (P ** R)).
Proof.
  intros HQ h [p [q [HPQ [HP Hq]]]].
  destruct (HQ _ Hq) as [a [r [HAR [HA HR]]]].
  pose proof (join_comm _ _ _ HPQ) as HQP.
  destruct (join_assoc _ _ _ _ _ HAR HQP) as [rp [HRP HARP]].
  exists a, rp. split; [exact HARP | split; [exact HA |]].
  exists p, r. split; [apply join_comm; exact HRP | split; assumption].
Qed.

Lemma finite_unit (P : model -> Prop) : P |-- P ** emp.
Proof.
  intros h HP. destruct (unit_join h) as [u [HU HJ]].
  exists h, u. split; [exact HJ | split; assumption].
Qed.

Ltac finite_pick :=
  first [apply finite_unit |
    apply finite_frame; [intros ? ?; assumption | intros ? ?; assumption] |
    eapply finite_rotate; finite_pick].

Ltac finite_heap :=
  first [solve [intros ? ?; assumption] |
    match goal with
    | |- ((?P ** ?Q) ** ?R |-- ?S) =>
        eapply finite_trans; [apply finite_assoc | finite_heap]
    end |
    match goal with
    | |- (?P ** ?Q |-- ?R) =>
        eapply finite_trans;
        [apply finite_frame; [intros ? ?; assumption | apply finite_assoc] | finite_heap]
    end |
    match goal with
    | |- (?P |-- ?A ** ?B) =>
        eapply finite_trans with (Q := A ** _); [finite_pick |];
        apply finite_frame; [intros ? ?; assumption | finite_heap]
    end |
    solve [intros ? ?; unfold andp, coq_prop in *;
      repeat split; try assumption; reflexivity]].

Ltac finite_array :=
  cbn [CharArray.seg CharArray.full store_array store_array_rec
       repeat_Z StoreCharAsElement.storeA];
  rewrite ?sizeof_char;
  cbn;
  finite_heap.

Theorem resolved_init_array2_entail_wit_1_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial. finite_array. Qed.
Theorem resolved_init_array2_entail_wit_1 : ExecutionGoal.init_array2_entail_wit_1.
Proof. unfold ExecutionGoal.init_array2_entail_wit_1. right. exact resolved_init_array2_entail_wit_1_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_2_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial. finite_array. Qed.
Theorem resolved_init_array2_entail_wit_2 : ExecutionGoal.init_array2_entail_wit_2.
Proof. unfold ExecutionGoal.init_array2_entail_wit_2. right. exact resolved_init_array2_entail_wit_2_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_3_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial. finite_array. Qed.
Theorem resolved_init_array2_entail_wit_3 : ExecutionGoal.init_array2_entail_wit_3.
Proof. unfold ExecutionGoal.init_array2_entail_wit_3. right. exact resolved_init_array2_entail_wit_3_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_4_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial. finite_array. Qed.
Theorem resolved_init_array2_entail_wit_4 : ExecutionGoal.init_array2_entail_wit_4.
Proof. unfold ExecutionGoal.init_array2_entail_wit_4. right. exact resolved_init_array2_entail_wit_4_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_5_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_5_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_5_split_goal_spatial. finite_array. Qed.
Theorem resolved_init_array2_entail_wit_5 : ExecutionGoal.init_array2_entail_wit_5.
Proof. unfold ExecutionGoal.init_array2_entail_wit_5. right. exact resolved_init_array2_entail_wit_5_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_6_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_6_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_6_split_goal_spatial. finite_array. Qed.
Theorem resolved_init_array2_entail_wit_6 : ExecutionGoal.init_array2_entail_wit_6.
Proof. unfold ExecutionGoal.init_array2_entail_wit_6. right. exact resolved_init_array2_entail_wit_6_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_7_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_7_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_7_split_goal_spatial. finite_array. Qed.
Theorem resolved_init_array2_entail_wit_7 : ExecutionGoal.init_array2_entail_wit_7.
Proof. unfold ExecutionGoal.init_array2_entail_wit_7. right. exact resolved_init_array2_entail_wit_7_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_8_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_8_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_8_split_goal_spatial. finite_array. Qed.
Theorem resolved_init_array2_entail_wit_8 : ExecutionGoal.init_array2_entail_wit_8.
Proof. unfold ExecutionGoal.init_array2_entail_wit_8. right. exact resolved_init_array2_entail_wit_8_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_9_split_goal_1 : ExecutionGoal.init_array2_entail_wit_9_split_goal_1.
Proof. unfold ExecutionGoal.init_array2_entail_wit_9_split_goal_1. intros ? ?. change (repeat_Z 0 0 = (@nil Z)). reflexivity. Qed.
Theorem resolved_init_array2_entail_wit_9_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_9_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_9_split_goal_spatial. cbn [CharArray.undef_full store_undef_array store_undef_array_rec StoreCharAsElement.undefstoreA]. rewrite ?sizeof_char. cbn. finite_heap. Qed.
Theorem resolved_init_array2_entail_wit_9 : ExecutionGoal.init_array2_entail_wit_9.
Proof. unfold ExecutionGoal.init_array2_entail_wit_9. right. intros h Hh. split. - exact (resolved_init_array2_entail_wit_9_split_goal_1 h Hh). - exact (resolved_init_array2_entail_wit_9_split_goal_spatial h Hh). Qed.
Theorem resolved_init_array2_return_wit_1 : ExecutionGoal.init_array2_return_wit_1.
Proof.
  unfold ExecutionGoal.init_array2_return_wit_1. left.
  intros n_pre p_pre PreH1 PreH2 PreH3 PreH4 PreH5 PreH6 PreH7
    PreH8 PreH9 PreH10 PreH11 PreH12 PreH13 PreH14.
  subst n_pre. subst p_pre.
  intros h Hh. exists (repeat_Z 0 8).
  revert h Hh. finite_array.
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
Print Assumptions resolved_init_array2_entail_wit_6_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_6.
Print Assumptions resolved_init_array2_entail_wit_7_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_7.
Print Assumptions resolved_init_array2_entail_wit_8_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_8.
Print Assumptions resolved_init_array2_entail_wit_9_split_goal_1.
Print Assumptions resolved_init_array2_entail_wit_9_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_9.
Print Assumptions resolved_init_array2_return_wit_1.
