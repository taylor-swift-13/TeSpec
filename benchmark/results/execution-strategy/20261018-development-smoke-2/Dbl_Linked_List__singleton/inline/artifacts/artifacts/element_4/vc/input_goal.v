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

(*----- Function singleton -----*)

Definition singleton_safety_wit_1 := 
forall (retval: Z) (PreH1 : (( &( "element_spec_467" ) ) = 4096)) (PreH2 : (( &( "n_spec_478" ) ) = 8192)) (PreH3 : (retval = 12288)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (12288 + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (12288 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (12288 + 8)) # Ptr  |->_)
  **  ((8192) # Ptr  |-> 12288)
  **  ((4096) # Int  |-> 1)
|--
  TT && emp 
.

Definition singleton_safety_wit_2 := 
forall (retval: Z) (PreH1 : (( &( "element_spec_467" ) ) = 4096)) (PreH2 : (( &( "n_spec_478" ) ) = 8192)) (PreH3 : (retval = 12288)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (12288 + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (12288 + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (12288 + 8)) # Ptr  |->_)
  **  ((8192) # Ptr  |-> 12288)
  **  ((4096) # Int  |-> 1)
|--
  TT && emp 
.

Definition singleton_return_wit_1 := 
(
forall (element_pre: Z) (e___tespec_entry: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (element_pre = 1)) (PreH3 : (e___tespec_entry = 1)) (PreH4 : (element_pre = e___tespec_entry)) (PreH5 : (0 <= retval)) (PreH6 : (retval <= UINT_MAX)) (PreH7 : (( &( "element_spec_467" ) ) = 4096)) (PreH8 : (( &( "n_spec_478" ) ) = 8192)) (PreH9 : (retval = 12288)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> element_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (retval + 8)) # Ptr  |-> 0)
|--
  (Dll retval (@nil Z) e___tespec_entry (@nil Z) )
) \/
(
forall (element_pre: Z) (e___tespec_entry: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (element_pre = 1)) (PreH3 : (e___tespec_entry = 1)) (PreH4 : (element_pre = e___tespec_entry)) (PreH5 : (0 <= retval)) (PreH6 : (retval <= UINT_MAX)) (PreH7 : (( &( "element_spec_467" ) ) = 4096)) (PreH8 : (( &( "n_spec_478" ) ) = 8192)) (PreH9 : (retval = 12288)) ,
  TT && emp 
|--
  TT && emp 
).

Definition singleton_partial_solve_wit_1 := 
forall (element_pre: Z) (e___tespec_entry: Z) (PreH1 : (element_pre = 1)) (PreH2 : (e___tespec_entry = 1)) (PreH3 : (element_pre = e___tespec_entry)) ,
  TT && emp 
|--
  “ (element_pre = 1) ” 
  &&  “ (e___tespec_entry = 1) ” 
  &&  “ (element_pre = e___tespec_entry) ”
  &&  emp
.

Definition singleton_precondition_wit_1 :=
exists (element_pre: Z) ,
exists (e___tespec_entry: Z) ,
~ ((  “ (element_pre = 1) ” 
  &&  “ (e___tespec_entry = 1) ” 
  &&  “ (element_pre = e___tespec_entry) ”
  &&  emp) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_singleton_safety_wit_1 : singleton_safety_wit_1.
Axiom proof_of_singleton_safety_wit_2 : singleton_safety_wit_2.
Axiom proof_of_singleton_return_wit_1 : singleton_return_wit_1.
Axiom proof_of_singleton_partial_solve_wit_1 : singleton_partial_solve_wit_1.
Axiom proof_of_singleton_precondition_wit_1 : singleton_precondition_wit_1.

End VC_Correct.
