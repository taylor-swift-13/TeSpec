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
Fixpoint DLLLeft (p n:Z) (l:list Z) : Assertion := match l with
| nil => “p=0” && emp
| a::tl => “p<>0” && EX q:Z, &(p # "node" ->ₛ "data") # Int |-> a ** &(p # "node" ->ₛ "prev") # Ptr |-> q ** &(p # "node" ->ₛ "next") # Ptr |-> n ** DLLLeft q p tl end.
Fixpoint DLLRight (p n:Z) (l:list Z) : Assertion := match l with
| nil => “p=0” && emp
| a::tl => “p<>0” && EX q:Z, &(p # "node" ->ₛ "data") # Int |-> a ** &(p # "node" ->ₛ "next") # Ptr |-> q ** &(p # "node" ->ₛ "prev") # Ptr |-> n ** DLLRight q p tl end.
Definition Dll (n:Z) (ll:list Z) (h:Z) (lr:list Z):Assertion :=
 (“n=0” && “ll=nil” && “lr=nil” && “h=0” && emp) ||
 (“n<>0” && EX p:Z, EX q:Z, &(n # "node" ->ₛ "data") # Int |-> h ** &(n # "node" ->ₛ "prev") # Ptr |-> p ** &(n # "node" ->ₛ "next") # Ptr |-> q ** DLLLeft p n ll ** DLLRight q n lr).
Definition dll_tail (l:list Z) := match l with nil=>nil | _::tl=>tl end.

Lemma DLLLeft_zero : forall n l, DLLLeft 0 n l |-- “l=nil” && emp.
Proof. intros; destruct l; cbn [DLLLeft]; [entailer!|]. Intros; Intros q; entailer!. Qed.
Lemma DLLLeft_nonzero : forall p n l, p<>0 -> DLLLeft p n l |-- EX a:Z, EX tl:list Z, EX q:Z, “l=a::tl” &&
 &(p # "node" ->ₛ "data") # Int |-> a ** &(p # "node" ->ₛ "prev") # Ptr |-> q ** &(p # "node" ->ₛ "next") # Ptr |-> n ** DLLLeft q p tl.
Proof. intros; destruct l as [|a tl]; cbn [DLLLeft]; [entailer!|]. Intros; Intros q; Exists a tl q; entailer!. Qed.
Lemma DLLLeft_fold : forall p n a tl q, p<>0 ->
 &(p # "node" ->ₛ "data") # Int |-> a ** &(p # "node" ->ₛ "prev") # Ptr |-> q ** &(p # "node" ->ₛ "next") # Ptr |-> n ** DLLLeft q p tl |-- DLLLeft p n (a::tl).
Proof. intros; cbn [DLLLeft]; Exists q; entailer!. Qed.

Lemma DLLRight_zero : forall n l, DLLRight 0 n l |-- “l=nil” && emp.
Proof. intros; destruct l; cbn [DLLRight]; [entailer!|]. Intros; Intros q; entailer!. Qed.
Lemma DLLRight_nonzero : forall p n l, p<>0 -> DLLRight p n l |-- EX a:Z, EX tl:list Z, EX q:Z, “l=a::tl” &&
 &(p # "node" ->ₛ "data") # Int |-> a ** &(p # "node" ->ₛ "next") # Ptr |-> q ** &(p # "node" ->ₛ "prev") # Ptr |-> n ** DLLRight q p tl.
Proof. intros; destruct l as [|a tl]; cbn [DLLRight]; [entailer!|]. Intros; Intros q; Exists a tl q; entailer!. Qed.
Lemma DLLRight_fold : forall p n a tl q, p<>0 ->
 &(p # "node" ->ₛ "data") # Int |-> a ** &(p # "node" ->ₛ "next") # Ptr |-> q ** &(p # "node" ->ₛ "prev") # Ptr |-> n ** DLLRight q p tl |-- DLLRight p n (a::tl).
Proof. intros; cbn [DLLRight]; Exists q; entailer!. Qed.
Lemma Dll_fold : forall n ll h lr p q, n<>0 ->
 &(n # "node" ->ₛ "data") # Int |-> h ** &(n # "node" ->ₛ "prev") # Ptr |-> p ** &(n # "node" ->ₛ "next") # Ptr |-> q ** DLLLeft p n ll ** DLLRight q n lr |-- Dll n ll h lr.
Proof. intros; unfold Dll; eapply derivable1_trans; [|apply derivable1_orp_intros2]; Exists p q; entailer!. Qed.
Lemma Dll_zero : emp |-- Dll 0 nil 0 nil.
Proof. unfold Dll; eapply derivable1_trans; [|apply derivable1_orp_intros1]; entailer!. Qed.
