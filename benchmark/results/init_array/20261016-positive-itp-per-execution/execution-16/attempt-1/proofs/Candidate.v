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



Lemma finite_sep_intro (P Q : CRules.expr) a b h :
  join a b h -> P a -> Q b -> (P ** Q) h.
Proof.
  intros J HP HQ. exists a, b.
  repeat first [ assumption | split ].
Qed.

Lemma finite_and_intro (P Q : CRules.expr) h :
  P h -> Q h -> (P && Q) h.
Proof. intros HP HQ; split; assumption. Qed.

Lemma finite_pure_intro (P : Prop) h : P -> (“ P ”) h.
Proof. intros HP; exact HP. Qed.

Ltac finite_unpack H :=
  lazymatch type of H with
  | (CharArray.undef_seg _ _ _) _ => idtac
  | (?P ** ?Q) ?h =>
      let a := fresh "ha" in let b := fresh "hb" in
      let K := fresh "parts" in
      destruct H as [a [b K]];
      let rec parts K :=
        lazymatch type of K with
        | join _ _ _ => idtac
        | P a => idtac
        | Q b => idtac
        | _ /\ _ =>
            let L := fresh "part" in let R := fresh "part" in
            destruct K as [L R]; parts L; parts R
        end in
      parts K;
      repeat match goal with
      | K : (_ ** _) _ |- _ => progress finite_unpack K
      end
  | _ => idtac
  end.

Ltac finite_comm_all :=
  let rec collect acc :=
    match goal with
    | J : join ?a ?b ?c |- _ =>
      let Jc := fresh "commuted" in
      let K := fresh "saved" in
      rename J into K;
      revert K;
      collect acc;
      intro K;
      pose proof (join_comm _ _ _ K) as Jc
    | _ => idtac
    end in collect constr:(tt).

Ltac finite_assoc_round :=
  let rec outer :=
    match goal with
    | J : join ?ab ?c ?h |- _ =>
      let rec inner :=
        match goal with
        | K : join ?a ?b ab |- _ =>
          let U := fresh "assoc_parts" in
          let bc := fresh "hbc" in
          let J1 := fresh "assoc_join" in
          let J2 := fresh "assoc_join" in
          pose proof (join_assoc _ _ _ _ _ K J) as U;
          revert K; inner; intro K;
          destruct U as [bc [J1 J2]]
        | _ => idtac
        end in
      revert J; outer; intro J; inner
    | _ => idtac
    end in outer.

Lemma finite_emp_tail (P : CRules.expr) h : P h -> (P ** emp) h.
Proof.
  intros HP. destruct (unit_join h) as [u [U J]].
  eapply finite_sep_intro; [exact J | exact HP | exact U].
Qed.
Lemma finite_pure_tail (P : CRules.expr) (F : Prop) h :
  P h -> F -> (P ** (“ F ” && emp)) h.
Proof.
  intros HP HF. destruct (unit_join h) as [u [U J]].
  eapply finite_sep_intro; [exact J | exact HP | ].
  split; [exact HF | exact U].
Qed.
Lemma finite_pure_tail2 (P : CRules.expr) (F G : Prop) h :
  P h -> F -> G -> (P ** (“ F ” && “ G ” && emp)) h.
Proof.
  intros HP HF HG. destruct (unit_join h) as [u [U J]].
  eapply finite_sep_intro; [exact J | exact HP | ].
  repeat first [ assumption | split ].
Qed.

Ltac finite_heap :=
  intros h H;
  finite_unpack H;
  finite_comm_all;
  finite_assoc_round;
  finite_comm_all;
  eauto 14 using finite_sep_intro, finite_and_intro, finite_pure_intro,
    finite_emp_tail, finite_pure_tail, finite_pure_tail2.

Ltac finite_array :=
  cbn [CharArray.seg CharArray.full store_array store_array_rec
       StoreCharAsElement.storeA repeat_Z];
  repeat rewrite sizeof_char;
  cbn;
  finite_heap.

Theorem resolved_init_array2_entail_wit_1_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial. finite_array.
Qed.
Theorem resolved_init_array2_entail_wit_1 : ExecutionGoal.init_array2_entail_wit_1.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_1. right. exact resolved_init_array2_entail_wit_1_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_2_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
  change (CharArray.undef_seg 4096 0 1 ** ((4096 + 1 * 1) # Char |-> 0) ** ((4096 + 2 * 1) # Char |-> 0)
    |-- CharArray.undef_seg 4096 0 1 ** CharArray.seg 4096 1 3 (repeat_Z 0 2)).
  finite_array.
Qed.
Theorem resolved_init_array2_entail_wit_2 : ExecutionGoal.init_array2_entail_wit_2.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_2. right. exact resolved_init_array2_entail_wit_2_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_3_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_3_split_goal_spatial.
  change (CharArray.undef_seg 4096 0 2 ** ((4096 + 2 * 1) # Char |-> 0)
    |-- CharArray.undef_seg 4096 0 2 ** CharArray.seg 4096 2 3 (repeat_Z 0 1)).
  finite_array.
Qed.
Theorem resolved_init_array2_entail_wit_3 : ExecutionGoal.init_array2_entail_wit_3.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_3. right. exact resolved_init_array2_entail_wit_3_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_4_split_goal_1 : ExecutionGoal.init_array2_entail_wit_4_split_goal_1.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_4_split_goal_1.
  intros h H. apply finite_pure_intro. reflexivity.
Qed.
Theorem resolved_init_array2_entail_wit_4_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_4_split_goal_spatial.
  cbn [CharArray.undef_full store_undef_array store_undef_array_rec
       StoreCharAsElement.undefstoreA].
  repeat rewrite sizeof_char. cbn. finite_heap.
Qed.
Theorem resolved_init_array2_entail_wit_4 : ExecutionGoal.init_array2_entail_wit_4.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_4. right.
  intros h H. apply finite_and_intro.
  - apply finite_pure_intro. reflexivity.
  - exact (resolved_init_array2_entail_wit_4_split_goal_spatial h H).
Qed.
Theorem resolved_init_array2_return_wit_1 : ExecutionGoal.init_array2_return_wit_1.
Proof.
  unfold ExecutionGoal.init_array2_return_wit_1. left.
  intros n p H1 H2 H3 H4 Hp Hn H7 H8 H9. subst n p.
  intros h H. exists (0 :: 0 :: 0 :: nil).
  revert h H. finite_array.
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
