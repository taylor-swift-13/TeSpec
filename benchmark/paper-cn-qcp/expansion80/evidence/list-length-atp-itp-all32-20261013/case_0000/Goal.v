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
Require Import SimpleC.EE.QCP_demos_human.sll_layout32.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function length -----*)

Definition length_safety_wit_1 := 
  ((( &( "l_spec_410" ) )) # Ptr  |-> 0)
  **  (sll32 0 (@nil Z) )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition length_safety_wit_2 := 
  ((( &( "l_spec_410" ) )) # Ptr  |-> 0)
  **  (sll32 0 (@nil Z) )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition length_return_wit_1 := 
  (sll32 0 (@nil Z) )
|--
  “ (0 = 0) ”
  &&  (sll32 0 (@nil Z) )
.

Definition length_precondition_wit_1 :=
~ ((  “ (0 = 0) ” 
  &&  “ ((@nil Z) = (@nil Z)) ” 
  &&  “ ((Zlength ((@nil Z))) < UINT_MAX) ”
  &&  (sll32 0 (@nil Z) )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_length_safety_wit_1 : length_safety_wit_1.
Axiom proof_of_length_safety_wit_2 : length_safety_wit_2.
Axiom proof_of_length_return_wit_1 : length_return_wit_1.
Axiom proof_of_length_precondition_wit_1 : length_precondition_wit_1.

End VC_Correct.
