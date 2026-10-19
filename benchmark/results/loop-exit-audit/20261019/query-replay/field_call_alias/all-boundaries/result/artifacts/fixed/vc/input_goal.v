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

(*----- Function sample -----*)

Definition sample_safety_wit_1 := 
forall (p_pre_value: Z) (PreH1 : (p_pre_value = 3)) ,
  ((( &( "q_spec_435" ) )) # Ptr  |-> 4096)
  **  ((( &( "p_spec_420" ) )) # Ptr  |-> 4096)
  **  ((( &( "q_spec_417" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 3)
|--
  “ ((p_pre_value + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (p_pre_value + 1 )) ”
.

Definition sample_safety_wit_2 := 
forall (p_pre_value: Z) (PreH1 : (p_pre_value = 3)) ,
  ((( &( "q_spec_435" ) )) # Ptr  |-> 4096)
  **  ((( &( "p_spec_420" ) )) # Ptr  |-> 4096)
  **  ((( &( "q_spec_417" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_entail_wit_1 := 
forall (q_pre: Z) (p_pre: Z) (p_pre_value: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (q_pre = 4096)) (PreH3 : (p_pre = q_pre)) (PreH4 : (p_pre_value = 3)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> (p_pre_value + 1 ))
|--
  EX (q_callee_value: Z) ,
  “ (q_callee_value = (3 + 1 )) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (q_pre = 4096) ” 
  &&  “ (p_pre = q_pre) ” 
  &&  “ (p_pre_value = 3) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (q_pre + 4)) # Int  |-> q_callee_value)
.

Definition sample_return_wit_1 := 
forall (q_pre: Z) (p_pre: Z) (p_pre_value: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (q_pre = 4096)) (PreH3 : (p_pre = q_pre)) (PreH4 : (p_pre_value = 3)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> (p_pre_value + 1 ))
|--
  EX (p_pre_value_2: Z) ,
  “ ((p_pre_value + 1 ) = 4) ” 
  &&  “ (p_pre_value_2 = 4) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> p_pre_value_2)
.

Definition sample_partial_solve_wit_1 := 
forall (q_pre: Z) (p_pre: Z) (p_pre_value: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (q_pre = 4096)) (PreH3 : (p_pre = q_pre)) (PreH4 : (p_pre_value = 3)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> p_pre_value)
|--
  “ (p_pre = 4096) ” 
  &&  “ (q_pre = 4096) ” 
  &&  “ (p_pre = q_pre) ” 
  &&  “ (p_pre_value = 3) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (q_pre + 4)) # Int  |-> 3)
.

Definition sample_precondition_wit_1 :=
exists (q_pre: Z) ,
exists (p_pre: Z) ,
~ ((  EX (p_pre_value: Z) ,
  “ (p_pre = 4096) ” 
  &&  “ (q_pre = 4096) ” 
  &&  “ (p_pre = q_pre) ” 
  &&  “ (p_pre_value = 3) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> p_pre_value)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_sample_safety_wit_1 : sample_safety_wit_1.
Axiom proof_of_sample_safety_wit_2 : sample_safety_wit_2.
Axiom proof_of_sample_entail_wit_1 : sample_entail_wit_1.
Axiom proof_of_sample_return_wit_1 : sample_return_wit_1.
Axiom proof_of_sample_partial_solve_wit_1 : sample_partial_solve_wit_1.
Axiom proof_of_sample_precondition_wit_1 : sample_precondition_wit_1.

End VC_Correct.
