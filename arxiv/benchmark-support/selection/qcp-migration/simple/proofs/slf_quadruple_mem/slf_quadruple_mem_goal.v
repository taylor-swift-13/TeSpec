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

(*----- Function quadruple_mem -----*)

Definition quadruple_mem_safety_wit_1 := 
forall (p_pre: Z) (v: Z) (PreH1 : ((INT_MIN) <= (4 * v ))) (PreH2 : ((4 * v ) <= INT_MAX)) ,
  ((( &( "m" ) )) # Int  |->_)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> v)
|--
  “ ((v + v ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (v + v )) ”
.

Definition quadruple_mem_safety_wit_2 := 
forall (p_pre: Z) (v: Z) (PreH1 : ((INT_MIN) <= (4 * v ))) (PreH2 : ((4 * v ) <= INT_MAX)) ,
  ((( &( "m" ) )) # Int  |-> (v + v ))
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> v)
|--
  “ (((v + v ) + (v + v ) ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= ((v + v ) + (v + v ) )) ”
.

Definition quadruple_mem_return_wit_1 := 
forall (p_pre: Z) (v: Z) (PreH1 : ((INT_MIN) <= (4 * v ))) (PreH2 : ((4 * v ) <= INT_MAX)) ,
  ((p_pre) # Int  |-> v)
|--
  “ (((v + v ) + (v + v ) ) = (4 * v )) ”
  &&  ((p_pre) # Int  |-> v)
.

Module Type VC_Correct.

Axiom proof_of_quadruple_mem_safety_wit_1 : quadruple_mem_safety_wit_1.
Axiom proof_of_quadruple_mem_safety_wit_2 : quadruple_mem_safety_wit_2.
Axiom proof_of_quadruple_mem_return_wit_1 : quadruple_mem_return_wit_1.

End VC_Correct.
