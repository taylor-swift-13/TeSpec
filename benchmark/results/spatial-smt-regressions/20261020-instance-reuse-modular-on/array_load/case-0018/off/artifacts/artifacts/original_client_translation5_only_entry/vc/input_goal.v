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
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (retval_3 = 2)) (PreH2 : (retval_2 = 1)) (PreH3 : (retval = 0)) (PreH4 : (( &( "a_spec_390" ) ) = 8192)) (PreH5 : (( &( "zero_spec_399" ) ) = 12288)) (PreH6 : (( &( "first_spec_414" ) ) = 16384)) (PreH7 : (( &( "one_spec_426" ) ) = 20480)) (PreH8 : (( &( "second_spec_447" ) ) = 24576)) (PreH9 : (( &( "two_spec_465" ) ) = 28672)) (PreH10 : (( &( "third_spec_492" ) ) = 32768)) ,
  ((8192) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((12288) # Int  |-> 0)
  **  ((16384) # Ptr  |-> 4096)
  **  ((20480) # Int  |-> 1)
  **  ((24576) # Ptr  |-> 4100)
  **  ((28672) # Int  |-> 2)
  **  ((32768) # Ptr  |-> 4104)
|--
  TT && emp 
.

Definition verify_main_safety_wit_2 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (retval_3 = 2)) (PreH2 : (retval_2 = 1)) (PreH3 : (retval = 0)) (PreH4 : (( &( "a_spec_390" ) ) = 8192)) (PreH5 : (( &( "zero_spec_399" ) ) = 12288)) (PreH6 : (( &( "first_spec_414" ) ) = 16384)) (PreH7 : (( &( "one_spec_426" ) ) = 20480)) (PreH8 : (( &( "second_spec_447" ) ) = 24576)) (PreH9 : (( &( "two_spec_465" ) ) = 28672)) ,
  ((( &( "third_spec_492" ) )) # Ptr  |->_)
  **  ((28672) # Int  |-> 2)
  **  ((8192) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((12288) # Int  |-> 0)
  **  ((16384) # Ptr  |-> 4096)
  **  ((20480) # Int  |-> 1)
  **  ((24576) # Ptr  |-> 4100)
|--
  TT && emp 
.

Definition verify_main_safety_wit_3 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (retval_2 = 1)) (PreH2 : (retval = 0)) (PreH3 : (( &( "a_spec_390" ) ) = 8192)) (PreH4 : (( &( "zero_spec_399" ) ) = 12288)) (PreH5 : (( &( "first_spec_414" ) ) = 16384)) (PreH6 : (( &( "one_spec_426" ) ) = 20480)) (PreH7 : (( &( "second_spec_447" ) ) = 24576)) ,
  ((( &( "two_spec_465" ) )) # Int  |->_)
  **  ((8192) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((12288) # Int  |-> 0)
  **  ((16384) # Ptr  |-> 4096)
  **  ((20480) # Int  |-> 1)
  **  ((24576) # Ptr  |-> 4100)
|--
  TT && emp 
.

Definition verify_main_safety_wit_4 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (retval_2 = 1)) (PreH2 : (retval = 0)) (PreH3 : (( &( "a_spec_390" ) ) = 8192)) (PreH4 : (( &( "zero_spec_399" ) ) = 12288)) (PreH5 : (( &( "first_spec_414" ) ) = 16384)) (PreH6 : (( &( "one_spec_426" ) ) = 20480)) (PreH7 : (( &( "second_spec_447" ) ) = 24576)) ,
  ((( &( "two_spec_465" ) )) # Int  |->_)
  **  ((8192) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((12288) # Int  |-> 0)
  **  ((16384) # Ptr  |-> 4096)
  **  ((20480) # Int  |-> 1)
  **  ((24576) # Ptr  |-> 4100)
|--
  TT && emp 
.

Definition verify_main_safety_wit_5 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (retval_2 = 1)) (PreH2 : (retval = 0)) (PreH3 : (( &( "a_spec_390" ) ) = 8192)) (PreH4 : (( &( "zero_spec_399" ) ) = 12288)) (PreH5 : (( &( "first_spec_414" ) ) = 16384)) (PreH6 : (( &( "one_spec_426" ) ) = 20480)) ,
  ((( &( "second_spec_447" ) )) # Ptr  |->_)
  **  ((20480) # Int  |-> 1)
  **  ((8192) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((12288) # Int  |-> 0)
  **  ((16384) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition verify_main_safety_wit_6 := 
forall (retval: Z) (PreH1 : (retval = 0)) (PreH2 : (( &( "a_spec_390" ) ) = 8192)) (PreH3 : (( &( "zero_spec_399" ) ) = 12288)) (PreH4 : (( &( "first_spec_414" ) ) = 16384)) ,
  ((( &( "one_spec_426" ) )) # Int  |->_)
  **  ((8192) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((12288) # Int  |-> 0)
  **  ((16384) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition verify_main_safety_wit_7 := 
forall (retval: Z) (PreH1 : (retval = 0)) (PreH2 : (( &( "a_spec_390" ) ) = 8192)) (PreH3 : (( &( "zero_spec_399" ) ) = 12288)) (PreH4 : (( &( "first_spec_414" ) ) = 16384)) ,
  ((( &( "one_spec_426" ) )) # Int  |->_)
  **  ((8192) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((12288) # Int  |-> 0)
  **  ((16384) # Ptr  |-> 4096)
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
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (2 = 2)) (PreH2 : (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH3 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH4 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH5 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH6 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH7 : (( &( "a_spec_390" ) ) = 8192)) (PreH8 : (( &( "zero_spec_399" ) ) = 12288)) (PreH9 : ((INT_MIN) <= retval)) (PreH10 : (retval <= INT_MAX)) (PreH11 : (( &( "first_spec_414" ) ) = 16384)) (PreH12 : (( &( "one_spec_426" ) ) = 20480)) (PreH13 : ((INT_MIN) <= retval_2)) (PreH14 : (retval_2 <= INT_MAX)) (PreH15 : (( &( "second_spec_447" ) ) = 24576)) (PreH16 : (( &( "two_spec_465" ) ) = 28672)) (PreH17 : ((INT_MIN) <= retval_3)) (PreH18 : (retval_3 <= INT_MAX)) ,
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ ((Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 2) ” 
  &&  “ (2 = 2) ” 
  &&  “ (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (( &( "a_spec_390" ) ) = 8192) ” 
  &&  “ (( &( "zero_spec_399" ) ) = 12288) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ (( &( "first_spec_414" ) ) = 16384) ” 
  &&  “ (( &( "one_spec_426" ) ) = 20480) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ” 
  &&  “ (( &( "second_spec_447" ) ) = 24576) ” 
  &&  “ (( &( "two_spec_465" ) ) = 28672) ” 
  &&  “ ((INT_MIN) <= retval_3) ” 
  &&  “ (retval_3 <= INT_MAX) ”
  &&  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_entail_wit_2 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH3 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH5 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH6 : (( &( "a_spec_390" ) ) = 8192)) (PreH7 : (( &( "zero_spec_399" ) ) = 12288)) (PreH8 : ((INT_MIN) <= retval)) (PreH9 : (retval <= INT_MAX)) (PreH10 : (( &( "first_spec_414" ) ) = 16384)) (PreH11 : (( &( "one_spec_426" ) ) = 20480)) (PreH12 : ((INT_MIN) <= retval_2)) (PreH13 : (retval_2 <= INT_MAX)) (PreH14 : (( &( "second_spec_447" ) ) = 24576)) (PreH15 : (( &( "two_spec_465" ) ) = 28672)) (PreH16 : ((INT_MIN) <= retval_3)) (PreH17 : (retval_3 <= INT_MAX)) ,
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "two_spec_465" ) )) # Int  |-> retval_3)
|--
  “ (2 = 2) ” 
  &&  “ (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (( &( "a_spec_390" ) ) = 8192) ” 
  &&  “ (( &( "zero_spec_399" ) ) = 12288) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ (( &( "first_spec_414" ) ) = 16384) ” 
  &&  “ (( &( "one_spec_426" ) ) = 20480) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ” 
  &&  “ (( &( "second_spec_447" ) ) = 24576) ” 
  &&  “ (( &( "two_spec_465" ) ) = 28672) ” 
  &&  “ ((INT_MIN) <= retval_3) ” 
  &&  “ (retval_3 <= INT_MAX) ”
  &&  ((( &( "two_spec_465" ) )) # Int  |-> 2)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_entail_wit_3 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (1 = 1)) (PreH2 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH3 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH4 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH5 : (( &( "a_spec_390" ) ) = 8192)) (PreH6 : (( &( "zero_spec_399" ) ) = 12288)) (PreH7 : ((INT_MIN) <= retval)) (PreH8 : (retval <= INT_MAX)) (PreH9 : (( &( "first_spec_414" ) ) = 16384)) (PreH10 : (( &( "one_spec_426" ) ) = 20480)) (PreH11 : ((INT_MIN) <= retval_2)) (PreH12 : (retval_2 <= INT_MAX)) ,
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1) ” 
  &&  “ (1 = 1) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (( &( "a_spec_390" ) ) = 8192) ” 
  &&  “ (( &( "zero_spec_399" ) ) = 12288) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ (( &( "first_spec_414" ) ) = 16384) ” 
  &&  “ (( &( "one_spec_426" ) ) = 20480) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ”
  &&  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_entail_wit_4 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH3 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : (( &( "a_spec_390" ) ) = 8192)) (PreH5 : (( &( "zero_spec_399" ) ) = 12288)) (PreH6 : ((INT_MIN) <= retval)) (PreH7 : (retval <= INT_MAX)) (PreH8 : (( &( "first_spec_414" ) ) = 16384)) (PreH9 : (( &( "one_spec_426" ) ) = 20480)) (PreH10 : ((INT_MIN) <= retval_2)) (PreH11 : (retval_2 <= INT_MAX)) ,
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "one_spec_426" ) )) # Int  |-> retval_2)
|--
  “ (1 = 1) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (( &( "a_spec_390" ) ) = 8192) ” 
  &&  “ (( &( "zero_spec_399" ) ) = 12288) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ (( &( "first_spec_414" ) ) = 16384) ” 
  &&  “ (( &( "one_spec_426" ) ) = 20480) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ”
  &&  ((( &( "one_spec_426" ) )) # Int  |-> 1)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_entail_wit_5 := 
forall (retval: Z) (PreH1 : (0 = 0)) (PreH2 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH3 : (4096 = 4096)) (PreH4 : (( &( "a_spec_390" ) ) = 8192)) (PreH5 : (( &( "zero_spec_399" ) ) = 12288)) (PreH6 : ((INT_MIN) <= retval)) (PreH7 : (retval <= INT_MAX)) ,
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (0 = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (4096 = 4096) ” 
  &&  “ (( &( "a_spec_390" ) ) = 8192) ” 
  &&  “ (( &( "zero_spec_399" ) ) = 12288) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_entail_wit_6 := 
forall (a_pre: Z) (retval: Z) (PreH1 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : (a_pre = 4096)) (PreH3 : (( &( "a_spec_390" ) ) = 8192)) (PreH4 : (( &( "zero_spec_399" ) ) = 12288)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_399" ) )) # Int  |-> retval)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> a_pre)
|--
  “ (0 = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (4096 = 4096) ” 
  &&  “ (( &( "a_spec_390" ) ) = 8192) ” 
  &&  “ (( &( "zero_spec_399" ) ) = 12288) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_return_wit_1 := 
forall (a_pre: Z) (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : ((Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 2)) (PreH2 : (2 = 2)) (PreH3 : (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH5 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH6 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH7 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH8 : (( &( "a_spec_390" ) ) = 8192)) (PreH9 : (( &( "zero_spec_399" ) ) = 12288)) (PreH10 : ((INT_MIN) <= retval)) (PreH11 : (retval <= INT_MAX)) (PreH12 : (( &( "first_spec_414" ) ) = 16384)) (PreH13 : (( &( "one_spec_426" ) ) = 20480)) (PreH14 : ((INT_MIN) <= retval_2)) (PreH15 : (retval_2 <= INT_MAX)) (PreH16 : (( &( "second_spec_447" ) ) = 24576)) (PreH17 : (( &( "two_spec_465" ) ) = 28672)) (PreH18 : ((INT_MIN) <= retval_3)) (PreH19 : (retval_3 <= INT_MAX)) (PreH20 : (( &( "third_spec_492" ) ) = 32768)) ,
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 = 0) ”
  &&  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_1_pure := 
forall (retval: Z) (retval_2: Z) (PreH1 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH2 : (1 = 1)) (PreH3 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH5 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH6 : (( &( "a_spec_390" ) ) = 8192)) (PreH7 : (( &( "zero_spec_399" ) ) = 12288)) (PreH8 : ((INT_MIN) <= retval)) (PreH9 : (retval <= INT_MAX)) (PreH10 : (( &( "first_spec_414" ) ) = 16384)) (PreH11 : (( &( "one_spec_426" ) ) = 20480)) (PreH12 : ((INT_MIN) <= retval_2)) (PreH13 : (retval_2 <= INT_MAX)) (PreH14 : (( &( "second_spec_447" ) ) = 24576)) (PreH15 : (( &( "two_spec_465" ) ) = 28672)) ,
  ((( &( "two_spec_465" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_414" ) )) # Ptr  |-> 4096)
  **  ((( &( "one_spec_426" ) )) # Int  |-> 1)
  **  ((( &( "second_spec_447" ) )) # Ptr  |-> (4096 + (1 * sizeof(INT))))
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ”
.

Definition verify_main_partial_solve_wit_1_aux := 
forall (retval: Z) (retval_2: Z) (PreH1 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH2 : (1 = 1)) (PreH3 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH5 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH6 : (( &( "a_spec_390" ) ) = 8192)) (PreH7 : (( &( "zero_spec_399" ) ) = 12288)) (PreH8 : ((INT_MIN) <= retval)) (PreH9 : (retval <= INT_MAX)) (PreH10 : (( &( "first_spec_414" ) ) = 16384)) (PreH11 : (( &( "one_spec_426" ) ) = 20480)) (PreH12 : ((INT_MIN) <= retval_2)) (PreH13 : (retval_2 <= INT_MAX)) (PreH14 : (( &( "second_spec_447" ) ) = 24576)) (PreH15 : (( &( "two_spec_465" ) ) = 28672)) ,
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ” 
  &&  “ ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (( &( "a_spec_390" ) ) = 8192) ” 
  &&  “ (( &( "zero_spec_399" ) ) = 12288) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ (( &( "first_spec_414" ) ) = 16384) ” 
  &&  “ (( &( "one_spec_426" ) ) = 20480) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ” 
  &&  “ (( &( "second_spec_447" ) ) = 24576) ” 
  &&  “ (( &( "two_spec_465" ) ) = 28672) ”
  &&  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_1 := verify_main_partial_solve_wit_1_pure -> verify_main_partial_solve_wit_1_aux.

Definition verify_main_partial_solve_wit_2_pure := 
forall (retval: Z) (PreH1 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH2 : (0 = 0)) (PreH3 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : (4096 = 4096)) (PreH5 : (( &( "a_spec_390" ) ) = 8192)) (PreH6 : (( &( "zero_spec_399" ) ) = 12288)) (PreH7 : ((INT_MIN) <= retval)) (PreH8 : (retval <= INT_MAX)) (PreH9 : (( &( "first_spec_414" ) ) = 16384)) (PreH10 : (( &( "one_spec_426" ) ) = 20480)) ,
  ((( &( "one_spec_426" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_414" ) )) # Ptr  |-> 4096)
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ”
.

Definition verify_main_partial_solve_wit_2_aux := 
forall (retval: Z) (PreH1 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH2 : (0 = 0)) (PreH3 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : (4096 = 4096)) (PreH5 : (( &( "a_spec_390" ) ) = 8192)) (PreH6 : (( &( "zero_spec_399" ) ) = 12288)) (PreH7 : ((INT_MIN) <= retval)) (PreH8 : (retval <= INT_MAX)) (PreH9 : (( &( "first_spec_414" ) ) = 16384)) (PreH10 : (( &( "one_spec_426" ) ) = 20480)) ,
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ” 
  &&  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (( &( "a_spec_390" ) ) = 8192) ” 
  &&  “ (( &( "zero_spec_399" ) ) = 12288) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ (( &( "first_spec_414" ) ) = 16384) ” 
  &&  “ (( &( "one_spec_426" ) ) = 20480) ”
  &&  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_2 := verify_main_partial_solve_wit_2_pure -> verify_main_partial_solve_wit_2_aux.

Definition verify_main_partial_solve_wit_3_pure := 
forall (a_pre: Z) (PreH1 : (a_pre = 4096)) (PreH2 : (( &( "a_spec_390" ) ) = 8192)) (PreH3 : (( &( "zero_spec_399" ) ) = 12288)) ,
  ((( &( "zero_spec_399" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> a_pre)
  **  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ”
.

Definition verify_main_partial_solve_wit_3_aux := 
forall (a_pre: Z) (PreH1 : (a_pre = 4096)) (PreH2 : (( &( "a_spec_390" ) ) = 8192)) (PreH3 : (( &( "zero_spec_399" ) ) = 12288)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ” 
  &&  “ (a_pre = 4096) ” 
  &&  “ (( &( "a_spec_390" ) ) = 8192) ” 
  &&  “ (( &( "zero_spec_399" ) ) = 12288) ”
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
