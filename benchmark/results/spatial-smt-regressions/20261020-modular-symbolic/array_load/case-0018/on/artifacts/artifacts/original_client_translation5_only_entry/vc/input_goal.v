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

(*----- Function verify_main -----*)

Definition verify_main_safety_wit_1 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (retval_3: Z) (two: Z) (a: Z) (zero_addr_v: Z) (first_addr_v: Z) (one_addr_v: Z) (second_addr_v: Z) (two_addr_v: Z) (third_addr_v: Z) (PreH1 : (two = 2)) (PreH2 : (retval_3 = 2)) (PreH3 : (one = 1)) (PreH4 : (retval_2 = 1)) (PreH5 : (zero = 0)) (PreH6 : (retval = 0)) ,
  ((( &( "a_spec_390" ) )) # Ptr  |-> a)
  **  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_399" ) )) # Int  |-> zero_addr_v)
  **  ((( &( "first_spec_414" ) )) # Ptr  |-> first_addr_v)
  **  ((( &( "one_spec_426" ) )) # Int  |-> one_addr_v)
  **  ((( &( "second_spec_447" ) )) # Ptr  |-> second_addr_v)
  **  ((( &( "two_spec_465" ) )) # Int  |-> two_addr_v)
  **  ((( &( "third_spec_492" ) )) # Ptr  |-> third_addr_v)
|--
  TT && emp 
.

Definition verify_main_safety_wit_2 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (retval_3: Z) (two: Z) (a: Z) (zero_addr_v: Z) (first_addr_v: Z) (one_addr_v: Z) (second_addr_v: Z) (PreH1 : (two = 2)) (PreH2 : (retval_3 = 2)) (PreH3 : (one = 1)) (PreH4 : (retval_2 = 1)) (PreH5 : (zero = 0)) (PreH6 : (retval = 0)) ,
  ((( &( "third_spec_492" ) )) # Ptr  |->_)
  **  ((( &( "two_spec_465" ) )) # Int  |-> 2)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> a)
  **  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_399" ) )) # Int  |-> zero_addr_v)
  **  ((( &( "first_spec_414" ) )) # Ptr  |-> first_addr_v)
  **  ((( &( "one_spec_426" ) )) # Int  |-> one_addr_v)
  **  ((( &( "second_spec_447" ) )) # Ptr  |-> second_addr_v)
|--
  TT && emp 
.

Definition verify_main_safety_wit_3 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (a: Z) (zero_addr_v: Z) (first_addr_v: Z) (one_addr_v: Z) (second_addr_v: Z) (PreH1 : (one = 1)) (PreH2 : (retval_2 = 1)) (PreH3 : (zero = 0)) (PreH4 : (retval = 0)) ,
  ((( &( "two_spec_465" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> a)
  **  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_399" ) )) # Int  |-> zero_addr_v)
  **  ((( &( "first_spec_414" ) )) # Ptr  |-> first_addr_v)
  **  ((( &( "one_spec_426" ) )) # Int  |-> one_addr_v)
  **  ((( &( "second_spec_447" ) )) # Ptr  |-> second_addr_v)
|--
  TT && emp 
.

Definition verify_main_safety_wit_4 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (a: Z) (zero_addr_v: Z) (first_addr_v: Z) (one_addr_v: Z) (second_addr_v: Z) (PreH1 : (one = 1)) (PreH2 : (retval_2 = 1)) (PreH3 : (zero = 0)) (PreH4 : (retval = 0)) ,
  ((( &( "two_spec_465" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> a)
  **  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_399" ) )) # Int  |-> zero_addr_v)
  **  ((( &( "first_spec_414" ) )) # Ptr  |-> first_addr_v)
  **  ((( &( "one_spec_426" ) )) # Int  |-> one_addr_v)
  **  ((( &( "second_spec_447" ) )) # Ptr  |-> second_addr_v)
|--
  TT && emp 
.

Definition verify_main_safety_wit_5 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (a: Z) (zero_addr_v: Z) (first_addr_v: Z) (PreH1 : (one = 1)) (PreH2 : (retval_2 = 1)) (PreH3 : (zero = 0)) (PreH4 : (retval = 0)) ,
  ((( &( "second_spec_447" ) )) # Ptr  |->_)
  **  ((( &( "one_spec_426" ) )) # Int  |-> 1)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> a)
  **  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_399" ) )) # Int  |-> zero_addr_v)
  **  ((( &( "first_spec_414" ) )) # Ptr  |-> first_addr_v)
|--
  TT && emp 
.

Definition verify_main_safety_wit_6 := 
forall (retval: Z) (zero: Z) (a: Z) (zero_addr_v: Z) (first_addr_v: Z) (PreH1 : (zero = 0)) (PreH2 : (retval = 0)) ,
  ((( &( "one_spec_426" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> a)
  **  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_399" ) )) # Int  |-> zero_addr_v)
  **  ((( &( "first_spec_414" ) )) # Ptr  |-> first_addr_v)
|--
  TT && emp 
.

Definition verify_main_safety_wit_7 := 
forall (retval: Z) (zero: Z) (a: Z) (zero_addr_v: Z) (first_addr_v: Z) (PreH1 : (zero = 0)) (PreH2 : (retval = 0)) ,
  ((( &( "one_spec_426" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> a)
  **  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_399" ) )) # Int  |-> zero_addr_v)
  **  ((( &( "first_spec_414" ) )) # Ptr  |-> first_addr_v)
|--
  TT && emp 
.

Definition verify_main_safety_wit_8 := 
  ((( &( "zero_spec_399" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition verify_main_safety_wit_9 := 
  ((( &( "zero_spec_399" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition verify_main_entail_wit_1 := 
forall (a_pre: Z) (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (retval_3: Z) (two: Z) (a: Z) (PreH1 : (two = 2)) (PreH2 : (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH3 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH4 : (one = 1)) (PreH5 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH6 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH7 : (zero = 0)) (PreH8 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH9 : (a_pre = 4096)) (PreH10 : ((INT_MIN) <= retval)) (PreH11 : (retval <= INT_MAX)) (PreH12 : ((INT_MIN) <= retval_2)) (PreH13 : (retval_2 <= INT_MAX)) (PreH14 : ((INT_MIN) <= retval_3)) (PreH15 : (retval_3 <= INT_MAX)) ,
  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ ((Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 2) ” 
  &&  “ (two = 2) ” 
  &&  “ (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1) ” 
  &&  “ (one = 1) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (zero = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (a_pre = 4096) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_3) ” 
  &&  “ (retval_3 <= INT_MAX) ”
  &&  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_entail_wit_2 := 
forall (a_pre: Z) (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (a: Z) (retval_3: Z) (PreH1 : (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH3 : (one = 1)) (PreH4 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH5 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH6 : (zero = 0)) (PreH7 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH8 : (a_pre = 4096)) (PreH9 : ((INT_MIN) <= retval)) (PreH10 : (retval <= INT_MAX)) (PreH11 : ((INT_MIN) <= retval_2)) (PreH12 : (retval_2 <= INT_MAX)) (PreH13 : ((INT_MIN) <= retval_3)) (PreH14 : (retval_3 <= INT_MAX)) ,
  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (retval_3 = 2) ” 
  &&  “ (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1) ” 
  &&  “ (one = 1) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (zero = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (a_pre = 4096) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_3) ” 
  &&  “ (retval_3 <= INT_MAX) ”
  &&  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_entail_wit_3 := 
forall (a_pre: Z) (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (a: Z) (PreH1 : (one = 1)) (PreH2 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH3 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH4 : (zero = 0)) (PreH5 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH6 : (a_pre = 4096)) (PreH7 : ((INT_MIN) <= retval)) (PreH8 : (retval <= INT_MAX)) (PreH9 : ((INT_MIN) <= retval_2)) (PreH10 : (retval_2 <= INT_MAX)) ,
  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1) ” 
  &&  “ (one = 1) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (zero = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (a_pre = 4096) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ”
  &&  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_entail_wit_4 := 
forall (a_pre: Z) (retval: Z) (zero: Z) (a: Z) (retval_2: Z) (PreH1 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH3 : (zero = 0)) (PreH4 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH5 : (a_pre = 4096)) (PreH6 : ((INT_MIN) <= retval)) (PreH7 : (retval <= INT_MAX)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) ,
  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (retval_2 = 1) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (zero = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (a_pre = 4096) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ”
  &&  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_entail_wit_5 := 
forall (a_pre: Z) (retval: Z) (zero: Z) (a: Z) (PreH1 : (zero = 0)) (PreH2 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH3 : (a_pre = 4096)) (PreH4 : ((INT_MIN) <= retval)) (PreH5 : (retval <= INT_MAX)) ,
  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (zero = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (a_pre = 4096) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_entail_wit_6 := 
forall (a_pre: Z) (retval: Z) (PreH1 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : (a_pre = 4096)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (retval = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (a_pre = 4096) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_return_wit_1 := 
(
forall (a_pre: Z) (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (retval_3: Z) (two: Z) (a: Z) (PreH1 : ((Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 2)) (PreH2 : (two = 2)) (PreH3 : (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH5 : (one = 1)) (PreH6 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH7 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH8 : (zero = 0)) (PreH9 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH10 : (a_pre = 4096)) (PreH11 : ((INT_MIN) <= retval)) (PreH12 : (retval <= INT_MAX)) (PreH13 : ((INT_MIN) <= retval_2)) (PreH14 : (retval_2 <= INT_MAX)) (PreH15 : ((INT_MIN) <= retval_3)) (PreH16 : (retval_3 <= INT_MAX)) ,
  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 = 0) ”
  &&  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
) \/
(
forall (a_pre: Z) (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (retval_3: Z) (two: Z) (a: Z) (PreH1 : ((Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 2)) (PreH2 : (two = 2)) (PreH3 : (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH5 : (one = 1)) (PreH6 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH7 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH8 : (zero = 0)) (PreH9 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH10 : (a_pre = 4096)) (PreH11 : ((INT_MIN) <= retval)) (PreH12 : (retval <= INT_MAX)) (PreH13 : ((INT_MIN) <= retval_2)) (PreH14 : (retval_2 <= INT_MAX)) (PreH15 : ((INT_MIN) <= retval_3)) (PreH16 : (retval_3 <= INT_MAX)) ,
  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
).

Definition verify_main_return_wit_1_split_goal_spatial := 
forall (a_pre: Z) (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (retval_3: Z) (two: Z) (a: Z) (PreH1 : ((Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 2)) (PreH2 : (two = 2)) (PreH3 : (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH5 : (one = 1)) (PreH6 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH7 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH8 : (zero = 0)) (PreH9 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH10 : (a_pre = 4096)) (PreH11 : ((INT_MIN) <= retval)) (PreH12 : (retval <= INT_MAX)) (PreH13 : ((INT_MIN) <= retval_2)) (PreH14 : (retval_2 <= INT_MAX)) (PreH15 : ((INT_MIN) <= retval_3)) (PreH16 : (retval_3 <= INT_MAX)) ,
  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_1_pure := 
forall (a_pre: Z) (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (a: Z) (zero_addr_v: Z) (first_addr_v: Z) (one_addr_v: Z) (second_addr_v: Z) (PreH1 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH2 : (one = 1)) (PreH3 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH5 : (zero = 0)) (PreH6 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH7 : (a_pre = 4096)) (PreH8 : ((INT_MIN) <= retval)) (PreH9 : (retval <= INT_MAX)) (PreH10 : ((INT_MIN) <= retval_2)) (PreH11 : (retval_2 <= INT_MAX)) ,
  ((( &( "two_spec_465" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> a)
  **  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_399" ) )) # Int  |-> zero_addr_v)
  **  ((( &( "first_spec_414" ) )) # Ptr  |-> first_addr_v)
  **  ((( &( "one_spec_426" ) )) # Int  |-> one_addr_v)
  **  ((( &( "second_spec_447" ) )) # Ptr  |-> second_addr_v)
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ”
.

Definition verify_main_partial_solve_wit_1_aux := 
forall (a_pre: Z) (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (a: Z) (PreH1 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH2 : (one = 1)) (PreH3 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH5 : (zero = 0)) (PreH6 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH7 : (a_pre = 4096)) (PreH8 : ((INT_MIN) <= retval)) (PreH9 : (retval <= INT_MAX)) (PreH10 : ((INT_MIN) <= retval_2)) (PreH11 : (retval_2 <= INT_MAX)) ,
  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ” 
  &&  “ ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1) ” 
  &&  “ (one = 1) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (zero = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (a_pre = 4096) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ”
  &&  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_1 := verify_main_partial_solve_wit_1_pure -> verify_main_partial_solve_wit_1_aux.

Definition verify_main_partial_solve_wit_2_pure := 
forall (a_pre: Z) (retval: Z) (zero: Z) (a: Z) (zero_addr_v: Z) (first_addr_v: Z) (PreH1 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH2 : (zero = 0)) (PreH3 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : (a_pre = 4096)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) ,
  ((( &( "one_spec_426" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> a)
  **  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_399" ) )) # Int  |-> zero_addr_v)
  **  ((( &( "first_spec_414" ) )) # Ptr  |-> first_addr_v)
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ”
.

Definition verify_main_partial_solve_wit_2_aux := 
forall (a_pre: Z) (retval: Z) (zero: Z) (a: Z) (PreH1 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH2 : (zero = 0)) (PreH3 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : (a_pre = 4096)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) ,
  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ” 
  &&  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (zero = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (a_pre = 4096) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  (IntArray.full a 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_2 := verify_main_partial_solve_wit_2_pure -> verify_main_partial_solve_wit_2_aux.

Definition verify_main_partial_solve_wit_3_pure := 
forall (a_pre: Z) (PreH1 : (a_pre = 4096)) ,
  ((( &( "zero_spec_399" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> a_pre)
  **  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ”
.

Definition verify_main_partial_solve_wit_3_aux := 
forall (a_pre: Z) (PreH1 : (a_pre = 4096)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ” 
  &&  “ (a_pre = 4096) ”
  &&  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_3 := verify_main_partial_solve_wit_3_pure -> verify_main_partial_solve_wit_3_aux.

Definition verify_main_precondition_wit_1 :=
exists (a_pre: Z) ,
~ ((  “ (a_pre = 4096) ”
  &&  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_verify_main_safety_wit_1 : verify_main_safety_wit_1.
Axiom proof_of_verify_main_safety_wit_2 : verify_main_safety_wit_2.
Axiom proof_of_verify_main_safety_wit_3 : verify_main_safety_wit_3.
Axiom proof_of_verify_main_safety_wit_4 : verify_main_safety_wit_4.
Axiom proof_of_verify_main_safety_wit_5 : verify_main_safety_wit_5.
Axiom proof_of_verify_main_safety_wit_6 : verify_main_safety_wit_6.
Axiom proof_of_verify_main_safety_wit_7 : verify_main_safety_wit_7.
Axiom proof_of_verify_main_safety_wit_8 : verify_main_safety_wit_8.
Axiom proof_of_verify_main_safety_wit_9 : verify_main_safety_wit_9.
Axiom proof_of_verify_main_entail_wit_1 : verify_main_entail_wit_1.
Axiom proof_of_verify_main_entail_wit_2 : verify_main_entail_wit_2.
Axiom proof_of_verify_main_entail_wit_3 : verify_main_entail_wit_3.
Axiom proof_of_verify_main_entail_wit_4 : verify_main_entail_wit_4.
Axiom proof_of_verify_main_entail_wit_5 : verify_main_entail_wit_5.
Axiom proof_of_verify_main_entail_wit_6 : verify_main_entail_wit_6.
Axiom proof_of_verify_main_return_wit_1 : verify_main_return_wit_1.
Axiom proof_of_verify_main_partial_solve_wit_1_pure : verify_main_partial_solve_wit_1_pure.
Axiom proof_of_verify_main_partial_solve_wit_1 : verify_main_partial_solve_wit_1.
Axiom proof_of_verify_main_partial_solve_wit_2_pure : verify_main_partial_solve_wit_2_pure.
Axiom proof_of_verify_main_partial_solve_wit_2 : verify_main_partial_solve_wit_2.
Axiom proof_of_verify_main_partial_solve_wit_3_pure : verify_main_partial_solve_wit_3_pure.
Axiom proof_of_verify_main_partial_solve_wit_3 : verify_main_partial_solve_wit_3.
Axiom proof_of_verify_main_precondition_wit_1 : verify_main_precondition_wit_1.

End VC_Correct.
