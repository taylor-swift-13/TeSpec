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
  ((( &( "i_spec_380" ) )) # Int  |-> (-1))
  **  ((( &( "n_spec_371" ) )) # Int  |-> 0)
|--
  TT && emp 
.

Definition sample_safety_wit_2 := 
  ((( &( "i_spec_380" ) )) # Int  |-> (-2))
  **  ((( &( "n_spec_371" ) )) # Int  |-> 0)
|--
  TT && emp 
.

Definition sample_safety_wit_3 := 
  ((( &( "i_spec_380" ) )) # Int  |-> (-3))
  **  ((( &( "n_spec_371" ) )) # Int  |-> 0)
|--
  TT && emp 
.

Definition sample_safety_wit_4 := 
  ((( &( "i_spec_380" ) )) # Int  |->_)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 0)
|--
  TT && emp 
.

Definition sample_safety_wit_5 := 
  ((( &( "i_spec_380" ) )) # Int  |->_)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 0)
|--
  TT && emp 
.

Definition sample_safety_wit_6 := 
  ((( &( "i_spec_380" ) )) # Int  |-> (-3))
  **  ((( &( "n_spec_371" ) )) # Int  |-> 0)
|--
  TT && emp 
.

Definition sample_safety_wit_7 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> (-3))
  **  ((( &( "n_spec_371" ) )) # Int  |-> 0)
|--
  “ False ”
.

Definition sample_safety_wit_8 := 
  ((( &( "i_spec_380" ) )) # Int  |-> (-2))
  **  ((( &( "n_spec_371" ) )) # Int  |-> 0)
|--
  TT && emp 
.

Definition sample_safety_wit_9 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> (-2))
  **  ((( &( "n_spec_371" ) )) # Int  |-> 0)
|--
  “ False ”
.

Definition sample_safety_wit_10 := 
  ((( &( "i_spec_380" ) )) # Int  |-> (-1))
  **  ((( &( "n_spec_371" ) )) # Int  |-> 0)
|--
  TT && emp 
.

Definition sample_safety_wit_11 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> (-1))
  **  ((( &( "n_spec_371" ) )) # Int  |-> 0)
|--
  “ False ”
.

Definition sample_safety_wit_12 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 0)
|--
  TT && emp 
.

Definition sample_safety_wit_13 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 0)
|--
  “ False ”
.

Definition sample_return_wit_1 := 
forall (n_pre: Z) (PreH1 : (((((-3) + 1 ) + 1 ) + 1 ) >= 0)) (PreH2 : ((((-3) + 1 ) + 1 ) < 0)) (PreH3 : (((-3) + 1 ) < 0)) (PreH4 : ((-3) < 0)) (PreH5 : (n_pre = 0)) (PreH6 : (0 <= n_pre)) (PreH7 : (n_pre <= 4096)) ,
  TT && emp 
|--
  “ (((((-3) + 1 ) + 1 ) + 1 ) = n_pre) ”
  &&  emp
.

Definition sample_precondition_wit_1 :=
exists (n_pre: Z) ,
~ ((  “ (n_pre = 0) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= 4096) ”
  &&  emp) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_sample_safety_wit_1 : sample_safety_wit_1.
Axiom proof_of_sample_safety_wit_2 : sample_safety_wit_2.
Axiom proof_of_sample_safety_wit_3 : sample_safety_wit_3.
Axiom proof_of_sample_safety_wit_4 : sample_safety_wit_4.
Axiom proof_of_sample_safety_wit_5 : sample_safety_wit_5.
Axiom proof_of_sample_safety_wit_6 : sample_safety_wit_6.
Axiom proof_of_sample_safety_wit_7 : sample_safety_wit_7.
Axiom proof_of_sample_safety_wit_8 : sample_safety_wit_8.
Axiom proof_of_sample_safety_wit_9 : sample_safety_wit_9.
Axiom proof_of_sample_safety_wit_10 : sample_safety_wit_10.
Axiom proof_of_sample_safety_wit_11 : sample_safety_wit_11.
Axiom proof_of_sample_safety_wit_12 : sample_safety_wit_12.
Axiom proof_of_sample_safety_wit_13 : sample_safety_wit_13.
Axiom proof_of_sample_return_wit_1 : sample_return_wit_1.
Axiom proof_of_sample_precondition_wit_1 : sample_precondition_wit_1.

End VC_Correct.
