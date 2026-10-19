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

(*----- Function abs_y -----*)

Definition abs_y_safety_wit_1 := 
  ((( &( "x_spec_435" ) )) # Int  |-> (-1))
  **  ((( &( "p_spec_432" ) )) # Ptr  |-> (* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4))
  **  ((( &( "p_spec_416" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> (-1))
|--
  TT && emp 
.

Definition abs_y_safety_wit_2 := 
  ((( &( "x_spec_435" ) )) # Int  |-> (-1))
  **  ((( &( "p_spec_432" ) )) # Ptr  |-> (* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4))
  **  ((( &( "p_spec_416" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> (-1))
|--
  TT && emp 
.

Definition abs_y_safety_wit_3 := 
forall (PreH1 : False) ,
  ((( &( "x_spec_435" ) )) # Int  |-> (-1))
  **  ((( &( "p_spec_432" ) )) # Ptr  |-> (* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4))
  **  ((( &( "p_spec_416" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> (-1))
|--
  “ False ”
.

Definition abs_y_entail_wit_1 := 
forall (p_pre: Z) (y___tespec_entry: Z) (x___tespec_entry: Z) (PreH1 : (y___tespec_entry < 0)) (PreH2 : (p_pre = 4096)) (PreH3 : (x___tespec_entry = (INT_MIN))) (PreH4 : (y___tespec_entry = (-1))) (PreH5 : ((INT_MIN) < y___tespec_entry)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> x___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> y___tespec_entry)
|--
  (EX (retval: Z) ,
  “ (retval = (-y___tespec_entry)) ” 
  &&  “ (y___tespec_entry < 0) ” 
  &&  “ (retval = (-y___tespec_entry)) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (x___tespec_entry = (INT_MIN)) ” 
  &&  “ (y___tespec_entry = (-1)) ” 
  &&  “ ((INT_MIN) < y___tespec_entry) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> y___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> x___tespec_entry))
  ||
  (EX (retval_2: Z) ,
  “ (retval_2 = (-y___tespec_entry)) ” 
  &&  “ (y___tespec_entry >= 0) ” 
  &&  “ (retval_2 = y___tespec_entry) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (x___tespec_entry = (INT_MIN)) ” 
  &&  “ (y___tespec_entry = (-1)) ” 
  &&  “ ((INT_MIN) < y___tespec_entry) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> y___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> x___tespec_entry))
.

Definition abs_y_return_wit_1 := 
forall (p_pre: Z) (y___tespec_entry: Z) (x___tespec_entry: Z) (PreH1 : (y___tespec_entry < 0)) (PreH2 : (p_pre = 4096)) (PreH3 : (x___tespec_entry = (INT_MIN))) (PreH4 : (y___tespec_entry = (-1))) (PreH5 : ((INT_MIN) < y___tespec_entry)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> x___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> y___tespec_entry)
|--
  (“ (y___tespec_entry < 0) ” 
  &&  “ ((-y___tespec_entry) = (-y___tespec_entry)) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> x___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> y___tespec_entry))
  ||
  (“ (y___tespec_entry >= 0) ” 
  &&  “ ((-y___tespec_entry) = y___tespec_entry) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> x___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> y___tespec_entry))
.

Definition abs_y_partial_solve_wit_1_pure := 
forall (p_pre: Z) (y___tespec_entry: Z) (x___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (x___tespec_entry = (INT_MIN))) (PreH3 : (y___tespec_entry = (-1))) (PreH4 : ((INT_MIN) < y___tespec_entry)) ,
  ((( &( "p_spec_416" ) )) # Ptr  |-> p_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> x___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> y___tespec_entry)
|--
  “ ((INT_MIN) < y___tespec_entry) ”
.

Definition abs_y_partial_solve_wit_1_aux := 
forall (p_pre: Z) (y___tespec_entry: Z) (x___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (x___tespec_entry = (INT_MIN))) (PreH3 : (y___tespec_entry = (-1))) (PreH4 : ((INT_MIN) < y___tespec_entry)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> x___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> y___tespec_entry)
|--
  “ ((INT_MIN) < y___tespec_entry) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (x___tespec_entry = (INT_MIN)) ” 
  &&  “ (y___tespec_entry = (-1)) ” 
  &&  “ ((INT_MIN) < y___tespec_entry) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> y___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> x___tespec_entry)
.

Definition abs_y_partial_solve_wit_1 := abs_y_partial_solve_wit_1_pure -> abs_y_partial_solve_wit_1_aux.

Definition abs_y_precondition_wit_1 :=
exists (p_pre: Z) ,
exists (y___tespec_entry: Z) ,
exists (x___tespec_entry: Z) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (x___tespec_entry = (INT_MIN)) ” 
  &&  “ (y___tespec_entry = (-1)) ” 
  &&  “ ((INT_MIN) < y___tespec_entry) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> x___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> y___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_abs_y_safety_wit_1 : abs_y_safety_wit_1.
Axiom proof_of_abs_y_safety_wit_2 : abs_y_safety_wit_2.
Axiom proof_of_abs_y_safety_wit_3 : abs_y_safety_wit_3.
Axiom proof_of_abs_y_entail_wit_1 : abs_y_entail_wit_1.
Axiom proof_of_abs_y_return_wit_1 : abs_y_return_wit_1.
Axiom proof_of_abs_y_partial_solve_wit_1_pure : abs_y_partial_solve_wit_1_pure.
Axiom proof_of_abs_y_partial_solve_wit_1 : abs_y_partial_solve_wit_1.
Axiom proof_of_abs_y_precondition_wit_1 : abs_y_precondition_wit_1.

End VC_Correct.
