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
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function top -----*)

Definition top_safety_wit_1 := 
forall (p_pre_size: Z) (PreH1 : (p_pre_size = 1)) ,
  ((( &( "p_spec_515" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # UInt  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> 8192)
  **  (sll 8192 (cons (0) ((@nil Z))) )
|--
  TT && emp 
.

Definition top_safety_wit_2 := 
forall (p_pre_size: Z) (PreH1 : False) ,
  ((( &( "p_spec_515" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # UInt  |-> p_pre_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> 8192)
  **  (sll 8192 (cons (0) ((@nil Z))) )
|--
  “ False ”
.

Definition top_return_wit_1 := 
forall (p_pre: Z) (l___tespec_entry: (@list Z)) (h___tespec_entry: Z) (d___tespec_entry: Z) (p_pre_size_2: Z) (y: Z) (PreH1 : (y = 0)) (PreH2 : (d___tespec_entry <> 0)) (PreH3 : (p_pre = 4096)) (PreH4 : (d___tespec_entry = 8192)) (PreH5 : (h___tespec_entry = 0)) (PreH6 : (l___tespec_entry = (@nil Z))) (PreH7 : ((((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH8 : (p_pre_size_2 = (((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) ))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (d___tespec_entry + 0)) # Int  |-> h___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (d___tespec_entry + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_pre_size_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
|--
  EX (p_pre_size: Z) ,
  “ (h___tespec_entry = h___tespec_entry) ” 
  &&  “ (p_pre_size = (((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_pre_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
  **  (sll d___tespec_entry (cons (h___tespec_entry) (l___tespec_entry)) )
.

Definition top_partial_solve_wit_1 := 
forall (p_pre: Z) (l___tespec_entry: (@list Z)) (h___tespec_entry: Z) (d___tespec_entry: Z) (p_pre_size: Z) (PreH1 : (d___tespec_entry <> 0)) (PreH2 : (p_pre = 4096)) (PreH3 : (d___tespec_entry = 8192)) (PreH4 : (h___tespec_entry = 0)) (PreH5 : (l___tespec_entry = (@nil Z))) (PreH6 : ((((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH7 : (p_pre_size = (((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) ))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_pre_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
  **  (sll d___tespec_entry (cons (h___tespec_entry) (l___tespec_entry)) )
|--
  EX (y: Z) ,
  “ (y = 0) ” 
  &&  “ (d___tespec_entry <> 0) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (d___tespec_entry = 8192) ” 
  &&  “ (h___tespec_entry = 0) ” 
  &&  “ (l___tespec_entry = (@nil Z)) ” 
  &&  “ ((((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) ) > 0) ” 
  &&  “ (p_pre_size = (((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (d___tespec_entry + 0)) # Int  |-> h___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (d___tespec_entry + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_pre_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
.

Definition top_precondition_wit_1 :=
exists (p_pre: Z) ,
exists (l___tespec_entry: (@list Z)) ,
exists (h___tespec_entry: Z) ,
exists (d___tespec_entry: Z) ,
~ ((  EX (p_pre_size: Z) ,
  “ (p_pre = 4096) ” 
  &&  “ (d___tespec_entry = 8192) ” 
  &&  “ (h___tespec_entry = 0) ” 
  &&  “ (l___tespec_entry = (@nil Z)) ” 
  &&  “ ((((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) ) > 0) ” 
  &&  “ (p_pre_size = (((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_pre_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
  **  (sll d___tespec_entry (cons (h___tespec_entry) (l___tespec_entry)) )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_top_safety_wit_1 : top_safety_wit_1.
Axiom proof_of_top_safety_wit_2 : top_safety_wit_2.
Axiom proof_of_top_return_wit_1 : top_return_wit_1.
Axiom proof_of_top_partial_solve_wit_1 : top_partial_solve_wit_1.
Axiom proof_of_top_precondition_wit_1 : top_precondition_wit_1.

End VC_Correct.
