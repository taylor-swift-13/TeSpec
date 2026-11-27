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


Definition uninit_mem : mem := fun x => if Z.leb 4096 x then (if Z.ltb x 4100 then Noninit else Noperm) else Noperm.

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

(*----- Function zero -----*)

Definition zero_return_wit_1 := 
(
forall (p_pre: Z) (PreH1 : (p_pre = 4096)) ,
  ((p_pre) # Int  |->_)
|--
  ((p_pre) # Int  |-> 0)
) \/
(
forall (p_pre: Z) (PreH1 : (p_pre = 4096)) ,
  ((p_pre) # Int  |->_)
|--
  ((p_pre) # Int  |-> 0)
).

Definition zero_return_wit_1_split_goal_spatial := 
forall (p_pre: Z) (PreH1 : (p_pre = 4096)) ,
  ((p_pre) # Int  |->_)
|--
  ((p_pre) # Int  |-> 0)
.

Definition zero_precondition_wit_1 :=
exists (p_pre: Z) ,
~ ((  “ (p_pre = 4096) ”
  &&  ((p_pre) # Int  |->_)) |-- “ False ”).



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



Local Notation ut2 := (fun x : Z =>
  if Z.eqb x 4098 then Noninit else
  if Z.eqb x 4099 then Noninit else Noperm).
Local Notation ut1 := (fun x : Z =>
  if Z.eqb x 4097 then Noninit else ut2 x).

Ltac noninit_join :=
  unfold mem_join, single_Noninit_mem, uninit_mem, addr_eqb;
  intro x;
  repeat match goal with
  | |- context [Z.eqb ?a ?b] =>
      let E := fresh "E" in destruct (Z.eqb a b) eqn:E;
      [apply Z.eqb_eq in E | apply Z.eqb_neq in E]
  | |- context [Z.leb ?a ?b] =>
      let E := fresh "E" in destruct (Z.leb a b) eqn:E;
      [apply Z.leb_le in E | apply Z.leb_gt in E]
  | |- context [Z.ltb ?a ?b] =>
      let E := fresh "E" in destruct (Z.ltb a b) eqn:E;
      [apply Z.ltb_lt in E | apply Z.ltb_ge in E]
  end; try lia; eauto 12.

Lemma uninit_join2 :
  mem_join (single_Noninit_mem 4098) (single_Noninit_mem 4099) ut2.
Proof. noninit_join. all: try solve [cbv beta iota zeta in *;
  repeat match goal with |- context [if ?b then _ else _] => destruct b eqn:? end;
  repeat match goal with
  | H : Z.eqb _ _ = true |- _ => apply Z.eqb_eq in H
  | H : Z.eqb _ _ = false |- _ => apply Z.eqb_neq in H
  | H : Z.leb _ _ = true |- _ => apply Z.leb_le in H
  | H : Z.leb _ _ = false |- _ => apply Z.leb_gt in H
  | H : Z.ltb _ _ = true |- _ => apply Z.ltb_lt in H
  | H : Z.ltb _ _ = false |- _ => apply Z.ltb_ge in H
  end; first [lia | solve [intuition (try congruence; try lia)] | eauto 16]].
Qed.

Lemma uninit_join1 :
  mem_join (single_Noninit_mem 4097) ut2 ut1.
Proof. noninit_join. all: try solve [cbv beta iota zeta in *;
  repeat match goal with |- context [if ?b then _ else _] => destruct b eqn:? end;
  repeat match goal with
  | H : Z.eqb _ _ = true |- _ => apply Z.eqb_eq in H
  | H : Z.eqb _ _ = false |- _ => apply Z.eqb_neq in H
  | H : Z.leb _ _ = true |- _ => apply Z.leb_le in H
  | H : Z.leb _ _ = false |- _ => apply Z.leb_gt in H
  | H : Z.ltb _ _ = true |- _ => apply Z.ltb_lt in H
  | H : Z.ltb _ _ = false |- _ => apply Z.ltb_ge in H
  end; first [lia | solve [intuition (try congruence; try lia)] | eauto 16]].
Qed.

Lemma uninit_join0 :
  mem_join (single_Noninit_mem 4096) ut1 uninit_mem.
Proof. noninit_join. all: try solve [cbv beta iota zeta in *;
  repeat match goal with |- context [if ?b then _ else _] => destruct b eqn:? end;
  repeat match goal with
  | H : Z.eqb _ _ = true |- _ => apply Z.eqb_eq in H
  | H : Z.eqb _ _ = false |- _ => apply Z.eqb_neq in H
  | H : Z.leb _ _ = true |- _ => apply Z.leb_le in H
  | H : Z.leb _ _ = false |- _ => apply Z.leb_gt in H
  | H : Z.ltb _ _ = true |- _ => apply Z.ltb_lt in H
  | H : Z.ltb _ _ = false |- _ => apply Z.ltb_ge in H
  end; first [lia | solve [intuition (try congruence; try lia)] | eauto 16]].
Qed.

Lemma noninit_byte_at : forall p,
  naive_C_Rules.mstore_noninit p (st (single_Noninit_mem p)).
Proof.
  intro p; unfold naive_C_Rules.mstore_noninit, st; cbn.
  split; [sets_unfold; tauto |].
  split; [sets_unfold; tauto | left; reflexivity].
all: try solve [cbv beta iota zeta in *;
  repeat match goal with |- context [if ?b then _ else _] => destruct b eqn:? end;
  repeat match goal with
  | H : Z.eqb _ _ = true |- _ => apply Z.eqb_eq in H
  | H : Z.eqb _ _ = false |- _ => apply Z.eqb_neq in H
  | H : Z.leb _ _ = true |- _ => apply Z.leb_le in H
  | H : Z.leb _ _ = false |- _ => apply Z.leb_gt in H
  | H : Z.ltb _ _ = true |- _ => apply Z.ltb_lt in H
  | H : Z.ltb _ _ = false |- _ => apply Z.ltb_ge in H
  end; first [lia | solve [intuition (try congruence; try lia)] | eauto 16]].
Qed.

Theorem entry_cell : (4096 # Int |->_) (st uninit_mem).
Proof.
  split.
  - vm_compute; intuition discriminate.
  - exists (st (single_Noninit_mem 4096)), (st ut1).
    split; [apply st_join; apply uninit_join0 |].
    split; [apply noninit_byte_at |].
    exists (st (single_Noninit_mem 4097)), (st ut2).
    split; [apply st_join; apply uninit_join1 |].
    split; [apply noninit_byte_at |].
    exists (st (single_Noninit_mem 4098)),
      (st (single_Noninit_mem 4099)).
    split; [apply st_join; apply uninit_join2 |].
    split; apply noninit_byte_at.
all: try solve [cbv beta iota zeta in *;
  repeat match goal with |- context [if ?b then _ else _] => destruct b eqn:? end;
  repeat match goal with
  | H : Z.eqb _ _ = true |- _ => apply Z.eqb_eq in H
  | H : Z.eqb _ _ = false |- _ => apply Z.eqb_neq in H
  | H : Z.leb _ _ = true |- _ => apply Z.leb_le in H
  | H : Z.leb _ _ = false |- _ => apply Z.leb_gt in H
  | H : Z.ltb _ _ = true |- _ => apply Z.ltb_lt in H
  | H : Z.ltb _ _ = false |- _ => apply Z.ltb_ge in H
  end; first [lia | solve [intuition (try congruence; try lia)] | eauto 16]].
Qed.
Theorem exit_cell : ~ (4096 # Int |-> 0) (st uninit_mem).
Proof.
  intro H; destruct H as [_ H].
  destruct H as (b0 & b1 & b2 & b3 & Hmerge & H).
  destruct H as (s0 & sr & Hj & Hb & Hr).
  destruct Hb as (v & Hv & Hmem & Hsts & Htoken).
  unfold naive_C_Rules.join, ConAssertion.state_join in Hj.
  destruct Hj as [Hj _].
  unfold mem_join in Hj; specialize (Hj 4096).
  rewrite Hmem in Hj.
  cbn [st uninit_mem single_byte_mem addr_eqb] in Hj.
  destruct Hj as [Hj | [Hj | [Hj | [Hj | Hj]]]];
    [destruct Hj as [Hbad _] | destruct Hj as [Hbad _] |
     destruct Hj as [Hbad _] | destruct Hj as [n [Hbad _]] |
     destruct Hj as [n [_ [_ Hbad]]]]; discriminate.
all: try solve [cbv beta iota zeta in *;
  repeat match goal with |- context [if ?b then _ else _] => destruct b eqn:? end;
  repeat match goal with
  | H : Z.eqb _ _ = true |- _ => apply Z.eqb_eq in H
  | H : Z.eqb _ _ = false |- _ => apply Z.eqb_neq in H
  | H : Z.leb _ _ = true |- _ => apply Z.leb_le in H
  | H : Z.leb _ _ = false |- _ => apply Z.leb_gt in H
  | H : Z.ltb _ _ = true |- _ => apply Z.ltb_lt in H
  | H : Z.ltb _ _ = false |- _ => apply Z.ltb_ge in H
  end; first [lia | solve [intuition (try congruence; try lia)] | eauto 16]].
Qed.
Theorem refute_zero_return_wit_1_split_goal_spatial : ~ ExecutionGoal.zero_return_wit_1_split_goal_spatial.
Proof.
  intro H; apply exit_cell.
  exact (H 4096 eq_refl (st uninit_mem) entry_cell).
all: try solve [cbv beta iota zeta in *;
  repeat match goal with |- context [if ?b then _ else _] => destruct b eqn:? end;
  repeat match goal with
  | H : Z.eqb _ _ = true |- _ => apply Z.eqb_eq in H
  | H : Z.eqb _ _ = false |- _ => apply Z.eqb_neq in H
  | H : Z.leb _ _ = true |- _ => apply Z.leb_le in H
  | H : Z.leb _ _ = false |- _ => apply Z.leb_gt in H
  | H : Z.ltb _ _ = true |- _ => apply Z.ltb_lt in H
  | H : Z.ltb _ _ = false |- _ => apply Z.ltb_ge in H
  end; first [lia | solve [intuition (try congruence; try lia)] | eauto 16]].
Qed.
Theorem refute_zero_return_wit_1 : ~ ExecutionGoal.zero_return_wit_1.
Proof.
  intros [H | H]; apply exit_cell;
    exact (H 4096 eq_refl (st uninit_mem) entry_cell).
all: try solve [cbv beta iota zeta in *;
  repeat match goal with |- context [if ?b then _ else _] => destruct b eqn:? end;
  repeat match goal with
  | H : Z.eqb _ _ = true |- _ => apply Z.eqb_eq in H
  | H : Z.eqb _ _ = false |- _ => apply Z.eqb_neq in H
  | H : Z.leb _ _ = true |- _ => apply Z.leb_le in H
  | H : Z.leb _ _ = false |- _ => apply Z.leb_gt in H
  | H : Z.ltb _ _ = true |- _ => apply Z.ltb_lt in H
  | H : Z.ltb _ _ = false |- _ => apply Z.ltb_ge in H
  end; first [lia | solve [intuition (try congruence; try lia)] | eauto 16]].
Qed.
Theorem entry_sat : ExecutionGoal.zero_precondition_wit_1.
Proof.
  exists 4096; intro H.
  exact (H (st uninit_mem) (conj eq_refl entry_cell)).
all: try solve [cbv beta iota zeta in *;
  repeat match goal with |- context [if ?b then _ else _] => destruct b eqn:? end;
  repeat match goal with
  | H : Z.eqb _ _ = true |- _ => apply Z.eqb_eq in H
  | H : Z.eqb _ _ = false |- _ => apply Z.eqb_neq in H
  | H : Z.leb _ _ = true |- _ => apply Z.leb_le in H
  | H : Z.leb _ _ = false |- _ => apply Z.leb_gt in H
  | H : Z.ltb _ _ = true |- _ => apply Z.ltb_lt in H
  | H : Z.ltb _ _ = false |- _ => apply Z.ltb_ge in H
  end; first [lia | solve [intuition (try congruence; try lia)] | eauto 16]].
Qed.
Print Assumptions entry_cell.
Print Assumptions exit_cell.
Print Assumptions refute_zero_return_wit_1_split_goal_spatial.
Print Assumptions refute_zero_return_wit_1.
Print Assumptions entry_sat.

End LegacyProof.
Require Import Goal.
Module Proofs.
Theorem proof_of_zero_return_wit_1 : ~ Goal.zero_return_wit_1.
Proof.
  intro current.
  apply LegacyProof.refute_zero_return_wit_1.
  unfold ExecutionGoal.zero_return_wit_1, Goal.zero_return_wit_1 in *.
  exact current.
Qed.
End Proofs.
