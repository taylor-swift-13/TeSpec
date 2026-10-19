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
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function init_point -----*)

Definition init_point_safety_wit_1 := 
  ((( &( "p_spec_422" ) )) # Ptr  |-> (* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4120 + 4))
  **  ((( &( "p_spec_414" ) )) # Ptr  |-> 4120)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4120 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4120 + 4)) # Int  |->_)
|--
  TT && emp 
.

Definition init_point_safety_wit_2 := 
  ((( &( "p_spec_420" ) )) # Ptr  |-> (* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4120 + 0))
  **  ((( &( "p_spec_414" ) )) # Ptr  |-> 4120)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4120 + 0)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4120 + 4)) # Int  |->_)
|--
  TT && emp 
.

Definition init_point_entail_wit_1 := 
forall (p_pre: Z) (PreH1 : (p_pre = 4120)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> 0)
|--
  “ (p_pre = 4120) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> 0)
.

Definition init_point_entail_wit_2 := 
forall (p_pre: Z) (PreH1 : (p_pre = 4120)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |->_)
|--
  “ (p_pre = 4120) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |->_)
.

Definition init_point_return_wit_1 := 
forall (p_pre: Z) (PreH1 : (p_pre = 4120)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> 0)
|--
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> 0)
.

Definition init_point_partial_solve_wit_1 := 
forall (p_pre: Z) (PreH1 : (p_pre = 4120)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |->_)
|--
  “ (p_pre = 4120) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> 0)
.

Definition init_point_partial_solve_wit_2 := 
forall (p_pre: Z) (PreH1 : (p_pre = 4120)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |->_)
|--
  “ (p_pre = 4120) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |->_)
.

Definition init_point_precondition_wit_1 :=
exists (p_pre: Z) ,
~ ((  “ (p_pre = 4120) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |->_)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_init_point_safety_wit_1 : init_point_safety_wit_1.
Axiom proof_of_init_point_safety_wit_2 : init_point_safety_wit_2.
Axiom proof_of_init_point_entail_wit_1 : init_point_entail_wit_1.
Axiom proof_of_init_point_entail_wit_2 : init_point_entail_wit_2.
Axiom proof_of_init_point_return_wit_1 : init_point_return_wit_1.
Axiom proof_of_init_point_partial_solve_wit_1 : init_point_partial_solve_wit_1.
Axiom proof_of_init_point_partial_solve_wit_2 : init_point_partial_solve_wit_2.
Axiom proof_of_init_point_precondition_wit_1 : init_point_precondition_wit_1.

End VC_Correct.
