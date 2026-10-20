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
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) (PreH10 : (retval_2 = (INT_MIN))) (PreH11 : (( &( "second_spec_433" ) ) = 20480)) (PreH12 : (( &( "two_spec_439" ) ) = 24576)) (PreH13 : ((INT_MIN) <= retval_3)) (PreH14 : (retval_3 <= INT_MAX)) (PreH15 : (retval_3 = (INT_MIN))) (PreH16 : (( &( "third_spec_453" ) ) = 28672)) ,
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((28672) # Ptr  |-> 4104)
  **  ((24576) # Int  |-> 2)
  **  ((20480) # Ptr  |-> 4100)
  **  ((16384) # Int  |-> 1)
  **  ((12288) # Ptr  |-> 4096)
  **  ((8192) # Int  |-> 0)
|--
  TT && emp 
.

Definition main_safety_wit_2 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) (PreH10 : (retval_2 = (INT_MIN))) (PreH11 : (( &( "second_spec_433" ) ) = 20480)) (PreH12 : (( &( "two_spec_439" ) ) = 24576)) (PreH13 : ((INT_MIN) <= retval_3)) (PreH14 : (retval_3 <= INT_MAX)) (PreH15 : (retval_3 = (INT_MIN))) ,
  ((( &( "third_spec_453" ) )) # Ptr  |->_)
  **  ((24576) # Int  |-> 2)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((20480) # Ptr  |-> 4100)
  **  ((16384) # Int  |-> 1)
  **  ((12288) # Ptr  |-> 4096)
  **  ((8192) # Int  |-> 0)
|--
  TT && emp 
.

Definition main_safety_wit_3 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) (PreH10 : (retval_2 = (INT_MIN))) (PreH11 : (( &( "second_spec_433" ) ) = 20480)) (PreH12 : (( &( "two_spec_439" ) ) = 24576)) (PreH13 : ((INT_MIN) <= retval_3)) (PreH14 : (retval_3 <= INT_MAX)) (PreH15 : (retval_3 = (INT_MIN))) ,
  ((( &( "third_spec_453" ) )) # Ptr  |->_)
  **  ((24576) # Int  |-> 2)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((20480) # Ptr  |-> 4100)
  **  ((16384) # Int  |-> 1)
  **  ((12288) # Ptr  |-> 4096)
  **  ((8192) # Int  |-> 0)
|--
  TT && emp 
.

Definition main_safety_wit_4 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) (PreH10 : (retval_2 = (INT_MIN))) (PreH11 : (( &( "second_spec_433" ) ) = 20480)) ,
  ((( &( "two_spec_439" ) )) # Int  |->_)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((20480) # Ptr  |-> 4100)
  **  ((16384) # Int  |-> 1)
  **  ((12288) # Ptr  |-> 4096)
  **  ((8192) # Int  |-> 0)
|--
  TT && emp 
.

Definition main_safety_wit_5 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) (PreH10 : (retval_2 = (INT_MIN))) (PreH11 : (( &( "second_spec_433" ) ) = 20480)) ,
  ((( &( "two_spec_439" ) )) # Int  |->_)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((20480) # Ptr  |-> 4100)
  **  ((16384) # Int  |-> 1)
  **  ((12288) # Ptr  |-> 4096)
  **  ((8192) # Int  |-> 0)
|--
  TT && emp 
.

Definition main_safety_wit_6 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) (PreH10 : (retval_2 = (INT_MIN))) ,
  ((( &( "second_spec_433" ) )) # Ptr  |->_)
  **  ((16384) # Int  |-> 1)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((12288) # Ptr  |-> 4096)
  **  ((8192) # Int  |-> 0)
|--
  TT && emp 
.

Definition main_safety_wit_7 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) (PreH10 : (retval_2 = (INT_MIN))) ,
  ((( &( "second_spec_433" ) )) # Ptr  |->_)
  **  ((16384) # Int  |-> 1)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((12288) # Ptr  |-> 4096)
  **  ((8192) # Int  |-> 0)
|--
  TT && emp 
.

Definition main_safety_wit_8 := 
forall (retval: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) ,
  ((( &( "one_spec_419" ) )) # Int  |->_)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((12288) # Ptr  |-> 4096)
  **  ((8192) # Int  |-> 0)
|--
  TT && emp 
.

Definition main_safety_wit_9 := 
forall (retval: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) ,
  ((( &( "one_spec_419" ) )) # Int  |->_)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((12288) # Ptr  |-> 4096)
  **  ((8192) # Int  |-> 0)
|--
  TT && emp 
.

Definition main_safety_wit_10 := 
forall (retval: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) ,
  ((( &( "first_spec_413" ) )) # Ptr  |->_)
  **  ((8192) # Int  |-> 0)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_11 := 
  ((( &( "zero_spec_399" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_12 := 
  ((( &( "zero_spec_399" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
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
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (2 = 2)) (PreH2 : (( &( "a_spec_396" ) ) = 4096)) (PreH3 : (( &( "zero_spec_399" ) ) = 8192)) (PreH4 : ((INT_MIN) <= retval)) (PreH5 : (retval <= INT_MAX)) (PreH6 : (retval = (INT_MIN))) (PreH7 : (( &( "first_spec_413" ) ) = 12288)) (PreH8 : (( &( "one_spec_419" ) ) = 16384)) (PreH9 : ((INT_MIN) <= retval_2)) (PreH10 : (retval_2 <= INT_MAX)) (PreH11 : (retval_2 = (INT_MIN))) (PreH12 : (( &( "second_spec_433" ) ) = 20480)) (PreH13 : (( &( "two_spec_439" ) ) = 24576)) (PreH14 : ((INT_MIN) <= retval_3)) (PreH15 : (retval_3 <= INT_MAX)) (PreH16 : (retval_3 = (INT_MIN))) ,
  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (2 = 2) ” 
  &&  “ (( &( "a_spec_396" ) ) = 4096) ” 
  &&  “ (( &( "zero_spec_399" ) ) = 8192) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ (retval = (INT_MIN)) ” 
  &&  “ (( &( "first_spec_413" ) ) = 12288) ” 
  &&  “ (( &( "one_spec_419" ) ) = 16384) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ” 
  &&  “ (retval_2 = (INT_MIN)) ” 
  &&  “ (( &( "second_spec_433" ) ) = 20480) ” 
  &&  “ (( &( "two_spec_439" ) ) = 24576) ” 
  &&  “ ((INT_MIN) <= retval_3) ” 
  &&  “ (retval_3 <= INT_MAX) ” 
  &&  “ (retval_3 = (INT_MIN)) ”
  &&  (((( &( "a_spec_396" ) ) + (2 * sizeof(INT)))) # Int  |-> 2)
  **  (IntArray.missing_i ( &( "a_spec_396" ) ) 2 0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_2 := 
(
forall (retval: Z) (retval_2: Z) (l2: (@list Z)) (retval_3: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) (PreH10 : (retval_2 = (INT_MIN))) (PreH11 : (( &( "second_spec_433" ) ) = 20480)) (PreH12 : (( &( "two_spec_439" ) ) = 24576)) (PreH13 : ((INT_MIN) <= retval_3)) (PreH14 : (retval_3 <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_396" ) ) 3 l2 )
  **  ((( &( "two_spec_439" ) )) # Int  |-> retval_3)
|--
  “ (2 = 2) ” 
  &&  “ (( &( "a_spec_396" ) ) = 4096) ” 
  &&  “ (( &( "zero_spec_399" ) ) = 8192) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ (retval = (INT_MIN)) ” 
  &&  “ (( &( "first_spec_413" ) ) = 12288) ” 
  &&  “ (( &( "one_spec_419" ) ) = 16384) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ” 
  &&  “ (retval_2 = (INT_MIN)) ” 
  &&  “ (( &( "second_spec_433" ) ) = 20480) ” 
  &&  “ (( &( "two_spec_439" ) ) = 24576) ” 
  &&  “ ((INT_MIN) <= retval_3) ” 
  &&  “ (retval_3 <= INT_MAX) ”
  &&  ((( &( "two_spec_439" ) )) # Int  |-> 2)
  **  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
) \/
(
forall (retval: Z) (retval_2: Z) (l2: (@list Z)) (retval_3: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) (PreH10 : (retval_2 = (INT_MIN))) (PreH11 : (( &( "second_spec_433" ) ) = 20480)) (PreH12 : (( &( "two_spec_439" ) ) = 24576)) (PreH13 : ((INT_MIN) <= retval_3)) (PreH14 : (retval_3 <= INT_MAX)) ,
  TT && emp 
|--
  “ (l2 = (cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) ” 
  &&  “ (retval_3 = 2) ” 
  &&  “ (( &( "a_spec_396" ) ) = 4096) ” 
  &&  “ (( &( "zero_spec_399" ) ) = 8192) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ (retval = (INT_MIN)) ” 
  &&  “ (( &( "first_spec_413" ) ) = 12288) ” 
  &&  “ (( &( "one_spec_419" ) ) = 16384) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ” 
  &&  “ (retval_2 = (INT_MIN)) ” 
  &&  “ (( &( "second_spec_433" ) ) = 20480) ” 
  &&  “ (( &( "two_spec_439" ) ) = 24576) ” 
  &&  “ ((INT_MIN) <= retval_3) ” 
  &&  “ (retval_3 <= INT_MAX) ”
  &&  emp
).

Definition main_entail_wit_2_split_goal_1 := 
forall (retval: Z) (retval_2: Z) (l2: (@list Z)) (retval_3: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) (PreH10 : (retval_2 = (INT_MIN))) (PreH11 : (( &( "second_spec_433" ) ) = 20480)) (PreH12 : (( &( "two_spec_439" ) ) = 24576)) (PreH13 : ((INT_MIN) <= retval_3)) (PreH14 : (retval_3 <= INT_MAX)) ,
  (l2 = (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))))
.

Definition main_entail_wit_2_split_goal_2 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) (PreH10 : (retval_2 = (INT_MIN))) (PreH11 : (( &( "second_spec_433" ) ) = 20480)) (PreH12 : (( &( "two_spec_439" ) ) = 24576)) (PreH13 : ((INT_MIN) <= retval_3)) (PreH14 : (retval_3 <= INT_MAX)) ,
  (retval_3 = 2)
.

Definition main_entail_wit_2_split_goal_3 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) (PreH10 : (retval_2 = (INT_MIN))) (PreH11 : (( &( "second_spec_433" ) ) = 20480)) (PreH12 : (( &( "two_spec_439" ) ) = 24576)) (PreH13 : ((INT_MIN) <= retval_3)) (PreH14 : (retval_3 <= INT_MAX)) ,
  (( &( "a_spec_396" ) ) = 4096)
.

Definition main_entail_wit_2_split_goal_4 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) (PreH10 : (retval_2 = (INT_MIN))) (PreH11 : (( &( "second_spec_433" ) ) = 20480)) (PreH12 : (( &( "two_spec_439" ) ) = 24576)) (PreH13 : ((INT_MIN) <= retval_3)) (PreH14 : (retval_3 <= INT_MAX)) ,
  (( &( "zero_spec_399" ) ) = 8192)
.

Definition main_entail_wit_2_split_goal_5 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) (PreH10 : (retval_2 = (INT_MIN))) (PreH11 : (( &( "second_spec_433" ) ) = 20480)) (PreH12 : (( &( "two_spec_439" ) ) = 24576)) (PreH13 : ((INT_MIN) <= retval_3)) (PreH14 : (retval_3 <= INT_MAX)) ,
  ((INT_MIN) <= retval)
.

Definition main_entail_wit_2_split_goal_6 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) (PreH10 : (retval_2 = (INT_MIN))) (PreH11 : (( &( "second_spec_433" ) ) = 20480)) (PreH12 : (( &( "two_spec_439" ) ) = 24576)) (PreH13 : ((INT_MIN) <= retval_3)) (PreH14 : (retval_3 <= INT_MAX)) ,
  (retval <= INT_MAX)
.

Definition main_entail_wit_2_split_goal_7 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) (PreH10 : (retval_2 = (INT_MIN))) (PreH11 : (( &( "second_spec_433" ) ) = 20480)) (PreH12 : (( &( "two_spec_439" ) ) = 24576)) (PreH13 : ((INT_MIN) <= retval_3)) (PreH14 : (retval_3 <= INT_MAX)) ,
  (retval = (INT_MIN))
.

Definition main_entail_wit_2_split_goal_8 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) (PreH10 : (retval_2 = (INT_MIN))) (PreH11 : (( &( "second_spec_433" ) ) = 20480)) (PreH12 : (( &( "two_spec_439" ) ) = 24576)) (PreH13 : ((INT_MIN) <= retval_3)) (PreH14 : (retval_3 <= INT_MAX)) ,
  (( &( "first_spec_413" ) ) = 12288)
.

Definition main_entail_wit_2_split_goal_9 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) (PreH10 : (retval_2 = (INT_MIN))) (PreH11 : (( &( "second_spec_433" ) ) = 20480)) (PreH12 : (( &( "two_spec_439" ) ) = 24576)) (PreH13 : ((INT_MIN) <= retval_3)) (PreH14 : (retval_3 <= INT_MAX)) ,
  (( &( "one_spec_419" ) ) = 16384)
.

Definition main_entail_wit_2_split_goal_10 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) (PreH10 : (retval_2 = (INT_MIN))) (PreH11 : (( &( "second_spec_433" ) ) = 20480)) (PreH12 : (( &( "two_spec_439" ) ) = 24576)) (PreH13 : ((INT_MIN) <= retval_3)) (PreH14 : (retval_3 <= INT_MAX)) ,
  ((INT_MIN) <= retval_2)
.

Definition main_entail_wit_2_split_goal_11 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) (PreH10 : (retval_2 = (INT_MIN))) (PreH11 : (( &( "second_spec_433" ) ) = 20480)) (PreH12 : (( &( "two_spec_439" ) ) = 24576)) (PreH13 : ((INT_MIN) <= retval_3)) (PreH14 : (retval_3 <= INT_MAX)) ,
  (retval_2 <= INT_MAX)
.

Definition main_entail_wit_2_split_goal_12 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) (PreH10 : (retval_2 = (INT_MIN))) (PreH11 : (( &( "second_spec_433" ) ) = 20480)) (PreH12 : (( &( "two_spec_439" ) ) = 24576)) (PreH13 : ((INT_MIN) <= retval_3)) (PreH14 : (retval_3 <= INT_MAX)) ,
  (retval_2 = (INT_MIN))
.

Definition main_entail_wit_2_split_goal_13 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) (PreH10 : (retval_2 = (INT_MIN))) (PreH11 : (( &( "second_spec_433" ) ) = 20480)) (PreH12 : (( &( "two_spec_439" ) ) = 24576)) (PreH13 : ((INT_MIN) <= retval_3)) (PreH14 : (retval_3 <= INT_MAX)) ,
  (( &( "second_spec_433" ) ) = 20480)
.

Definition main_entail_wit_2_split_goal_14 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) (PreH10 : (retval_2 = (INT_MIN))) (PreH11 : (( &( "second_spec_433" ) ) = 20480)) (PreH12 : (( &( "two_spec_439" ) ) = 24576)) (PreH13 : ((INT_MIN) <= retval_3)) (PreH14 : (retval_3 <= INT_MAX)) ,
  (( &( "two_spec_439" ) ) = 24576)
.

Definition main_entail_wit_2_split_goal_15 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) (PreH10 : (retval_2 = (INT_MIN))) (PreH11 : (( &( "second_spec_433" ) ) = 20480)) (PreH12 : (( &( "two_spec_439" ) ) = 24576)) (PreH13 : ((INT_MIN) <= retval_3)) (PreH14 : (retval_3 <= INT_MAX)) ,
  ((INT_MIN) <= retval_3)
.

Definition main_entail_wit_2_split_goal_16 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) (PreH10 : (retval_2 = (INT_MIN))) (PreH11 : (( &( "second_spec_433" ) ) = 20480)) (PreH12 : (( &( "two_spec_439" ) ) = 24576)) (PreH13 : ((INT_MIN) <= retval_3)) (PreH14 : (retval_3 <= INT_MAX)) ,
  (retval_3 <= INT_MAX)
.

Definition main_entail_wit_3 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (1 = 1)) (PreH2 : (( &( "a_spec_396" ) ) = 4096)) (PreH3 : (( &( "zero_spec_399" ) ) = 8192)) (PreH4 : ((INT_MIN) <= retval)) (PreH5 : (retval <= INT_MAX)) (PreH6 : (retval = (INT_MIN))) (PreH7 : (( &( "first_spec_413" ) ) = 12288)) (PreH8 : (( &( "one_spec_419" ) ) = 16384)) (PreH9 : ((INT_MIN) <= retval_2)) (PreH10 : (retval_2 <= INT_MAX)) (PreH11 : (retval_2 = (INT_MIN))) ,
  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (1 = 1) ” 
  &&  “ (( &( "a_spec_396" ) ) = 4096) ” 
  &&  “ (( &( "zero_spec_399" ) ) = 8192) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ (retval = (INT_MIN)) ” 
  &&  “ (( &( "first_spec_413" ) ) = 12288) ” 
  &&  “ (( &( "one_spec_419" ) ) = 16384) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ” 
  &&  “ (retval_2 = (INT_MIN)) ”
  &&  (((( &( "a_spec_396" ) ) + (1 * sizeof(INT)))) # Int  |-> 1)
  **  (IntArray.missing_i ( &( "a_spec_396" ) ) 1 0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_4 := 
(
forall (retval: Z) (l2: (@list Z)) (retval_2: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_396" ) ) 3 l2 )
  **  ((( &( "one_spec_419" ) )) # Int  |-> retval_2)
|--
  “ (1 = 1) ” 
  &&  “ (( &( "a_spec_396" ) ) = 4096) ” 
  &&  “ (( &( "zero_spec_399" ) ) = 8192) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ (retval = (INT_MIN)) ” 
  &&  “ (( &( "first_spec_413" ) ) = 12288) ” 
  &&  “ (( &( "one_spec_419" ) ) = 16384) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ”
  &&  ((( &( "one_spec_419" ) )) # Int  |-> 1)
  **  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
) \/
(
forall (retval: Z) (l2: (@list Z)) (retval_2: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) ,
  TT && emp 
|--
  “ (l2 = (cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) ” 
  &&  “ (retval_2 = 1) ” 
  &&  “ (( &( "a_spec_396" ) ) = 4096) ” 
  &&  “ (( &( "zero_spec_399" ) ) = 8192) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ (retval = (INT_MIN)) ” 
  &&  “ (( &( "first_spec_413" ) ) = 12288) ” 
  &&  “ (( &( "one_spec_419" ) ) = 16384) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ”
  &&  emp
).

Definition main_entail_wit_4_split_goal_1 := 
forall (retval: Z) (l2: (@list Z)) (retval_2: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) ,
  (l2 = (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))))
.

Definition main_entail_wit_4_split_goal_2 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) ,
  (retval_2 = 1)
.

Definition main_entail_wit_4_split_goal_3 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) ,
  (( &( "a_spec_396" ) ) = 4096)
.

Definition main_entail_wit_4_split_goal_4 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) ,
  (( &( "zero_spec_399" ) ) = 8192)
.

Definition main_entail_wit_4_split_goal_5 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) ,
  ((INT_MIN) <= retval)
.

Definition main_entail_wit_4_split_goal_6 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) ,
  (retval <= INT_MAX)
.

Definition main_entail_wit_4_split_goal_7 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) ,
  (retval = (INT_MIN))
.

Definition main_entail_wit_4_split_goal_8 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) ,
  (( &( "first_spec_413" ) ) = 12288)
.

Definition main_entail_wit_4_split_goal_9 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) ,
  (( &( "one_spec_419" ) ) = 16384)
.

Definition main_entail_wit_4_split_goal_10 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) ,
  ((INT_MIN) <= retval_2)
.

Definition main_entail_wit_4_split_goal_11 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) (PreH6 : (( &( "first_spec_413" ) ) = 12288)) (PreH7 : (( &( "one_spec_419" ) ) = 16384)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) ,
  (retval_2 <= INT_MAX)
.

Definition main_entail_wit_5 := 
(
forall (retval: Z) (PreH1 : (0 = 0)) (PreH2 : (( &( "a_spec_396" ) ) = 4096)) (PreH3 : (( &( "zero_spec_399" ) ) = 8192)) (PreH4 : ((INT_MIN) <= retval)) (PreH5 : (retval <= INT_MAX)) (PreH6 : (retval = (INT_MIN))) ,
  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 = 0) ” 
  &&  “ (( &( "a_spec_396" ) ) = 4096) ” 
  &&  “ (( &( "zero_spec_399" ) ) = 8192) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ (retval = (INT_MIN)) ”
  &&  (((( &( "a_spec_396" ) ) + (0 * sizeof(INT)))) # Int  |-> 0)
  **  (IntArray.missing_i ( &( "a_spec_396" ) ) 0 0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
) \/
(
forall (retval: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : (retval = (INT_MIN))) ,
  TT && emp 
|--
  TT && emp 
).

Definition main_entail_wit_6 := 
(
forall (l2: (@list Z)) (retval: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_396" ) ) 3 l2 )
  **  ((( &( "zero_spec_399" ) )) # Int  |-> retval)
|--
  “ (0 = 0) ” 
  &&  “ (( &( "a_spec_396" ) ) = 4096) ” 
  &&  “ (( &( "zero_spec_399" ) ) = 8192) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
) \/
(
forall (l2: (@list Z)) (retval: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) ,
  TT && emp 
|--
  “ (l2 = (cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) ” 
  &&  “ (retval = 0) ” 
  &&  “ (( &( "a_spec_396" ) ) = 4096) ” 
  &&  “ (( &( "zero_spec_399" ) ) = 8192) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  emp
).

Definition main_entail_wit_6_split_goal_1 := 
forall (l2: (@list Z)) (retval: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) ,
  (l2 = (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))))
.

Definition main_entail_wit_6_split_goal_2 := 
forall (retval: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) ,
  (retval = 0)
.

Definition main_entail_wit_6_split_goal_3 := 
forall (retval: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) ,
  (( &( "a_spec_396" ) ) = 4096)
.

Definition main_entail_wit_6_split_goal_4 := 
forall (retval: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) ,
  (( &( "zero_spec_399" ) ) = 8192)
.

Definition main_entail_wit_6_split_goal_5 := 
forall (retval: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) ,
  ((INT_MIN) <= retval)
.

Definition main_entail_wit_6_split_goal_6 := 
forall (retval: Z) (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) ,
  (retval <= INT_MAX)
.

Definition main_return_wit_1 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (2 = 2)) (PreH2 : (( &( "a_spec_396" ) ) = 4096)) (PreH3 : (( &( "zero_spec_399" ) ) = 8192)) (PreH4 : ((INT_MIN) <= retval)) (PreH5 : (retval <= INT_MAX)) (PreH6 : (retval = (INT_MIN))) (PreH7 : (( &( "first_spec_413" ) ) = 12288)) (PreH8 : (( &( "one_spec_419" ) ) = 16384)) (PreH9 : ((INT_MIN) <= retval_2)) (PreH10 : (retval_2 <= INT_MAX)) (PreH11 : (retval_2 = (INT_MIN))) (PreH12 : (( &( "second_spec_433" ) ) = 20480)) (PreH13 : (( &( "two_spec_439" ) ) = 24576)) (PreH14 : ((INT_MIN) <= retval_3)) (PreH15 : (retval_3 <= INT_MAX)) (PreH16 : (retval_3 = (INT_MIN))) (PreH17 : (( &( "third_spec_453" ) ) = 28672)) ,
  TT && emp 
|--
  “ (0 = 0) ”
  &&  emp
.

Definition main_partial_solve_wit_1_pure := 
forall (retval: Z) (retval_2: Z) (PreH1 : (1 = 1)) (PreH2 : (( &( "a_spec_396" ) ) = 4096)) (PreH3 : (( &( "zero_spec_399" ) ) = 8192)) (PreH4 : ((INT_MIN) <= retval)) (PreH5 : (retval <= INT_MAX)) (PreH6 : (retval = (INT_MIN))) (PreH7 : (( &( "first_spec_413" ) ) = 12288)) (PreH8 : (( &( "one_spec_419" ) ) = 16384)) (PreH9 : ((INT_MIN) <= retval_2)) (PreH10 : (retval_2 <= INT_MAX)) (PreH11 : (retval_2 = (INT_MIN))) (PreH12 : (( &( "second_spec_433" ) ) = 20480)) (PreH13 : (( &( "two_spec_439" ) ) = 24576)) ,
  ((( &( "two_spec_439" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_396" ) ) 3 (replace_Znth (1) (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z))))))))) )
  **  ((( &( "second_spec_433" ) )) # Ptr  |-> (( &( "a_spec_396" ) ) + (1 * sizeof(INT))))
  **  ((( &( "one_spec_419" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_413" ) )) # Ptr  |-> (( &( "a_spec_396" ) ) + (0 * sizeof(INT))))
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ”
.

Definition main_partial_solve_wit_1_aux := 
forall (retval: Z) (retval_2: Z) (PreH1 : (1 = 1)) (PreH2 : (( &( "a_spec_396" ) ) = 4096)) (PreH3 : (( &( "zero_spec_399" ) ) = 8192)) (PreH4 : ((INT_MIN) <= retval)) (PreH5 : (retval <= INT_MAX)) (PreH6 : (retval = (INT_MIN))) (PreH7 : (( &( "first_spec_413" ) ) = 12288)) (PreH8 : (( &( "one_spec_419" ) ) = 16384)) (PreH9 : ((INT_MIN) <= retval_2)) (PreH10 : (retval_2 <= INT_MAX)) (PreH11 : (retval_2 = (INT_MIN))) (PreH12 : (( &( "second_spec_433" ) ) = 20480)) (PreH13 : (( &( "two_spec_439" ) ) = 24576)) ,
  (IntArray.full ( &( "a_spec_396" ) ) 3 (replace_Znth (1) (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z))))))))) )
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ” 
  &&  “ (( &( "a_spec_396" ) ) = 4096) ” 
  &&  “ (( &( "zero_spec_399" ) ) = 8192) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ (retval = (INT_MIN)) ” 
  &&  “ (( &( "first_spec_413" ) ) = 12288) ” 
  &&  “ (( &( "one_spec_419" ) ) = 16384) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ” 
  &&  “ (retval_2 = (INT_MIN)) ” 
  &&  “ (( &( "second_spec_433" ) ) = 20480) ” 
  &&  “ (( &( "two_spec_439" ) ) = 24576) ”
  &&  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_partial_solve_wit_1 := main_partial_solve_wit_1_pure -> main_partial_solve_wit_1_aux.

Definition main_partial_solve_wit_2_pure := 
forall (retval: Z) (PreH1 : (0 = 0)) (PreH2 : (( &( "a_spec_396" ) ) = 4096)) (PreH3 : (( &( "zero_spec_399" ) ) = 8192)) (PreH4 : ((INT_MIN) <= retval)) (PreH5 : (retval <= INT_MAX)) (PreH6 : (retval = (INT_MIN))) (PreH7 : (( &( "first_spec_413" ) ) = 12288)) (PreH8 : (( &( "one_spec_419" ) ) = 16384)) ,
  ((( &( "one_spec_419" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_396" ) ) 3 (replace_Znth (0) (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z))))))))) )
  **  ((( &( "first_spec_413" ) )) # Ptr  |-> (( &( "a_spec_396" ) ) + (0 * sizeof(INT))))
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ”
.

Definition main_partial_solve_wit_2_aux := 
forall (retval: Z) (PreH1 : (0 = 0)) (PreH2 : (( &( "a_spec_396" ) ) = 4096)) (PreH3 : (( &( "zero_spec_399" ) ) = 8192)) (PreH4 : ((INT_MIN) <= retval)) (PreH5 : (retval <= INT_MAX)) (PreH6 : (retval = (INT_MIN))) (PreH7 : (( &( "first_spec_413" ) ) = 12288)) (PreH8 : (( &( "one_spec_419" ) ) = 16384)) ,
  (IntArray.full ( &( "a_spec_396" ) ) 3 (replace_Znth (0) (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z))))))))) )
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ” 
  &&  “ (( &( "a_spec_396" ) ) = 4096) ” 
  &&  “ (( &( "zero_spec_399" ) ) = 8192) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ (retval = (INT_MIN)) ” 
  &&  “ (( &( "first_spec_413" ) ) = 12288) ” 
  &&  “ (( &( "one_spec_419" ) ) = 16384) ”
  &&  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_partial_solve_wit_2 := main_partial_solve_wit_2_pure -> main_partial_solve_wit_2_aux.

Definition main_partial_solve_wit_3_pure := 
forall (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) ,
  ((( &( "zero_spec_399" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ”
.

Definition main_partial_solve_wit_3_aux := 
forall (PreH1 : (( &( "a_spec_396" ) ) = 4096)) (PreH2 : (( &( "zero_spec_399" ) ) = 8192)) ,
  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ” 
  &&  “ (( &( "a_spec_396" ) ) = 4096) ” 
  &&  “ (( &( "zero_spec_399" ) ) = 8192) ”
  &&  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
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
