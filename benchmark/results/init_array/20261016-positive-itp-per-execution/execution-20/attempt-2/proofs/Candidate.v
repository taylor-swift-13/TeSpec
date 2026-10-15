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
Proof. intros H K m HP; apply K, H, HP. Qed.
Lemma finite_frame (P Q R S : model -> Prop) :
  (P |-- R) -> (Q |-- S) -> (P ** Q |-- R ** S).
Proof.
  intros H K m [a [b [J [HP HQ]]]].
  exists a, b; split; [exact J|split; [apply H|apply K]; assumption].
Qed.
Lemma finite_swap (P Q R : model -> Prop) :
  (P ** (Q ** R) |-- Q ** (P ** R)).
Proof.
  intros m [a [bc [J [HP [b [c [K [HQ HR]]]]]]]].
  destruct (join_assoc b c a bc m K (join_comm _ _ _ J))
    as [ca [L M]].
  exists b, ca; split; [exact M|split; [exact HQ|]].
  exists a, c; split; [apply join_comm; exact L|auto].
Qed.
Lemma finite_assoc (P Q R : model -> Prop) :
  ((P ** Q) ** R |-- P ** (Q ** R)).
Proof.
  intros m [ab [c [J [[a [b [K [HP HQ]]]] HR]]]].
  destruct (join_assoc a b c ab m K J) as [bc [L M]].
  exists a, bc; split; [exact M|split; [exact HP|]].
  exists b, c; auto.
Qed.
Lemma finite_unit (P : model -> Prop) : P |-- P ** emp.
Proof.
  intros m HP. destruct (unit_join m) as [u [U J]].
  exists m, u; split; [exact J|split; assumption].
Qed.
Ltac finite_take :=
  lazymatch goal with
  | |- ?P ** ?Q |-- ?P ** _ => let h := fresh "heap_fact" in intros ? h; exact h
  | |- (?A ** ?B) ** ?C |-- _ =>
      eapply finite_trans; [apply finite_assoc|finite_take]
  | |- ?A ** ?B |-- ?P ** _ =>
      eapply finite_trans;
      [apply finite_frame; [let h := fresh "heap_fact" in intros ? h; exact h|finite_take]|
       apply finite_swap]
  | |- ?P |-- ?P ** _ => apply finite_unit
  end.
Ltac finite_heap :=
  first [let h := fresh "heap_fact" in intros ? h; exact h |
    lazymatch goal with
    | |- _ |-- ?P ** ?Q =>
      eapply finite_trans with (Q := P ** _); [finite_take|
        apply finite_frame; [let h := fresh "heap_fact" in intros ? h; exact h|finite_heap]]
    | |- _ => let h := fresh "heap_fact" in intros ? h; solve [repeat first [assumption | reflexivity | split]]
    end].
Ltac finite_reduce :=
  cbn [CharArray.seg CharArray.full CharArray.undef_full
       CharArray.undef_seg store_array store_undef_array
       store_array_rec store_undef_array_rec repeat_Z
       StoreCharAsElement.storeA StoreCharAsElement.undefstoreA
       StoreCharAsElement.sizeA];
  rewrite ?sizeof_char; cbn.

Theorem resolved_init_array2_entail_wit_1_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial; finite_reduce; finite_heap. Qed.
Theorem resolved_init_array2_entail_wit_1 : ExecutionGoal.init_array2_entail_wit_1.
Proof. unfold ExecutionGoal.init_array2_entail_wit_1; right; exact resolved_init_array2_entail_wit_1_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_2_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial; finite_reduce; finite_heap. Qed.
Theorem resolved_init_array2_entail_wit_2 : ExecutionGoal.init_array2_entail_wit_2.
Proof. unfold ExecutionGoal.init_array2_entail_wit_2; right; exact resolved_init_array2_entail_wit_2_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_3_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial; finite_reduce; finite_heap. Qed.
Theorem resolved_init_array2_entail_wit_3 : ExecutionGoal.init_array2_entail_wit_3.
Proof. unfold ExecutionGoal.init_array2_entail_wit_3; right; exact resolved_init_array2_entail_wit_3_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_4_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial; finite_reduce; finite_heap. Qed.
Theorem resolved_init_array2_entail_wit_4 : ExecutionGoal.init_array2_entail_wit_4.
Proof. unfold ExecutionGoal.init_array2_entail_wit_4; right; exact resolved_init_array2_entail_wit_4_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_5_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_5_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_5_split_goal_spatial; finite_reduce; finite_heap. Qed.
Theorem resolved_init_array2_entail_wit_5 : ExecutionGoal.init_array2_entail_wit_5.
Proof. unfold ExecutionGoal.init_array2_entail_wit_5; right; exact resolved_init_array2_entail_wit_5_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_6_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_6_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_6_split_goal_spatial; finite_reduce; finite_heap. Qed.
Theorem resolved_init_array2_entail_wit_6 : ExecutionGoal.init_array2_entail_wit_6.
Proof. unfold ExecutionGoal.init_array2_entail_wit_6; right; exact resolved_init_array2_entail_wit_6_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_7_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_7_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_7_split_goal_spatial; finite_reduce; finite_heap. Qed.
Theorem resolved_init_array2_entail_wit_7 : ExecutionGoal.init_array2_entail_wit_7.
Proof. unfold ExecutionGoal.init_array2_entail_wit_7; right; exact resolved_init_array2_entail_wit_7_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_8_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_8_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_8_split_goal_spatial; finite_reduce; finite_heap. Qed.
Theorem resolved_init_array2_entail_wit_8 : ExecutionGoal.init_array2_entail_wit_8.
Proof. unfold ExecutionGoal.init_array2_entail_wit_8; right; exact resolved_init_array2_entail_wit_8_split_goal_spatial. Qed.
Theorem resolved_init_array2_entail_wit_9_split_goal_1 : ExecutionGoal.init_array2_entail_wit_9_split_goal_1.
Proof. unfold ExecutionGoal.init_array2_entail_wit_9_split_goal_1; intros ? H; change (repeat_Z 0 0 = @nil Z); reflexivity. Qed.
Theorem resolved_init_array2_entail_wit_9_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_9_split_goal_spatial.
Proof. unfold ExecutionGoal.init_array2_entail_wit_9_split_goal_spatial; finite_reduce; finite_heap. Qed.
Theorem resolved_init_array2_entail_wit_9 : ExecutionGoal.init_array2_entail_wit_9.
Proof. unfold ExecutionGoal.init_array2_entail_wit_9; right; intros m H; split;
  [change (repeat_Z 0 0 = @nil Z); reflexivity|apply resolved_init_array2_entail_wit_9_split_goal_spatial; exact H]. Qed.
Theorem resolved_init_array2_return_wit_1 : ExecutionGoal.init_array2_return_wit_1.
Proof. unfold ExecutionGoal.init_array2_return_wit_1; left; intros; subst;
  eapply finite_trans with (Q := CharArray.full 4096 8 (repeat_Z 0 8));
  [finite_reduce; finite_heap|intros heap_state heap_fact; exists (repeat_Z 0 8); exact heap_fact]. Qed.
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
