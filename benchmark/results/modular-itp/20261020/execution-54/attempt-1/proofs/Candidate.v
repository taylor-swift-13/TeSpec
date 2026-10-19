Require Import ConcreteCell ExecutionGoal.
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
Proof. noninit_join. Qed.

Lemma uninit_join1 :
  mem_join (single_Noninit_mem 4097) ut2 ut1.
Proof. noninit_join. Qed.

Lemma uninit_join0 :
  mem_join (single_Noninit_mem 4096) ut1 uninit_mem.
Proof. noninit_join. Qed.

Lemma noninit_byte_at : forall p,
  naive_C_Rules.mstore_noninit p (st (single_Noninit_mem p)).
Proof.
  intro p; unfold naive_C_Rules.mstore_noninit, st; cbn.
  split; [sets_unfold; tauto |].
  split; [sets_unfold; tauto | left; reflexivity].
Qed.


Require Import ReferenceProof.
Theorem entry_cell : (4096 # Int |->_) (st uninit_mem).
Proof. exact ReferenceProof.entry_cell. Qed.
Theorem exit_cell : ~ (4096 # Int |-> 0) (st uninit_mem).
Proof. exact ReferenceProof.exit_cell. Qed.
Theorem refute_zero_return_wit_1_split_goal_spatial : ~ ExecutionGoal.zero_return_wit_1_split_goal_spatial.
Proof. exact ReferenceProof.refute_zero_return_wit_1_split_goal_spatial. Qed.
Theorem refute_zero_return_wit_1 : ~ ExecutionGoal.zero_return_wit_1.
Proof. exact ReferenceProof.refute_zero_return_wit_1. Qed.
Theorem entry_sat : ExecutionGoal.zero_precondition_wit_1.
Proof. exact ReferenceProof.entry_sat. Qed.
Print Assumptions entry_cell.
Print Assumptions exit_cell.
Print Assumptions refute_zero_return_wit_1_split_goal_spatial.
Print Assumptions refute_zero_return_wit_1.
Print Assumptions entry_sat.
