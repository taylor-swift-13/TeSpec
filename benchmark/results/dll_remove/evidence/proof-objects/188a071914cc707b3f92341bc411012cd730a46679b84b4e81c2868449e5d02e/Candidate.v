Require Import PrimaryQcpGoal.
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
Require Import DLLSupplement.
Local Open Scope sac.

Lemma primary_store_int_forget (addr value : Z) :
  (addr # Int |-> value) |-- (addr # Int |->_).
Proof.
  apply store_int_undef_store_int.
Qed.

Lemma primary_store_ptr_forget (addr value : Z) :
  (addr # Ptr |-> value) |-- (addr # Ptr |->_).
Proof.
  apply store_ptr_undef_store_ptr.
Qed.

Theorem primary_remove_safety_wit_1 : PrimaryQcpGoal.remove_safety_wit_1.
Proof.
  unfold PrimaryQcpGoal.remove_safety_wit_1.
  intros.
  entailer!.
Qed.

Theorem primary_remove_safety_wit_2 : PrimaryQcpGoal.remove_safety_wit_2.
Proof.
  unfold PrimaryQcpGoal.remove_safety_wit_2.
  intros.
  entailer!.
Qed.

Theorem primary_remove_safety_wit_3 : PrimaryQcpGoal.remove_safety_wit_3.
Proof.
  unfold PrimaryQcpGoal.remove_safety_wit_3.
  intros.
  entailer!.
Qed.

Theorem primary_remove_safety_wit_4 : PrimaryQcpGoal.remove_safety_wit_4.
Proof.
  unfold PrimaryQcpGoal.remove_safety_wit_4.
  intros.
  entailer!.
Qed.

Theorem primary_remove_return_wit_1 : PrimaryQcpGoal.remove_return_wit_1.
Proof.
  unfold PrimaryQcpGoal.remove_return_wit_1.
  right.
  intros n_pre lr ll q p a tl q_2 a_2 tl_2 retval
    PreH1 PreH2 PreH3 PreH4 PreH5 PreH6 PreH7 PreH8.
  subst ll.
  cbn [dll_tail DLLLeft].
  Exists q_2.
  entailer!.
Qed.

Theorem primary_remove_return_wit_2 : PrimaryQcpGoal.remove_return_wit_2.
Proof.
  unfold PrimaryQcpGoal.remove_return_wit_2.
  right.
  intros n_pre lr ll q p a tl retval
    PreH1 PreH2 PreH3 PreH4 PreH5 PreH6.
  cbn [dll_tail].
  entailer!.
Qed.

Theorem primary_remove_return_wit_3 : PrimaryQcpGoal.remove_return_wit_3.
Proof.
  unfold PrimaryQcpGoal.remove_return_wit_3.
  intros n_pre lr ll q p h retval
    PreH1 PreH2 PreH3 PreH4 PreH5 PreH6.
  Exists (0 : Z).
  entailer!.
  unfold Dll.
  Left.
  entailer!.
Qed.

Theorem primary_remove_return_wit_4 : PrimaryQcpGoal.remove_return_wit_4.
Proof.
  unfold PrimaryQcpGoal.remove_return_wit_4.
  right.
  intros n_pre lr ll q p a tl retval
    PreH1 PreH2 PreH3 PreH4 PreH5 PreH6.
  cbn [dll_tail].
  entailer!.
Qed.

Theorem primary_remove_partial_solve_wit_1 :
  PrimaryQcpGoal.remove_partial_solve_wit_1.
Proof.
  unfold PrimaryQcpGoal.remove_partial_solve_wit_1.
  intros n_pre lr ll q p h PreH1 PreH2.
  destruct ll as [|a tl].
  - cbn [DLLLeft].
    Intros.
    entailer!; try congruence; try lia.
  - cbn [DLLLeft].
    Intros q_2.
    Exists q_2 tl a.
    entailer!; apply store_ptr_undef_store_ptr.
Qed.

Theorem primary_remove_partial_solve_wit_2 :
  PrimaryQcpGoal.remove_partial_solve_wit_2.
Proof.
  unfold PrimaryQcpGoal.remove_partial_solve_wit_2.
  intros n_pre lr ll q p h a tl q_2
    PreH1 PreH2 PreH3 PreH4.
  destruct lr as [|a_2 tl_2].
  - cbn [DLLRight].
    Intros.
    entailer!; try congruence; try lia.
  - cbn [DLLRight].
    Intros q_3.
    Exists q_3 tl_2 a_2.
    entailer!; apply store_ptr_undef_store_ptr.
Qed.

Theorem primary_remove_partial_solve_wit_3 :
  PrimaryQcpGoal.remove_partial_solve_wit_3.
Proof.
  unfold PrimaryQcpGoal.remove_partial_solve_wit_3.
  intros n_pre lr ll q p h PreH1 PreH2 PreH3.
  destruct ll as [|a_left tl_left].
  - cbn [DLLLeft].
    Intros.
    destruct lr as [|a tl].
    + cbn [DLLRight].
      Intros.
      entailer!; try congruence; try lia.
    + cbn [DLLRight].
      Intros q_2.
      Exists q_2 tl a.
      entailer!; apply store_ptr_undef_store_ptr.
  - cbn [DLLLeft].
    Intros q_left.
    entailer!; try congruence; try lia.
Qed.

Theorem primary_remove_partial_solve_wit_4 :
  PrimaryQcpGoal.remove_partial_solve_wit_4.
Proof.
  unfold PrimaryQcpGoal.remove_partial_solve_wit_4.
  intros n_pre lr ll q p h a tl q_2 a_2 tl_2 q_3
    PreH1 PreH2 PreH3 PreH4 PreH5.
  entailer!.
Qed.

Theorem primary_remove_partial_solve_wit_5 :
  PrimaryQcpGoal.remove_partial_solve_wit_5.
Proof.
  unfold PrimaryQcpGoal.remove_partial_solve_wit_5.
  intros n_pre lr ll q p h a tl q_2
    PreH1 PreH2 PreH3 PreH4 PreH5.
  entailer!.
Qed.

Theorem primary_remove_partial_solve_wit_6 :
  PrimaryQcpGoal.remove_partial_solve_wit_6.
Proof.
  unfold PrimaryQcpGoal.remove_partial_solve_wit_6.
  intros n_pre lr ll q p h PreH1 PreH2 PreH3.
  destruct ll as [|a_left tl_left].
  - cbn [DLLLeft].
    Intros.
    destruct lr as [|a_right tl_right].
    + cbn [DLLRight].
      Intros.
      entailer!.
    + cbn [DLLRight].
      Intros q_right.
      entailer!; try congruence; try lia.
  - cbn [DLLLeft].
    Intros q_left.
    entailer!; try congruence; try lia.
Qed.

Theorem primary_remove_partial_solve_wit_7 :
  PrimaryQcpGoal.remove_partial_solve_wit_7.
Proof.
  unfold PrimaryQcpGoal.remove_partial_solve_wit_7.
  intros n_pre lr ll q p h a tl q_2
    PreH1 PreH2 PreH3 PreH4.
  destruct lr as [|a_right tl_right].
  - cbn [DLLRight].
    Intros.
    entailer!.
  - cbn [DLLRight].
    Intros q_right.
    entailer!; try congruence; try lia.
Qed.

Theorem primary_remove_partial_solve_wit_8 :
  PrimaryQcpGoal.remove_partial_solve_wit_8.
Proof.
  unfold PrimaryQcpGoal.remove_partial_solve_wit_8.
  intros n_pre lr ll q p h a tl q_2 a_2 tl_2 q_3 retval
    PreH1 PreH2 PreH3 PreH4 PreH5 PreH6.
  sep_apply
    (primary_store_int_forget (&(n_pre # "node" ->ₛ "data")) h).
  sep_apply
    (primary_store_ptr_forget (&(n_pre # "node" ->ₛ "prev")) p).
  sep_apply
    (primary_store_ptr_forget (&(n_pre # "node" ->ₛ "next")) q).
  entailer!.
Qed.

Theorem primary_remove_partial_solve_wit_9 :
  PrimaryQcpGoal.remove_partial_solve_wit_9.
Proof.
  unfold PrimaryQcpGoal.remove_partial_solve_wit_9.
  intros n_pre lr ll q p h a tl q_2 retval
    PreH1 PreH2 PreH3 PreH4 PreH5 PreH6.
  sep_apply
    (primary_store_int_forget (&(n_pre # "node" ->ₛ "data")) h).
  sep_apply
    (primary_store_ptr_forget (&(n_pre # "node" ->ₛ "prev")) p).
  sep_apply
    (primary_store_ptr_forget (&(n_pre # "node" ->ₛ "next")) q).
  entailer!.
Qed.

Theorem primary_remove_partial_solve_wit_10 :
  PrimaryQcpGoal.remove_partial_solve_wit_10.
Proof.
  unfold PrimaryQcpGoal.remove_partial_solve_wit_10.
  intros n_pre lr ll q p h retval
    PreH1 PreH2 PreH3 PreH4 PreH5 PreH6.
  sep_apply
    (primary_store_int_forget (&(n_pre # "node" ->ₛ "data")) h).
  sep_apply
    (primary_store_ptr_forget (&(n_pre # "node" ->ₛ "prev")) p).
  sep_apply
    (primary_store_ptr_forget (&(n_pre # "node" ->ₛ "next")) q).
  entailer!.
Qed.

Theorem primary_remove_partial_solve_wit_11 :
  PrimaryQcpGoal.remove_partial_solve_wit_11.
Proof.
  unfold PrimaryQcpGoal.remove_partial_solve_wit_11.
  intros n_pre lr ll q p h a tl q_2 retval
    PreH1 PreH2 PreH3 PreH4 PreH5 PreH6.
  sep_apply
    (primary_store_int_forget (&(n_pre # "node" ->ₛ "data")) h).
  sep_apply
    (primary_store_ptr_forget (&(n_pre # "node" ->ₛ "prev")) p).
  sep_apply
    (primary_store_ptr_forget (&(n_pre # "node" ->ₛ "next")) q).
  entailer!.
Qed.

Module PrimaryCertificate : PrimaryQcpGoal.VC_Correct.
Definition proof_of_remove_safety_wit_1 := primary_remove_safety_wit_1.
Definition proof_of_remove_safety_wit_2 := primary_remove_safety_wit_2.
Definition proof_of_remove_safety_wit_3 := primary_remove_safety_wit_3.
Definition proof_of_remove_safety_wit_4 := primary_remove_safety_wit_4.
Definition proof_of_remove_return_wit_1 := primary_remove_return_wit_1.
Definition proof_of_remove_return_wit_2 := primary_remove_return_wit_2.
Definition proof_of_remove_return_wit_3 := primary_remove_return_wit_3.
Definition proof_of_remove_return_wit_4 := primary_remove_return_wit_4.
Definition proof_of_remove_partial_solve_wit_1 := primary_remove_partial_solve_wit_1.
Definition proof_of_remove_partial_solve_wit_2 := primary_remove_partial_solve_wit_2.
Definition proof_of_remove_partial_solve_wit_3 := primary_remove_partial_solve_wit_3.
Definition proof_of_remove_partial_solve_wit_4 := primary_remove_partial_solve_wit_4.
Definition proof_of_remove_partial_solve_wit_5 := primary_remove_partial_solve_wit_5.
Definition proof_of_remove_partial_solve_wit_6 := primary_remove_partial_solve_wit_6.
Definition proof_of_remove_partial_solve_wit_7 := primary_remove_partial_solve_wit_7.
Definition proof_of_remove_partial_solve_wit_8 := primary_remove_partial_solve_wit_8.
Definition proof_of_remove_partial_solve_wit_9 := primary_remove_partial_solve_wit_9.
Definition proof_of_remove_partial_solve_wit_10 := primary_remove_partial_solve_wit_10.
Definition proof_of_remove_partial_solve_wit_11 := primary_remove_partial_solve_wit_11.
End PrimaryCertificate.
