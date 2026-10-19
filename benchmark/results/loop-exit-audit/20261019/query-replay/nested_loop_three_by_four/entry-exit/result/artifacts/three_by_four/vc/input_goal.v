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

(*----- Function nested_loop -----*)

Definition nested_loop_safety_wit_1 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 4)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 2)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 12)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_2 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 3)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 2)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 12)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_3 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 3)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 2)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 11)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_4 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 2)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 11)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_5 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 2)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 10)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_6 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 2)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 10)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_7 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 2)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 9)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_8 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 0)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 2)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 9)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_9 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 0)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 2)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_10 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 4)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 2)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_11 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 4)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 1)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_12 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 3)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 1)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_13 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 3)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 1)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_14 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 1)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_15 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 1)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 6)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_16 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 1)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 6)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_17 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 1)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_18 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 0)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 1)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_19 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 0)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 1)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_20 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 4)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 1)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_21 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 4)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 0)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_22 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 3)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 0)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_23 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 3)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 0)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_24 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 0)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_25 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 0)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_26 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 0)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_27 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 0)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_28 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 0)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 0)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_29 := 
  ((( &( "j_spec_393" ) )) # Int  |-> 0)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 0)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_30 := 
  ((( &( "j_spec_393" ) )) # Int  |->_)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 0)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_31 := 
  ((( &( "j_spec_393" ) )) # Int  |->_)
  **  ((( &( "i_spec_390" ) )) # Int  |->_)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_32 := 
  ((( &( "count_spec_387" ) )) # Int  |->_)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_33 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_393" ) )) # Int  |->_)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 0)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  “ False ”
.

Definition nested_loop_safety_wit_34 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_393" ) )) # Int  |-> 0)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 0)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  “ False ”
.

Definition nested_loop_safety_wit_35 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_393" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 0)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  “ False ”
.

Definition nested_loop_safety_wit_36 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_393" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 0)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  “ False ”
.

Definition nested_loop_safety_wit_37 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_393" ) )) # Int  |-> 3)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 0)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  “ False ”
.

Definition nested_loop_safety_wit_38 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_393" ) )) # Int  |-> 4)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 0)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  “ False ”
.

Definition nested_loop_safety_wit_39 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_393" ) )) # Int  |-> 4)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 1)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  “ False ”
.

Definition nested_loop_safety_wit_40 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_393" ) )) # Int  |-> 0)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 1)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  “ False ”
.

Definition nested_loop_safety_wit_41 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_393" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 1)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  “ False ”
.

Definition nested_loop_safety_wit_42 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_393" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 1)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 6)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  “ False ”
.

Definition nested_loop_safety_wit_43 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_393" ) )) # Int  |-> 3)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 1)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  “ False ”
.

Definition nested_loop_safety_wit_44 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_393" ) )) # Int  |-> 4)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 1)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  “ False ”
.

Definition nested_loop_safety_wit_45 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_393" ) )) # Int  |-> 4)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 2)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  “ False ”
.

Definition nested_loop_safety_wit_46 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_393" ) )) # Int  |-> 0)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 2)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  “ False ”
.

Definition nested_loop_safety_wit_47 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_393" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 2)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 9)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  “ False ”
.

Definition nested_loop_safety_wit_48 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_393" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 2)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 10)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  “ False ”
.

Definition nested_loop_safety_wit_49 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_393" ) )) # Int  |-> 3)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 2)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 11)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  “ False ”
.

Definition nested_loop_safety_wit_50 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_393" ) )) # Int  |-> 4)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 2)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 12)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  “ False ”
.

Definition nested_loop_safety_wit_51 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_393" ) )) # Int  |-> 4)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 3)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 12)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 3)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 4)
|--
  “ False ”
.

Definition nested_loop_return_wit_1 := 
forall (m_pre: Z) (n_pre: Z) (M___tespec_entry: Z) (N___tespec_entry: Z) (PreH1 : ((((0 + 1 ) + 1 ) + 1 ) >= n_pre)) (PreH2 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) >= m_pre)) (PreH3 : ((((0 + 1 ) + 1 ) + 1 ) < m_pre)) (PreH4 : (((0 + 1 ) + 1 ) < m_pre)) (PreH5 : ((0 + 1 ) < m_pre)) (PreH6 : (0 < m_pre)) (PreH7 : (((0 + 1 ) + 1 ) < n_pre)) (PreH8 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) >= m_pre)) (PreH9 : ((((0 + 1 ) + 1 ) + 1 ) < m_pre)) (PreH10 : (((0 + 1 ) + 1 ) < m_pre)) (PreH11 : ((0 + 1 ) < m_pre)) (PreH12 : (0 < m_pre)) (PreH13 : ((0 + 1 ) < n_pre)) (PreH14 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) >= m_pre)) (PreH15 : ((((0 + 1 ) + 1 ) + 1 ) < m_pre)) (PreH16 : (((0 + 1 ) + 1 ) < m_pre)) (PreH17 : ((0 + 1 ) < m_pre)) (PreH18 : (0 < m_pre)) (PreH19 : (0 < n_pre)) (PreH20 : (n_pre = 3)) (PreH21 : (m_pre = 4)) (PreH22 : (M___tespec_entry = 4)) (PreH23 : (N___tespec_entry = 3)) (PreH24 : (n_pre = N___tespec_entry)) (PreH25 : (m_pre = M___tespec_entry)) (PreH26 : (0 <= N___tespec_entry)) (PreH27 : (N___tespec_entry <= 100)) (PreH28 : (0 <= M___tespec_entry)) (PreH29 : (M___tespec_entry <= 100)) ,
  TT && emp 
