Module ConcreteCell.
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


Definition st (m:mem) : naive_C_Rules.model := {|ConAssertion.s_mem:=m;ConAssertion.s_STS:=Sets.full;ConAssertion.s_token:=Sets.empty|}.
Definition tail2 (b2 b3:Z) : mem := fun x=>if Z.eqb x 4098 then value b2 else if Z.eqb x 4099 then value b3 else Noperm.
Definition tail1 (b1 b2 b3:Z) : mem := fun x=>if Z.eqb x 4097 then value b1 else tail2 b2 b3 x.
Definition cell (b0 b1 b2 b3:Z) : mem := fun x=>if Z.eqb x 4096 then value b0 else tail1 b1 b2 b3 x.
Lemma st_join : forall a b c, mem_join a b c -> naive_C_Rules.join (st a) (st b) (st c).
Proof. intros; unfold naive_C_Rules.join, ConAssertion.state_join, st; cbn; split; [assumption|]. unfold ConAssertion.TokenSet_join, ConAssertion.STS_state_join; sets_unfold; tauto. Qed.
Ltac byte_join := unfold mem_join, single_byte_mem, cell, tail1, tail2, addr_eqb; intro x;
 repeat match goal with |- context[Z.eqb ?y ?k] => let E:=fresh in destruct (Z.eqb y k) eqn:E; [apply Z.eqb_eq in E|apply Z.eqb_neq in E] end; try lia; eauto 12.
Lemma join2 : forall a b, mem_join (single_byte_mem 4098 a) (single_byte_mem 4099 b) (tail2 a b).
Proof. intros; byte_join. Qed.
Lemma join1 : forall a b c, mem_join (single_byte_mem 4097 a) (tail2 b c) (tail1 a b c).
Proof. intros; byte_join. Qed.
Lemma join0 : forall a b c d, mem_join (single_byte_mem 4096 a) (tail1 b c d) (cell a b c d).
Proof. intros; byte_join. Qed.
Lemma byte_at : forall p v, naive_C_Rules.mstore p v (st (single_byte_mem p v)).
Proof. intros; unfold naive_C_Rules.mstore,st; exists v; split; [apply Byte.eqm_refl|]; repeat split; try reflexivity; sets_unfold; tauto. Qed.
Lemma cell_not_emp : forall a b c d, ~ emp (st (cell a b c d)).
Proof. intros a b c d H; unfold naive_C_Rules.emp, naive_C_Rules.is_unit, ConAssertion.state_empty, st in H; cbn in H; destruct H as [H _]; unfold mem_empty in H; specialize (H 4096); cbn [cell] in H; discriminate. Qed.


End ConcreteCell.
Module ExecutionGoal.
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

(*----- Function inplace_double -----*)

