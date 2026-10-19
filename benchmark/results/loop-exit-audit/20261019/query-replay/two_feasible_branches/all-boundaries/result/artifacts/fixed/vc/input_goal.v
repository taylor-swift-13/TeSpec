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
forall (x: Z) (PreH1 : (x <> 0)) (PreH2 : (0 <= x)) (PreH3 : (x <= 1)) ,
  ((( &( "v_spec_384" ) )) # Int  |-> x)
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  ((4096) # Int  |-> x)
|--
  TT && emp 
.

Definition sample_safety_wit_2 := 
forall (x: Z) (PreH1 : (x = 0)) ,
  ((( &( "v_spec_384" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  ((4096) # Int  |-> 0)
|--
  TT && emp 
.

Definition sample_safety_wit_3 := 
forall (x: Z) (PreH1 : (0 <= x)) (PreH2 : (x <= 1)) ,
  ((( &( "v_spec_384" ) )) # Int  |-> x)
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  ((4096) # Int  |-> x)
|--
  TT && emp 
.

Definition sample_return_wit_1 := 
forall (p_pre: Z) (x_2: Z) (PreH1 : (x_2 <> 0)) (PreH2 : (p_pre = 4096)) (PreH3 : (0 <= x_2)) (PreH4 : (x_2 <= 1)) ,
  ((p_pre) # Int  |-> x_2)
|--
  EX (x: Z) ,
  “ (1 = x) ”
  &&  ((p_pre) # Int  |-> x)
.

Definition sample_return_wit_2 := 
forall (p_pre: Z) (x_2: Z) (PreH1 : (x_2 = 0)) (PreH2 : (p_pre = 4096)) (PreH3 : (0 <= x_2)) (PreH4 : (x_2 <= 1)) ,
  ((p_pre) # Int  |-> x_2)
|--
  EX (x: Z) ,
  “ (0 = x) ”
  &&  ((p_pre) # Int  |-> x)
.

Definition sample_precondition_wit_1 :=
exists (p_pre: Z) ,
~ ((  EX (x: Z) ,
  “ (p_pre = 4096) ” 
  &&  “ (0 <= x) ” 
  &&  “ (x <= 1) ”
  &&  ((p_pre) # Int  |-> x)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_sample_safety_wit_1 : sample_safety_wit_1.
Axiom proof_of_sample_safety_wit_2 : sample_safety_wit_2.
Axiom proof_of_sample_safety_wit_3 : sample_safety_wit_3.
Axiom proof_of_sample_return_wit_1 : sample_return_wit_1.
Axiom proof_of_sample_return_wit_2 : sample_return_wit_2.
Axiom proof_of_sample_precondition_wit_1 : sample_precondition_wit_1.

End VC_Correct.
