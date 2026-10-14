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

(*----- Function is_multiple -----*)

Definition is_multiple_safety_wit_1 := 
  ((( &( "a_spec_374" ) )) # Int  |-> 6)
  **  ((( &( "b_spec_371" ) )) # Int  |-> 3)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition is_multiple_safety_wit_2 := 
  ((( &( "a_spec_374" ) )) # Int  |-> 6)
  **  ((( &( "b_spec_371" ) )) # Int  |-> 3)
|--
  “ ((6 <> (INT_MIN)) \/ (3 <> (-1))) ” 
  &&  “ (3 <> 0) ”
.

Definition is_multiple_safety_wit_3 := 
  ((( &( "a_spec_374" ) )) # Int  |-> 6)
  **  ((( &( "b_spec_371" ) )) # Int  |-> 3)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition is_multiple_safety_wit_4 := 
forall (PreH1 : ((6 % ( 3 ) ) <> 0)) ,
  ((( &( "a_spec_374" ) )) # Int  |-> 6)
  **  ((( &( "b_spec_371" ) )) # Int  |-> 3)
|--
  “ False ”
.

Definition is_multiple_return_wit_1 := 
  TT && emp 
|--
  (“ (1 = 0) ” 
  &&  “ forall (q: Z) , (6 <> (q * 3 )) ”
  &&  emp)
  ||
  (EX (q_2: Z) ,
  “ (1 = 1) ” 
  &&  “ (6 = (q_2 * 3 )) ”
  &&  emp)
.

Definition is_multiple_precondition_wit_1 :=
~ ((  “ (6 = 6) ” 
  &&  “ (3 = 3) ” 
  &&  “ (0 < 3) ”
  &&  emp) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_is_multiple_safety_wit_1 : is_multiple_safety_wit_1.
Axiom proof_of_is_multiple_safety_wit_2 : is_multiple_safety_wit_2.
Axiom proof_of_is_multiple_safety_wit_3 : is_multiple_safety_wit_3.
Axiom proof_of_is_multiple_safety_wit_4 : is_multiple_safety_wit_4.
Axiom proof_of_is_multiple_return_wit_1 : is_multiple_return_wit_1.
Axiom proof_of_is_multiple_precondition_wit_1 : is_multiple_precondition_wit_1.

End VC_Correct.
