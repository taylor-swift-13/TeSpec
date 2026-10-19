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
From QCIPLib.xizi.xizi_single_link_common Require Import xizi_single_link_lib.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function xizi_single_link_empty -----*)

Definition xizi_single_link_empty_safety_wit_1 := 
forall (q: Z) (PreH1 : (q = 0)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Ptr  |-> 0)
  **  ((( &( "linklist_spec_416" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition xizi_single_link_empty_safety_wit_2 := 
forall (PreH1 : False) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Ptr  |-> 0)
  **  ((( &( "linklist_spec_416" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition xizi_single_link_empty_return_wit_1 := 
forall (linklist_pre: Z) (l___tespec_entry: (@list Z)) (q: Z) (PreH1 : (q = 0)) (PreH2 : (q = 0)) (PreH3 : (linklist_pre <> 0)) (PreH4 : (linklist_pre = 8192)) (PreH5 : (l___tespec_entry = (@nil Z))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (linklist_pre + 0)) # Ptr  |-> q)
|--
  (“ (l___tespec_entry <> (@nil Z)) ” 
  &&  “ (1 = 0) ”
  &&  (xizi_sll_head linklist_pre l___tespec_entry ))
  ||
  (“ (l___tespec_entry = (@nil Z)) ” 
  &&  “ (1 = 1) ”
  &&  (xizi_sll_head linklist_pre l___tespec_entry ))
.

Definition xizi_single_link_empty_partial_solve_wit_1 := 
forall (linklist_pre: Z) (l___tespec_entry: (@list Z)) (PreH1 : (linklist_pre = 8192)) (PreH2 : (l___tespec_entry = (@nil Z))) ,
  (xizi_sll_head linklist_pre l___tespec_entry )
|--
  EX (q: Z) ,
  “ (q = 0) ” 
  &&  “ (linklist_pre <> 0) ” 
  &&  “ (linklist_pre = 8192) ” 
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (linklist_pre + 0)) # Ptr  |-> q)
.

Definition xizi_single_link_empty_precondition_wit_1 :=
exists (linklist_pre: Z) ,
exists (l___tespec_entry: (@list Z)) ,
~ ((  “ (linklist_pre = 8192) ” 
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  (xizi_sll_head linklist_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_xizi_single_link_empty_safety_wit_1 : xizi_single_link_empty_safety_wit_1.
Axiom proof_of_xizi_single_link_empty_safety_wit_2 : xizi_single_link_empty_safety_wit_2.
Axiom proof_of_xizi_single_link_empty_return_wit_1 : xizi_single_link_empty_return_wit_1.
Axiom proof_of_xizi_single_link_empty_partial_solve_wit_1 : xizi_single_link_empty_partial_solve_wit_1.
Axiom proof_of_xizi_single_link_empty_precondition_wit_1 : xizi_single_link_empty_precondition_wit_1.

End VC_Correct.
