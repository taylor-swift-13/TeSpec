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
forall (y: Z) (a: Z) (y_2: Z) (PreH1 : False) ,
  ((( &( "p_spec_506" ) )) # Ptr  |-> 12288)
  **  ((( &( "front_spec_505" ) )) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> a)
  **  ((( &( "p_spec_494" ) )) # Ptr  |-> 12288)
  **  ((( &( "front_spec_493" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "front_spec_452" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_449" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (12288 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (12288 + 4)) # Ptr  |-> 16384)
|--
  “ False ”
.

Definition push_induction_safety_wit_2 := 
forall (y: Z) (a: Z) (PreH1 : False) ,
  ((( &( "p_spec_506" ) )) # Ptr  |-> 12288)
  **  ((( &( "front_spec_505" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> a)
  **  ((( &( "p_spec_494" ) )) # Ptr  |-> 12288)
  **  ((( &( "front_spec_493" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "front_spec_452" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_449" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (12288 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (12288 + 4)) # Ptr  |-> 16384)
|--
  “ False ”
.

Definition push_induction_safety_wit_3 := 
forall (PreH1 : False) ,
  ((( &( "front_spec_452" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_449" ) )) # Ptr  |-> 12288)
  **  (CNQueueAux 8192 12288 (cons (1) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (12288 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (12288 + 4)) # Ptr  |-> 16384)
|--
  “ False ”
.

Definition push_induction_return_wit_1 := 
forall (p_pre: Z) (front_pre: Z) (l___tespec_entry: (@list Z)) (y___tespec_entry: Z) (v___tespec_entry: Z) (a: Z) (tl: (@list Z)) (y: Z) (PreH1 : (y = p_pre)) (PreH2 : (y <> 0)) (PreH3 : (front_pre <> 0)) (PreH4 : (l___tespec_entry = (cons (a) (tl)))) (PreH5 : (front_pre <> p_pre)) (PreH6 : (front_pre = 8192)) (PreH7 : (p_pre = 12288)) (PreH8 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH9 : (v___tespec_entry = (INT_MIN))) (PreH10 : (y___tespec_entry = 16384)) (PreH11 : (p_pre <> 0)) (PreH12 : (front_pre <> y___tespec_entry)) (PreH13 : (y___tespec_entry <> 0)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (front_pre + 4)) # Ptr  |-> y)
  **  (CNQueueAux y p_pre tl )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (front_pre + 0)) # Int  |-> a)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> v___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> y___tespec_entry)
|--
  (CNQueueAux front_pre y___tespec_entry (app (l___tespec_entry) ((cons (v___tespec_entry) ((@nil Z))))) )
.

Definition push_induction_partial_solve_wit_1 := 
forall (p_pre: Z) (front_pre: Z) (l___tespec_entry: (@list Z)) (y___tespec_entry: Z) (v___tespec_entry: Z) (PreH1 : (front_pre <> p_pre)) (PreH2 : (front_pre = 8192)) (PreH3 : (p_pre = 12288)) (PreH4 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH5 : (v___tespec_entry = (INT_MIN))) (PreH6 : (y___tespec_entry = 16384)) (PreH7 : (p_pre <> 0)) (PreH8 : (front_pre <> y___tespec_entry)) (PreH9 : (y___tespec_entry <> 0)) ,
  (CNQueueAux front_pre p_pre l___tespec_entry )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> v___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> y___tespec_entry)
|--
  EX (a: Z)  (tl: (@list Z))  (y: Z) ,
  “ (y <> 0) ” 
  &&  “ (front_pre <> 0) ” 
  &&  “ (l___tespec_entry = (cons (a) (tl))) ” 
  &&  “ (front_pre <> p_pre) ” 
  &&  “ (front_pre = 8192) ” 
  &&  “ (p_pre = 12288) ” 
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ” 
  &&  “ (v___tespec_entry = (INT_MIN)) ” 
  &&  “ (y___tespec_entry = 16384) ” 
  &&  “ (p_pre <> 0) ” 
  &&  “ (front_pre <> y___tespec_entry) ” 
  &&  “ (y___tespec_entry <> 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (front_pre + 4)) # Ptr  |-> y)
  **  (CNQueueAux y p_pre tl )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (front_pre + 0)) # Int  |-> a)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> v___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> y___tespec_entry)
.

Definition push_induction_partial_solve_wit_2 := 
forall (p_pre: Z) (front_pre: Z) (l___tespec_entry: (@list Z)) (y___tespec_entry: Z) (v___tespec_entry: Z) (a: Z) (tl: (@list Z)) (y: Z) (PreH1 : (y <> p_pre)) (PreH2 : (y <> 0)) (PreH3 : (front_pre <> 0)) (PreH4 : (l___tespec_entry = (cons (a) (tl)))) (PreH5 : (front_pre <> p_pre)) (PreH6 : (front_pre = 8192)) (PreH7 : (p_pre = 12288)) (PreH8 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH9 : (v___tespec_entry = (INT_MIN))) (PreH10 : (y___tespec_entry = 16384)) (PreH11 : (p_pre <> 0)) (PreH12 : (front_pre <> y___tespec_entry)) (PreH13 : (y___tespec_entry <> 0)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (front_pre + 4)) # Ptr  |-> y)
  **  (CNQueueAux y p_pre tl )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (front_pre + 0)) # Int  |-> a)
  **  ((( &( "front_spec_452" ) )) # Ptr  |-> front_pre)
  **  ((( &( "p_spec_449" ) )) # Ptr  |-> p_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> v___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> y___tespec_entry)
|--
  EX (a_2: Z)  (tl_2: (@list Z))  (y_2: Z) ,
  “ (tl_2 = (@nil Z)) ” 
  &&  “ (y_2 <> 0) ” 
  &&  “ (y <> 0) ” 
  &&  “ (tl = (cons (a_2) (tl_2))) ” 
  &&  “ (y <> p_pre) ” 
  &&  “ (y <> 0) ” 
  &&  “ (front_pre <> 0) ” 
  &&  “ (l___tespec_entry = (cons (a) (tl))) ” 
  &&  “ (front_pre <> p_pre) ” 
  &&  “ (front_pre = 8192) ” 
  &&  “ (p_pre = 12288) ” 
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ” 
  &&  “ (v___tespec_entry = (INT_MIN)) ” 
  &&  “ (y___tespec_entry = 16384) ” 
  &&  “ (p_pre <> 0) ” 
  &&  “ (front_pre <> y___tespec_entry) ” 
  &&  “ (y___tespec_entry <> 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> a_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (front_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (front_pre + 0)) # Int  |-> a)
  **  ((( &( "front_spec_452" ) )) # Ptr  |-> front_pre)
  **  ((( &( "p_spec_449" ) )) # Ptr  |-> p_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> v___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> y___tespec_entry)
.

Definition push_induction_precondition_wit_1 :=
exists (p_pre: Z) ,
exists (front_pre: Z) ,
exists (l___tespec_entry: (@list Z)) ,
exists (y___tespec_entry: Z) ,
exists (v___tespec_entry: Z) ,
~ ((  “ (front_pre = 8192) ” 
  &&  “ (p_pre = 12288) ” 
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ” 
  &&  “ (v___tespec_entry = (INT_MIN)) ” 
  &&  “ (y___tespec_entry = 16384) ” 
  &&  “ (p_pre <> 0) ” 
  &&  “ (front_pre <> y___tespec_entry) ” 
  &&  “ (y___tespec_entry <> 0) ”
  &&  (CNQueueAux front_pre p_pre l___tespec_entry )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> v___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> y___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_push_induction_safety_wit_1 : push_induction_safety_wit_1.
Axiom proof_of_push_induction_safety_wit_2 : push_induction_safety_wit_2.
Axiom proof_of_push_induction_safety_wit_3 : push_induction_safety_wit_3.
Axiom proof_of_push_induction_return_wit_1 : push_induction_return_wit_1.
Axiom proof_of_push_induction_partial_solve_wit_1 : push_induction_partial_solve_wit_1.
Axiom proof_of_push_induction_partial_solve_wit_2 : push_induction_partial_solve_wit_2.
Axiom proof_of_push_induction_precondition_wit_1 : push_induction_precondition_wit_1.

End VC_Correct.
