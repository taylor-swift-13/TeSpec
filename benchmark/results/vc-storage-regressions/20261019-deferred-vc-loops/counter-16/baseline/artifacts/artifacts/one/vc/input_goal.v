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
  **  ((( &( "i_spec_380" ) )) # Int  |-> 15)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_2 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 15)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_3 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 15)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_4 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 14)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_5 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 14)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_6 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 14)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_7 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 13)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_8 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 13)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_9 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 13)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_10 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 12)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_11 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 12)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_12 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 12)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_13 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 11)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_14 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 11)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_15 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 11)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_16 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 10)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_17 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 10)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_18 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 10)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_19 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 9)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_20 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 9)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_21 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 9)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_22 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_23 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_24 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_25 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_26 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_27 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_28 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 6)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_29 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 6)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_30 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 6)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_31 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_32 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_33 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_34 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_35 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_36 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_37 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_38 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_39 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_40 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_41 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_42 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_43 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_44 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_45 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_46 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_47 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_48 := 
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_49 := 
  ((( &( "k_spec_383" ) )) # Int  |->_)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_50 := 
  ((( &( "i_spec_380" ) )) # Int  |->_)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_51 := 
forall (PreH1 : False) ,
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_52 := 
forall (PreH1 : False) ,
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_53 := 
forall (PreH1 : False) ,
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_54 := 
forall (PreH1 : False) ,
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_55 := 
forall (PreH1 : False) ,
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_56 := 
forall (PreH1 : False) ,
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_57 := 
forall (PreH1 : False) ,
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 6)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_58 := 
forall (PreH1 : False) ,
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_59 := 
forall (PreH1 : False) ,
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_60 := 
forall (PreH1 : False) ,
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 9)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_61 := 
forall (PreH1 : False) ,
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 10)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_62 := 
forall (PreH1 : False) ,
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 11)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_63 := 
forall (PreH1 : False) ,
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 12)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_64 := 
forall (PreH1 : False) ,
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 13)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_65 := 
forall (PreH1 : False) ,
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 14)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_66 := 
forall (PreH1 : False) ,
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 15)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_67 := 
forall (PreH1 : False) ,
  ((( &( "k_spec_383" ) )) # Int  |-> 7)
  **  ((( &( "i_spec_380" ) )) # Int  |-> 16)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_return_wit_1 := 
forall (n_pre: Z) (PreH1 : (((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) >= n_pre)) (PreH2 : ((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH3 : (((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH4 : ((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH5 : (((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH6 : ((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH7 : (((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH8 : ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH9 : (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH10 : ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH11 : (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH12 : ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH13 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH14 : ((((0 + 1 ) + 1 ) + 1 ) < n_pre)) (PreH15 : (((0 + 1 ) + 1 ) < n_pre)) (PreH16 : ((0 + 1 ) < n_pre)) (PreH17 : (0 < n_pre)) (PreH18 : (n_pre = 16)) (PreH19 : (0 <= n_pre)) (PreH20 : (n_pre <= 4096)) ,
  TT && emp 
|--
  “ (((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) = n_pre) ”
  &&  emp
.

Definition sample_precondition_wit_1 :=
exists (n_pre: Z) ,
~ ((  “ (n_pre = 16) ” 
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
Axiom proof_of_sample_safety_wit_49 : sample_safety_wit_49.
Axiom proof_of_sample_safety_wit_50 : sample_safety_wit_50.
Axiom proof_of_sample_safety_wit_51 : sample_safety_wit_51.
Axiom proof_of_sample_safety_wit_52 : sample_safety_wit_52.
Axiom proof_of_sample_safety_wit_53 : sample_safety_wit_53.
Axiom proof_of_sample_safety_wit_54 : sample_safety_wit_54.
Axiom proof_of_sample_safety_wit_55 : sample_safety_wit_55.
Axiom proof_of_sample_safety_wit_56 : sample_safety_wit_56.
Axiom proof_of_sample_safety_wit_57 : sample_safety_wit_57.
Axiom proof_of_sample_safety_wit_58 : sample_safety_wit_58.
Axiom proof_of_sample_safety_wit_59 : sample_safety_wit_59.
Axiom proof_of_sample_safety_wit_60 : sample_safety_wit_60.
Axiom proof_of_sample_safety_wit_61 : sample_safety_wit_61.
Axiom proof_of_sample_safety_wit_62 : sample_safety_wit_62.
Axiom proof_of_sample_safety_wit_63 : sample_safety_wit_63.
Axiom proof_of_sample_safety_wit_64 : sample_safety_wit_64.
Axiom proof_of_sample_safety_wit_65 : sample_safety_wit_65.
Axiom proof_of_sample_safety_wit_66 : sample_safety_wit_66.
Axiom proof_of_sample_safety_wit_67 : sample_safety_wit_67.
Axiom proof_of_sample_return_wit_1 : sample_return_wit_1.
Axiom proof_of_sample_precondition_wit_1 : sample_precondition_wit_1.

End VC_Correct.
