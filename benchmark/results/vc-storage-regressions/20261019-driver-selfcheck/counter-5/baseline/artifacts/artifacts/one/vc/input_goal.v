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
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_2 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_3 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_4 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_5 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_6 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_7 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_8 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_9 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_10 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_11 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_12 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_13 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_14 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_15 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_16 := 
  ((( &( "k_spec_383" ) )) # Int  |->_)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_17 := 
  ((( &( "i_spec_380" ) )) # Int  |->_)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_18 := 
forall (PreH1 : False) ,
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  “ False ”
.

Definition sample_safety_wit_19 := 
forall (PreH1 : False) ,
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  “ False ”
.

Definition sample_safety_wit_20 := 
forall (PreH1 : False) ,
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  “ False ”
.

Definition sample_safety_wit_21 := 
forall (PreH1 : False) ,
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  “ False ”
.

Definition sample_safety_wit_22 := 
forall (PreH1 : False) ,
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  “ False ”
.

Definition sample_safety_wit_23 := 
forall (PreH1 : False) ,
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  “ False ”
.

Definition sample_return_wit_1 := 
forall (n_pre: Z) (PreH1 : ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) >= n_pre)) (PreH2 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH3 : ((((0 + 1 ) + 1 ) + 1 ) < n_pre)) (PreH4 : (((0 + 1 ) + 1 ) < n_pre)) (PreH5 : ((0 + 1 ) < n_pre)) (PreH6 : (0 < n_pre)) (PreH7 : (n_pre = 5)) (PreH8 : (0 <= n_pre)) (PreH9 : (n_pre <= 4096)) ,
  TT && emp 
|--
  “ ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) = n_pre) ”
  &&  emp
.

Definition sample_precondition_wit_1 :=
exists (n_pre: Z) ,
~ ((  “ (n_pre = 5) ” 
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
Axiom proof_of_sample_safety_wit_14 : sample_safety_wit_14.
Axiom proof_of_sample_safety_wit_15 : sample_safety_wit_15.
Axiom proof_of_sample_safety_wit_16 : sample_safety_wit_16.
Axiom proof_of_sample_safety_wit_17 : sample_safety_wit_17.
Axiom proof_of_sample_safety_wit_18 : sample_safety_wit_18.
Axiom proof_of_sample_safety_wit_19 : sample_safety_wit_19.
Axiom proof_of_sample_safety_wit_20 : sample_safety_wit_20.
Axiom proof_of_sample_safety_wit_21 : sample_safety_wit_21.
Axiom proof_of_sample_safety_wit_22 : sample_safety_wit_22.
Axiom proof_of_sample_safety_wit_23 : sample_safety_wit_23.
Axiom proof_of_sample_return_wit_1 : sample_return_wit_1.
Axiom proof_of_sample_precondition_wit_1 : sample_precondition_wit_1.

End VC_Correct.
