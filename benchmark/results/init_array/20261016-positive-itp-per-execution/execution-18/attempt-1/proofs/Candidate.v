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



(* Pointwise transformations retain the original subheaps. *)
Lemma finite_id : forall P, P |-- P.
Proof. intros P h H; exact H. Qed.
Lemma finite_trans : forall P Q R, (P |-- Q) -> (Q |-- R) -> (P |-- R).
Proof. intros P Q R HP HQ h H; exact (HQ h (HP h H)). Qed.
Lemma finite_frame : forall P Q R S,
  (P |-- R) -> (Q |-- S) -> (P ** Q |-- R ** S).
Proof.
  intros P Q R S HP HQ h [a [b [J [HA HB]]]].
  exists a, b; split; [exact J|]. split; [apply HP|apply HQ]; assumption.
Qed.
Lemma finite_comm : forall P Q, P ** Q |-- Q ** P.
Proof.
  intros P Q h [a [b [J [HA HB]]]].
  exists b, a; split; [apply join_comm; exact J|].
  split; assumption.
Qed.
Lemma finite_assoc : forall P Q R, (P ** Q) ** R |-- P ** (Q ** R).
Proof.
  intros P Q R h [ab [c [J [HAB HC]]]].
  destruct HAB as [a [b [JAB [HA HB]]]].
  destruct (join_assoc _ _ _ _ _ JAB J) as [bc [JBC JABC]].
  exists a, bc; split; [exact JABC|]. split; [exact HA|].
  exists b, c; split; [exact JBC|]. split; assumption.
Qed.
Lemma finite_move : forall P Q R, Q ** (P ** R) |-- P ** (Q ** R).
Proof.
  intros P Q R h [a [bc [J [HA HBC]]]].
  destruct HBC as [b [c [JBC [HB HC]]]].
  pose proof (join_comm _ _ _ J) as JR.
  destruct (join_assoc _ _ _ _ _ JBC JR) as [ca [JCA JBCA]].
  exists b, ca; split; [exact JBCA|]. split; [exact HB|].
  exists a, c; split; [apply join_comm; exact JCA|].
  split; assumption.
Qed.
Lemma finite_append : forall P Q,
  (forall u, is_unit u -> Q u) -> (P |-- P ** Q).
Proof.
  intros P Q HQ h HP.
  destruct (unit_join h) as [u [HU HJ]].
  exists h, u; split; [exact HJ|]. split; [exact HP|apply HQ; exact HU].
Qed.
Ltac finite_terminal :=
  intros; repeat first [assumption | reflexivity | split].
Ltac finite_extract p :=
  lazymatch goal with
  | |- (?a ** ?b) ** ?c |-- _ =>
      eapply finite_trans; [apply finite_assoc | finite_extract p]
  | |- ?a ** ?b |-- _ =>
      first [unify a p; apply finite_id
            | unify b p; apply finite_comm
            | eapply finite_trans;
                [apply finite_frame; [apply finite_id | finite_extract p]
                | apply finite_move]]
  end.
Ltac finite_spatial :=
  first [apply finite_id
        | solve [apply finite_append; finite_terminal]
        | solve [finite_terminal]
        | solve [apply finite_frame; finite_spatial]
        | lazymatch goal with
          | |- (?a ** ?b) ** ?c |-- _ =>
              eapply finite_trans; [apply finite_assoc | finite_spatial]
          | |- _ |-- ?p ** ?q =>
              eapply finite_trans;
                [finite_extract p
                | apply finite_frame; [apply finite_id | finite_spatial]]
          end].
Ltac finite_array :=
  cbn [CharArray.seg CharArray.full store_array store_array_rec
       StoreCharAsElement.storeA repeat_Z];
  repeat rewrite sizeof_char;
  cbn;
  finite_spatial.

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
Theorem resolved_init_array2_entail_wit_6_split_goal_1 : ExecutionGoal.init_array2_entail_wit_6_split_goal_1.
Proof. unfold ExecutionGoal.init_array2_entail_wit_6_split_goal_1.
  intros h H. change (repeat_Z 0 0 = (@nil Z)). reflexivity. Qed.
Theorem resolved_init_array2_entail_wit_6_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_6_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_6_split_goal_spatial.
  cbn [CharArray.undef_full store_undef_array store_undef_array_rec
       StoreCharAsElement.undefstoreA].
  repeat rewrite sizeof_char. cbn. finite_spatial. Qed.
Theorem resolved_init_array2_entail_wit_6 : ExecutionGoal.init_array2_entail_wit_6.
Proof. unfold ExecutionGoal.init_array2_entail_wit_6. right.
  intros h H. split.
  - change (repeat_Z 0 0 = (@nil Z)). reflexivity.
  - exact (resolved_init_array2_entail_wit_6_split_goal_spatial h H). Qed.
Theorem resolved_init_array2_return_wit_1 : ExecutionGoal.init_array2_return_wit_1.
Proof. unfold ExecutionGoal.init_array2_return_wit_1. left.
  intros n_pre p_pre H1 H2 H3 H4 H5 H6 H7 H8 H9 H10 H11.
  subst n_pre; subst p_pre.
  eapply finite_trans with (Q := CharArray.full 4096 5 (repeat_Z 0 5)).
  - finite_array.
  - intros h H. exists (repeat_Z 0 5). exact H. Qed.
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
