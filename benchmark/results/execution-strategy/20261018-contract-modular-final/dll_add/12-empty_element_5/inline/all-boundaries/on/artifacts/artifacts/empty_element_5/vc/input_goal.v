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
Require Import DLLSupplement.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function add -----*)

Definition add_safety_wit_1 := 
forall (retval: Z) (PreH1 : (( &( "n_spec_467" ) ) = 4096)) (PreH2 : (( &( "element_spec_470" ) ) = 8192)) (PreH3 : (( &( "new_node_spec_491" ) ) = 12288)) (PreH4 : (retval = 16384)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> 5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (16384 + 8)) # Ptr  |-> 0)
  **  ((12288) # Ptr  |-> 16384)
  **  ((8192) # Int  |-> 5)
  **  ((4096) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition add_safety_wit_2 := 
forall (retval: Z) (PreH1 : (( &( "n_spec_467" ) ) = 4096)) (PreH2 : (( &( "element_spec_470" ) ) = 8192)) (PreH3 : (( &( "new_node_spec_491" ) ) = 12288)) (PreH4 : (retval = 16384)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> 5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (16384 + 8)) # Ptr  |-> 0)
  **  ((12288) # Ptr  |-> 16384)
  **  ((8192) # Int  |-> 5)
  **  ((4096) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition add_safety_wit_3 := 
forall (retval: Z) (PreH1 : (( &( "n_spec_467" ) ) = 4096)) (PreH2 : (( &( "element_spec_470" ) ) = 8192)) (PreH3 : (( &( "new_node_spec_491" ) ) = 12288)) (PreH4 : (retval = 16384)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> 5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (16384 + 8)) # Ptr  |->_)
  **  ((12288) # Ptr  |-> 16384)
  **  ((8192) # Int  |-> 5)
  **  ((4096) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition add_safety_wit_4 := 
forall (retval: Z) (PreH1 : (( &( "n_spec_467" ) ) = 4096)) (PreH2 : (( &( "element_spec_470" ) ) = 8192)) (PreH3 : (( &( "new_node_spec_491" ) ) = 12288)) (PreH4 : (retval = 16384)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> 5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (16384 + 8)) # Ptr  |->_)
  **  ((12288) # Ptr  |-> 16384)
  **  ((8192) # Int  |-> 5)
  **  ((4096) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition add_safety_wit_5 := 
forall (retval: Z) (PreH1 : (( &( "n_spec_467" ) ) = 4096)) (PreH2 : (( &( "element_spec_470" ) ) = 8192)) (PreH3 : (( &( "new_node_spec_491" ) ) = 12288)) (PreH4 : (retval = 16384)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> 5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (16384 + 8)) # Ptr  |-> 0)
  **  ((12288) # Ptr  |-> 16384)
  **  ((8192) # Int  |-> 5)
  **  ((4096) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition add_safety_wit_6 := 
forall (retval: Z) (PreH1 : False) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> 5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (retval + 8)) # Ptr  |-> 0)
  **  ((( &( "new_node_spec_491" ) )) # Ptr  |-> retval)
  **  ((( &( "element_spec_470" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_467" ) )) # Ptr  |-> 0)
|--
  “ False ”
.

Definition add_return_wit_1 := 
forall (n_pre: Z) (element_pre: Z) (lr___tespec_entry: (@list Z)) (ll___tespec_entry: (@list Z)) (q___tespec_entry: Z) (p___tespec_entry: Z) (h___tespec_entry: Z) (e___tespec_entry: Z) (retval: Z) (PreH1 : (n_pre = 0)) (PreH2 : (retval <> 0)) (PreH3 : (element_pre = 5)) (PreH4 : (n_pre = 0)) (PreH5 : (e___tespec_entry = 5)) (PreH6 : (h___tespec_entry = 0)) (PreH7 : (ll___tespec_entry = (@nil Z))) (PreH8 : (lr___tespec_entry = (@nil Z))) (PreH9 : (p___tespec_entry = 0)) (PreH10 : (q___tespec_entry = 0)) (PreH11 : (element_pre = e___tespec_entry)) (PreH12 : (n_pre = 0)) (PreH13 : (ll___tespec_entry = (@nil Z))) (PreH14 : (lr___tespec_entry = (@nil Z))) (PreH15 : (( &( "n_spec_467" ) ) = 4096)) (PreH16 : (( &( "element_spec_470" ) ) = 8192)) (PreH17 : (( &( "new_node_spec_491" ) ) = 12288)) (PreH18 : (0 <= retval)) (PreH19 : (retval <= UINT_MAX)) (PreH20 : (retval = 16384)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> element_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (retval + 8)) # Ptr  |-> 0)
|--
  (“ (n_pre = 0) ”
  &&  (Dll retval (@nil Z) e___tespec_entry (@nil Z) ))
  ||
  (“ (n_pre <> 0) ”
  &&  (Dll retval (cons (h___tespec_entry) (ll___tespec_entry)) e___tespec_entry lr___tespec_entry ))
.

Definition add_partial_solve_wit_1 := 
forall (n_pre: Z) (element_pre: Z) (lr___tespec_entry: (@list Z)) (ll___tespec_entry: (@list Z)) (q___tespec_entry: Z) (p___tespec_entry: Z) (h___tespec_entry: Z) (e___tespec_entry: Z) (PreH1 : (element_pre = 5)) (PreH2 : (n_pre = 0)) (PreH3 : (e___tespec_entry = 5)) (PreH4 : (h___tespec_entry = 0)) (PreH5 : (ll___tespec_entry = (@nil Z))) (PreH6 : (lr___tespec_entry = (@nil Z))) (PreH7 : (p___tespec_entry = 0)) (PreH8 : (q___tespec_entry = 0)) (PreH9 : (element_pre = e___tespec_entry)) (PreH10 : (n_pre = 0)) (PreH11 : (ll___tespec_entry = (@nil Z))) (PreH12 : (lr___tespec_entry = (@nil Z))) (PreH13 : (( &( "n_spec_467" ) ) = 4096)) (PreH14 : (( &( "element_spec_470" ) ) = 8192)) (PreH15 : (( &( "new_node_spec_491" ) ) = 12288)) ,
  TT && emp 
|--
  “ (element_pre = 5) ” 
  &&  “ (n_pre = 0) ” 
  &&  “ (e___tespec_entry = 5) ” 
  &&  “ (h___tespec_entry = 0) ” 
  &&  “ (ll___tespec_entry = (@nil Z)) ” 
  &&  “ (lr___tespec_entry = (@nil Z)) ” 
  &&  “ (p___tespec_entry = 0) ” 
  &&  “ (q___tespec_entry = 0) ” 
  &&  “ (element_pre = e___tespec_entry) ” 
  &&  “ (n_pre = 0) ” 
  &&  “ (ll___tespec_entry = (@nil Z)) ” 
  &&  “ (lr___tespec_entry = (@nil Z)) ” 
  &&  “ (( &( "n_spec_467" ) ) = 4096) ” 
  &&  “ (( &( "element_spec_470" ) ) = 8192) ” 
  &&  “ (( &( "new_node_spec_491" ) ) = 12288) ”
  &&  emp
.

Definition add_precondition_wit_1 :=
exists (n_pre: Z) ,
exists (element_pre: Z) ,
exists (lr___tespec_entry: (@list Z)) ,
exists (ll___tespec_entry: (@list Z)) ,
exists (q___tespec_entry: Z) ,
exists (p___tespec_entry: Z) ,
exists (h___tespec_entry: Z) ,
exists (e___tespec_entry: Z) ,
~ ((  “ (element_pre = 5) ” 
  &&  “ (n_pre = 0) ” 
  &&  “ (e___tespec_entry = 5) ” 
  &&  “ (h___tespec_entry = 0) ” 
  &&  “ (ll___tespec_entry = (@nil Z)) ” 
  &&  “ (lr___tespec_entry = (@nil Z)) ” 
  &&  “ (p___tespec_entry = 0) ” 
  &&  “ (q___tespec_entry = 0) ” 
  &&  “ (element_pre = e___tespec_entry) ” 
  &&  “ (n_pre = 0) ” 
  &&  “ (ll___tespec_entry = (@nil Z)) ” 
  &&  “ (lr___tespec_entry = (@nil Z)) ”
  &&  emp) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_add_safety_wit_1 : add_safety_wit_1.
Axiom proof_of_add_safety_wit_2 : add_safety_wit_2.
Axiom proof_of_add_safety_wit_3 : add_safety_wit_3.
Axiom proof_of_add_safety_wit_4 : add_safety_wit_4.
Axiom proof_of_add_safety_wit_5 : add_safety_wit_5.
Axiom proof_of_add_safety_wit_6 : add_safety_wit_6.
Axiom proof_of_add_return_wit_1 : add_return_wit_1.
Axiom proof_of_add_partial_solve_wit_1 : add_partial_solve_wit_1.
Axiom proof_of_add_precondition_wit_1 : add_precondition_wit_1.

End VC_Correct.
