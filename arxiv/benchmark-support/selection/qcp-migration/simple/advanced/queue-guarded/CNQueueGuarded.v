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
Fixpoint CNQueueAux (f b:Z) (l:list Z) : Assertion :=
 match l with
 | nil => “ f = b ” && emp
 | a::tl => “ f <> b ” && “ f <> 0 ” && EX y:Z, “ y <> 0 ” &&
   &(f # "int_queueCell" ->ₛ "first") # Int |-> a **
   &(f # "int_queueCell" ->ₛ "next") # Ptr |-> y ** CNQueueAux y b tl
 end.

Lemma guarded_empty : forall f b l, f=b -> CNQueueAux f b l |-- “ l = nil ” && emp.
Proof. intros f b l H; subst f; destruct l; simpl. - entailer!. - Intros; Intros y; entailer!. Qed.
Lemma guarded_nonempty : forall f b l, f<>b -> CNQueueAux f b l |-- EX a:Z, EX tl:list Z, EX y:Z, “ l=a::tl ” && “ f<>0 ” && “ y<>0 ” && &(f # "int_queueCell" ->ₛ "first") # Int |-> a ** &(f # "int_queueCell" ->ₛ "next") # Ptr |-> y ** CNQueueAux y b tl.
Proof. intros f b l H; destruct l as [|a tl]; simpl; [entailer!|]. Intros; Intros y; Exists a tl y; entailer!. Qed.
Lemma guarded_cons : forall f b a tl y, f<>b -> f<>0 -> y<>0 -> &(f # "int_queueCell" ->ₛ "first") # Int |-> a ** &(f # "int_queueCell" ->ₛ "next") # Ptr |-> y ** CNQueueAux y b tl |-- CNQueueAux f b (a::tl).
Proof. intros; simpl; Exists y; entailer!. Qed.
