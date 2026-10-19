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
  ((( &( "i_spec_383" ) )) # Int  |-> 5)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_2 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 5)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_3 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 4)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_4 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 3)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_5 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 3)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_6 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 2)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_7 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 1)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_8 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 1)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_9 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 0)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_10 := 
  ((( &( "i_spec_383" ) )) # Int  |->_)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_11 := 
  ((( &( "c_spec_380" ) )) # Int  |->_)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_12 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 0)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_13 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 0)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_14 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 0)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_15 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 0)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_16 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_383" ) )) # Int  |-> 0)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  “ False ”
.

Definition sample_safety_wit_17 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 1)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_18 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_383" ) )) # Int  |-> 1)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  “ False ”
.

Definition sample_safety_wit_19 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 1)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_20 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 1)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_21 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 1)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_22 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_383" ) )) # Int  |-> 1)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  “ False ”
.

Definition sample_safety_wit_23 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 2)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_24 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_383" ) )) # Int  |-> 2)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  “ False ”
.

Definition sample_safety_wit_25 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 2)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_26 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 2)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_27 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 2)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_28 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_383" ) )) # Int  |-> 2)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  “ False ”
.

Definition sample_safety_wit_29 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 3)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_30 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_383" ) )) # Int  |-> 3)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  “ False ”
.

Definition sample_safety_wit_31 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 3)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_32 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 3)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_33 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 3)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_34 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_383" ) )) # Int  |-> 3)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  “ False ”
.

Definition sample_safety_wit_35 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 4)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_36 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_383" ) )) # Int  |-> 4)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  “ False ”
.

Definition sample_safety_wit_37 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 4)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_38 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 4)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_39 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 4)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_40 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_383" ) )) # Int  |-> 4)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  “ False ”
.

Definition sample_safety_wit_41 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 5)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_42 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_383" ) )) # Int  |-> 5)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  “ False ”
.

Definition sample_safety_wit_43 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 5)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_44 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 5)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_45 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 5)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_46 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_383" ) )) # Int  |-> 5)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  “ False ”
.

Definition sample_safety_wit_47 := 
  ((( &( "i_spec_383" ) )) # Int  |-> 6)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_48 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_383" ) )) # Int  |-> 6)
  **  ((( &( "c_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  “ False ”
.

Definition sample_return_wit_1 := 
forall (n_pre: Z) (PreH1 : (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) >= 6)) (PreH2 : (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) % ( 2 ) ) <> 0)) (PreH3 : ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < 6)) (PreH4 : ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) % ( 2 ) ) = 0)) (PreH5 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < 6)) (PreH6 : (((((0 + 1 ) + 1 ) + 1 ) % ( 2 ) ) <> 0)) (PreH7 : ((((0 + 1 ) + 1 ) + 1 ) < 6)) (PreH8 : ((((0 + 1 ) + 1 ) % ( 2 ) ) = 0)) (PreH9 : (((0 + 1 ) + 1 ) < 6)) (PreH10 : (((0 + 1 ) % ( 2 ) ) <> 0)) (PreH11 : ((0 + 1 ) < 6)) (PreH12 : ((0 % ( 2 ) ) = 0)) (PreH13 : (n_pre = 3)) (PreH14 : (0 <= n_pre)) (PreH15 : (n_pre <= 4096)) ,
  TT && emp 
|--
  “ ((((0 + 1 ) + 1 ) + 1 ) = n_pre) ”
  &&  emp
.

Definition sample_precondition_wit_1 :=
exists (n_pre: Z) ,
~ ((  “ (n_pre = 3) ” 
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
Axiom proof_of_sample_safety_wit_28 : sample_safety_wit_28.
Axiom proof_of_sample_safety_wit_29 : sample_safety_wit_29.
Axiom proof_of_sample_safety_wit_30 : sample_safety_wit_30.
Axiom proof_of_sample_safety_wit_31 : sample_safety_wit_31.
Axiom proof_of_sample_safety_wit_32 : sample_safety_wit_32.
Axiom proof_of_sample_safety_wit_33 : sample_safety_wit_33.
Axiom proof_of_sample_safety_wit_34 : sample_safety_wit_34.
Axiom proof_of_sample_safety_wit_35 : sample_safety_wit_35.
Axiom proof_of_sample_safety_wit_36 : sample_safety_wit_36.
Axiom proof_of_sample_safety_wit_37 : sample_safety_wit_37.
Axiom proof_of_sample_safety_wit_38 : sample_safety_wit_38.
Axiom proof_of_sample_safety_wit_39 : sample_safety_wit_39.
Axiom proof_of_sample_safety_wit_40 : sample_safety_wit_40.
Axiom proof_of_sample_safety_wit_41 : sample_safety_wit_41.
Axiom proof_of_sample_safety_wit_42 : sample_safety_wit_42.
Axiom proof_of_sample_safety_wit_43 : sample_safety_wit_43.
Axiom proof_of_sample_safety_wit_44 : sample_safety_wit_44.
Axiom proof_of_sample_safety_wit_45 : sample_safety_wit_45.
Axiom proof_of_sample_safety_wit_46 : sample_safety_wit_46.
Axiom proof_of_sample_safety_wit_47 : sample_safety_wit_47.
Axiom proof_of_sample_safety_wit_48 : sample_safety_wit_48.
Axiom proof_of_sample_return_wit_1 : sample_return_wit_1.
Axiom proof_of_sample_precondition_wit_1 : sample_precondition_wit_1.

End VC_Correct.
