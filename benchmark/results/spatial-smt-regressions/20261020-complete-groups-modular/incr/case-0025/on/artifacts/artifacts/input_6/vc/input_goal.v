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

(*----- Function incr -----*)

Definition incr_safety_wit_1 := 
(
  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  ((4096) # Int  |-> 2147483646)
|--
  “ False ”
) \/
(
  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  ((4096) # Int  |-> 2147483646)
|--
  “ False ”
).

Definition incr_safety_wit_1_split_goal_1 := 
  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  ((4096) # Int  |-> 2147483646)
|--
  “ False ”
.

Definition incr_safety_wit_2 := 
  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  ((4096) # Int  |-> 2147483646)
|--
  TT && emp 
.

Definition incr_return_wit_1 := 
forall (p_pre: Z) (old___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (old___tespec_entry = 2147483646)) (PreH3 : (old___tespec_entry < INT_MAX)) ,
  ((p_pre) # Int  |-> (old___tespec_entry + 2 ))
|--
  ((p_pre) # Int  |-> (old___tespec_entry + 1 ))
.

Definition incr_precondition_wit_1 :=
exists (p_pre: Z) ,
exists (old___tespec_entry: Z) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (old___tespec_entry = 2147483646) ” 
  &&  “ (old___tespec_entry < INT_MAX) ”
  &&  ((p_pre) # Int  |-> old___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_incr_safety_wit_1 : incr_safety_wit_1.
Axiom proof_of_incr_safety_wit_2 : incr_safety_wit_2.
Axiom proof_of_incr_return_wit_1 : incr_return_wit_1.
Axiom proof_of_incr_precondition_wit_1 : incr_precondition_wit_1.

End VC_Correct.
