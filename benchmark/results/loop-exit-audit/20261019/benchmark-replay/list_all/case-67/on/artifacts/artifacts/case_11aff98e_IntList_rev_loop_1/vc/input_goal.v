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

(*----- Function IntList_rev_loop -----*)

Definition IntList_rev_loop_safety_wit_1 := 
  ((( &( "last_spec_639" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_566" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (1) ((@nil Z))) )
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_2 := 
  ((( &( "cur_spec_642" ) )) # Ptr  |-> 8192)
  **  ((( &( "last_spec_639" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_566" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (1) ((@nil Z))) )
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_3 := 
  ((( &( "cur_spec_642" ) )) # Ptr  |-> 8192)
  **  ((( &( "last_spec_639" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_566" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (1) ((@nil Z))) )
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_4 := 
forall (PreH1 : False) ,
  ((( &( "cur_spec_642" ) )) # Ptr  |-> 8192)
  **  ((( &( "last_spec_639" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_566" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (1) ((@nil Z))) )
|--
  “ False ”
.

Definition IntList_rev_loop_safety_wit_5 := 
forall (y: Z) (PreH1 : (y = 0)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "cur_spec_642" ) )) # Ptr  |-> 0)
  **  ((( &( "last_spec_639" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_566" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_6 := 
forall (y: Z) (PreH1 : (y = 0)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "cur_spec_642" ) )) # Ptr  |-> 0)
  **  ((( &( "last_spec_639" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_566" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_7 := 
forall (PreH1 : False) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "cur_spec_642" ) )) # Ptr  |-> 0)
  **  ((( &( "last_spec_639" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_566" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_rev_loop_entail_wit_1 := 
(
forall (y: Z) (PreH1 : (y = 0)) ,
  ((8196) # Ptr  |-> 0)
  **  ((8192) # Int  |-> 1)
|--
  EX (l2: (@list Z))  (l1: (@list Z)) ,
  “ ((app ((rev (l2))) (l1)) = (cons (1) ((@nil Z)))) ”
  &&  (sll 8192 l1 )
  **  (sll 0 l2 )
) \/
(
forall (y: Z) (PreH1 : (1 <= INT_MAX)) (PreH2 : (1 >= INT_MIN)) (PreH3 : (y = 0)) ,
  ((8196) # Ptr  |-> 0)
  **  ((8192) # Int  |-> 1)
|--
  EX (l1: (@list Z)) ,
  “ ((app ((rev ((@nil Z)))) (l1)) = (cons (1) ((@nil Z)))) ”
  &&  (sll 8192 l1 )
).

Definition IntList_rev_loop_entail_wit_2 := 
  (sll 8192 (cons (1) ((@nil Z))) )
|--
  EX (l2: (@list Z))  (l1: (@list Z)) ,
  “ ((app ((rev (l2))) (l1)) = (cons (1) ((@nil Z)))) ”
  &&  (sll 0 l1 )
  **  (sll 8192 l2 )
.

Definition IntList_rev_loop_return_wit_1 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (PreH1 : (y = 0)) (PreH2 : (y = 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (xs_pre = 8192)) (PreH5 : (l___tespec_entry = (cons (1) ((@nil Z))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  (sll xs_pre (rev (l___tespec_entry)) )
.

Definition IntList_rev_loop_partial_solve_wit_1 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (PreH1 : (xs_pre <> 0)) (PreH2 : (xs_pre = 8192)) (PreH3 : (l___tespec_entry = (cons (1) ((@nil Z))))) ,
  (sll xs_pre l___tespec_entry )
|--
  EX (y: Z) ,
  “ (y = 0) ” 
  &&  “ (xs_pre <> 0) ” 
  &&  “ (xs_pre = 8192) ” 
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
.

Definition IntList_rev_loop_precondition_wit_1 :=
exists (xs_pre: Z) ,
exists (l___tespec_entry: (@list Z)) ,
~ ((  “ (xs_pre = 8192) ” 
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_rev_loop_safety_wit_1 : IntList_rev_loop_safety_wit_1.
Axiom proof_of_IntList_rev_loop_safety_wit_2 : IntList_rev_loop_safety_wit_2.
Axiom proof_of_IntList_rev_loop_safety_wit_3 : IntList_rev_loop_safety_wit_3.
Axiom proof_of_IntList_rev_loop_safety_wit_4 : IntList_rev_loop_safety_wit_4.
Axiom proof_of_IntList_rev_loop_safety_wit_5 : IntList_rev_loop_safety_wit_5.
Axiom proof_of_IntList_rev_loop_safety_wit_6 : IntList_rev_loop_safety_wit_6.
Axiom proof_of_IntList_rev_loop_safety_wit_7 : IntList_rev_loop_safety_wit_7.
Axiom proof_of_IntList_rev_loop_entail_wit_1 : IntList_rev_loop_entail_wit_1.
Axiom proof_of_IntList_rev_loop_entail_wit_2 : IntList_rev_loop_entail_wit_2.
Axiom proof_of_IntList_rev_loop_return_wit_1 : IntList_rev_loop_return_wit_1.
Axiom proof_of_IntList_rev_loop_partial_solve_wit_1 : IntList_rev_loop_partial_solve_wit_1.
Axiom proof_of_IntList_rev_loop_precondition_wit_1 : IntList_rev_loop_precondition_wit_1.

End VC_Correct.
