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
Require Import SimpleC.EE.QCP_demos_LLM.sll_lib.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function sample -----*)

Definition sample_safety_wit_1 := 
forall (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> y)
  **  ((( &( "cur_spec_431" ) )) # Ptr  |-> y)
  **  ((( &( "total_spec_428" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_417" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_2 := 
forall (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> y)
  **  ((( &( "cur_spec_431" ) )) # Ptr  |-> 4096)
  **  ((( &( "total_spec_428" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_417" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_3 := 
  ((( &( "total_spec_428" ) )) # Int  |->_)
  **  ((( &( "p_spec_417" ) )) # Ptr  |-> 4096)
  **  (sll 4096 (cons (1) ((cons (2) ((@nil Z))))) )
|--
  TT && emp 
.

Definition sample_safety_wit_4 := 
  ((( &( "cur_spec_431" ) )) # Ptr  |-> 4096)
  **  ((( &( "total_spec_428" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_417" ) )) # Ptr  |-> 4096)
  **  (sll 4096 (cons (1) ((cons (2) ((@nil Z))))) )
|--
  TT && emp 
.

Definition sample_safety_wit_5 := 
forall (PreH1 : False) ,
  ((( &( "cur_spec_431" ) )) # Ptr  |-> 4096)
  **  ((( &( "total_spec_428" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_417" ) )) # Ptr  |-> 4096)
  **  (sll 4096 (cons (1) ((cons (2) ((@nil Z))))) )
|--
  “ False ”
.

Definition sample_safety_wit_6 := 
forall (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> y)
  **  ((( &( "cur_spec_431" ) )) # Ptr  |-> y)
  **  ((( &( "total_spec_428" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_417" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_7 := 
forall (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> y)
  **  ((( &( "cur_spec_431" ) )) # Ptr  |-> 0)
  **  ((( &( "total_spec_428" ) )) # Int  |-> 3)
  **  ((( &( "p_spec_417" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_8 := 
forall (y: Z) (PreH1 : False) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> y)
  **  ((( &( "cur_spec_431" ) )) # Ptr  |-> 0)
  **  ((( &( "total_spec_428" ) )) # Int  |-> 3)
  **  ((( &( "p_spec_417" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition sample_return_wit_1 := 
(
forall (p_pre: Z) (xs___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : (y = 0)) (PreH2 : (y_2 = 0)) (PreH3 : (p_pre <> 0)) (PreH4 : (p_pre = 4096)) (PreH5 : (xs___tespec_entry = (cons (1) ((cons (2) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> y)
|--
  “ ((0 + 1 ) = 3) ”
  &&  (sll p_pre xs___tespec_entry )
) \/
(
forall (p_pre: Z) (xs___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : (2 <= INT_MAX)) (PreH2 : (2 >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (p_pre <> 0)) (PreH6 : (p_pre = 4096)) (PreH7 : (xs___tespec_entry = (cons (1) ((cons (2) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 2)
|--
  “ (p_pre <> 0) ” 
  &&  “ (xs___tespec_entry = (cons (1) ((@nil Z)))) ” 
  &&  “ ((0 + 1 ) = 3) ”
  &&  emp
).

Definition sample_return_wit_1_split_goal_1 := 
forall (p_pre: Z) (xs___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : (2 <= INT_MAX)) (PreH2 : (2 >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (p_pre <> 0)) (PreH6 : (p_pre = 4096)) (PreH7 : (xs___tespec_entry = (cons (1) ((cons (2) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 2)
|--
  “ (p_pre <> 0) ”
.

Definition sample_return_wit_1_split_goal_2 := 
forall (p_pre: Z) (xs___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : (2 <= INT_MAX)) (PreH2 : (2 >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (p_pre <> 0)) (PreH6 : (p_pre = 4096)) (PreH7 : (xs___tespec_entry = (cons (1) ((cons (2) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 2)
|--
  “ (xs___tespec_entry = (cons (1) ((@nil Z)))) ”
.

Definition sample_return_wit_1_split_goal_3 := 
forall (p_pre: Z) (xs___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : (2 <= INT_MAX)) (PreH2 : (2 >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (p_pre <> 0)) (PreH6 : (p_pre = 4096)) (PreH7 : (xs___tespec_entry = (cons (1) ((cons (2) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 2)
|--
  “ ((0 + 1 ) = 3) ”
.

Definition sample_return_wit_1_split_goal_spatial := 
forall (p_pre: Z) (xs___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : (2 <= INT_MAX)) (PreH2 : (2 >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (p_pre <> 0)) (PreH6 : (p_pre = 4096)) (PreH7 : (xs___tespec_entry = (cons (1) ((cons (2) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 2)
|--
  TT && emp 
.

Definition sample_return_wit_2 := 
forall (p_pre: Z) (xs___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (p_pre <> 0)) (PreH5 : (p_pre = 4096)) (PreH6 : (xs___tespec_entry = (cons (1) ((cons (2) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> y)
|--
  “ (((0 + 1 ) + 2 ) = 3) ”
  &&  (sll p_pre xs___tespec_entry )
.

Definition sample_partial_solve_wit_1 := 
forall (p_pre: Z) (xs___tespec_entry: (@list Z)) (PreH1 : (p_pre <> 0)) (PreH2 : (p_pre = 4096)) (PreH3 : (xs___tespec_entry = (cons (1) ((cons (2) ((@nil Z))))))) ,
  (sll p_pre xs___tespec_entry )
|--
  EX (y: Z)  (y_2: Z) ,
  “ (y_2 = 0) ” 
  &&  “ (p_pre <> 0) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (xs___tespec_entry = (cons (1) ((cons (2) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> y)
.

Definition sample_precondition_wit_1 :=
exists (p_pre: Z) ,
exists (xs___tespec_entry: (@list Z)) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (xs___tespec_entry = (cons (1) ((cons (2) ((@nil Z)))))) ”
  &&  (sll p_pre xs___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_sample_safety_wit_1 : sample_safety_wit_1.
Axiom proof_of_sample_safety_wit_2 : sample_safety_wit_2.
Axiom proof_of_sample_safety_wit_3 : sample_safety_wit_3.
Axiom proof_of_sample_safety_wit_4 : sample_safety_wit_4.
Axiom proof_of_sample_safety_wit_5 : sample_safety_wit_5.
Axiom proof_of_sample_safety_wit_6 : sample_safety_wit_6.
Axiom proof_of_sample_safety_wit_7 : sample_safety_wit_7.
Axiom proof_of_sample_safety_wit_8 : sample_safety_wit_8.
Axiom proof_of_sample_return_wit_1 : sample_return_wit_1.
Axiom proof_of_sample_return_wit_2 : sample_return_wit_2.
Axiom proof_of_sample_partial_solve_wit_1 : sample_partial_solve_wit_1.
Axiom proof_of_sample_precondition_wit_1 : sample_precondition_wit_1.

End VC_Correct.
