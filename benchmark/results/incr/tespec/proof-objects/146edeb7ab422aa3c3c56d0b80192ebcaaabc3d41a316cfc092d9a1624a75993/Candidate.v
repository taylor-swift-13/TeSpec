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

(*----- Function incr -----*)

Definition incr_safety_wit_1 := 
  ((( &( "m_spec_383" ) )) # UInt  |->_)
  **  ((( &( "n_spec_380" ) )) # UInt  |-> 5)
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  ((4096) # UInt  |-> 5)
|--
  TT && emp 
.

Definition incr_return_wit_1 := 
(
forall (p_pre: Z) (old___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (old___tespec_entry = 5)) (PreH3 : (0 <= old___tespec_entry)) (PreH4 : (old___tespec_entry <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> (old___tespec_entry + 1 ))
|--
  TT && emp 
) \/
(
forall (p_pre: Z) (old___tespec_entry: Z) (PreH1 : ((old___tespec_entry + 1 ) <= UINT_MAX)) (PreH2 : ((old___tespec_entry + 1 ) >= 0)) (PreH3 : (p_pre = 4096)) (PreH4 : (old___tespec_entry = 5)) (PreH5 : (0 <= old___tespec_entry)) (PreH6 : (old___tespec_entry <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> (old___tespec_entry + 1 ))
|--
  TT && emp 
).

Definition incr_return_wit_1_split_goal_spatial := 
forall (p_pre: Z) (old___tespec_entry: Z) (PreH1 : ((old___tespec_entry + 1 ) <= UINT_MAX)) (PreH2 : ((old___tespec_entry + 1 ) >= 0)) (PreH3 : (p_pre = 4096)) (PreH4 : (old___tespec_entry = 5)) (PreH5 : (0 <= old___tespec_entry)) (PreH6 : (old___tespec_entry <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> (old___tespec_entry + 1 ))
|--
  TT && emp 
.

Definition incr_precondition_wit_1 :=
exists (p_pre: Z) ,
exists (old___tespec_entry: Z) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (old___tespec_entry = 5) ” 
  &&  “ (0 <= old___tespec_entry) ” 
  &&  “ (old___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> old___tespec_entry)) |-- “ False ”).



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



Theorem entry_cell : (4096 # UInt |-> (5)) (st (cell 0 0 0 5)).
Proof.
  unfold store_uint.
  split.
  - change (isvalidptr_int 4096 /\ 5 >= 0 /\ 5 <= Int.max_unsigned).
    vm_compute; intuition congruence.
  - unfold store_4byte.
    exists 0, 0, 0, 5.
    split.
    + change (merge_int 0 0 0 5 5).
      vm_compute; intuition congruence.
    + exists (st (single_byte_mem 4096 0)), (st (tail1 0 0 5)).
      split; [apply st_join; apply join0 |].
      split; [apply byte_at |].
      exists (st (single_byte_mem 4097 0)), (st (tail2 0 5)).
      split; [apply st_join; apply join1 |].
      split; [apply byte_at |].
      exists (st (single_byte_mem 4098 0)), (st (single_byte_mem 4099 5)).
      split; [apply st_join; apply join2 |].
      split; apply byte_at.
Qed.
Theorem exit_cell : (4096 # UInt |-> (6)) (st (cell 0 0 0 6)).
Proof.
  unfold store_uint.
  split.
  - change (isvalidptr_int 4096 /\ 6 >= 0 /\ 6 <= Int.max_unsigned).
    vm_compute; intuition congruence.
  - unfold store_4byte.
    exists 0, 0, 0, 6.
    split.
    + change (merge_int 0 0 0 6 6).
      vm_compute; intuition congruence.
    + exists (st (single_byte_mem 4096 0)), (st (tail1 0 0 6)).
      split; [apply st_join; apply join0 |].
      split; [apply byte_at |].
      exists (st (single_byte_mem 4097 0)), (st (tail2 0 6)).
      split; [apply st_join; apply join1 |].
      split; [apply byte_at |].
      exists (st (single_byte_mem 4098 0)), (st (single_byte_mem 4099 6)).
      split; [apply st_join; apply join2 |].
      split; apply byte_at.
Qed.
Theorem refute_incr_return_wit_1_split_goal_spatial : ~ ExecutionGoal.incr_return_wit_1_split_goal_spatial.
Proof.
  unfold ExecutionGoal.incr_return_wit_1_split_goal_spatial.
  intro H.
  specialize (H 4096 5 ltac:(lia) ltac:(lia)
    eq_refl eq_refl ltac:(lia) ltac:(lia)).
  specialize (H (st (cell 0 0 0 6)) exit_cell).
  destruct H as [_ Hempty].
  exact (ConcreteCell.cell_not_emp 0 0 0 6 Hempty).
Qed.
Theorem refute_incr_return_wit_1 : ~ ExecutionGoal.incr_return_wit_1.
Proof.
  unfold ExecutionGoal.incr_return_wit_1.
  intros [H | H].
  - specialize (H 4096 5 eq_refl eq_refl ltac:(lia) ltac:(lia)).
    specialize (H (st (cell 0 0 0 6)) exit_cell).
    destruct H as [_ Hempty].
    exact (ConcreteCell.cell_not_emp 0 0 0 6 Hempty).
  - specialize (H 4096 5 ltac:(lia) ltac:(lia)
      eq_refl eq_refl ltac:(lia) ltac:(lia)).
    specialize (H (st (cell 0 0 0 6)) exit_cell).
    destruct H as [_ Hempty].
    exact (ConcreteCell.cell_not_emp 0 0 0 6 Hempty).
Qed.
Theorem entry_sat : ExecutionGoal.incr_precondition_wit_1.
Proof.
  unfold ExecutionGoal.incr_precondition_wit_1.
  exists 4096, 5.
  intro H.
  assert (Hentry :
    ( “ (4096 = 4096) ” && “ (5 = 5) ” && “ (0 <= 5) ”
      && “ (5 <= UINT_MAX) ” && (4096 # UInt |-> 5))
      (st (cell 0 0 0 5))).
  { split.
    - split.
      + split.
        * split.
          -- change (4096 = 4096); reflexivity.
          -- change (5 = 5); reflexivity.
        * change (0 <= 5); lia.
      + change (5 <= UINT_MAX); lia.
    - exact entry_cell. }
  specialize (H (st (cell 0 0 0 5)) Hentry).
  change False in H.
  exact H.
Qed.
Print Assumptions entry_cell.
Print Assumptions exit_cell.
Print Assumptions refute_incr_return_wit_1_split_goal_spatial.
Print Assumptions refute_incr_return_wit_1.
Print Assumptions entry_sat.

End LegacyProof.
Require Import Goal.
Module Proofs.
Theorem proof_of_incr_return_wit_1 : ~ Goal.incr_return_wit_1.
Proof.
  intro current.
  apply LegacyProof.refute_incr_return_wit_1.
  unfold ExecutionGoal.incr_return_wit_1, Goal.incr_return_wit_1 in *.
  destruct current as [arm0 | arm1].
  - left. intros p_pre old___tespec_entry PreH1 PreH2 PreH3 PreH4.
    exact (arm0 old___tespec_entry p_pre PreH1 PreH2 PreH3 PreH4).
  - right. intros p_pre old___tespec_entry PreH1 PreH2 PreH3 PreH4 PreH5 PreH6.
    exact (arm1 old___tespec_entry p_pre PreH1 PreH2 PreH3 PreH4 PreH5 PreH6).
Qed.
End Proofs.
