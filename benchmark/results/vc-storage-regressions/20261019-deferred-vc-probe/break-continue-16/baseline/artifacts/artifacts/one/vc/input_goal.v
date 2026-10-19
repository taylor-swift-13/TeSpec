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
  ((( &( "c_spec_383" ) )) # Int  |-> 3)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_2 := 
  ((( &( "c_spec_383" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_3 := 
  ((( &( "c_spec_383" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_4 := 
  ((( &( "c_spec_383" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_5 := 
  ((( &( "c_spec_383" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_6 := 
  ((( &( "c_spec_383" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_7 := 
  ((( &( "c_spec_383" ) )) # Int  |-> 0)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_8 := 
  ((( &( "c_spec_383" ) )) # Int  |-> 0)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_9 := 
  ((( &( "c_spec_383" ) )) # Int  |->_)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_10 := 
  ((( &( "i_spec_380" ) )) # Int  |->_)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_11 := 
forall (PreH1 : False) ,
  ((( &( "c_spec_383" ) )) # Int  |-> 0)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_12 := 
  ((( &( "c_spec_383" ) )) # Int  |-> 0)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_13 := 
forall (PreH1 : False) ,
  ((( &( "c_spec_383" ) )) # Int  |-> 0)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_14 := 
  ((( &( "c_spec_383" ) )) # Int  |-> 0)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_15 := 
forall (PreH1 : False) ,
  ((( &( "c_spec_383" ) )) # Int  |-> 0)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_16 := 
forall (PreH1 : False) ,
  ((( &( "c_spec_383" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_17 := 
  ((( &( "c_spec_383" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_18 := 
forall (PreH1 : False) ,
  ((( &( "c_spec_383" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_19 := 
forall (PreH1 : False) ,
  ((( &( "c_spec_383" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_20 := 
  ((( &( "c_spec_383" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_21 := 
forall (PreH1 : False) ,
  ((( &( "c_spec_383" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_22 := 
  ((( &( "c_spec_383" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_23 := 
forall (PreH1 : False) ,
  ((( &( "c_spec_383" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_24 := 
forall (PreH1 : False) ,
  ((( &( "c_spec_383" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_25 := 
  ((( &( "c_spec_383" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_26 := 
forall (PreH1 : False) ,
  ((( &( "c_spec_383" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_27 := 
  ((( &( "c_spec_383" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_28 := 
forall (PreH1 : False) ,
  ((( &( "c_spec_383" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_29 := 
forall (PreH1 : False) ,
  ((( &( "c_spec_383" ) )) # Int  |-> 3)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_30 := 
  ((( &( "c_spec_383" ) )) # Int  |-> 3)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_31 := 
forall (PreH1 : False) ,
  ((( &( "c_spec_383" ) )) # Int  |-> 3)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_32 := 
  ((( &( "c_spec_383" ) )) # Int  |-> 3)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_33 := 
forall (PreH1 : False) ,
  ((( &( "c_spec_383" ) )) # Int  |-> 3)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_return_wit_1 := 
forall (n_pre: Z) (PreH1 : ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) = 5)) (PreH2 : ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> 2)) (PreH3 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH4 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) <> 5)) (PreH5 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) <> 2)) (PreH6 : ((((0 + 1 ) + 1 ) + 1 ) < n_pre)) (PreH7 : ((((0 + 1 ) + 1 ) + 1 ) <> 5)) (PreH8 : ((((0 + 1 ) + 1 ) + 1 ) <> 2)) (PreH9 : (((0 + 1 ) + 1 ) < n_pre)) (PreH10 : (((0 + 1 ) + 1 ) = 2)) (PreH11 : ((0 + 1 ) < n_pre)) (PreH12 : ((0 + 1 ) <> 5)) (PreH13 : ((0 + 1 ) <> 2)) (PreH14 : (0 < n_pre)) (PreH15 : (n_pre = 16)) (PreH16 : (5 <= n_pre)) (PreH17 : (n_pre <= 4096)) ,
  TT && emp 
|--
  “ ((((0 + 1 ) + 1 ) + 1 ) = 3) ”
  &&  emp
.

Definition sample_precondition_wit_1 :=
exists (n_pre: Z) ,
~ ((  “ (n_pre = 16) ” 
  &&  “ (5 <= n_pre) ” 
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
Axiom proof_of_sample_safety_wit_28 : sample_safety_wit_28.
Axiom proof_of_sample_safety_wit_29 : sample_safety_wit_29.
Axiom proof_of_sample_safety_wit_30 : sample_safety_wit_30.
Axiom proof_of_sample_safety_wit_31 : sample_safety_wit_31.
Axiom proof_of_sample_safety_wit_32 : sample_safety_wit_32.
Axiom proof_of_sample_safety_wit_33 : sample_safety_wit_33.
Axiom proof_of_sample_return_wit_1 : sample_return_wit_1.
Axiom proof_of_sample_precondition_wit_1 : sample_precondition_wit_1.

End VC_Correct.
