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
  ((( &( "p_spec_479" ) )) # Ptr  |-> 4096)
  **  (((4096 + (8 * 1))) # Int  |-> 7)
|--
  TT && emp 
.

Definition sample_safety_wit_2 := 
  ((( &( "p_spec_479" ) )) # Ptr  |-> 4096)
  **  (((4096 + (8 * 1))) # Int  |-> 7)
|--
  TT && emp 
.

Definition sample_return_wit_1 := 
forall (p_pre: Z) (PreH1 : (p_pre = 4096)) ,
  (((p_pre + (8 * sizeof(CHAR)))) # Int  |-> (7 + 1 ))
|--
  “ ((7 + 1 ) = 8) ”
  &&  (((p_pre + (8 * sizeof(CHAR)))) # Int  |-> 8)
.

Definition sample_precondition_wit_1 :=
exists (p_pre: Z) ,
~ ((  “ (p_pre = 4096) ”
  &&  (((p_pre + (8 * sizeof(CHAR)))) # Int  |-> 7)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_sample_safety_wit_1 : sample_safety_wit_1.
Axiom proof_of_sample_safety_wit_2 : sample_safety_wit_2.
Axiom proof_of_sample_return_wit_1 : sample_return_wit_1.
Axiom proof_of_sample_precondition_wit_1 : sample_precondition_wit_1.

End VC_Correct.
