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

(*----- Function abs_mem -----*)

Definition abs_mem_safety_wit_1 := 
  ((( &( "x_spec_382" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  ((4096) # Int  |-> 0)
|--
  TT && emp 
.

Definition abs_mem_safety_wit_2 := 
forall (PreH1 : False) ,
  ((( &( "x_spec_382" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  ((4096) # Int  |-> 0)
|--
  “ False ”
.

Definition abs_mem_return_wit_1 := 
forall (p_pre: Z) (v___tespec_entry: Z) (PreH1 : (v___tespec_entry >= 0)) (PreH2 : (p_pre = 4096)) (PreH3 : (v___tespec_entry = 0)) (PreH4 : ((INT_MIN) < v___tespec_entry)) ,
  ((p_pre) # Int  |-> v___tespec_entry)
|--
  (“ (v___tespec_entry < 0) ” 
  &&  “ (v___tespec_entry = (-v___tespec_entry)) ”
  &&  ((p_pre) # Int  |-> v___tespec_entry))
  ||
  (“ (v___tespec_entry >= 0) ” 
  &&  “ (v___tespec_entry = v___tespec_entry) ”
  &&  ((p_pre) # Int  |-> v___tespec_entry))
.

Definition abs_mem_precondition_wit_1 :=
exists (p_pre: Z) ,
exists (v___tespec_entry: Z) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (v___tespec_entry = 0) ” 
  &&  “ ((INT_MIN) < v___tespec_entry) ”
  &&  ((p_pre) # Int  |-> v___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_abs_mem_safety_wit_1 : abs_mem_safety_wit_1.
Axiom proof_of_abs_mem_safety_wit_2 : abs_mem_safety_wit_2.
Axiom proof_of_abs_mem_return_wit_1 : abs_mem_return_wit_1.
Axiom proof_of_abs_mem_precondition_wit_1 : abs_mem_precondition_wit_1.

End VC_Correct.
