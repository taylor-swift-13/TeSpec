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

(*----- Function IntList_rev -----*)

Definition IntList_rev_safety_wit_1 := 
  ((( &( "xs_spec_479" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (1) ((@nil Z))) )
|--
  TT && emp 
.

Definition IntList_rev_safety_wit_2 := 
forall (y: Z) (PreH1 : (y = 0)) ,
  ((( &( "ys_spec_663" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_662" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "tmp_spec_649" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_644" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_643" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_479" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_rev_safety_wit_3 := 
forall (PreH1 : False) ,
  ((( &( "ys_spec_663" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_662" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "tmp_spec_649" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_644" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_643" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_479" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_rev_safety_wit_4 := 
  ((( &( "ys_spec_644" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_643" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_479" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (1) ((@nil Z))) )
|--
  TT && emp 
.

Definition IntList_rev_safety_wit_5 := 
forall (PreH1 : False) ,
  ((( &( "ys_spec_644" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_643" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_479" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (1) ((@nil Z))) )
|--
  “ False ”
.

Definition IntList_rev_entail_wit_1 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (PreH1 : (y = 0)) (PreH2 : (y = 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (xs_pre = 8192)) (PreH5 : (l___tespec_entry = (cons (1) ((@nil Z))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  EX (retval: Z) ,
  “ (retval = xs_pre) ” 
  &&  “ (y = 0) ” 
  &&  “ (xs_pre <> 0) ” 
  &&  “ (xs_pre = 8192) ” 
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll retval (app ((rev ((@nil Z)))) ((cons (1) ((@nil Z))))) )
.

Definition IntList_rev_entail_wit_2 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (PreH1 : (y = 0)) (PreH2 : (y = 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (xs_pre = 8192)) (PreH5 : (l___tespec_entry = (cons (1) ((@nil Z))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  EX (retval: Z) ,
  “ (retval = xs_pre) ” 
  &&  “ (xs_pre = 8192) ” 
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll retval (app ((rev (l___tespec_entry))) ((@nil Z))) )
.

Definition IntList_rev_return_wit_1 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (PreH1 : (y = 0)) (PreH2 : (y = 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (xs_pre = 8192)) (PreH5 : (l___tespec_entry = (cons (1) ((@nil Z))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  (sll xs_pre (rev (l___tespec_entry)) )
.

Definition IntList_rev_partial_solve_wit_1 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (PreH1 : (xs_pre = 8192)) (PreH2 : (l___tespec_entry = (cons (1) ((@nil Z))))) ,
  (sll xs_pre l___tespec_entry )
|--
  “ (xs_pre = 8192) ” 
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll 0 (@nil Z) )
  **  (sll xs_pre l___tespec_entry )
.

Definition IntList_rev_partial_solve_wit_2 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (PreH1 : (y = 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (xs_pre = 8192)) (PreH4 : (l___tespec_entry = (cons (1) ((@nil Z))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  “ (y = 0) ” 
  &&  “ (xs_pre <> 0) ” 
  &&  “ (xs_pre = 8192) ” 
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll xs_pre (cons (1) ((@nil Z))) )
  **  (sll y (@nil Z) )
.

Definition IntList_rev_partial_solve_wit_3 := 
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

Definition IntList_rev_precondition_wit_1 :=
exists (xs_pre: Z) ,
exists (l___tespec_entry: (@list Z)) ,
~ ((  “ (xs_pre = 8192) ” 
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_rev_safety_wit_1 : IntList_rev_safety_wit_1.
Axiom proof_of_IntList_rev_safety_wit_2 : IntList_rev_safety_wit_2.
Axiom proof_of_IntList_rev_safety_wit_3 : IntList_rev_safety_wit_3.
Axiom proof_of_IntList_rev_safety_wit_4 : IntList_rev_safety_wit_4.
Axiom proof_of_IntList_rev_safety_wit_5 : IntList_rev_safety_wit_5.
Axiom proof_of_IntList_rev_entail_wit_1 : IntList_rev_entail_wit_1.
Axiom proof_of_IntList_rev_entail_wit_2 : IntList_rev_entail_wit_2.
Axiom proof_of_IntList_rev_return_wit_1 : IntList_rev_return_wit_1.
Axiom proof_of_IntList_rev_partial_solve_wit_1 : IntList_rev_partial_solve_wit_1.
Axiom proof_of_IntList_rev_partial_solve_wit_2 : IntList_rev_partial_solve_wit_2.
Axiom proof_of_IntList_rev_partial_solve_wit_3 : IntList_rev_partial_solve_wit_3.
Axiom proof_of_IntList_rev_precondition_wit_1 : IntList_rev_precondition_wit_1.

End VC_Correct.
