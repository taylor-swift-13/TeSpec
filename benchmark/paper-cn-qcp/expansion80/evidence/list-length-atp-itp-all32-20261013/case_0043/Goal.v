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
Require Import SimpleC.EE.QCP_demos_human.sll_layout32.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function length -----*)

Definition length_safety_wit_1 := 
  ((( &( "l_spec_410" ) )) # Ptr  |-> 4096)
  **  (sll32 4096 (cons (100) ((cons (2147483646) ((cons (INT_MAX) ((@nil Z))))))) )
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition length_safety_wit_2 := 
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) ,
  ((( &( "l_spec_430" ) )) # Ptr  |-> y)
  **  ((4100) # Ptr  |-> y)
  **  (((y_2 + 4 )) # Ptr  |-> 0)
  **  ((y_2) # Int  |-> INT_MAX)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 2147483646)
  **  ((4096) # Int  |-> 100)
  **  ((( &( "l_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition length_safety_wit_3 := 
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) ,
  ((( &( "l_spec_431" ) )) # Ptr  |-> y_2)
  **  ((( &( "l_spec_430" ) )) # Ptr  |-> y)
  **  ((4100) # Ptr  |-> y)
  **  (((y_2 + 4 )) # Ptr  |-> 0)
  **  ((y_2) # Int  |-> INT_MAX)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 2147483646)
  **  ((4096) # Int  |-> 100)
  **  ((( &( "l_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition length_safety_wit_4 := 
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) ,
  ((( &( "l_spec_432" ) )) # Ptr  |-> 0)
  **  ((( &( "l_spec_431" ) )) # Ptr  |-> y_2)
  **  ((( &( "l_spec_430" ) )) # Ptr  |-> y)
  **  ((4100) # Ptr  |-> y)
  **  (((y_2 + 4 )) # Ptr  |-> 0)
  **  ((y_2) # Int  |-> INT_MAX)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 2147483646)
  **  ((4096) # Int  |-> 100)
  **  ((( &( "l_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition length_safety_wit_5 := 
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) ,
  ((( &( "l_spec_432" ) )) # Ptr  |-> 0)
  **  ((( &( "l_spec_431" ) )) # Ptr  |-> y_2)
  **  ((( &( "l_spec_430" ) )) # Ptr  |-> y)
  **  ((4100) # Ptr  |-> y)
  **  (((y_2 + 4 )) # Ptr  |-> 0)
  **  ((y_2) # Int  |-> INT_MAX)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 2147483646)
  **  ((4096) # Int  |-> 100)
  **  ((( &( "l_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition length_safety_wit_6 := 
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) ,
  ((( &( "l_spec_431" ) )) # Ptr  |-> y_2)
  **  ((( &( "l_spec_430" ) )) # Ptr  |-> y)
  **  ((4100) # Ptr  |-> y)
  **  (((y_2 + 4 )) # Ptr  |-> 0)
  **  ((y_2) # Int  |-> INT_MAX)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 2147483646)
  **  ((4096) # Int  |-> 100)
  **  ((( &( "l_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition length_safety_wit_7 := 
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) ,
  ((( &( "l_spec_431" ) )) # Ptr  |-> y_2)
  **  ((( &( "l_spec_430" ) )) # Ptr  |-> y)
  **  ((4100) # Ptr  |-> y)
  **  (((y_2 + 4 )) # Ptr  |-> 0)
  **  ((y_2) # Int  |-> INT_MAX)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 2147483646)
  **  ((4096) # Int  |-> 100)
  **  ((( &( "l_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition length_safety_wit_8 := 
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) ,
  ((( &( "l_spec_430" ) )) # Ptr  |-> y)
  **  ((4100) # Ptr  |-> y)
  **  (((y_2 + 4 )) # Ptr  |-> 0)
  **  ((y_2) # Int  |-> INT_MAX)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 2147483646)
  **  ((4096) # Int  |-> 100)
  **  ((( &( "l_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition length_safety_wit_9 := 
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y = 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) ,
  ((( &( "l_spec_430" ) )) # Ptr  |-> y)
  **  ((4100) # Ptr  |-> y)
  **  (((y_2 + 4 )) # Ptr  |-> 0)
  **  ((y_2) # Int  |-> INT_MAX)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 2147483646)
  **  ((4096) # Int  |-> 100)
  **  ((( &( "l_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition length_safety_wit_10 := 
  ((( &( "l_spec_410" ) )) # Ptr  |-> 4096)
  **  (sll32 4096 (cons (100) ((cons (2147483646) ((cons (INT_MAX) ((@nil Z))))))) )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition length_return_wit_1 := 
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_2 + 4 )) # Ptr  |-> 0)
  **  ((y_2) # Int  |-> INT_MAX)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 2147483646)
  **  ((4096) # Int  |-> 100)
|--
  “ (3 = 3) ”
  &&  (sll32 4096 (cons (100) ((cons (2147483646) ((cons (INT_MAX) ((@nil Z))))))) )
.

Definition length_partial_solve_wit_1 := 
  (sll32 4096 (cons (100) ((cons (2147483646) ((cons (INT_MAX) ((@nil Z))))))) )
|--
  EX (y: Z)  (y_2: Z)  (y_3: Z) ,
  “ (y_3 = 0) ” 
  &&  “ (y_2 <> 0) ” 
  &&  “ (y <> 0) ” 
  &&  “ (4096 <> 0) ”
  &&  ((4100) # Ptr  |-> y)
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> INT_MAX)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 2147483646)
  **  ((4096) # Int  |-> 100)
.

Definition length_precondition_wit_1 :=
~ ((  “ (4096 = 4096) ” 
  &&  “ ((cons (100) ((cons (2147483646) ((cons (INT_MAX) ((@nil Z))))))) = (cons (100) ((cons (2147483646) ((cons (INT_MAX) ((@nil Z)))))))) ” 
  &&  “ ((Zlength ((cons (100) ((cons (2147483646) ((cons (INT_MAX) ((@nil Z))))))))) < UINT_MAX) ”
  &&  (sll32 4096 (cons (100) ((cons (2147483646) ((cons (INT_MAX) ((@nil Z))))))) )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_length_safety_wit_1 : length_safety_wit_1.
Axiom proof_of_length_safety_wit_2 : length_safety_wit_2.
Axiom proof_of_length_safety_wit_3 : length_safety_wit_3.
Axiom proof_of_length_safety_wit_4 : length_safety_wit_4.
Axiom proof_of_length_safety_wit_5 : length_safety_wit_5.
Axiom proof_of_length_safety_wit_6 : length_safety_wit_6.
Axiom proof_of_length_safety_wit_7 : length_safety_wit_7.
Axiom proof_of_length_safety_wit_8 : length_safety_wit_8.
Axiom proof_of_length_safety_wit_9 : length_safety_wit_9.
Axiom proof_of_length_safety_wit_10 : length_safety_wit_10.
Axiom proof_of_length_return_wit_1 : length_return_wit_1.
Axiom proof_of_length_partial_solve_wit_1 : length_partial_solve_wit_1.
Axiom proof_of_length_precondition_wit_1 : length_precondition_wit_1.

End VC_Correct.
