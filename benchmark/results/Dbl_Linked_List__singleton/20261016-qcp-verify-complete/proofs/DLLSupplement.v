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
