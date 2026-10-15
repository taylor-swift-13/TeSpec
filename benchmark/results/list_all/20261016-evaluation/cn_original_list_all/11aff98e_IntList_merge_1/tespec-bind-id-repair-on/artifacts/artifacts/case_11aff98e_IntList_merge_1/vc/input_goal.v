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

(*----- Function IntList_merge -----*)

Definition IntList_merge_safety_wit_1 := 
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y = 0)) ,
  ((( &( "ys_spec_667" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_666" ) )) # Ptr  |-> 0)
  **  ((( &( "zs_spec_657" ) )) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  ((( &( "xs_spec_589" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_586" ) )) # Ptr  |-> 16384)
|--
  TT && emp 
.

Definition IntList_merge_safety_wit_2 := 
forall (y: Z) (PreH1 : False) ,
  ((( &( "ys_spec_667" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_666" ) )) # Ptr  |-> 0)
  **  ((( &( "zs_spec_657" ) )) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  ((( &( "xs_spec_589" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_586" ) )) # Ptr  |-> 16384)
|--
  “ False ”
.

Definition IntList_merge_safety_wit_3 := 
  ((( &( "xs_spec_589" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_586" ) )) # Ptr  |-> 16384)
  **  (sll 8192 (cons (1) ((@nil Z))) )
  **  (sll 16384 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  TT && emp 
.

Definition IntList_merge_safety_wit_4 := 
forall (PreH1 : False) ,
  ((( &( "xs_spec_589" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_586" ) )) # Ptr  |-> 16384)
  **  (sll 8192 (cons (1) ((@nil Z))) )
  **  (sll 16384 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  “ False ”
.

Definition IntList_merge_safety_wit_5 := 
  ((( &( "xs_spec_589" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_586" ) )) # Ptr  |-> 16384)
  **  (sll 8192 (cons (1) ((@nil Z))) )
  **  (sll 16384 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  TT && emp 
.

Definition IntList_merge_safety_wit_6 := 
forall (PreH1 : False) ,
  ((( &( "xs_spec_589" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_586" ) )) # Ptr  |-> 16384)
  **  (sll 8192 (cons (1) ((@nil Z))) )
  **  (sll 16384 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  “ False ”
.

Definition IntList_merge_return_wit_1 := 
(
forall (ys_pre: Z) (xs_pre: Z) (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y = 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y = 0)) (PreH4 : (ys_pre <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (ys_pre = 16384)) (PreH8 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH9 : (r___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> ys_pre)
|--
  (sll xs_pre (cn_merge (l___tespec_entry) (r___tespec_entry)) )
) \/
(
forall (ys_pre: Z) (xs_pre: Z) (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : ((-1) <= INT_MAX)) (PreH2 : ((-1) >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y = 0)) (PreH6 : (ys_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (ys_pre = 16384)) (PreH10 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH11 : (r___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
|--
  EX (l0: (@list Z)) ,
  “ (ys_pre <> 0) ” 
  &&  “ (xs_pre <> 0) ” 
  &&  “ ((cn_merge (l___tespec_entry) (r___tespec_entry)) = (cons (1) ((cons (2) (l0))))) ”
  &&  (sll y_2 l0 )
).

Definition IntList_merge_partial_solve_wit_1 := 
forall (ys_pre: Z) (xs_pre: Z) (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (PreH1 : (ys_pre <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (xs_pre = 8192)) (PreH4 : (ys_pre = 16384)) (PreH5 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH6 : (r___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (sll xs_pre l___tespec_entry )
  **  (sll ys_pre r___tespec_entry )
|--
  EX (y: Z)  (y_2: Z)  (y_3: Z) ,
  “ (y_3 = 0) ” 
  &&  “ (y = 0) ” 
  &&  “ (ys_pre <> 0) ” 
  &&  “ (xs_pre <> 0) ” 
  &&  “ (xs_pre = 8192) ” 
  &&  “ (ys_pre = 16384) ” 
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ” 
  &&  “ (r___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
.

Definition IntList_merge_precondition_wit_1 :=
exists (ys_pre: Z) ,
exists (xs_pre: Z) ,
exists (r___tespec_entry: (@list Z)) ,
exists (l___tespec_entry: (@list Z)) ,
~ ((  “ (xs_pre = 8192) ” 
  &&  “ (ys_pre = 16384) ” 
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ” 
  &&  “ (r___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll xs_pre l___tespec_entry )
  **  (sll ys_pre r___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_merge_safety_wit_1 : IntList_merge_safety_wit_1.
Axiom proof_of_IntList_merge_safety_wit_2 : IntList_merge_safety_wit_2.
Axiom proof_of_IntList_merge_safety_wit_3 : IntList_merge_safety_wit_3.
Axiom proof_of_IntList_merge_safety_wit_4 : IntList_merge_safety_wit_4.
Axiom proof_of_IntList_merge_safety_wit_5 : IntList_merge_safety_wit_5.
Axiom proof_of_IntList_merge_safety_wit_6 : IntList_merge_safety_wit_6.
Axiom proof_of_IntList_merge_return_wit_1 : IntList_merge_return_wit_1.
Axiom proof_of_IntList_merge_partial_solve_wit_1 : IntList_merge_partial_solve_wit_1.
Axiom proof_of_IntList_merge_precondition_wit_1 : IntList_merge_precondition_wit_1.

End VC_Correct.
