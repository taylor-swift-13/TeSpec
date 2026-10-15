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
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_length -----*)

Definition IntList_length_safety_wit_1 := 
  ((( &( "xs_spec_457" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  TT && emp 
.

Definition IntList_length_safety_wit_2 := 
forall (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) ,
  ((( &( "xs_spec_648" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "xs_spec_457" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_length_safety_wit_3 := 
forall (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) ,
  ((( &( "xs_spec_653" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_648" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "xs_spec_457" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_length_safety_wit_4 := 
forall (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) ,
  ((( &( "xs_spec_653" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_648" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "xs_spec_457" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_length_safety_wit_5 := 
forall (y: Z) (PreH1 : False) ,
  ((( &( "xs_spec_653" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_648" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "xs_spec_457" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_length_safety_wit_6 := 
forall (y: Z) (y_2: Z) (PreH1 : (y = 0)) (PreH2 : (y_2 = 0)) ,
  ((( &( "xs_spec_648" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "xs_spec_457" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_length_safety_wit_7 := 
forall (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) ,
  ((( &( "xs_spec_648" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "xs_spec_457" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_length_safety_wit_8 := 
  ((( &( "xs_spec_457" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  TT && emp 
.

Definition IntList_length_safety_wit_9 := 
forall (PreH1 : False) ,
  ((( &( "xs_spec_457" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  “ False ”
.

Definition IntList_length_entail_wit_1 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre = 8192)) (PreH6 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  ((( &( "xs_spec_457" ) )) # Ptr  |-> xs_pre)
|--
  EX (retval: Z) ,
  “ (retval = 0) ” 
  &&  “ (retval = ((Zlength ((@nil Z))) % ( 4294967296 ) )) ” 
  &&  “ (y <> 0) ” 
  &&  “ (y_2 = 0) ” 
  &&  “ (xs_pre <> 0) ” 
  &&  “ (xs_pre = 8192) ” 
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll y_2 (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  ((( &( "xs_spec_457" ) )) # Ptr  |-> xs_pre)
.

Definition IntList_length_return_wit_1 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre = 8192)) (PreH6 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  “ ((1 + (1 + 0 ) ) = ((Zlength (l___tespec_entry)) % ( 4294967296 ) )) ”
  &&  (sll xs_pre l___tespec_entry )
.

Definition IntList_length_return_wit_2 := 
(
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : (y = 0)) (PreH2 : (y_2 = 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (xs_pre = 8192)) (PreH5 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  “ ((1 + 0 ) = ((Zlength (l___tespec_entry)) % ( 4294967296 ) )) ”
  &&  (sll xs_pre l___tespec_entry )
) \/
(
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : ((-1) <= INT_MAX)) (PreH2 : ((-1) >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
|--
  “ (xs_pre <> 0) ” 
  &&  “ (l___tespec_entry = (cons (2) ((@nil Z)))) ” 
  &&  “ ((1 + 0 ) = ((Zlength (l___tespec_entry)) % ( 4294967296 ) )) ”
  &&  emp
).

Definition IntList_length_return_wit_2_split_goal_1 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : ((-1) <= INT_MAX)) (PreH2 : ((-1) >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
|--
  “ (xs_pre <> 0) ”
.

Definition IntList_length_return_wit_2_split_goal_2 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : ((-1) <= INT_MAX)) (PreH2 : ((-1) >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
|--
  “ (l___tespec_entry = (cons (2) ((@nil Z)))) ”
.

Definition IntList_length_return_wit_2_split_goal_3 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : ((-1) <= INT_MAX)) (PreH2 : ((-1) >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
|--
  “ ((1 + 0 ) = ((Zlength (l___tespec_entry)) % ( 4294967296 ) )) ”
.

Definition IntList_length_return_wit_2_split_goal_spatial := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : ((-1) <= INT_MAX)) (PreH2 : ((-1) >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
|--
  TT && emp 
.

Definition IntList_length_partial_solve_wit_1 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (PreH1 : (xs_pre <> 0)) (PreH2 : (xs_pre = 8192)) (PreH3 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (sll xs_pre l___tespec_entry )
|--
  EX (y: Z)  (y_2: Z) ,
  “ (y_2 = 0) ” 
  &&  “ (xs_pre <> 0) ” 
  &&  “ (xs_pre = 8192) ” 
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
.

Definition IntList_length_partial_solve_wit_2 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (xs_pre = 8192)) (PreH5 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  ((( &( "xs_spec_457" ) )) # Ptr  |-> xs_pre)
|--
  “ (y <> 0) ” 
  &&  “ (y_2 = 0) ” 
  &&  “ (xs_pre <> 0) ” 
  &&  “ (xs_pre = 8192) ” 
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll y_2 (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  ((( &( "xs_spec_457" ) )) # Ptr  |-> xs_pre)
.

Definition IntList_length_precondition_wit_1 :=
exists (xs_pre: Z) ,
exists (l___tespec_entry: (@list Z)) ,
~ ((  “ (xs_pre = 8192) ” 
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_length_safety_wit_1 : IntList_length_safety_wit_1.
Axiom proof_of_IntList_length_safety_wit_2 : IntList_length_safety_wit_2.
Axiom proof_of_IntList_length_safety_wit_3 : IntList_length_safety_wit_3.
Axiom proof_of_IntList_length_safety_wit_4 : IntList_length_safety_wit_4.
Axiom proof_of_IntList_length_safety_wit_5 : IntList_length_safety_wit_5.
Axiom proof_of_IntList_length_safety_wit_6 : IntList_length_safety_wit_6.
Axiom proof_of_IntList_length_safety_wit_7 : IntList_length_safety_wit_7.
Axiom proof_of_IntList_length_safety_wit_8 : IntList_length_safety_wit_8.
Axiom proof_of_IntList_length_safety_wit_9 : IntList_length_safety_wit_9.
Axiom proof_of_IntList_length_entail_wit_1 : IntList_length_entail_wit_1.
Axiom proof_of_IntList_length_return_wit_1 : IntList_length_return_wit_1.
Axiom proof_of_IntList_length_return_wit_2 : IntList_length_return_wit_2.
Axiom proof_of_IntList_length_partial_solve_wit_1 : IntList_length_partial_solve_wit_1.
Axiom proof_of_IntList_length_partial_solve_wit_2 : IntList_length_partial_solve_wit_2.
Axiom proof_of_IntList_length_precondition_wit_1 : IntList_length_precondition_wit_1.

End VC_Correct.
