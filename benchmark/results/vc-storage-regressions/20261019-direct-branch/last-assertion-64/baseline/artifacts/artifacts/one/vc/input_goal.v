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
  ((( &( "i_spec_380" ) )) # Int  |-> 63)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_2 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 62)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_3 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 61)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_4 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 60)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_5 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 59)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_6 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 58)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_7 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 57)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_8 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 56)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_9 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 55)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_10 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 54)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_11 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 53)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_12 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 52)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_13 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 51)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_14 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 50)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_15 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 49)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_16 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 48)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_17 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 47)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_18 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 46)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_19 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 45)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_20 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 44)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_21 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 43)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_22 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 42)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_23 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 41)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_24 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 40)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_25 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 39)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_26 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 38)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_27 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 37)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_28 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 36)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_29 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 35)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_30 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 34)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_31 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 33)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_32 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 32)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_33 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 31)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_34 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 30)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_35 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 29)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_36 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 28)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_37 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 27)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_38 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 26)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_39 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 25)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_40 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 24)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_41 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 23)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_42 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 22)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_43 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 21)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_44 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 20)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_45 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 19)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_46 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 18)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_47 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 17)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_48 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 16)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_49 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 15)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_50 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 14)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_51 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 13)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_52 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 12)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_53 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 11)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_54 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 10)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_55 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 9)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_56 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_57 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_58 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 6)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_59 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_60 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_61 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_62 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_63 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_64 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_65 := 
  ((( &( "i_spec_380" ) )) # Int  |->_)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_66 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_67 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_68 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_69 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_70 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_71 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_72 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_73 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_74 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_75 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_76 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_77 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_78 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_79 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_80 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_81 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_82 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_83 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_84 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_85 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_86 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_87 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_88 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_89 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_90 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 6)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_91 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 6)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_92 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 6)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_93 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 6)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_94 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_95 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_96 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_97 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_98 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_99 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_100 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_101 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_102 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 9)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_103 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 9)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_104 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 9)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_105 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 9)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_106 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 10)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_107 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 10)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_108 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 10)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_109 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 10)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_110 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 11)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_111 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 11)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_112 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 11)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_113 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 11)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_114 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 12)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_115 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 12)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_116 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 12)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_117 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 12)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_118 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 13)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_119 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 13)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_120 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 13)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_121 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 13)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_122 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 14)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_123 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 14)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_124 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 14)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_125 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 14)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_126 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 15)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_127 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 15)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_128 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 15)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_129 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 15)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_130 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 16)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_131 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 16)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_132 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 16)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_133 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 16)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_134 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 17)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_135 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 17)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_136 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 17)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_137 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 17)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_138 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 18)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_139 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 18)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_140 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 18)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_141 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 18)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_142 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 19)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_143 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 19)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_144 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 19)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_145 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 19)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_146 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 20)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_147 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 20)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_148 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 20)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_149 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 20)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_150 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 21)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_151 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 21)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_152 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 21)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_153 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 21)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_154 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 22)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_155 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 22)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_156 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 22)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_157 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 22)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_158 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 23)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_159 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 23)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_160 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 23)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_161 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 23)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_162 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 24)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_163 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 24)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_164 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 24)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_165 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 24)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_166 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 25)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_167 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 25)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_168 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 25)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_169 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 25)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_170 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 26)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_171 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 26)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_172 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 26)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_173 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 26)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_174 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 27)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_175 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 27)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_176 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 27)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_177 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 27)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_178 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 28)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_179 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 28)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_180 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 28)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_181 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 28)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_182 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 29)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_183 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 29)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_184 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 29)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_185 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 29)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_186 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 30)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_187 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 30)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_188 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 30)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_189 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 30)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_190 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 31)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_191 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 31)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_192 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 31)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_193 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 31)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_194 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 32)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_195 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 32)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_196 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 32)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_197 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 32)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_198 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 33)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_199 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 33)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_200 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 33)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_201 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 33)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_202 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 34)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_203 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 34)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_204 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 34)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_205 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 34)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_206 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 35)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_207 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 35)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_208 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 35)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_209 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 35)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_210 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 36)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_211 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 36)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_212 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 36)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_213 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 36)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_214 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 37)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_215 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 37)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_216 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 37)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_217 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 37)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_218 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 38)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_219 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 38)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_220 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 38)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_221 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 38)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_222 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 39)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_223 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 39)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_224 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 39)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_225 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 39)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_226 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 40)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_227 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 40)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_228 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 40)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_229 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 40)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_230 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 41)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_231 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 41)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_232 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 41)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_233 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 41)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_234 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 42)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_235 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 42)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_236 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 42)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_237 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 42)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_238 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 43)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_239 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 43)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_240 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 43)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_241 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 43)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_242 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 44)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_243 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 44)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_244 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 44)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_245 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 44)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_246 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 45)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_247 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 45)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_248 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 45)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_249 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 45)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_250 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 46)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_251 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 46)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_252 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 46)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_253 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 46)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_254 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 47)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_255 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 47)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_256 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 47)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_257 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 47)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_258 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 48)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_259 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 48)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_260 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 48)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_261 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 48)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_262 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 49)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_263 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 49)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_264 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 49)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_265 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 49)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_266 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 50)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_267 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 50)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_268 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 50)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_269 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 50)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_270 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 51)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_271 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 51)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_272 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 51)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_273 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 51)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_274 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 52)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_275 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 52)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_276 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 52)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_277 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 52)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_278 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 53)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_279 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 53)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_280 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 53)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_281 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 53)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_282 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 54)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_283 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 54)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_284 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 54)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_285 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 54)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_286 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 55)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_287 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 55)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_288 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 55)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_289 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 55)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_290 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 56)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_291 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 56)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_292 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 56)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_293 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 56)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_294 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 57)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_295 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 57)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_296 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 57)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_297 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 57)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_298 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 58)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_299 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 58)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_300 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 58)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_301 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 58)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_302 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 59)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_303 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 59)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_304 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 59)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_305 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 59)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_306 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 60)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_307 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 60)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_308 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 60)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_309 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 60)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_310 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 61)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_311 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 61)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_312 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 61)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_313 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 61)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_314 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 62)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_315 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 62)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_316 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 62)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_317 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 62)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_318 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 63)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_319 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 63)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_320 := 
  ((( &( "i_spec_380" ) )) # Int  |-> 63)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  TT && emp 
.

Definition sample_safety_wit_321 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 63)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
|--
  “ False ”
.

Definition sample_safety_wit_322 := 
forall (PreH1 : False) ,
  ((( &( "i_spec_380" ) )) # Int  |-> 64)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 64)
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
forall (n_pre: Z) (PreH1 : (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) >= n_pre)) (PreH2 : ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) = (n_pre - 1 ))) (PreH3 : ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH4 : (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH5 : (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH6 : ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH7 : ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH8 : (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH9 : (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH10 : ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH11 : ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH12 : (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH13 : (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH14 : ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH15 : ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH16 : (((((((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH17 : (((((((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH18 : ((((((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH19 : ((((((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH20 : (((((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH21 : (((((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH22 : ((((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH23 : ((((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH24 : (((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH25 : (((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH26 : ((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH27 : ((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH28 : (((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH29 : (((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH30 : ((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH31 : ((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH32 : (((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH33 : (((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH34 : ((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH35 : ((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH36 : (((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH37 : (((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH38 : ((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH39 : ((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH40 : (((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH41 : (((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH42 : ((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH43 : ((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH44 : (((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH45 : (((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH46 : ((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH47 : ((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH48 : (((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH49 : (((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH50 : ((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH51 : ((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH52 : (((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH53 : (((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH54 : ((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH55 : ((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH56 : (((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH57 : (((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH58 : ((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH59 : ((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH60 : (((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH61 : (((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH62 : ((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH63 : ((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH64 : (((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH65 : (((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH66 : ((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH67 : ((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH68 : (((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH69 : (((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH70 : ((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH71 : ((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH72 : (((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH73 : (((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH74 : ((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH75 : ((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH76 : (((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH77 : (((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH78 : ((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH79 : ((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH80 : (((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH81 : (((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH82 : ((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH83 : ((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH84 : (((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH85 : (((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH86 : ((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH87 : ((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH88 : (((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH89 : (((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH90 : ((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH91 : ((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH92 : (((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH93 : (((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH94 : ((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH95 : ((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH96 : (((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH97 : (((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH98 : ((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH99 : ((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH100 : (((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH101 : (((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH102 : ((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH103 : ((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH104 : (((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH105 : (((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH106 : ((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH107 : ((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH108 : (((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH109 : (((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH110 : ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH111 : ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH112 : (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH113 : (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH114 : ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH115 : ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH116 : (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH117 : (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH118 : ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH119 : ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH120 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH121 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH122 : ((((0 + 1 ) + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH123 : ((((0 + 1 ) + 1 ) + 1 ) < n_pre)) (PreH124 : (((0 + 1 ) + 1 ) <> (n_pre - 1 ))) (PreH125 : (((0 + 1 ) + 1 ) < n_pre)) (PreH126 : ((0 + 1 ) <> (n_pre - 1 ))) (PreH127 : ((0 + 1 ) < n_pre)) (PreH128 : (0 <> (n_pre - 1 ))) (PreH129 : (0 < n_pre)) (PreH130 : (n_pre = 64)) (PreH131 : (0 <= n_pre)) (PreH132 : (n_pre <= 4096)) ,
  TT && emp 
|--
  “ (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) = n_pre) ”
  &&  emp
.

Definition sample_precondition_wit_1 :=
exists (n_pre: Z) ,
~ ((  “ (n_pre = 64) ” 
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
Axiom proof_of_sample_safety_wit_83 : sample_safety_wit_83.
Axiom proof_of_sample_safety_wit_84 : sample_safety_wit_84.
Axiom proof_of_sample_safety_wit_85 : sample_safety_wit_85.
Axiom proof_of_sample_safety_wit_86 : sample_safety_wit_86.
Axiom proof_of_sample_safety_wit_87 : sample_safety_wit_87.
Axiom proof_of_sample_safety_wit_88 : sample_safety_wit_88.
Axiom proof_of_sample_safety_wit_89 : sample_safety_wit_89.
Axiom proof_of_sample_safety_wit_90 : sample_safety_wit_90.
Axiom proof_of_sample_safety_wit_91 : sample_safety_wit_91.
Axiom proof_of_sample_safety_wit_92 : sample_safety_wit_92.
Axiom proof_of_sample_safety_wit_93 : sample_safety_wit_93.
Axiom proof_of_sample_safety_wit_94 : sample_safety_wit_94.
Axiom proof_of_sample_safety_wit_95 : sample_safety_wit_95.
Axiom proof_of_sample_safety_wit_96 : sample_safety_wit_96.
Axiom proof_of_sample_safety_wit_97 : sample_safety_wit_97.
Axiom proof_of_sample_safety_wit_98 : sample_safety_wit_98.
Axiom proof_of_sample_safety_wit_99 : sample_safety_wit_99.
Axiom proof_of_sample_safety_wit_100 : sample_safety_wit_100.
Axiom proof_of_sample_safety_wit_101 : sample_safety_wit_101.
Axiom proof_of_sample_safety_wit_102 : sample_safety_wit_102.
Axiom proof_of_sample_safety_wit_103 : sample_safety_wit_103.
Axiom proof_of_sample_safety_wit_104 : sample_safety_wit_104.
Axiom proof_of_sample_safety_wit_105 : sample_safety_wit_105.
Axiom proof_of_sample_safety_wit_106 : sample_safety_wit_106.
Axiom proof_of_sample_safety_wit_107 : sample_safety_wit_107.
Axiom proof_of_sample_safety_wit_108 : sample_safety_wit_108.
Axiom proof_of_sample_safety_wit_109 : sample_safety_wit_109.
Axiom proof_of_sample_safety_wit_110 : sample_safety_wit_110.
Axiom proof_of_sample_safety_wit_111 : sample_safety_wit_111.
Axiom proof_of_sample_safety_wit_112 : sample_safety_wit_112.
Axiom proof_of_sample_safety_wit_113 : sample_safety_wit_113.
Axiom proof_of_sample_safety_wit_114 : sample_safety_wit_114.
Axiom proof_of_sample_safety_wit_115 : sample_safety_wit_115.
Axiom proof_of_sample_safety_wit_116 : sample_safety_wit_116.
Axiom proof_of_sample_safety_wit_117 : sample_safety_wit_117.
Axiom proof_of_sample_safety_wit_118 : sample_safety_wit_118.
Axiom proof_of_sample_safety_wit_119 : sample_safety_wit_119.
Axiom proof_of_sample_safety_wit_120 : sample_safety_wit_120.
Axiom proof_of_sample_safety_wit_121 : sample_safety_wit_121.
Axiom proof_of_sample_safety_wit_122 : sample_safety_wit_122.
Axiom proof_of_sample_safety_wit_123 : sample_safety_wit_123.
Axiom proof_of_sample_safety_wit_124 : sample_safety_wit_124.
Axiom proof_of_sample_safety_wit_125 : sample_safety_wit_125.
Axiom proof_of_sample_safety_wit_126 : sample_safety_wit_126.
Axiom proof_of_sample_safety_wit_127 : sample_safety_wit_127.
Axiom proof_of_sample_safety_wit_128 : sample_safety_wit_128.
Axiom proof_of_sample_safety_wit_129 : sample_safety_wit_129.
Axiom proof_of_sample_safety_wit_130 : sample_safety_wit_130.
Axiom proof_of_sample_safety_wit_131 : sample_safety_wit_131.
Axiom proof_of_sample_safety_wit_132 : sample_safety_wit_132.
Axiom proof_of_sample_safety_wit_133 : sample_safety_wit_133.
Axiom proof_of_sample_safety_wit_134 : sample_safety_wit_134.
Axiom proof_of_sample_safety_wit_135 : sample_safety_wit_135.
Axiom proof_of_sample_safety_wit_136 : sample_safety_wit_136.
Axiom proof_of_sample_safety_wit_137 : sample_safety_wit_137.
Axiom proof_of_sample_safety_wit_138 : sample_safety_wit_138.
Axiom proof_of_sample_safety_wit_139 : sample_safety_wit_139.
Axiom proof_of_sample_safety_wit_140 : sample_safety_wit_140.
Axiom proof_of_sample_safety_wit_141 : sample_safety_wit_141.
Axiom proof_of_sample_safety_wit_142 : sample_safety_wit_142.
Axiom proof_of_sample_safety_wit_143 : sample_safety_wit_143.
Axiom proof_of_sample_safety_wit_144 : sample_safety_wit_144.
Axiom proof_of_sample_safety_wit_145 : sample_safety_wit_145.
Axiom proof_of_sample_safety_wit_146 : sample_safety_wit_146.
Axiom proof_of_sample_safety_wit_147 : sample_safety_wit_147.
Axiom proof_of_sample_safety_wit_148 : sample_safety_wit_148.
Axiom proof_of_sample_safety_wit_149 : sample_safety_wit_149.
Axiom proof_of_sample_safety_wit_150 : sample_safety_wit_150.
Axiom proof_of_sample_safety_wit_151 : sample_safety_wit_151.
Axiom proof_of_sample_safety_wit_152 : sample_safety_wit_152.
Axiom proof_of_sample_safety_wit_153 : sample_safety_wit_153.
Axiom proof_of_sample_safety_wit_154 : sample_safety_wit_154.
Axiom proof_of_sample_safety_wit_155 : sample_safety_wit_155.
Axiom proof_of_sample_safety_wit_156 : sample_safety_wit_156.
Axiom proof_of_sample_safety_wit_157 : sample_safety_wit_157.
Axiom proof_of_sample_safety_wit_158 : sample_safety_wit_158.
Axiom proof_of_sample_safety_wit_159 : sample_safety_wit_159.
Axiom proof_of_sample_safety_wit_160 : sample_safety_wit_160.
Axiom proof_of_sample_safety_wit_161 : sample_safety_wit_161.
Axiom proof_of_sample_safety_wit_162 : sample_safety_wit_162.
Axiom proof_of_sample_safety_wit_163 : sample_safety_wit_163.
Axiom proof_of_sample_safety_wit_164 : sample_safety_wit_164.
Axiom proof_of_sample_safety_wit_165 : sample_safety_wit_165.
Axiom proof_of_sample_safety_wit_166 : sample_safety_wit_166.
Axiom proof_of_sample_safety_wit_167 : sample_safety_wit_167.
Axiom proof_of_sample_safety_wit_168 : sample_safety_wit_168.
Axiom proof_of_sample_safety_wit_169 : sample_safety_wit_169.
Axiom proof_of_sample_safety_wit_170 : sample_safety_wit_170.
Axiom proof_of_sample_safety_wit_171 : sample_safety_wit_171.
Axiom proof_of_sample_safety_wit_172 : sample_safety_wit_172.
Axiom proof_of_sample_safety_wit_173 : sample_safety_wit_173.
Axiom proof_of_sample_safety_wit_174 : sample_safety_wit_174.
Axiom proof_of_sample_safety_wit_175 : sample_safety_wit_175.
Axiom proof_of_sample_safety_wit_176 : sample_safety_wit_176.
Axiom proof_of_sample_safety_wit_177 : sample_safety_wit_177.
Axiom proof_of_sample_safety_wit_178 : sample_safety_wit_178.
Axiom proof_of_sample_safety_wit_179 : sample_safety_wit_179.
Axiom proof_of_sample_safety_wit_180 : sample_safety_wit_180.
Axiom proof_of_sample_safety_wit_181 : sample_safety_wit_181.
Axiom proof_of_sample_safety_wit_182 : sample_safety_wit_182.
Axiom proof_of_sample_safety_wit_183 : sample_safety_wit_183.
Axiom proof_of_sample_safety_wit_184 : sample_safety_wit_184.
Axiom proof_of_sample_safety_wit_185 : sample_safety_wit_185.
Axiom proof_of_sample_safety_wit_186 : sample_safety_wit_186.
Axiom proof_of_sample_safety_wit_187 : sample_safety_wit_187.
Axiom proof_of_sample_safety_wit_188 : sample_safety_wit_188.
Axiom proof_of_sample_safety_wit_189 : sample_safety_wit_189.
Axiom proof_of_sample_safety_wit_190 : sample_safety_wit_190.
Axiom proof_of_sample_safety_wit_191 : sample_safety_wit_191.
Axiom proof_of_sample_safety_wit_192 : sample_safety_wit_192.
Axiom proof_of_sample_safety_wit_193 : sample_safety_wit_193.
Axiom proof_of_sample_safety_wit_194 : sample_safety_wit_194.
Axiom proof_of_sample_safety_wit_195 : sample_safety_wit_195.
Axiom proof_of_sample_safety_wit_196 : sample_safety_wit_196.
Axiom proof_of_sample_safety_wit_197 : sample_safety_wit_197.
Axiom proof_of_sample_safety_wit_198 : sample_safety_wit_198.
Axiom proof_of_sample_safety_wit_199 : sample_safety_wit_199.
Axiom proof_of_sample_safety_wit_200 : sample_safety_wit_200.
Axiom proof_of_sample_safety_wit_201 : sample_safety_wit_201.
Axiom proof_of_sample_safety_wit_202 : sample_safety_wit_202.
Axiom proof_of_sample_safety_wit_203 : sample_safety_wit_203.
Axiom proof_of_sample_safety_wit_204 : sample_safety_wit_204.
Axiom proof_of_sample_safety_wit_205 : sample_safety_wit_205.
Axiom proof_of_sample_safety_wit_206 : sample_safety_wit_206.
Axiom proof_of_sample_safety_wit_207 : sample_safety_wit_207.
Axiom proof_of_sample_safety_wit_208 : sample_safety_wit_208.
Axiom proof_of_sample_safety_wit_209 : sample_safety_wit_209.
Axiom proof_of_sample_safety_wit_210 : sample_safety_wit_210.
Axiom proof_of_sample_safety_wit_211 : sample_safety_wit_211.
Axiom proof_of_sample_safety_wit_212 : sample_safety_wit_212.
Axiom proof_of_sample_safety_wit_213 : sample_safety_wit_213.
Axiom proof_of_sample_safety_wit_214 : sample_safety_wit_214.
Axiom proof_of_sample_safety_wit_215 : sample_safety_wit_215.
Axiom proof_of_sample_safety_wit_216 : sample_safety_wit_216.
Axiom proof_of_sample_safety_wit_217 : sample_safety_wit_217.
Axiom proof_of_sample_safety_wit_218 : sample_safety_wit_218.
Axiom proof_of_sample_safety_wit_219 : sample_safety_wit_219.
Axiom proof_of_sample_safety_wit_220 : sample_safety_wit_220.
Axiom proof_of_sample_safety_wit_221 : sample_safety_wit_221.
Axiom proof_of_sample_safety_wit_222 : sample_safety_wit_222.
Axiom proof_of_sample_safety_wit_223 : sample_safety_wit_223.
Axiom proof_of_sample_safety_wit_224 : sample_safety_wit_224.
Axiom proof_of_sample_safety_wit_225 : sample_safety_wit_225.
Axiom proof_of_sample_safety_wit_226 : sample_safety_wit_226.
Axiom proof_of_sample_safety_wit_227 : sample_safety_wit_227.
Axiom proof_of_sample_safety_wit_228 : sample_safety_wit_228.
Axiom proof_of_sample_safety_wit_229 : sample_safety_wit_229.
Axiom proof_of_sample_safety_wit_230 : sample_safety_wit_230.
Axiom proof_of_sample_safety_wit_231 : sample_safety_wit_231.
Axiom proof_of_sample_safety_wit_232 : sample_safety_wit_232.
Axiom proof_of_sample_safety_wit_233 : sample_safety_wit_233.
Axiom proof_of_sample_safety_wit_234 : sample_safety_wit_234.
Axiom proof_of_sample_safety_wit_235 : sample_safety_wit_235.
Axiom proof_of_sample_safety_wit_236 : sample_safety_wit_236.
Axiom proof_of_sample_safety_wit_237 : sample_safety_wit_237.
Axiom proof_of_sample_safety_wit_238 : sample_safety_wit_238.
Axiom proof_of_sample_safety_wit_239 : sample_safety_wit_239.
Axiom proof_of_sample_safety_wit_240 : sample_safety_wit_240.
Axiom proof_of_sample_safety_wit_241 : sample_safety_wit_241.
Axiom proof_of_sample_safety_wit_242 : sample_safety_wit_242.
Axiom proof_of_sample_safety_wit_243 : sample_safety_wit_243.
Axiom proof_of_sample_safety_wit_244 : sample_safety_wit_244.
Axiom proof_of_sample_safety_wit_245 : sample_safety_wit_245.
Axiom proof_of_sample_safety_wit_246 : sample_safety_wit_246.
Axiom proof_of_sample_safety_wit_247 : sample_safety_wit_247.
Axiom proof_of_sample_safety_wit_248 : sample_safety_wit_248.
Axiom proof_of_sample_safety_wit_249 : sample_safety_wit_249.
Axiom proof_of_sample_safety_wit_250 : sample_safety_wit_250.
Axiom proof_of_sample_safety_wit_251 : sample_safety_wit_251.
Axiom proof_of_sample_safety_wit_252 : sample_safety_wit_252.
Axiom proof_of_sample_safety_wit_253 : sample_safety_wit_253.
Axiom proof_of_sample_safety_wit_254 : sample_safety_wit_254.
Axiom proof_of_sample_safety_wit_255 : sample_safety_wit_255.
Axiom proof_of_sample_safety_wit_256 : sample_safety_wit_256.
Axiom proof_of_sample_safety_wit_257 : sample_safety_wit_257.
Axiom proof_of_sample_safety_wit_258 : sample_safety_wit_258.
Axiom proof_of_sample_safety_wit_259 : sample_safety_wit_259.
Axiom proof_of_sample_safety_wit_260 : sample_safety_wit_260.
Axiom proof_of_sample_safety_wit_261 : sample_safety_wit_261.
Axiom proof_of_sample_safety_wit_262 : sample_safety_wit_262.
Axiom proof_of_sample_safety_wit_263 : sample_safety_wit_263.
Axiom proof_of_sample_safety_wit_264 : sample_safety_wit_264.
Axiom proof_of_sample_safety_wit_265 : sample_safety_wit_265.
Axiom proof_of_sample_safety_wit_266 : sample_safety_wit_266.
Axiom proof_of_sample_safety_wit_267 : sample_safety_wit_267.
Axiom proof_of_sample_safety_wit_268 : sample_safety_wit_268.
Axiom proof_of_sample_safety_wit_269 : sample_safety_wit_269.
Axiom proof_of_sample_safety_wit_270 : sample_safety_wit_270.
Axiom proof_of_sample_safety_wit_271 : sample_safety_wit_271.
Axiom proof_of_sample_safety_wit_272 : sample_safety_wit_272.
Axiom proof_of_sample_safety_wit_273 : sample_safety_wit_273.
Axiom proof_of_sample_safety_wit_274 : sample_safety_wit_274.
Axiom proof_of_sample_safety_wit_275 : sample_safety_wit_275.
Axiom proof_of_sample_safety_wit_276 : sample_safety_wit_276.
Axiom proof_of_sample_safety_wit_277 : sample_safety_wit_277.
Axiom proof_of_sample_safety_wit_278 : sample_safety_wit_278.
Axiom proof_of_sample_safety_wit_279 : sample_safety_wit_279.
Axiom proof_of_sample_safety_wit_280 : sample_safety_wit_280.
Axiom proof_of_sample_safety_wit_281 : sample_safety_wit_281.
Axiom proof_of_sample_safety_wit_282 : sample_safety_wit_282.
Axiom proof_of_sample_safety_wit_283 : sample_safety_wit_283.
Axiom proof_of_sample_safety_wit_284 : sample_safety_wit_284.
Axiom proof_of_sample_safety_wit_285 : sample_safety_wit_285.
Axiom proof_of_sample_safety_wit_286 : sample_safety_wit_286.
Axiom proof_of_sample_safety_wit_287 : sample_safety_wit_287.
Axiom proof_of_sample_safety_wit_288 : sample_safety_wit_288.
Axiom proof_of_sample_safety_wit_289 : sample_safety_wit_289.
Axiom proof_of_sample_safety_wit_290 : sample_safety_wit_290.
Axiom proof_of_sample_safety_wit_291 : sample_safety_wit_291.
Axiom proof_of_sample_safety_wit_292 : sample_safety_wit_292.
Axiom proof_of_sample_safety_wit_293 : sample_safety_wit_293.
Axiom proof_of_sample_safety_wit_294 : sample_safety_wit_294.
Axiom proof_of_sample_safety_wit_295 : sample_safety_wit_295.
Axiom proof_of_sample_safety_wit_296 : sample_safety_wit_296.
Axiom proof_of_sample_safety_wit_297 : sample_safety_wit_297.
Axiom proof_of_sample_safety_wit_298 : sample_safety_wit_298.
Axiom proof_of_sample_safety_wit_299 : sample_safety_wit_299.
Axiom proof_of_sample_safety_wit_300 : sample_safety_wit_300.
Axiom proof_of_sample_safety_wit_301 : sample_safety_wit_301.
Axiom proof_of_sample_safety_wit_302 : sample_safety_wit_302.
Axiom proof_of_sample_safety_wit_303 : sample_safety_wit_303.
Axiom proof_of_sample_safety_wit_304 : sample_safety_wit_304.
Axiom proof_of_sample_safety_wit_305 : sample_safety_wit_305.
Axiom proof_of_sample_safety_wit_306 : sample_safety_wit_306.
Axiom proof_of_sample_safety_wit_307 : sample_safety_wit_307.
Axiom proof_of_sample_safety_wit_308 : sample_safety_wit_308.
Axiom proof_of_sample_safety_wit_309 : sample_safety_wit_309.
Axiom proof_of_sample_safety_wit_310 : sample_safety_wit_310.
Axiom proof_of_sample_safety_wit_311 : sample_safety_wit_311.
Axiom proof_of_sample_safety_wit_312 : sample_safety_wit_312.
Axiom proof_of_sample_safety_wit_313 : sample_safety_wit_313.
Axiom proof_of_sample_safety_wit_314 : sample_safety_wit_314.
Axiom proof_of_sample_safety_wit_315 : sample_safety_wit_315.
Axiom proof_of_sample_safety_wit_316 : sample_safety_wit_316.
Axiom proof_of_sample_safety_wit_317 : sample_safety_wit_317.
Axiom proof_of_sample_safety_wit_318 : sample_safety_wit_318.
Axiom proof_of_sample_safety_wit_319 : sample_safety_wit_319.
Axiom proof_of_sample_safety_wit_320 : sample_safety_wit_320.
Axiom proof_of_sample_safety_wit_321 : sample_safety_wit_321.
Axiom proof_of_sample_safety_wit_322 : sample_safety_wit_322.
Axiom proof_of_sample_entail_wit_1 : sample_entail_wit_1.
Axiom proof_of_sample_return_wit_1 : sample_return_wit_1.
Axiom proof_of_sample_precondition_wit_1 : sample_precondition_wit_1.

End VC_Correct.
