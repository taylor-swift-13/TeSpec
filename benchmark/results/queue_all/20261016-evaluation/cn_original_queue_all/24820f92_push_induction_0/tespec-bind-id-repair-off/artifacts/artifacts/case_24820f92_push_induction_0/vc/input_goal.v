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
Require Import CNQueueGuarded.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function push_induction -----*)

Definition push_induction_safety_wit_1 := 
forall (PreH1 : False) ,
  ((( &( "front_spec_452" ) )) # Ptr  |-> 12288)
  **  ((( &( "p_spec_449" ) )) # Ptr  |-> 12288)
  **  (CNQueueAux 12288 12288 (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (12288 + 0)) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (12288 + 4)) # Ptr  |-> 16384)
|--
  “ False ”
.

Definition push_induction_return_wit_1 := 
forall (p_pre: Z) (front_pre: Z) (l___tespec_entry: (@list Z)) (y___tespec_entry: Z) (v___tespec_entry: Z) (PreH1 : (front_pre = p_pre)) (PreH2 : (front_pre = 12288)) (PreH3 : (p_pre = 12288)) (PreH4 : (l___tespec_entry = (@nil Z))) (PreH5 : (v___tespec_entry = 7)) (PreH6 : (y___tespec_entry = 16384)) (PreH7 : (p_pre <> 0)) (PreH8 : (front_pre <> y___tespec_entry)) (PreH9 : (y___tespec_entry <> 0)) ,
  (CNQueueAux front_pre p_pre l___tespec_entry )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> v___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> y___tespec_entry)
|--
  (CNQueueAux front_pre y___tespec_entry (app (l___tespec_entry) ((cons (v___tespec_entry) ((@nil Z))))) )
.

Definition push_induction_precondition_wit_1 :=
exists (p_pre: Z) ,
exists (front_pre: Z) ,
exists (l___tespec_entry: (@list Z)) ,
exists (y___tespec_entry: Z) ,
exists (v___tespec_entry: Z) ,
~ ((  “ (front_pre = 12288) ” 
  &&  “ (p_pre = 12288) ” 
  &&  “ (l___tespec_entry = (@nil Z)) ” 
  &&  “ (v___tespec_entry = 7) ” 
  &&  “ (y___tespec_entry = 16384) ” 
  &&  “ (p_pre <> 0) ” 
  &&  “ (front_pre <> y___tespec_entry) ” 
  &&  “ (y___tespec_entry <> 0) ”
  &&  (CNQueueAux front_pre p_pre l___tespec_entry )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> v___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> y___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_push_induction_safety_wit_1 : push_induction_safety_wit_1.
Axiom proof_of_push_induction_return_wit_1 : push_induction_return_wit_1.
Axiom proof_of_push_induction_precondition_wit_1 : push_induction_precondition_wit_1.

End VC_Correct.
