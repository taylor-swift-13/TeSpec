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

(*----- Function IntList_length_acc_aux -----*)

Definition IntList_length_acc_aux_safety_wit_1 := 
forall (y: Z) (PreH1 : (y = 0)) ,
  ((( &( "p_spec_647" ) )) # Ptr  |-> 4096)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_619" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_616" ) )) # Ptr  |-> 4096)
  **  ((4096) # UInt  |-> 2)
|--
  TT && emp 
.

Definition IntList_length_acc_aux_safety_wit_2 := 
forall (PreH1 : False) ,
  ((( &( "p_spec_647" ) )) # Ptr  |-> 4096)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_619" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_616" ) )) # Ptr  |-> 4096)
  **  ((4096) # UInt  |-> 2)
|--
  “ False ”
.

Definition IntList_length_acc_aux_safety_wit_3 := 
  ((( &( "xs_spec_619" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_616" ) )) # Ptr  |-> 4096)
  **  ((4096) # UInt  |-> 1)
  **  (sll 8192 (cons (1) ((@nil Z))) )
|--
  TT && emp 
.

Definition IntList_length_acc_aux_safety_wit_4 := 
  ((( &( "xs_spec_619" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_616" ) )) # Ptr  |-> 4096)
  **  ((4096) # UInt  |-> 1)
  **  (sll 8192 (cons (1) ((@nil Z))) )
|--
  TT && emp 
.

Definition IntList_length_acc_aux_safety_wit_5 := 
forall (PreH1 : False) ,
  ((( &( "xs_spec_619" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_616" ) )) # Ptr  |-> 4096)
  **  ((4096) # UInt  |-> 1)
  **  (sll 8192 (cons (1) ((@nil Z))) )
|--
  “ False ”
.

Definition IntList_length_acc_aux_entail_wit_1 := 
forall (p_pre: Z) (xs_pre: Z) (l___tespec_entry: (@list Z)) (n___tespec_entry: Z) (y: Z) (PreH1 : (y = 0)) (PreH2 : (y = 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (xs_pre = 8192)) (PreH5 : (p_pre = 4096)) (PreH6 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH7 : (n___tespec_entry = 1)) (PreH8 : (0 <= n___tespec_entry)) (PreH9 : (n___tespec_entry <= UINT_MAX)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((p_pre) # UInt  |-> (n___tespec_entry + 1 ))
|--
  “ (y = 0) ” 
  &&  “ (xs_pre <> 0) ” 
  &&  “ (xs_pre = 8192) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ” 
  &&  “ (n___tespec_entry = 1) ” 
  &&  “ (0 <= n___tespec_entry) ” 
  &&  “ (n___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> (((n___tespec_entry + 1 ) + (Zlength ((@nil Z))) ) % ( 4294967296 ) ))
  **  (sll y (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
.

Definition IntList_length_acc_aux_return_wit_1 := 
forall (p_pre: Z) (xs_pre: Z) (l___tespec_entry: (@list Z)) (n___tespec_entry: Z) (y: Z) (PreH1 : (y = 0)) (PreH2 : (y = 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (xs_pre = 8192)) (PreH5 : (p_pre = 4096)) (PreH6 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH7 : (n___tespec_entry = 1)) (PreH8 : (0 <= n___tespec_entry)) (PreH9 : (n___tespec_entry <= UINT_MAX)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((p_pre) # UInt  |-> (n___tespec_entry + 1 ))
|--
  ((p_pre) # UInt  |-> ((n___tespec_entry + (Zlength (l___tespec_entry)) ) % ( 4294967296 ) ))
  **  (sll xs_pre l___tespec_entry )
.

Definition IntList_length_acc_aux_partial_solve_wit_1 := 
forall (p_pre: Z) (xs_pre: Z) (l___tespec_entry: (@list Z)) (n___tespec_entry: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (xs_pre = 8192)) (PreH3 : (p_pre = 4096)) (PreH4 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH5 : (n___tespec_entry = 1)) (PreH6 : (0 <= n___tespec_entry)) (PreH7 : (n___tespec_entry <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> (n___tespec_entry + 1 ))
  **  (sll xs_pre l___tespec_entry )
|--
  EX (y: Z) ,
  “ (y = 0) ” 
  &&  “ (xs_pre <> 0) ” 
  &&  “ (xs_pre = 8192) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ” 
  &&  “ (n___tespec_entry = 1) ” 
  &&  “ (0 <= n___tespec_entry) ” 
  &&  “ (n___tespec_entry <= UINT_MAX) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((p_pre) # UInt  |-> (n___tespec_entry + 1 ))
.

Definition IntList_length_acc_aux_partial_solve_wit_2_pure := 
forall (p_pre: Z) (xs_pre: Z) (l___tespec_entry: (@list Z)) (n___tespec_entry: Z) (y: Z) (PreH1 : (y = 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (xs_pre = 8192)) (PreH4 : (p_pre = 4096)) (PreH5 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH6 : (n___tespec_entry = 1)) (PreH7 : (0 <= n___tespec_entry)) (PreH8 : (n___tespec_entry <= UINT_MAX)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_619" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "p_spec_616" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # UInt  |-> (n___tespec_entry + 1 ))
|--
  “ (0 <= (n___tespec_entry + 1 )) ” 
  &&  “ ((n___tespec_entry + 1 ) <= UINT_MAX) ”
.

Definition IntList_length_acc_aux_partial_solve_wit_2_aux := 
forall (p_pre: Z) (xs_pre: Z) (l___tespec_entry: (@list Z)) (n___tespec_entry: Z) (y: Z) (PreH1 : (y = 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (xs_pre = 8192)) (PreH4 : (p_pre = 4096)) (PreH5 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH6 : (n___tespec_entry = 1)) (PreH7 : (0 <= n___tespec_entry)) (PreH8 : (n___tespec_entry <= UINT_MAX)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((p_pre) # UInt  |-> (n___tespec_entry + 1 ))
|--
  “ (0 <= (n___tespec_entry + 1 )) ” 
  &&  “ ((n___tespec_entry + 1 ) <= UINT_MAX) ” 
  &&  “ (y = 0) ” 
  &&  “ (xs_pre <> 0) ” 
  &&  “ (xs_pre = 8192) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ” 
  &&  “ (n___tespec_entry = 1) ” 
  &&  “ (0 <= n___tespec_entry) ” 
  &&  “ (n___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> (n___tespec_entry + 1 ))
  **  (sll y (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
.

Definition IntList_length_acc_aux_partial_solve_wit_2 := IntList_length_acc_aux_partial_solve_wit_2_pure -> IntList_length_acc_aux_partial_solve_wit_2_aux.

Definition IntList_length_acc_aux_precondition_wit_1 :=
exists (p_pre: Z) ,
exists (xs_pre: Z) ,
exists (l___tespec_entry: (@list Z)) ,
exists (n___tespec_entry: Z) ,
~ ((  “ (xs_pre = 8192) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ” 
  &&  “ (n___tespec_entry = 1) ” 
  &&  “ (0 <= n___tespec_entry) ” 
  &&  “ (n___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> n___tespec_entry)
  **  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_length_acc_aux_safety_wit_1 : IntList_length_acc_aux_safety_wit_1.
Axiom proof_of_IntList_length_acc_aux_safety_wit_2 : IntList_length_acc_aux_safety_wit_2.
Axiom proof_of_IntList_length_acc_aux_safety_wit_3 : IntList_length_acc_aux_safety_wit_3.
Axiom proof_of_IntList_length_acc_aux_safety_wit_4 : IntList_length_acc_aux_safety_wit_4.
Axiom proof_of_IntList_length_acc_aux_safety_wit_5 : IntList_length_acc_aux_safety_wit_5.
Axiom proof_of_IntList_length_acc_aux_entail_wit_1 : IntList_length_acc_aux_entail_wit_1.
Axiom proof_of_IntList_length_acc_aux_return_wit_1 : IntList_length_acc_aux_return_wit_1.
Axiom proof_of_IntList_length_acc_aux_partial_solve_wit_1 : IntList_length_acc_aux_partial_solve_wit_1.
Axiom proof_of_IntList_length_acc_aux_partial_solve_wit_2_pure : IntList_length_acc_aux_partial_solve_wit_2_pure.
Axiom proof_of_IntList_length_acc_aux_partial_solve_wit_2 : IntList_length_acc_aux_partial_solve_wit_2.
Axiom proof_of_IntList_length_acc_aux_precondition_wit_1 : IntList_length_acc_aux_precondition_wit_1.

End VC_Correct.
