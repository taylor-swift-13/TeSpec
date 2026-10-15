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
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function sizeOf -----*)

Definition sizeOf_return_wit_1 := 
forall (p_pre: Z) (l___tespec_entry: (@list Z)) (d___tespec_entry: Z) (p_pre_size: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (d___tespec_entry = 8192)) (PreH3 : (l___tespec_entry = (cons ((-1)) ((cons (0) ((cons (3) ((@nil Z))))))))) (PreH4 : (p_pre_size = ((Zlength (l___tespec_entry)) % ( 4294967296 ) ))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_pre_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
  **  (sll d___tespec_entry l___tespec_entry )
|--
  EX (p_pre_size_2: Z) ,
  “ (p_pre_size = ((Zlength (l___tespec_entry)) % ( 4294967296 ) )) ” 
  &&  “ (p_pre_size_2 = ((Zlength (l___tespec_entry)) % ( 4294967296 ) )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_pre_size_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
  **  (sll d___tespec_entry l___tespec_entry )
.

Definition sizeOf_precondition_wit_1 :=
exists (p_pre: Z) ,
exists (l___tespec_entry: (@list Z)) ,
exists (d___tespec_entry: Z) ,
~ ((  EX (p_pre_size: Z) ,
  “ (p_pre = 4096) ” 
  &&  “ (d___tespec_entry = 8192) ” 
  &&  “ (l___tespec_entry = (cons ((-1)) ((cons (0) ((cons (3) ((@nil Z)))))))) ” 
  &&  “ (p_pre_size = ((Zlength (l___tespec_entry)) % ( 4294967296 ) )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_pre_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
  **  (sll d___tespec_entry l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_sizeOf_return_wit_1 : sizeOf_return_wit_1.
Axiom proof_of_sizeOf_precondition_wit_1 : sizeOf_precondition_wit_1.

End VC_Correct.
