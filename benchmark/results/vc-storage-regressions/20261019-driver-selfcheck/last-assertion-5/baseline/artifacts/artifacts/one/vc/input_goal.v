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
  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_2 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_3 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_4 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_5 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_6 := 
  ((( &( "i_spec_380" ) )) # Int  |->_)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_7 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  “ False ”
.

Definition sample_safety_wit_8 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_9 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_10 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  “ False ”
.

Definition sample_safety_wit_11 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  “ False ”
.

Definition sample_safety_wit_12 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_13 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_14 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  “ False ”
.

Definition sample_safety_wit_15 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  “ False ”
.

Definition sample_safety_wit_16 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_17 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_18 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  “ False ”
.

Definition sample_safety_wit_19 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  “ False ”
.

Definition sample_safety_wit_20 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_21 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_22 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  “ False ”
.

Definition sample_safety_wit_23 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  “ False ”
.

Definition sample_safety_wit_24 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_25 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition sample_safety_wit_26 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  “ False ”
.

Definition sample_safety_wit_27 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 5)
|--
  “ False ”
.

Definition sample_entail_wit_1 := 
(
  TT && emp 
|--
  “ False ”
  &&  emp
) \/
(
  TT && emp 
|--
  “ False ”
  &&  emp
).

Definition sample_entail_wit_1_split_goal_1 := 
  False
.

Definition sample_return_wit_1 := 
forall (n_pre: Z) (PreH1 : ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) >= n_pre)) (PreH2 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) = (n_pre - 1 ))) (PreH3 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH4 : ((((0 + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH5 : ((((0 + 1 ) + 1 ) + 1 ) < n_pre)) (PreH6 : (((0 + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH7 : (((0 + 1 ) + 1 ) < n_pre)) (PreH8 : ((0 + 1 ) <> (n_pre - 1 ))) (PreH9 : ((0 + 1 ) < n_pre)) (PreH10 : (0 <> (n_pre - 1 ))) (PreH11 : (0 < n_pre)) (PreH12 : (n_pre = 5)) (PreH13 : (0 <= n_pre)) (PreH14 : (n_pre <= 4096)) ,
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
Axiom proof_of_sample_safety_wit_24 : sample_safety_wit_24.
Axiom proof_of_sample_safety_wit_25 : sample_safety_wit_25.
Axiom proof_of_sample_safety_wit_26 : sample_safety_wit_26.
Axiom proof_of_sample_safety_wit_27 : sample_safety_wit_27.
Axiom proof_of_sample_entail_wit_1 : sample_entail_wit_1.
Axiom proof_of_sample_return_wit_1 : sample_return_wit_1.
Axiom proof_of_sample_precondition_wit_1 : sample_precondition_wit_1.

End VC_Correct.
