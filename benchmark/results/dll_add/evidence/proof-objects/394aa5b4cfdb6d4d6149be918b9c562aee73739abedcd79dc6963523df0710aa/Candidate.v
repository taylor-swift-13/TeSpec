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


Lemma candidate_fold_DLLLeft : forall (p n q a : Z) (tl : list Z),
  p <> 0 ->
  (&(p # "node" ->ₛ "data") # Int |-> a)
  ** (&(p # "node" ->ₛ "prev") # Ptr |-> q)
  ** (&(p # "node" ->ₛ "next") # Ptr |-> n)
  ** DLLLeft q p tl
  |-- DLLLeft p n (a :: tl).
Proof.
  intros p n q a tl Hp.
  cbn [DLLLeft].
  apply _derivable1_andp_intros.
  - entailer!.
  - Exists q.
    entailer!.
Qed.

Lemma candidate_fold_DLLRight : forall (p n q a : Z) (tl : list Z),
  p <> 0 ->
  (&(p # "node" ->ₛ "data") # Int |-> a)
  ** (&(p # "node" ->ₛ "next") # Ptr |-> q)
  ** (&(p # "node" ->ₛ "prev") # Ptr |-> n)
  ** DLLRight q p tl
  |-- DLLRight p n (a :: tl).
Proof.
  intros p n q a tl Hp.
  cbn [DLLRight].
  apply _derivable1_andp_intros.
  - entailer!.
  - Exists q.
    entailer!.
Qed.

Lemma candidate_fold_Dll : forall (n p q : Z) (ll : list Z)
  (h : Z) (lr : list Z),
  n <> 0 ->
  (&(n # "node" ->ₛ "data") # Int |-> h)
  ** (&(n # "node" ->ₛ "prev") # Ptr |-> p)
  ** (&(n # "node" ->ₛ "next") # Ptr |-> q)
  ** DLLLeft p n ll
  ** DLLRight q n lr
  |-- Dll n ll h lr.
Proof.
  intros n p q ll h lr Hn.
  unfold Dll.
  Right.
  apply _derivable1_andp_intros.
  - entailer!.
  - Exists p q.
    entailer!.
Qed.

Lemma candidate_DLLRight_null_change : forall (n m : Z) (l : list Z),
  DLLRight 0 n l |-- DLLRight 0 m l.
Proof.
  intros n m l.
  destruct l as [|a tl].
  - cbn [DLLRight].
    entailer!.
  - cbn [DLLRight].
    Intros q; entailer!.
Qed.

Theorem primary_add_safety_wit_1 : PrimaryQcpGoal.add_safety_wit_1.
Proof.
  unfold PrimaryQcpGoal.add_safety_wit_1.
  intros n_pre element_pre lr ll q p h e retval PreH1 PreH2 PreH3.
  entailer!.
Qed.
Theorem primary_add_safety_wit_2 : PrimaryQcpGoal.add_safety_wit_2.
Proof.
  unfold PrimaryQcpGoal.add_safety_wit_2.
  intros n_pre element_pre lr ll e retval PreH1 PreH2 PreH3 PreH4 PreH5.
  entailer!.
Qed.
Theorem primary_add_safety_wit_3 : PrimaryQcpGoal.add_safety_wit_3.
Proof.
  unfold PrimaryQcpGoal.add_safety_wit_3.
  intros n_pre element_pre lr ll q p h e retval PreH1 PreH2 PreH3.
  entailer!.
Qed.
Theorem primary_add_safety_wit_4 : PrimaryQcpGoal.add_safety_wit_4.
Proof.
  unfold PrimaryQcpGoal.add_safety_wit_4.
  intros n_pre element_pre lr ll e retval PreH1 PreH2 PreH3 PreH4 PreH5.
  entailer!.
Qed.
Theorem primary_add_safety_wit_5 : PrimaryQcpGoal.add_safety_wit_5.
Proof.
  unfold PrimaryQcpGoal.add_safety_wit_5.
  intros n_pre element_pre lr ll q p h e retval PreH1 PreH2 PreH3.
  entailer!.
Qed.
Theorem primary_add_safety_wit_6 : PrimaryQcpGoal.add_safety_wit_6.
Proof.
  unfold PrimaryQcpGoal.add_safety_wit_6.
  intros n_pre element_pre lr ll e retval PreH1 PreH2 PreH3 PreH4 PreH5.
  entailer!.
Qed.
Theorem primary_add_safety_wit_7 : PrimaryQcpGoal.add_safety_wit_7.
Proof.
  unfold PrimaryQcpGoal.add_safety_wit_7.
  intros n_pre element_pre lr ll q p h e retval PreH1 PreH2 PreH3 PreH4.
  contradiction.
Qed.
Theorem primary_add_safety_wit_8 : PrimaryQcpGoal.add_safety_wit_8.
Proof.
  unfold PrimaryQcpGoal.add_safety_wit_8.
  intros n_pre element_pre lr ll e retval PreH1 PreH2 PreH3 PreH4 PreH5 PreH6.
  contradiction.
Qed.
Theorem primary_add_safety_wit_9 : PrimaryQcpGoal.add_safety_wit_9.
Proof.
  unfold PrimaryQcpGoal.add_safety_wit_9.
  intros n_pre element_pre lr ll e retval PreH1 PreH2 PreH3 PreH4 PreH5 PreH6.
  entailer!.
Qed.
Theorem primary_add_safety_wit_10 : PrimaryQcpGoal.add_safety_wit_10.
Proof.
  unfold PrimaryQcpGoal.add_safety_wit_10.
  intros n_pre element_pre lr ll e retval PreH1 PreH2 PreH3 PreH4 PreH5 PreH6.
  entailer!.
Qed.
Theorem primary_add_safety_wit_11 : PrimaryQcpGoal.add_safety_wit_11.
Proof.
  unfold PrimaryQcpGoal.add_safety_wit_11.
  intros n_pre element_pre lr ll q p h e retval PreH1 PreH2 PreH3 PreH4.
  entailer!.
Qed.

Theorem strong_add_return_wit_1 : forall (n_pre: Z) (element_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (e: Z) (retval: Z) (a: Z) (tl: (@list Z)) (q_2: Z) (PreH1 : (lr = (cons (a) (tl)))) (PreH2 : (q <> 0)) (PreH3 : (n_pre <> 0)) (PreH4 : (retval <> 0)) (PreH5 : (element_pre = e)) (PreH6 : (n_pre <> 0)) ,
  ((&((q)  # "node" ->ₛ "prev")) # Ptr  |-> retval)
  **  (DLLRight q_2 q tl )
  **  ((&((q)  # "node" ->ₛ "next")) # Ptr  |-> q_2)
  **  ((&((q)  # "node" ->ₛ "data")) # Int  |-> a)
  **  ((&((retval)  # "node" ->ₛ "data")) # Int  |-> element_pre)
  **  ((&((retval)  # "node" ->ₛ "prev")) # Ptr  |-> n_pre)
  **  ((&((retval)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> retval)
  **  (DLLLeft p n_pre ll )
|--
  “ (n_pre <> 0) ”
  &&  (Dll retval (cons (h) (ll)) e lr ).
Proof.
  intros n_pre element_pre lr ll q p h e retval a tl q_2
    PreH1 PreH2 PreH3 PreH4 PreH5 PreH6.
  subst lr element_pre.
  apply _derivable1_andp_intros.
  - entailer!.
  - rewrite <- (candidate_fold_Dll retval n_pre q (h :: ll) e
      (a :: tl) PreH4).
    rewrite <- (candidate_fold_DLLLeft n_pre retval p h ll PreH3).
    rewrite <- (candidate_fold_DLLRight q retval q_2 a tl PreH2).
    entailer!.
Qed.

Theorem primary_add_return_wit_1 : PrimaryQcpGoal.add_return_wit_1.
Proof.
  unfold PrimaryQcpGoal.add_return_wit_1.
  left.
  exact strong_add_return_wit_1.
Qed.

Theorem primary_add_return_wit_2 : PrimaryQcpGoal.add_return_wit_2.
Proof.
  unfold PrimaryQcpGoal.add_return_wit_2.
  intros n_pre element_pre lr ll q p h e retval
    PreH1 PreH2 PreH3 PreH4 PreH5.
  subst q element_pre.
  apply _derivable1_andp_intros.
  - entailer!.
  - rewrite <- (candidate_fold_Dll retval n_pre 0 (h :: ll) e lr
      PreH3).
    rewrite <- (candidate_fold_DLLLeft n_pre retval p h ll PreH2).
    rewrite <- (candidate_DLLRight_null_change n_pre retval lr).
    entailer!.
Qed.

Theorem primary_add_return_wit_3 : PrimaryQcpGoal.add_return_wit_3.
Proof.
  unfold PrimaryQcpGoal.add_return_wit_3.
  intros n_pre element_pre lr ll e retval
    PreH1 PreH2 PreH3 PreH4 PreH5 PreH6.
  subst n_pre element_pre.
  apply _derivable1_andp_intros.
  - entailer!.
  - unfold Dll.
    Right.
    apply _derivable1_andp_intros.
    + entailer!.
    + Exists 0 0.
      cbn [DLLLeft DLLRight].
      entailer!.
Qed.

Theorem primary_add_partial_solve_wit_1 : PrimaryQcpGoal.add_partial_solve_wit_1.
Proof.
  unfold PrimaryQcpGoal.add_partial_solve_wit_1.
  intros n_pre element_pre lr ll q p h e PreH1 PreH2.
  entailer!.
Qed.
Theorem primary_add_partial_solve_wit_2 : PrimaryQcpGoal.add_partial_solve_wit_2.
Proof.
  unfold PrimaryQcpGoal.add_partial_solve_wit_2.
  intros n_pre element_pre lr ll e PreH1 PreH2 PreH3 PreH4.
  entailer!.
Qed.
Theorem primary_add_partial_solve_wit_3 : PrimaryQcpGoal.add_partial_solve_wit_3.
Proof.
  unfold PrimaryQcpGoal.add_partial_solve_wit_3.
  intros n_pre element_pre lr ll q p h e retval
    PreH1 PreH2 PreH3 PreH4 PreH5.
  destruct lr as [|a tl].
  - cbn [DLLRight].
    entailer!.
  - cbn [DLLRight].
    Intros q_2.
    Exists q_2 tl a.
    entailer!.
    apply store_ptr_undef_store_ptr.
Qed.

Module PrimaryCertificate : PrimaryQcpGoal.VC_Correct.
Definition proof_of_add_safety_wit_1 := primary_add_safety_wit_1.
Definition proof_of_add_safety_wit_2 := primary_add_safety_wit_2.
Definition proof_of_add_safety_wit_3 := primary_add_safety_wit_3.
Definition proof_of_add_safety_wit_4 := primary_add_safety_wit_4.
Definition proof_of_add_safety_wit_5 := primary_add_safety_wit_5.
Definition proof_of_add_safety_wit_6 := primary_add_safety_wit_6.
Definition proof_of_add_safety_wit_7 := primary_add_safety_wit_7.
Definition proof_of_add_safety_wit_8 := primary_add_safety_wit_8.
Definition proof_of_add_safety_wit_9 := primary_add_safety_wit_9.
Definition proof_of_add_safety_wit_10 := primary_add_safety_wit_10.
Definition proof_of_add_safety_wit_11 := primary_add_safety_wit_11.
Definition proof_of_add_return_wit_1 := primary_add_return_wit_1.
Definition proof_of_add_return_wit_2 := primary_add_return_wit_2.
Definition proof_of_add_return_wit_3 := primary_add_return_wit_3.
Definition proof_of_add_partial_solve_wit_1 := primary_add_partial_solve_wit_1.
Definition proof_of_add_partial_solve_wit_2 := primary_add_partial_solve_wit_2.
Definition proof_of_add_partial_solve_wit_3 := primary_add_partial_solve_wit_3.
End PrimaryCertificate.
Print Assumptions primary_add_safety_wit_1.
Print Assumptions primary_add_safety_wit_2.
Print Assumptions primary_add_safety_wit_3.
Print Assumptions primary_add_safety_wit_4.
Print Assumptions primary_add_safety_wit_5.
Print Assumptions primary_add_safety_wit_6.
Print Assumptions primary_add_safety_wit_7.
Print Assumptions primary_add_safety_wit_8.
Print Assumptions primary_add_safety_wit_9.
Print Assumptions primary_add_safety_wit_10.
Print Assumptions primary_add_safety_wit_11.
Print Assumptions primary_add_return_wit_1.
Print Assumptions primary_add_return_wit_2.
Print Assumptions primary_add_return_wit_3.
Print Assumptions primary_add_partial_solve_wit_1.
Print Assumptions primary_add_partial_solve_wit_2.
Print Assumptions primary_add_partial_solve_wit_3.
Print Assumptions strong_add_return_wit_1.
