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
  ((( &( "i_spec_380" ) )) # Int  |-> 15)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_2 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 14)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_3 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 13)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_4 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 12)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_5 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 11)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_6 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 10)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_7 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 9)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_8 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_9 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_10 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 6)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_11 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_12 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_13 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_14 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_15 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_16 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_17 := 
  ((( &( "i_spec_380" ) )) # Int  |->_)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_18 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_19 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_20 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_21 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_22 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_23 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_24 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_25 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_26 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_27 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_28 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_29 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_30 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_31 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_32 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_33 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_34 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_35 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_36 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_37 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_38 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_39 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_40 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_41 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_42 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 6)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_43 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 6)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_44 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 6)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_45 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 6)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_46 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_47 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_48 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_49 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_50 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_51 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_52 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_53 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_54 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 9)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_55 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 9)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_56 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 9)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_57 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 9)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_58 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 10)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_59 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 10)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_60 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 10)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_61 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 10)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_62 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 11)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_63 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 11)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_64 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 11)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_65 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 11)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_66 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 12)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_67 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 12)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_68 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 12)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_69 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 12)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_70 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 13)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_71 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 13)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_72 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 13)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_73 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 13)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_74 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 14)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_75 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 14)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_76 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 14)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_77 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 14)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_78 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 15)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_79 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 15)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_80 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 15)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  TT && emp 
.

Definition sample_safety_wit_81 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 15)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
|--
  “ False ”
.

Definition sample_safety_wit_82 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 16)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 16)
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
forall (n_pre: Z) (PreH1 : (((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) >= n_pre)) (PreH2 : ((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) = (n_pre - 1 ))) (PreH3 : ((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH4 : (((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH5 : (((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH6 : ((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH7 : ((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH8 : (((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH9 : (((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH10 : ((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH11 : ((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH12 : (((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH13 : (((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH14 : ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH15 : ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH16 : (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH17 : (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH18 : ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH19 : ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH20 : (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH21 : (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH22 : ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH23 : ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH24 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH25 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH26 : ((((0 + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH27 : ((((0 + 1 ) + 1 ) + 1 ) < n_pre)) (PreH28 : (((0 + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH29 : (((0 + 1 ) + 1 ) < n_pre)) (PreH30 : ((0 + 1 ) <> (n_pre - 1 ))) (PreH31 : ((0 + 1 ) < n_pre)) (PreH32 : (0 <> (n_pre - 1 ))) (PreH33 : (0 < n_pre)) (PreH34 : (n_pre = 16)) (PreH35 : (0 <= n_pre)) (PreH36 : (n_pre <= 4096)) ,
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
Axiom proof_of_sample_safety_wit_68 : sample_safety_wit_68.
Axiom proof_of_sample_safety_wit_69 : sample_safety_wit_69.
Axiom proof_of_sample_safety_wit_70 : sample_safety_wit_70.
Axiom proof_of_sample_safety_wit_71 : sample_safety_wit_71.
Axiom proof_of_sample_safety_wit_72 : sample_safety_wit_72.
Axiom proof_of_sample_safety_wit_73 : sample_safety_wit_73.
Axiom proof_of_sample_safety_wit_74 : sample_safety_wit_74.
Axiom proof_of_sample_safety_wit_75 : sample_safety_wit_75.
Axiom proof_of_sample_safety_wit_76 : sample_safety_wit_76.
Axiom proof_of_sample_safety_wit_77 : sample_safety_wit_77.
Axiom proof_of_sample_safety_wit_78 : sample_safety_wit_78.
Axiom proof_of_sample_safety_wit_79 : sample_safety_wit_79.
Axiom proof_of_sample_safety_wit_80 : sample_safety_wit_80.
Axiom proof_of_sample_safety_wit_81 : sample_safety_wit_81.
Axiom proof_of_sample_safety_wit_82 : sample_safety_wit_82.
Axiom proof_of_sample_entail_wit_1 : sample_entail_wit_1.
Axiom proof_of_sample_return_wit_1 : sample_return_wit_1.
Axiom proof_of_sample_precondition_wit_1 : sample_precondition_wit_1.

End VC_Correct.