|--
  “ (((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) = (N___tespec_entry * M___tespec_entry )) ”
  &&  emp
.

Definition nested_loop_precondition_wit_1 :=
exists (m_pre: Z) ,
exists (n_pre: Z) ,
exists (M___tespec_entry: Z) ,
exists (N___tespec_entry: Z) ,
~ ((  “ (n_pre = 3) ” 
  &&  “ (m_pre = 4) ” 
  &&  “ (M___tespec_entry = 4) ” 
  &&  “ (N___tespec_entry = 3) ” 
  &&  “ (n_pre = N___tespec_entry) ” 
  &&  “ (m_pre = M___tespec_entry) ” 
  &&  “ (0 <= N___tespec_entry) ” 
  &&  “ (N___tespec_entry <= 100) ” 
  &&  “ (0 <= M___tespec_entry) ” 
  &&  “ (M___tespec_entry <= 100) ”
  &&  emp) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_nested_loop_safety_wit_1 : nested_loop_safety_wit_1.
Axiom proof_of_nested_loop_safety_wit_2 : nested_loop_safety_wit_2.
Axiom proof_of_nested_loop_safety_wit_3 : nested_loop_safety_wit_3.
Axiom proof_of_nested_loop_safety_wit_4 : nested_loop_safety_wit_4.
Axiom proof_of_nested_loop_safety_wit_5 : nested_loop_safety_wit_5.
Axiom proof_of_nested_loop_safety_wit_6 : nested_loop_safety_wit_6.
Axiom proof_of_nested_loop_safety_wit_7 : nested_loop_safety_wit_7.
Axiom proof_of_nested_loop_safety_wit_8 : nested_loop_safety_wit_8.
Axiom proof_of_nested_loop_safety_wit_9 : nested_loop_safety_wit_9.
Axiom proof_of_nested_loop_safety_wit_10 : nested_loop_safety_wit_10.
Axiom proof_of_nested_loop_safety_wit_11 : nested_loop_safety_wit_11.
Axiom proof_of_nested_loop_safety_wit_12 : nested_loop_safety_wit_12.
Axiom proof_of_nested_loop_safety_wit_13 : nested_loop_safety_wit_13.
Axiom proof_of_nested_loop_safety_wit_14 : nested_loop_safety_wit_14.
Axiom proof_of_nested_loop_safety_wit_15 : nested_loop_safety_wit_15.
Axiom proof_of_nested_loop_safety_wit_16 : nested_loop_safety_wit_16.
Axiom proof_of_nested_loop_safety_wit_17 : nested_loop_safety_wit_17.
Axiom proof_of_nested_loop_safety_wit_18 : nested_loop_safety_wit_18.
Axiom proof_of_nested_loop_safety_wit_19 : nested_loop_safety_wit_19.
Axiom proof_of_nested_loop_safety_wit_20 : nested_loop_safety_wit_20.
Axiom proof_of_nested_loop_safety_wit_21 : nested_loop_safety_wit_21.
Axiom proof_of_nested_loop_safety_wit_22 : nested_loop_safety_wit_22.
Axiom proof_of_nested_loop_safety_wit_23 : nested_loop_safety_wit_23.
Axiom proof_of_nested_loop_safety_wit_24 : nested_loop_safety_wit_24.
Axiom proof_of_nested_loop_safety_wit_25 : nested_loop_safety_wit_25.
Axiom proof_of_nested_loop_safety_wit_26 : nested_loop_safety_wit_26.
Axiom proof_of_nested_loop_safety_wit_27 : nested_loop_safety_wit_27.
Axiom proof_of_nested_loop_safety_wit_28 : nested_loop_safety_wit_28.
Axiom proof_of_nested_loop_safety_wit_29 : nested_loop_safety_wit_29.
Axiom proof_of_nested_loop_safety_wit_30 : nested_loop_safety_wit_30.
Axiom proof_of_nested_loop_safety_wit_31 : nested_loop_safety_wit_31.
Axiom proof_of_nested_loop_safety_wit_32 : nested_loop_safety_wit_32.
Axiom proof_of_nested_loop_safety_wit_33 : nested_loop_safety_wit_33.
Axiom proof_of_nested_loop_safety_wit_34 : nested_loop_safety_wit_34.
Axiom proof_of_nested_loop_safety_wit_35 : nested_loop_safety_wit_35.
Axiom proof_of_nested_loop_safety_wit_36 : nested_loop_safety_wit_36.
Axiom proof_of_nested_loop_safety_wit_37 : nested_loop_safety_wit_37.
Axiom proof_of_nested_loop_safety_wit_38 : nested_loop_safety_wit_38.
Axiom proof_of_nested_loop_safety_wit_39 : nested_loop_safety_wit_39.
Axiom proof_of_nested_loop_safety_wit_40 : nested_loop_safety_wit_40.
Axiom proof_of_nested_loop_safety_wit_41 : nested_loop_safety_wit_41.
Axiom proof_of_nested_loop_safety_wit_42 : nested_loop_safety_wit_42.
Axiom proof_of_nested_loop_safety_wit_43 : nested_loop_safety_wit_43.
Axiom proof_of_nested_loop_safety_wit_44 : nested_loop_safety_wit_44.
Axiom proof_of_nested_loop_safety_wit_45 : nested_loop_safety_wit_45.
Axiom proof_of_nested_loop_safety_wit_46 : nested_loop_safety_wit_46.
Axiom proof_of_nested_loop_safety_wit_47 : nested_loop_safety_wit_47.
Axiom proof_of_nested_loop_safety_wit_48 : nested_loop_safety_wit_48.
Axiom proof_of_nested_loop_safety_wit_49 : nested_loop_safety_wit_49.
Axiom proof_of_nested_loop_safety_wit_50 : nested_loop_safety_wit_50.
Axiom proof_of_nested_loop_safety_wit_51 : nested_loop_safety_wit_51.
Axiom proof_of_nested_loop_return_wit_1 : nested_loop_return_wit_1.
Axiom proof_of_nested_loop_precondition_wit_1 : nested_loop_precondition_wit_1.

End VC_Correct.
