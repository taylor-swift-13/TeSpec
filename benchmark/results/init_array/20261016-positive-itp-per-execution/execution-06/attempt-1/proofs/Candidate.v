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


(* The spatial search below only reuses the finitely many heap pieces in
   the premise.  The only additional piece is their empty unit. *)
Set Firstorder Depth 8.

Ltac finite_comm :=
  multimatch goal with
  | H : state_join ?a ?b ?c |- _ =>
      let J := fresh "reversed_join" in
      assert (J : state_join b a c) by
        (let M := fresh "M" in
         let T := fresh "T" in
         let S := fresh "S" in
         destruct H as [M [T S]];
         clear - M T S;
         unfold state_join;
         split;
         [ first [solve [apply mem_join_comm; exact M]
                 | solve [unfold mem_join in *; firstorder]]
         | unfold TokenSet_join, STS_state_join in *;
           sets_unfold in *; firstorder ]);
      exact J
  end.

Ltac finite_spatial :=
  first
    [ assumption
    | solve [cbn [andp coq_prop]; split; finite_spatial]
    | solve [reflexivity]
    | solve [unfold emp; cbn; repeat split; try reflexivity;
             sets_unfold; intuition]
    | lazymatch goal with
      | |- (?P ** ?Q) ?h =>
          first
            [ solve [do 2 eexists; split;
                     [eassumption | split; finite_spatial]]
            | solve [do 2 eexists; split;
                     [finite_comm | split; finite_spatial]]
            | solve [do 2 eexists; split;
                     [apply unit_join | split; finite_spatial]]
            | solve [let J := fresh "empty_join" in
                     pose proof (unit_join h) as J;
                     do 2 eexists; split;
                     [finite_comm | split; finite_spatial]]
            ]
      end ].

Ltac finite_array :=
  cbn [repeat_Z CharArray.full CharArray.undef_full
       store_array store_array_rec store_undef_array store_undef_array_rec
       StoreCharAsElement.storeA StoreCharAsElement.undefstoreA];
  rewrite ?sizeof_char;
  cbn;
  intros h H;
  repeat match goal with
  | H : (?P ** ?Q) ?h |- _ =>
      destruct H as (? & ? & ? & ? & ?)
  end;
  finite_spatial.

Theorem resolved_init_array2_entail_wit_1_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
  finite_array.
Qed.
Theorem resolved_init_array2_entail_wit_1 : ExecutionGoal.init_array2_entail_wit_1.
Proof.
  right. exact resolved_init_array2_entail_wit_1_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_2_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
  finite_array.
Qed.
Theorem resolved_init_array2_entail_wit_2 : ExecutionGoal.init_array2_entail_wit_2.
Proof.
  right. exact resolved_init_array2_entail_wit_2_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_3_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
  finite_array.
Qed.
Theorem resolved_init_array2_entail_wit_3 : ExecutionGoal.init_array2_entail_wit_3.
Proof.
  right. exact resolved_init_array2_entail_wit_3_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_4_split_goal_1 : ExecutionGoal.init_array2_entail_wit_4_split_goal_1.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_4_split_goal_1.
  intros h H. cbn [coq_prop repeat_Z]. reflexivity.
Qed.
Theorem resolved_init_array2_entail_wit_4_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial.
  finite_array.
Qed.
Theorem resolved_init_array2_entail_wit_4 : ExecutionGoal.init_array2_entail_wit_4.
Proof.
  right. intros h H. split.
  - exact (resolved_init_array2_entail_wit_4_split_goal_1 h H).
  - exact (resolved_init_array2_entail_wit_4_split_goal_spatial h H).
Qed.
Theorem resolved_init_array2_return_wit_1 : ExecutionGoal.init_array2_return_wit_1.
Proof.
  right.
  intros n p H1 H2 H3 H4 Hp Hn H7 H8.
  subst p; subst n.
  rewrite sizeof_char. cbn.
  intros h H. exists (repeat_Z 0 3).
  exact (resolved_init_array2_entail_wit_1_split_goal_spatial h H).
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
