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


(* Pointwise heap transformations; no equality of assertions is used. *)
Lemma finite_refl (P : CRules.expr) : P |-- P.
Proof. intros h H; exact H. Qed.
Lemma finite_trans (P Q R : CRules.expr) :
  (P |-- Q) -> (Q |-- R) -> (P |-- R).
Proof. intros H K h HP; exact (K h (H h HP)). Qed.
Lemma finite_mono (P Q R S : CRules.expr) :
  (P |-- R) -> (Q |-- S) -> (P ** Q |-- R ** S).
Proof.
  intros HP HQ h [a [b [J [HA HB]]]].
  exists a, b; split; [exact J|split; [apply HP|apply HQ]; assumption].
Qed.
Lemma finite_comm (P Q : CRules.expr) : P ** Q |-- Q ** P.
Proof.
  intros h [a [b [J [HA HB]]]].
  exists b, a; split; [apply join_comm; exact J|split; assumption].
Qed.
Lemma finite_assoc (P Q R : CRules.expr) :
  (P ** Q) ** R |-- P ** (Q ** R).
Proof.
  intros h [ab [c [J [ [a [b [K [HA HB]]]] HC]]]].
  destruct (join_assoc _ _ _ _ _ K J) as [bc [L M]].
  exists a, bc; split; [exact M|split; [exact HA|]].
  exists b, c; split; [exact L|split; assumption].
Qed.
Lemma finite_unassoc (P Q R : CRules.expr) :
  P ** (Q ** R) |-- (P ** Q) ** R.
Proof.
  intros h [a [bc [J [HA [b [c [K [HB HC]]]]]]]].
  pose proof (join_comm _ _ _ K) as K'.
  pose proof (join_comm _ _ _ J) as J'.
  destruct (join_assoc _ _ _ _ _ K' J') as [ba [L M]].
  exists ba, c; split; [apply join_comm; exact M|split; [|exact HC]].
  exists a, b; split; [apply join_comm; exact L|split; assumption].
Qed.
Lemma finite_append (P T : CRules.expr) :
  (forall u, is_unit u -> T u) -> (P |-- P ** T).
Proof.
  intros HT h HP. destruct (unit_join h) as [u [HU HJ]].
  exists h, u; split; [exact HJ|split; [exact HP|apply HT; exact HU]].
Qed.
Ltac finite_normalize :=
  cbn [CharArray.seg CharArray.full CharArray.undef_seg CharArray.undef_full
       store_array store_array_rec store_undef_array store_undef_array_rec
       repeat_Z StoreCharAsElement.storeA StoreCharAsElement.undefstoreA];
  repeat rewrite sizeof_char;
  cbn.
Ltac finite_terminal :=
  intros u HU; repeat first [exact HU | reflexivity | split].
Ltac finite_build n :=
  first [apply finite_refl |
    apply finite_append; finite_terminal |
    lazymatch n with
    | S ?k => first
      [eapply finite_mono; finite_build k
      |eapply finite_trans; [apply finite_assoc|finite_build k]
      |eapply finite_trans; [apply finite_unassoc|finite_build k]
      |eapply finite_trans; [apply finite_comm|finite_build k]]
    end].

Theorem resolved_init_array2_entail_wit_1_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
  finite_normalize. finite_build 7%nat.
Qed.
Theorem resolved_init_array2_entail_wit_1 : ExecutionGoal.init_array2_entail_wit_1.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_1. right.
  exact resolved_init_array2_entail_wit_1_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_2_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
  finite_normalize. finite_build 7%nat.
Qed.
Theorem resolved_init_array2_entail_wit_2 : ExecutionGoal.init_array2_entail_wit_2.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_2. right.
  exact resolved_init_array2_entail_wit_2_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_3_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
  finite_normalize. finite_build 7%nat.
Qed.
Theorem resolved_init_array2_entail_wit_3 : ExecutionGoal.init_array2_entail_wit_3.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_3. right.
  exact resolved_init_array2_entail_wit_3_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_4_split_goal_1 : ExecutionGoal.init_array2_entail_wit_4_split_goal_1.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_4_split_goal_1.
  intros h H. change (nil = (@nil Z)). reflexivity.
Qed.
Theorem resolved_init_array2_entail_wit_4_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial.
  finite_normalize. finite_build 9%nat.
Qed.
Theorem resolved_init_array2_entail_wit_4 : ExecutionGoal.init_array2_entail_wit_4.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_4. right.
  intros h H. split.
  - exact (resolved_init_array2_entail_wit_4_split_goal_1 h H).
  - exact (resolved_init_array2_entail_wit_4_split_goal_spatial h H).
Qed.
Theorem resolved_init_array2_return_wit_1 : ExecutionGoal.init_array2_return_wit_1.
Proof.
  unfold ExecutionGoal.init_array2_return_wit_1. left.
  intros n p H1 H2 H3 H4 Hp Hn H7 H8 H9. subst n; subst p.
  intros h H. exists (0 :: 0 :: 0 :: nil).
  revert h H. finite_normalize. finite_build 7%nat.
Qed.
Print Assumptions resolved_init_array2_entail_wit_1_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_1.
Print Assumptions resolved_init_array2_entail_wit_2_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_2.
Print Assumptions resolved_init_array2_entail_wit_3_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_3.
Print Assumptions resolved_init_array2_entail_wit_4_split_goal_1.
Print Assumptions resolved_init_array2_entail_wit_4_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_4.
Print Assumptions resolved_init_array2_return_wit_1.
