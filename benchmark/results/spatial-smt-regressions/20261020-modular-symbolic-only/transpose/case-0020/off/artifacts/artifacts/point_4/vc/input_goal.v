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

(*----- Function transpose2 -----*)

Definition transpose2_return_wit_1 := 
forall (p_pre: Z) (y___tespec_entry: Z) (x___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (x___tespec_entry = UINT_MAX)) (PreH3 : (y___tespec_entry = 0)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> y___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # UInt  |-> x___tespec_entry)
|--
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> y___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # UInt  |-> x___tespec_entry)
.

Definition transpose2_partial_solve_wit_1 := 
forall (p_pre: Z) (y___tespec_entry: Z) (x___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (x___tespec_entry = UINT_MAX)) (PreH3 : (y___tespec_entry = 0)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> x___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # UInt  |-> y___tespec_entry)
|--
  “ (p_pre = 4096) ” 
  &&  “ (x___tespec_entry = UINT_MAX) ” 
  &&  “ (y___tespec_entry = 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> x___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # UInt  |-> y___tespec_entry)
.

Definition transpose2_precondition_wit_1 :=
exists (p_pre: Z) ,
exists (y___tespec_entry: Z) ,
exists (x___tespec_entry: Z) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (x___tespec_entry = UINT_MAX) ” 
  &&  “ (y___tespec_entry = 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> x___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # UInt  |-> y___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_transpose2_return_wit_1 : transpose2_return_wit_1.
Axiom proof_of_transpose2_partial_solve_wit_1 : transpose2_partial_solve_wit_1.
Axiom proof_of_transpose2_precondition_wit_1 : transpose2_precondition_wit_1.

End VC_Correct.
