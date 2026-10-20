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

(*----- Function main -----*)

Definition main_safety_wit_1 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (retval_3 = 2)) (PreH2 : (retval_2 = 1)) (PreH3 : (retval = 0)) (PreH4 : (( &( "a_spec_395" ) ) = 4096)) (PreH5 : (( &( "zero_spec_398" ) ) = 8192)) (PreH6 : (( &( "first_spec_410" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : (( &( "second_spec_437" ) ) = 20480)) (PreH9 : (( &( "two_spec_452" ) ) = 24576)) (PreH10 : (( &( "third_spec_476" ) ) = 28672)) ,
  ((28672) # Ptr  |-> 4104)
  **  ((8192) # Int  |-> 0)
  **  ((12288) # Ptr  |-> 4096)
  **  ((16384) # Int  |-> 1)
  **  ((20480) # Ptr  |-> 4100)
  **  ((24576) # Int  |-> 2)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_2 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (retval_3 = 2)) (PreH2 : (retval_2 = 1)) (PreH3 : (retval = 0)) (PreH4 : (( &( "a_spec_395" ) ) = 4096)) (PreH5 : (( &( "zero_spec_398" ) ) = 8192)) (PreH6 : (( &( "first_spec_410" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : (( &( "second_spec_437" ) ) = 20480)) (PreH9 : (( &( "two_spec_452" ) ) = 24576)) ,
  ((( &( "third_spec_476" ) )) # Ptr  |->_)
  **  ((24576) # Int  |-> 2)
  **  ((8192) # Int  |-> 0)
  **  ((12288) # Ptr  |-> 4096)
  **  ((16384) # Int  |-> 1)
  **  ((20480) # Ptr  |-> 4100)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_3 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (retval_3 = 2)) (PreH2 : (retval_2 = 1)) (PreH3 : (retval = 0)) (PreH4 : (( &( "a_spec_395" ) ) = 4096)) (PreH5 : (( &( "zero_spec_398" ) ) = 8192)) (PreH6 : (( &( "first_spec_410" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : (( &( "second_spec_437" ) ) = 20480)) (PreH9 : (( &( "two_spec_452" ) ) = 24576)) ,
  ((( &( "third_spec_476" ) )) # Ptr  |->_)
  **  ((24576) # Int  |-> 2)
  **  ((8192) # Int  |-> 0)
  **  ((12288) # Ptr  |-> 4096)
  **  ((16384) # Int  |-> 1)
  **  ((20480) # Ptr  |-> 4100)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_4 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (retval_2 = 1)) (PreH2 : (retval = 0)) (PreH3 : (( &( "a_spec_395" ) ) = 4096)) (PreH4 : (( &( "zero_spec_398" ) ) = 8192)) (PreH5 : (( &( "first_spec_410" ) ) = 12288)) (PreH6 : (( &( "one_spec_419" ) ) = 16384)) (PreH7 : (( &( "second_spec_437" ) ) = 20480)) ,
  ((( &( "two_spec_452" ) )) # Int  |->_)
  **  ((20480) # Ptr  |-> 4100)
  **  ((8192) # Int  |-> 0)
  **  ((12288) # Ptr  |-> 4096)
  **  ((16384) # Int  |-> 1)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_5 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (retval_2 = 1)) (PreH2 : (retval = 0)) (PreH3 : (( &( "a_spec_395" ) ) = 4096)) (PreH4 : (( &( "zero_spec_398" ) ) = 8192)) (PreH5 : (( &( "first_spec_410" ) ) = 12288)) (PreH6 : (( &( "one_spec_419" ) ) = 16384)) (PreH7 : (( &( "second_spec_437" ) ) = 20480)) ,
  ((( &( "two_spec_452" ) )) # Int  |->_)
  **  ((20480) # Ptr  |-> 4100)
  **  ((8192) # Int  |-> 0)
  **  ((12288) # Ptr  |-> 4096)
  **  ((16384) # Int  |-> 1)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_6 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (retval_2 = 1)) (PreH2 : (retval = 0)) (PreH3 : (( &( "a_spec_395" ) ) = 4096)) (PreH4 : (( &( "zero_spec_398" ) ) = 8192)) (PreH5 : (( &( "first_spec_410" ) ) = 12288)) (PreH6 : (( &( "one_spec_419" ) ) = 16384)) ,
  ((( &( "second_spec_437" ) )) # Ptr  |->_)
  **  ((16384) # Int  |-> 1)
  **  ((8192) # Int  |-> 0)
  **  ((12288) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_7 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (retval_2 = 1)) (PreH2 : (retval = 0)) (PreH3 : (( &( "a_spec_395" ) ) = 4096)) (PreH4 : (( &( "zero_spec_398" ) ) = 8192)) (PreH5 : (( &( "first_spec_410" ) ) = 12288)) (PreH6 : (( &( "one_spec_419" ) ) = 16384)) ,
  ((( &( "second_spec_437" ) )) # Ptr  |->_)
  **  ((16384) # Int  |-> 1)
  **  ((8192) # Int  |-> 0)
  **  ((12288) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_8 := 
forall (retval: Z) (PreH1 : (retval = 0)) (PreH2 : (( &( "a_spec_395" ) ) = 4096)) (PreH3 : (( &( "zero_spec_398" ) ) = 8192)) (PreH4 : (( &( "first_spec_410" ) ) = 12288)) ,
  ((( &( "one_spec_419" ) )) # Int  |->_)
  **  ((12288) # Ptr  |-> 4096)
  **  ((8192) # Int  |-> 0)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_9 := 
forall (retval: Z) (PreH1 : (retval = 0)) (PreH2 : (( &( "a_spec_395" ) ) = 4096)) (PreH3 : (( &( "zero_spec_398" ) ) = 8192)) (PreH4 : (( &( "first_spec_410" ) ) = 12288)) ,
  ((( &( "one_spec_419" ) )) # Int  |->_)
  **  ((12288) # Ptr  |-> 4096)
  **  ((8192) # Int  |-> 0)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_10 := 
forall (retval: Z) (PreH1 : (retval = 0)) (PreH2 : (( &( "a_spec_395" ) ) = 4096)) (PreH3 : (( &( "zero_spec_398" ) ) = 8192)) ,
  ((( &( "first_spec_410" ) )) # Ptr  |->_)
  **  ((8192) # Int  |-> 0)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_11 := 
  ((( &( "zero_spec_398" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_12 := 
  ((( &( "zero_spec_398" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_13 := 
  TT && emp 
|--
  TT && emp 
.

Definition main_safety_wit_14 := 
  TT && emp 
|--
  TT && emp 
.

Definition main_safety_wit_15 := 
  TT && emp 
|--
  TT && emp 
.

Definition main_entail_wit_1 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (2 = 2)) (PreH2 : (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH3 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH5 : (( &( "a_spec_395" ) ) = 4096)) (PreH6 : (( &( "zero_spec_398" ) ) = 8192)) (PreH7 : ((INT_MIN) <= retval)) (PreH8 : (retval <= INT_MAX)) (PreH9 : (( &( "first_spec_410" ) ) = 12288)) (PreH10 : (( &( "one_spec_419" ) ) = 16384)) (PreH11 : ((INT_MIN) <= retval_2)) (PreH12 : (retval_2 <= INT_MAX)) (PreH13 : (( &( "second_spec_437" ) ) = 20480)) (PreH14 : (( &( "two_spec_452" ) ) = 24576)) (PreH15 : ((INT_MIN) <= retval_3)) (PreH16 : (retval_3 <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ ((( &( "a_spec_395" ) ) + (2 * sizeof(INT))) = (( &( "a_spec_395" ) ) + (2 * sizeof(INT)))) ” 
  &&  “ (2 = 2) ” 
  &&  “ (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (( &( "a_spec_395" ) ) = 4096) ” 
  &&  “ (( &( "zero_spec_398" ) ) = 8192) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ (( &( "first_spec_410" ) ) = 12288) ” 
  &&  “ (( &( "one_spec_419" ) ) = 16384) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ” 
  &&  “ (( &( "second_spec_437" ) ) = 20480) ” 
  &&  “ (( &( "two_spec_452" ) ) = 24576) ” 
  &&  “ ((INT_MIN) <= retval_3) ” 
  &&  “ (retval_3 <= INT_MAX) ”
  &&  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_2 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH3 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : (( &( "a_spec_395" ) ) = 4096)) (PreH5 : (( &( "zero_spec_398" ) ) = 8192)) (PreH6 : ((INT_MIN) <= retval)) (PreH7 : (retval <= INT_MAX)) (PreH8 : (( &( "first_spec_410" ) ) = 12288)) (PreH9 : (( &( "one_spec_419" ) ) = 16384)) (PreH10 : ((INT_MIN) <= retval_2)) (PreH11 : (retval_2 <= INT_MAX)) (PreH12 : (( &( "second_spec_437" ) ) = 20480)) (PreH13 : (( &( "two_spec_452" ) ) = 24576)) (PreH14 : ((INT_MIN) <= retval_3)) (PreH15 : (retval_3 <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "two_spec_452" ) )) # Int  |-> retval_3)
|--
  “ (2 = 2) ” 
  &&  “ (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (( &( "a_spec_395" ) ) = 4096) ” 
  &&  “ (( &( "zero_spec_398" ) ) = 8192) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ (( &( "first_spec_410" ) ) = 12288) ” 
  &&  “ (( &( "one_spec_419" ) ) = 16384) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ” 
  &&  “ (( &( "second_spec_437" ) ) = 20480) ” 
  &&  “ (( &( "two_spec_452" ) ) = 24576) ” 
  &&  “ ((INT_MIN) <= retval_3) ” 
  &&  “ (retval_3 <= INT_MAX) ”
  &&  ((( &( "two_spec_452" ) )) # Int  |-> 2)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_3 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (1 = 1)) (PreH2 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH3 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : (( &( "a_spec_395" ) ) = 4096)) (PreH5 : (( &( "zero_spec_398" ) ) = 8192)) (PreH6 : ((INT_MIN) <= retval)) (PreH7 : (retval <= INT_MAX)) (PreH8 : (( &( "first_spec_410" ) ) = 12288)) (PreH9 : (( &( "one_spec_419" ) ) = 16384)) (PreH10 : ((INT_MIN) <= retval_2)) (PreH11 : (retval_2 <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ ((( &( "a_spec_395" ) ) + (1 * sizeof(INT))) = (( &( "a_spec_395" ) ) + (1 * sizeof(INT)))) ” 
  &&  “ (1 = 1) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (( &( "a_spec_395" ) ) = 4096) ” 
  &&  “ (( &( "zero_spec_398" ) ) = 8192) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ (( &( "first_spec_410" ) ) = 12288) ” 
  &&  “ (( &( "one_spec_419" ) ) = 16384) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ”
  &&  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_4 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH3 : (( &( "a_spec_395" ) ) = 4096)) (PreH4 : (( &( "zero_spec_398" ) ) = 8192)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) (PreH7 : (( &( "first_spec_410" ) ) = 12288)) (PreH8 : (( &( "one_spec_419" ) ) = 16384)) (PreH9 : ((INT_MIN) <= retval_2)) (PreH10 : (retval_2 <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "one_spec_419" ) )) # Int  |-> retval_2)
|--
  “ (1 = 1) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (( &( "a_spec_395" ) ) = 4096) ” 
  &&  “ (( &( "zero_spec_398" ) ) = 8192) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ (( &( "first_spec_410" ) ) = 12288) ” 
  &&  “ (( &( "one_spec_419" ) ) = 16384) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ”
  &&  ((( &( "one_spec_419" ) )) # Int  |-> 1)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_5 := 
forall (retval: Z) (PreH1 : (0 = 0)) (PreH2 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH3 : (( &( "a_spec_395" ) ) = 4096)) (PreH4 : (( &( "zero_spec_398" ) ) = 8192)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((( &( "a_spec_395" ) ) + (0 * sizeof(INT))) = 4096) ” 
  &&  “ (( &( "zero_spec_398" ) ) = 8192) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  (IntArray.full (( &( "a_spec_395" ) ) + (0 * sizeof(INT))) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_6 := 
forall (retval: Z) (PreH1 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : (( &( "a_spec_395" ) ) = 4096)) (PreH3 : (( &( "zero_spec_398" ) ) = 8192)) (PreH4 : ((INT_MIN) <= retval)) (PreH5 : (retval <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_398" ) )) # Int  |-> retval)
|--
  “ (0 = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (( &( "a_spec_395" ) ) = 4096) ” 
  &&  “ (( &( "zero_spec_398" ) ) = 8192) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_return_wit_1 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : ((( &( "a_spec_395" ) ) + (2 * sizeof(INT))) = (( &( "a_spec_395" ) ) + (2 * sizeof(INT))))) (PreH2 : (2 = 2)) (PreH3 : (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH5 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH6 : (( &( "a_spec_395" ) ) = 4096)) (PreH7 : (( &( "zero_spec_398" ) ) = 8192)) (PreH8 : ((INT_MIN) <= retval)) (PreH9 : (retval <= INT_MAX)) (PreH10 : (( &( "first_spec_410" ) ) = 12288)) (PreH11 : (( &( "one_spec_419" ) ) = 16384)) (PreH12 : ((INT_MIN) <= retval_2)) (PreH13 : (retval_2 <= INT_MAX)) (PreH14 : (( &( "second_spec_437" ) ) = 20480)) (PreH15 : (( &( "two_spec_452" ) ) = 24576)) (PreH16 : ((INT_MIN) <= retval_3)) (PreH17 : (retval_3 <= INT_MAX)) (PreH18 : (( &( "third_spec_476" ) ) = 28672)) ,
  TT && emp 
|--
  “ (0 = 0) ”
  &&  emp
.

Definition main_partial_solve_wit_1_pure := 
forall (retval: Z) (retval_2: Z) (PreH1 : ((( &( "a_spec_395" ) ) + (1 * sizeof(INT))) = (( &( "a_spec_395" ) ) + (1 * sizeof(INT))))) (PreH2 : (1 = 1)) (PreH3 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH5 : (( &( "a_spec_395" ) ) = 4096)) (PreH6 : (( &( "zero_spec_398" ) ) = 8192)) (PreH7 : ((INT_MIN) <= retval)) (PreH8 : (retval <= INT_MAX)) (PreH9 : (( &( "first_spec_410" ) ) = 12288)) (PreH10 : (( &( "one_spec_419" ) ) = 16384)) (PreH11 : ((INT_MIN) <= retval_2)) (PreH12 : (retval_2 <= INT_MAX)) (PreH13 : (( &( "second_spec_437" ) ) = 20480)) (PreH14 : (( &( "two_spec_452" ) ) = 24576)) ,
  ((( &( "two_spec_452" ) )) # Int  |->_)
  **  ((( &( "second_spec_437" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (1 * sizeof(INT))))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> ( &( "a_spec_395" ) ))
  **  ((( &( "one_spec_419" ) )) # Int  |-> 1)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ”
.

Definition main_partial_solve_wit_1_aux := 
forall (retval: Z) (retval_2: Z) (PreH1 : ((( &( "a_spec_395" ) ) + (1 * sizeof(INT))) = (( &( "a_spec_395" ) ) + (1 * sizeof(INT))))) (PreH2 : (1 = 1)) (PreH3 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH5 : (( &( "a_spec_395" ) ) = 4096)) (PreH6 : (( &( "zero_spec_398" ) ) = 8192)) (PreH7 : ((INT_MIN) <= retval)) (PreH8 : (retval <= INT_MAX)) (PreH9 : (( &( "first_spec_410" ) ) = 12288)) (PreH10 : (( &( "one_spec_419" ) ) = 16384)) (PreH11 : ((INT_MIN) <= retval_2)) (PreH12 : (retval_2 <= INT_MAX)) (PreH13 : (( &( "second_spec_437" ) ) = 20480)) (PreH14 : (( &( "two_spec_452" ) ) = 24576)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (( &( "a_spec_395" ) ) = 4096) ” 
  &&  “ (( &( "zero_spec_398" ) ) = 8192) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ (( &( "first_spec_410" ) ) = 12288) ” 
  &&  “ (( &( "one_spec_419" ) ) = 16384) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ” 
  &&  “ (( &( "second_spec_437" ) ) = 20480) ” 
  &&  “ (( &( "two_spec_452" ) ) = 24576) ”
  &&  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_partial_solve_wit_1 := main_partial_solve_wit_1_pure -> main_partial_solve_wit_1_aux.

Definition main_partial_solve_wit_2_pure := 
forall (retval: Z) (PreH1 : (0 = 0)) (PreH2 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH3 : (( &( "a_spec_395" ) ) = 4096)) (PreH4 : (( &( "zero_spec_398" ) ) = 8192)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) (PreH7 : (( &( "first_spec_410" ) ) = 12288)) (PreH8 : (( &( "one_spec_419" ) ) = 16384)) ,
  ((( &( "one_spec_419" ) )) # Int  |->_)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> ( &( "a_spec_395" ) ))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ”
.

Definition main_partial_solve_wit_2_aux := 
forall (retval: Z) (PreH1 : (0 = 0)) (PreH2 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH3 : (( &( "a_spec_395" ) ) = 4096)) (PreH4 : (( &( "zero_spec_398" ) ) = 8192)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) (PreH7 : (( &( "first_spec_410" ) ) = 12288)) (PreH8 : (( &( "one_spec_419" ) ) = 16384)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (( &( "a_spec_395" ) ) = 4096) ” 
  &&  “ (( &( "zero_spec_398" ) ) = 8192) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ (( &( "first_spec_410" ) ) = 12288) ” 
  &&  “ (( &( "one_spec_419" ) ) = 16384) ”
  &&  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_partial_solve_wit_2 := main_partial_solve_wit_2_pure -> main_partial_solve_wit_2_aux.

Definition main_partial_solve_wit_3_pure := 
forall (PreH1 : (( &( "a_spec_395" ) ) = 4096)) (PreH2 : (( &( "zero_spec_398" ) ) = 8192)) ,
  ((( &( "zero_spec_398" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ”
.

Definition main_partial_solve_wit_3_aux := 
forall (PreH1 : (( &( "a_spec_395" ) ) = 4096)) (PreH2 : (( &( "zero_spec_398" ) ) = 8192)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ” 
  &&  “ (( &( "a_spec_395" ) ) = 4096) ” 
  &&  “ (( &( "zero_spec_398" ) ) = 8192) ”
  &&  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_partial_solve_wit_3 := main_partial_solve_wit_3_pure -> main_partial_solve_wit_3_aux.

Definition main_precondition_wit_1 :=
~ ((  TT && emp ) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_main_safety_wit_1 : main_safety_wit_1.
Axiom proof_of_main_safety_wit_2 : main_safety_wit_2.
Axiom proof_of_main_safety_wit_3 : main_safety_wit_3.
Axiom proof_of_main_safety_wit_4 : main_safety_wit_4.
Axiom proof_of_main_safety_wit_5 : main_safety_wit_5.
Axiom proof_of_main_safety_wit_6 : main_safety_wit_6.
Axiom proof_of_main_safety_wit_7 : main_safety_wit_7.
Axiom proof_of_main_safety_wit_8 : main_safety_wit_8.
Axiom proof_of_main_safety_wit_9 : main_safety_wit_9.
Axiom proof_of_main_safety_wit_10 : main_safety_wit_10.
Axiom proof_of_main_safety_wit_11 : main_safety_wit_11.
Axiom proof_of_main_safety_wit_12 : main_safety_wit_12.
Axiom proof_of_main_safety_wit_13 : main_safety_wit_13.
Axiom proof_of_main_safety_wit_14 : main_safety_wit_14.
Axiom proof_of_main_safety_wit_15 : main_safety_wit_15.
Axiom proof_of_main_entail_wit_1 : main_entail_wit_1.
Axiom proof_of_main_entail_wit_2 : main_entail_wit_2.
Axiom proof_of_main_entail_wit_3 : main_entail_wit_3.
Axiom proof_of_main_entail_wit_4 : main_entail_wit_4.
Axiom proof_of_main_entail_wit_5 : main_entail_wit_5.
Axiom proof_of_main_entail_wit_6 : main_entail_wit_6.
Axiom proof_of_main_return_wit_1 : main_return_wit_1.
Axiom proof_of_main_partial_solve_wit_1_pure : main_partial_solve_wit_1_pure.
Axiom proof_of_main_partial_solve_wit_1 : main_partial_solve_wit_1.
Axiom proof_of_main_partial_solve_wit_2_pure : main_partial_solve_wit_2_pure.
Axiom proof_of_main_partial_solve_wit_2 : main_partial_solve_wit_2.
Axiom proof_of_main_partial_solve_wit_3_pure : main_partial_solve_wit_3_pure.
Axiom proof_of_main_partial_solve_wit_3 : main_partial_solve_wit_3.
Axiom proof_of_main_precondition_wit_1 : main_precondition_wit_1.

End VC_Correct.