Definition inplace_double_safety_wit_1 := 
  ((( &( "m_spec_383" ) )) # Int  |->_)
  **  ((( &( "n_spec_380" ) )) # Int  |-> (-1))
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  ((4096) # Int  |-> (-1))
|--
  TT && emp 
.

Definition inplace_double_return_wit_1 := 
(
forall (p_pre: Z) (old___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (old___tespec_entry = (-1))) (PreH3 : ((-1073741824) <= old___tespec_entry)) (PreH4 : (old___tespec_entry <= 1073741823)) ,
  ((p_pre) # Int  |-> (old___tespec_entry + old___tespec_entry ))
|--
  TT && emp 
) \/
(
forall (p_pre: Z) (old___tespec_entry: Z) (PreH1 : ((old___tespec_entry + old___tespec_entry ) <= INT_MAX)) (PreH2 : ((old___tespec_entry + old___tespec_entry ) >= INT_MIN)) (PreH3 : (p_pre = 4096)) (PreH4 : (old___tespec_entry = (-1))) (PreH5 : ((-1073741824) <= old___tespec_entry)) (PreH6 : (old___tespec_entry <= 1073741823)) ,
  ((p_pre) # Int  |-> (old___tespec_entry + old___tespec_entry ))
|--
  TT && emp 
).

Definition inplace_double_return_wit_1_split_goal_spatial := 
forall (p_pre: Z) (old___tespec_entry: Z) (PreH1 : ((old___tespec_entry + old___tespec_entry ) <= INT_MAX)) (PreH2 : ((old___tespec_entry + old___tespec_entry ) >= INT_MIN)) (PreH3 : (p_pre = 4096)) (PreH4 : (old___tespec_entry = (-1))) (PreH5 : ((-1073741824) <= old___tespec_entry)) (PreH6 : (old___tespec_entry <= 1073741823)) ,
  ((p_pre) # Int  |-> (old___tespec_entry + old___tespec_entry ))
|--
  TT && emp 
.

Definition inplace_double_precondition_wit_1 :=
exists (p_pre: Z) ,
exists (old___tespec_entry: Z) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (old___tespec_entry = (-1)) ” 
  &&  “ ((-1073741824) <= old___tespec_entry) ” 
  &&  “ (old___tespec_entry <= 1073741823) ”
  &&  ((p_pre) # Int  |-> old___tespec_entry)) |-- “ False ”).



End ExecutionGoal.
Module LegacyProof.
Import ConcreteCell ExecutionGoal.
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



Theorem entry_cell : (4096 # Int |-> (-1)) (st (cell 255 255 255 255)).
Proof.
  unfold store_int.
  split.
  - change (isvalidptr_int 4096 /\ -1 <= Int.max_signed /\ -1 >= Int.min_signed).
    vm_compute; repeat split; congruence.
  - unfold store_4byte.
    exists 255, 255, 255, 255.
    split.
    + change (merge_int 255 255 255 255 (-1)).
      vm_compute; repeat split; congruence.
    + unfold naive_C_Rules.sepcon.
      exists (st (single_byte_mem 4096 255)), (st (tail1 255 255 255)).
      split; [apply st_join; apply join0|].
      split; [apply byte_at|].
      exists (st (single_byte_mem 4097 255)), (st (tail2 255 255)).
      split; [apply st_join; apply join1|].
      split; [apply byte_at|].
      exists (st (single_byte_mem 4098 255)), (st (single_byte_mem 4099 255)).
      split; [apply st_join; apply join2|].
      split; apply byte_at.
Qed.
Theorem exit_cell : (4096 # Int |-> (-2)) (st (cell 255 255 255 254)).
Proof.
  unfold store_int.
  split.
  - change (isvalidptr_int 4096 /\ -2 <= Int.max_signed /\ -2 >= Int.min_signed).
    vm_compute; repeat split; congruence.
  - unfold store_4byte.
    exists 255, 255, 255, 254.
    split.
    + change (merge_int 255 255 255 254 (-2)).
      vm_compute; repeat split; congruence.
    + unfold naive_C_Rules.sepcon.
      exists (st (single_byte_mem 4096 255)), (st (tail1 255 255 254)).
      split; [apply st_join; apply join0|].
      split; [apply byte_at|].
      exists (st (single_byte_mem 4097 255)), (st (tail2 255 254)).
      split; [apply st_join; apply join1|].
      split; [apply byte_at|].
      exists (st (single_byte_mem 4098 255)), (st (single_byte_mem 4099 254)).
      split; [apply st_join; apply join2|].
      split; apply byte_at.
Qed.
Theorem refute_inplace_double_return_wit_1_split_goal_spatial : ~ ExecutionGoal.inplace_double_return_wit_1_split_goal_spatial.
Proof.
  unfold ExecutionGoal.inplace_double_return_wit_1_split_goal_spatial.
  intro H.
  specialize (H 4096 (-1) ltac:(vm_compute; congruence)
    ltac:(vm_compute; congruence) eq_refl eq_refl ltac:(lia) ltac:(lia)).
  specialize (H (st (cell 255 255 255 254)) exit_cell).
  destruct H as [_ H].
  exact (cell_not_emp 255 255 255 254 H).
Qed.
Theorem refute_inplace_double_return_wit_1 : ~ ExecutionGoal.inplace_double_return_wit_1.
Proof.
  unfold ExecutionGoal.inplace_double_return_wit_1.
  intros [H | H].
  - specialize (H 4096 (-1) eq_refl eq_refl ltac:(lia) ltac:(lia)).
    specialize (H (st (cell 255 255 255 254)) exit_cell).
    destruct H as [_ H].
    exact (cell_not_emp 255 255 255 254 H).
  - apply refute_inplace_double_return_wit_1_split_goal_spatial.
    exact H.
Qed.
Theorem entry_sat : ExecutionGoal.inplace_double_precondition_wit_1.
Proof.
  unfold ExecutionGoal.inplace_double_precondition_wit_1.
  exists 4096, (-1).
  intro H.
  apply (H (st (cell 255 255 255 255))).
  change ((((4096 = 4096 /\ -1 = -1) /\ -1073741824 <= -1)
    /\ -1 <= 1073741823) /\
    (4096 # Int |-> (-1)) (st (cell 255 255 255 255))).
  split.
  - repeat split; lia.
  - exact entry_cell.
Qed.
Print Assumptions entry_cell.
Print Assumptions exit_cell.
Print Assumptions refute_inplace_double_return_wit_1_split_goal_spatial.
Print Assumptions refute_inplace_double_return_wit_1.
Print Assumptions entry_sat.

End LegacyProof.
Require Import Goal.
Module Proofs.
Theorem proof_of_inplace_double_return_wit_1 : ~ Goal.inplace_double_return_wit_1.
Proof.
  intro current.
  apply LegacyProof.refute_inplace_double_return_wit_1.
  unfold ExecutionGoal.inplace_double_return_wit_1, Goal.inplace_double_return_wit_1 in *.
  destruct current as [arm0 | arm1].
  - left. intros p_pre old___tespec_entry PreH1 PreH2 PreH3 PreH4.
    exact (arm0 old___tespec_entry p_pre PreH1 PreH2 PreH3 PreH4).
  - right. intros p_pre old___tespec_entry PreH1 PreH2 PreH3 PreH4 PreH5 PreH6.
    exact (arm1 old___tespec_entry p_pre PreH1 PreH2 PreH3 PreH4 PreH5 PreH6).
Qed.
End Proofs.
