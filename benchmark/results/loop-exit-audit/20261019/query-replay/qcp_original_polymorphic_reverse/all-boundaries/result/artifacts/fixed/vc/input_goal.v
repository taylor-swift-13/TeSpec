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
Require Import BenchMemoryPayload.
Require Import SimpleC.EE.QCP_demos_human.poly_sll_lib.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function reverse -----*)

Definition reverse_safety_wit_1 := 
  ((( &( "w_spec_426" ) )) # Ptr  |->_)
  **  ((( &( "p_spec_412" ) )) # Ptr  |-> 4096)
  **  (sll int_payload 4096 (cons (0) ((@nil Z))) )
|--
  TT && emp 
.

Definition reverse_safety_wit_2 := 
forall (PreH1 : False) ,
  ((( &( "v_spec_429" ) )) # Ptr  |-> 4096)
  **  ((( &( "w_spec_426" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_412" ) )) # Ptr  |-> 4096)
  **  (sll int_payload 4096 (cons (0) ((@nil Z))) )
|--
  “ False ”
.

Definition reverse_safety_wit_3 := 
forall (y: Z) (h: Z) (PreH1 : (y <> 0)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> 0)
  **  (sll int_payload y (@nil Z) )
  **  (int_payload h 0 )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Ptr  |-> h)
  **  ((( &( "v_spec_429" ) )) # Ptr  |-> y)
  **  ((( &( "w_spec_426" ) )) # Ptr  |-> 4096)
  **  ((( &( "p_spec_412" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition reverse_entail_wit_1 := 
(
forall (y: Z) (h: Z) ,
  ((4100) # Ptr  |-> 0)
  **  (sll int_payload y (@nil Z) )
  **  (int_payload h 0 )
  **  ((4096) # Ptr  |-> h)
|--
  EX (l1: (@list Z))  (l2: (@list Z)) ,
  “ ((cons (0) ((@nil Z))) = (app ((rev (l1))) (l2))) ”
  &&  (sll int_payload 4096 l1 )
  **  (sll int_payload y l2 )
) \/
(
forall (h: Z) ,
  ((4100) # Ptr  |-> 0)
  **  (int_payload h 0 )
  **  ((4096) # Ptr  |-> h)
|--
  EX (l1: (@list Z)) ,
  “ ((cons (0) ((@nil Z))) = (app ((rev (l1))) ((@nil Z)))) ”
  &&  (sll int_payload 4096 l1 )
).

Definition reverse_entail_wit_2 := 
  (sll int_payload 4096 (cons (0) ((@nil Z))) )
|--
  EX (l1: (@list Z))  (l2: (@list Z)) ,
  “ ((cons (0) ((@nil Z))) = (app ((rev (l1))) (l2))) ”
  &&  (sll int_payload 0 l1 )
  **  (sll int_payload 4096 l2 )
.

Definition reverse_return_wit_1 := 
forall (p_pre: Z) (l___tespec_entry: (@list Z)) (storeA___tespec_entry: (Z -> (Z -> Assertion))) (y: Z) (h: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (l___tespec_entry = (cons (0) ((@nil Z))))) (PreH3 : (storeA___tespec_entry = int_payload)) (PreH4 : (p_pre <> 0)) (PreH5 : (y = 0)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> 0)
  **  (sll storeA___tespec_entry y (@nil Z) )
  **  (storeA___tespec_entry h 0 )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Ptr  |-> h)
|--
  (sll storeA___tespec_entry p_pre (rev (l___tespec_entry)) )
.

Definition reverse_partial_solve_wit_1 := 
forall (p_pre: Z) (l___tespec_entry: (@list Z)) (storeA___tespec_entry: (Z -> (Z -> Assertion))) (PreH1 : (p_pre = 4096)) (PreH2 : (l___tespec_entry = (cons (0) ((@nil Z))))) (PreH3 : (storeA___tespec_entry = int_payload)) (PreH4 : (p_pre <> 0)) ,
  (sll storeA___tespec_entry p_pre l___tespec_entry )
|--
  EX (y: Z)  (h: Z) ,
  “ (p_pre = 4096) ” 
  &&  “ (l___tespec_entry = (cons (0) ((@nil Z)))) ” 
  &&  “ (storeA___tespec_entry = int_payload) ” 
  &&  “ (p_pre <> 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> y)
  **  (sll storeA___tespec_entry y (@nil Z) )
  **  (storeA___tespec_entry h 0 )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Ptr  |-> h)
.

Definition reverse_which_implies_wit_1 := 
forall (storeA___tespec_entry: (Z -> (Z -> Assertion))) (l2: (@list Z)) (v: Z) (PreH1 : (v <> 0)) ,
  (sll storeA___tespec_entry v l2 )
|--
  EX (v_next: Z)  (v_data: Z)  (x: Z)  (xs: (@list Z)) ,
  “ (l2 = (cons (x) (xs))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (v + 0)) # Ptr  |-> v_data)
  **  (storeA___tespec_entry v_data x )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (v + 4)) # Ptr  |-> v_next)
  **  (sll storeA___tespec_entry v_next xs )
.

Definition reverse_precondition_wit_1 :=
exists (p_pre: Z) ,
exists (l___tespec_entry: (@list Z)) ,
exists (storeA___tespec_entry: (Z -> (Z -> Assertion))) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (l___tespec_entry = (cons (0) ((@nil Z)))) ” 
  &&  “ (storeA___tespec_entry = int_payload) ”
  &&  (sll storeA___tespec_entry p_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_reverse_safety_wit_1 : reverse_safety_wit_1.
Axiom proof_of_reverse_safety_wit_2 : reverse_safety_wit_2.
Axiom proof_of_reverse_safety_wit_3 : reverse_safety_wit_3.
Axiom proof_of_reverse_entail_wit_1 : reverse_entail_wit_1.
Axiom proof_of_reverse_entail_wit_2 : reverse_entail_wit_2.
Axiom proof_of_reverse_return_wit_1 : reverse_return_wit_1.
Axiom proof_of_reverse_partial_solve_wit_1 : reverse_partial_solve_wit_1.
Axiom proof_of_reverse_which_implies_wit_1 : reverse_which_implies_wit_1.
Axiom proof_of_reverse_precondition_wit_1 : reverse_precondition_wit_1.

End VC_Correct.
