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
Require Import RootSpec.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function root_cell -----*)

Definition root_cell_safety_wit_1 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 1)
|--
  “ ((0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (0 + 1 )) ”
.

Definition root_cell_safety_wit_2 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition root_cell_safety_wit_3 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |->_)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 1)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition root_cell_safety_wit_4 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 1)
|--
  “ ((0 * 0 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (0 * 0 )) ”
.

Definition root_cell_safety_wit_5 := 
forall (p_pre: Z) (PreH1 : ((0 * 0 ) >= 1)) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 1)
|--
  “ False ”
.

Definition root_cell_safety_wit_6 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition root_cell_safety_wit_7 := 
forall (p_pre: Z) (PreH1 : ((1 * 1 ) < 1)) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 1)
|--
  “ False ”
.

Definition root_cell_return_wit_1 := 
(
forall (p_pre: Z) ,
  ((p_pre) # Int  |-> 1)
|--
  EX (r: Z) ,
  “ (r = 1) ” 
  &&  “ (least_root 1 r ) ”
  &&  ((p_pre) # Int  |-> r)
) \/
(
  TT && emp 
|--
  “ (least_root 1 1 ) ”
  &&  emp
).

Definition root_cell_return_wit_1_split_goal_1 := 
  (least_root 1 1 )
.

Definition root_cell_precondition_wit_1 :=
exists (p_pre: Z) ,
~ ((  “ (1 = 1) ” 
  &&  “ (0 <= 1) ” 
  &&  “ (1 <= 100) ”
  &&  ((p_pre) # Int  |-> 1)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_root_cell_safety_wit_1 : root_cell_safety_wit_1.
Axiom proof_of_root_cell_safety_wit_2 : root_cell_safety_wit_2.
Axiom proof_of_root_cell_safety_wit_3 : root_cell_safety_wit_3.
Axiom proof_of_root_cell_safety_wit_4 : root_cell_safety_wit_4.
Axiom proof_of_root_cell_safety_wit_5 : root_cell_safety_wit_5.
Axiom proof_of_root_cell_safety_wit_6 : root_cell_safety_wit_6.
Axiom proof_of_root_cell_safety_wit_7 : root_cell_safety_wit_7.
Axiom proof_of_root_cell_return_wit_1 : root_cell_return_wit_1.
Axiom proof_of_root_cell_precondition_wit_1 : root_cell_precondition_wit_1.

End VC_Correct.
