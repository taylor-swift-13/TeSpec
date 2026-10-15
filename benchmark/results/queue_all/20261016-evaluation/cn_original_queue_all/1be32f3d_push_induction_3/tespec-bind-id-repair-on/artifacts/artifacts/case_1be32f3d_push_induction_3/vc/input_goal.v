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
Require Import CNQueueGuarded.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function push_induction -----*)

Definition push_induction_safety_wit_1 := 
forall (y: Z) (y_2: Z) (a: Z) (y_3: Z) (a_2: Z) (y_4: Z) (PreH1 : False) ,
  ((( &( "p_spec_505" ) )) # Ptr  |-> 12288)
  **  ((( &( "front_spec_504" ) )) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> a_2)
  **  ((( &( "p_spec_493" ) )) # Ptr  |-> 12288)
  **  ((( &( "front_spec_492" ) )) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> a)
  **  ((( &( "p_spec_481" ) )) # Ptr  |-> 12288)
  **  ((( &( "front_spec_480" ) )) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  ((( &( "p_spec_469" ) )) # Ptr  |-> 12288)
  **  ((( &( "front_spec_468" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "front_spec_447" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_444" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (12288 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (12288 + 4)) # Ptr  |-> 16384)
|--
  “ False ”
.

Definition push_induction_safety_wit_2 := 
forall (y: Z) (y_2: Z) (a: Z) (y_3: Z) (a_2: Z) (PreH1 : False) ,
  ((( &( "p_spec_505" ) )) # Ptr  |-> 12288)
  **  ((( &( "front_spec_504" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> a_2)
  **  ((( &( "p_spec_493" ) )) # Ptr  |-> 12288)
  **  ((( &( "front_spec_492" ) )) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> a)
  **  ((( &( "p_spec_481" ) )) # Ptr  |-> 12288)
  **  ((( &( "front_spec_480" ) )) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  ((( &( "p_spec_469" ) )) # Ptr  |-> 12288)
  **  ((( &( "front_spec_468" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "front_spec_447" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_444" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (12288 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (12288 + 4)) # Ptr  |-> 16384)
|--
  “ False ”
.

Definition push_induction_safety_wit_3 := 
forall (a: Z) (tl: (@list Z)) (y: Z) (a_2: Z) (tl_2: (@list Z)) (y_2: Z) (PreH1 : (y_2 = 12288)) (PreH2 : (y <> 0)) (PreH3 : (0 = a_2)) (PreH4 : ((cons ((INT_MIN)) ((@nil Z))) = tl_2)) (PreH5 : (y <> 12288)) (PreH6 : (y <> 0)) (PreH7 : (INT_MAX = a)) (PreH8 : ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))) = tl)) ,
  ((( &( "p_spec_481" ) )) # Ptr  |-> 12288)
  **  ((( &( "front_spec_480" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 12288)
  **  (CNQueueAux 12288 12288 (cons ((INT_MIN)) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  ((( &( "p_spec_469" ) )) # Ptr  |-> 12288)
  **  ((( &( "front_spec_468" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "front_spec_447" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_444" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (12288 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (12288 + 4)) # Ptr  |-> 16384)
|--
  “ False ”
.

Definition push_induction_safety_wit_4 := 
forall (a: Z) (tl: (@list Z)) (y: Z) (PreH1 : (y = 12288)) (PreH2 : (INT_MAX = a)) (PreH3 : ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))) = tl)) ,
  ((( &( "p_spec_469" ) )) # Ptr  |-> 12288)
  **  ((( &( "front_spec_468" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 12288)
  **  (CNQueueAux 12288 12288 (cons (0) ((cons ((INT_MIN)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "front_spec_447" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_444" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (12288 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (12288 + 4)) # Ptr  |-> 16384)
|--
  “ False ”
.

Definition push_induction_safety_wit_5 := 
forall (PreH1 : False) ,
  ((( &( "front_spec_447" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_444" ) )) # Ptr  |-> 12288)
  **  (CNQueueAux 8192 12288 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (12288 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (12288 + 4)) # Ptr  |-> 16384)
|--
  “ False ”
.

Definition push_induction_return_wit_1 := 
(
forall (p_pre: Z) (front_pre: Z) (l___tespec_entry: (@list Z)) (y___tespec_entry: Z) (v___tespec_entry: Z) (a: Z) (tl: (@list Z)) (y: Z) (a_2: Z) (tl_2: (@list Z)) (y_2: Z) (a_3: Z) (tl_3: (@list Z)) (y_3: Z) (PreH1 : (y_3 = p_pre)) (PreH2 : (y_3 <> 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (tl_2 = (cons (a_3) (tl_3)))) (PreH5 : (y_2 <> p_pre)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (tl = (cons (a_2) (tl_2)))) (PreH9 : (y <> p_pre)) (PreH10 : (y <> 0)) (PreH11 : (front_pre <> 0)) (PreH12 : (l___tespec_entry = (cons (a) (tl)))) (PreH13 : (front_pre <> p_pre)) (PreH14 : (front_pre = 8192)) (PreH15 : (p_pre = 12288)) (PreH16 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH17 : (v___tespec_entry = (-1))) (PreH18 : (y___tespec_entry = 16384)) (PreH19 : (p_pre <> 0)) (PreH20 : (front_pre <> y___tespec_entry)) (PreH21 : (y___tespec_entry <> 0)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (CNQueueAux y_3 p_pre tl_3 )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> a_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> a_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (front_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (front_pre + 0)) # Int  |-> a)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> v___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> y___tespec_entry)
|--
  (CNQueueAux front_pre y___tespec_entry (app (l___tespec_entry) ((cons (v___tespec_entry) ((@nil Z))))) )
) \/
(
forall (p_pre: Z) (front_pre: Z) (l___tespec_entry: (@list Z)) (y___tespec_entry: Z) (v___tespec_entry: Z) (a: Z) (tl: (@list Z)) (y: Z) (a_2: Z) (tl_2: (@list Z)) (y_2: Z) (a_3: Z) (tl_3: (@list Z)) (y_3: Z) (PreH1 : (v___tespec_entry <= INT_MAX)) (PreH2 : (a <= INT_MAX)) (PreH3 : (a_2 <= INT_MAX)) (PreH4 : (a_3 <= INT_MAX)) (PreH5 : (v___tespec_entry >= INT_MIN)) (PreH6 : (a >= INT_MIN)) (PreH7 : (a_2 >= INT_MIN)) (PreH8 : (a_3 >= INT_MIN)) (PreH9 : (tl_3 = (@nil Z))) (PreH10 : (y_3 = p_pre)) (PreH11 : (y_3 <> 0)) (PreH12 : (y_2 <> 0)) (PreH13 : (tl_2 = (cons (a_3) (tl_3)))) (PreH14 : (y_2 <> p_pre)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (tl = (cons (a_2) (tl_2)))) (PreH18 : (y <> p_pre)) (PreH19 : (y <> 0)) (PreH20 : (front_pre <> 0)) (PreH21 : (l___tespec_entry = (cons (a) (tl)))) (PreH22 : (front_pre <> p_pre)) (PreH23 : (front_pre = 8192)) (PreH24 : (p_pre = 12288)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH26 : (v___tespec_entry = (-1))) (PreH27 : (y___tespec_entry = 16384)) (PreH28 : (p_pre <> 0)) (PreH29 : (front_pre <> y___tespec_entry)) (PreH30 : (y___tespec_entry <> 0)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> a_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> a_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (front_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (front_pre + 0)) # Int  |-> a)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> v___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> y___tespec_entry)
|--
  (CNQueueAux front_pre y___tespec_entry (app (l___tespec_entry) ((cons (v___tespec_entry) ((@nil Z))))) )
).

Definition push_induction_return_wit_1_split_goal_spatial := 
forall (p_pre: Z) (front_pre: Z) (l___tespec_entry: (@list Z)) (y___tespec_entry: Z) (v___tespec_entry: Z) (a: Z) (tl: (@list Z)) (y: Z) (a_2: Z) (tl_2: (@list Z)) (y_2: Z) (a_3: Z) (tl_3: (@list Z)) (y_3: Z) (PreH1 : (v___tespec_entry <= INT_MAX)) (PreH2 : (a <= INT_MAX)) (PreH3 : (a_2 <= INT_MAX)) (PreH4 : (a_3 <= INT_MAX)) (PreH5 : (v___tespec_entry >= INT_MIN)) (PreH6 : (a >= INT_MIN)) (PreH7 : (a_2 >= INT_MIN)) (PreH8 : (a_3 >= INT_MIN)) (PreH9 : (tl_3 = (@nil Z))) (PreH10 : (y_3 = p_pre)) (PreH11 : (y_3 <> 0)) (PreH12 : (y_2 <> 0)) (PreH13 : (tl_2 = (cons (a_3) (tl_3)))) (PreH14 : (y_2 <> p_pre)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (tl = (cons (a_2) (tl_2)))) (PreH18 : (y <> p_pre)) (PreH19 : (y <> 0)) (PreH20 : (front_pre <> 0)) (PreH21 : (l___tespec_entry = (cons (a) (tl)))) (PreH22 : (front_pre <> p_pre)) (PreH23 : (front_pre = 8192)) (PreH24 : (p_pre = 12288)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH26 : (v___tespec_entry = (-1))) (PreH27 : (y___tespec_entry = 16384)) (PreH28 : (p_pre <> 0)) (PreH29 : (front_pre <> y___tespec_entry)) (PreH30 : (y___tespec_entry <> 0)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> a_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> a_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (front_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (front_pre + 0)) # Int  |-> a)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> v___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> y___tespec_entry)
|--
  (CNQueueAux front_pre y___tespec_entry (app (l___tespec_entry) ((cons (v___tespec_entry) ((@nil Z))))) )
.

Definition push_induction_partial_solve_wit_1 := 
forall (p_pre: Z) (front_pre: Z) (l___tespec_entry: (@list Z)) (y___tespec_entry: Z) (v___tespec_entry: Z) (PreH1 : (front_pre <> p_pre)) (PreH2 : (front_pre = 8192)) (PreH3 : (p_pre = 12288)) (PreH4 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH5 : (v___tespec_entry = (-1))) (PreH6 : (y___tespec_entry = 16384)) (PreH7 : (p_pre <> 0)) (PreH8 : (front_pre <> y___tespec_entry)) (PreH9 : (y___tespec_entry <> 0)) ,
  (CNQueueAux front_pre p_pre l___tespec_entry )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> v___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> y___tespec_entry)
|--
  EX (a: Z)  (tl: (@list Z))  (y: Z) ,
  “ (y <> 0) ” 
  &&  “ (front_pre <> 0) ” 
  &&  “ (l___tespec_entry = (cons (a) (tl))) ” 
  &&  “ (front_pre <> p_pre) ” 
  &&  “ (front_pre = 8192) ” 
  &&  “ (p_pre = 12288) ” 
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ” 
  &&  “ (v___tespec_entry = (-1)) ” 
  &&  “ (y___tespec_entry = 16384) ” 
  &&  “ (p_pre <> 0) ” 
  &&  “ (front_pre <> y___tespec_entry) ” 
  &&  “ (y___tespec_entry <> 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (front_pre + 4)) # Ptr  |-> y)
  **  (CNQueueAux y p_pre tl )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (front_pre + 0)) # Int  |-> a)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> v___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> y___tespec_entry)
.

Definition push_induction_partial_solve_wit_2 := 
forall (p_pre: Z) (front_pre: Z) (l___tespec_entry: (@list Z)) (y___tespec_entry: Z) (v___tespec_entry: Z) (a: Z) (tl: (@list Z)) (y: Z) (PreH1 : (y <> p_pre)) (PreH2 : (y <> 0)) (PreH3 : (front_pre <> 0)) (PreH4 : (l___tespec_entry = (cons (a) (tl)))) (PreH5 : (front_pre <> p_pre)) (PreH6 : (front_pre = 8192)) (PreH7 : (p_pre = 12288)) (PreH8 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH9 : (v___tespec_entry = (-1))) (PreH10 : (y___tespec_entry = 16384)) (PreH11 : (p_pre <> 0)) (PreH12 : (front_pre <> y___tespec_entry)) (PreH13 : (y___tespec_entry <> 0)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (front_pre + 4)) # Ptr  |-> y)
  **  (CNQueueAux y p_pre tl )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (front_pre + 0)) # Int  |-> a)
  **  ((( &( "front_spec_447" ) )) # Ptr  |-> front_pre)
  **  ((( &( "p_spec_444" ) )) # Ptr  |-> p_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> v___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> y___tespec_entry)
|--
  EX (a_2: Z)  (tl_2: (@list Z))  (y_2: Z) ,
  “ (y_2 <> 0) ” 
  &&  “ (y <> 0) ” 
  &&  “ (tl = (cons (a_2) (tl_2))) ” 
  &&  “ (y <> p_pre) ” 
  &&  “ (y <> 0) ” 
  &&  “ (front_pre <> 0) ” 
  &&  “ (l___tespec_entry = (cons (a) (tl))) ” 
  &&  “ (front_pre <> p_pre) ” 
  &&  “ (front_pre = 8192) ” 
  &&  “ (p_pre = 12288) ” 
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ” 
  &&  “ (v___tespec_entry = (-1)) ” 
  &&  “ (y___tespec_entry = 16384) ” 
  &&  “ (p_pre <> 0) ” 
  &&  “ (front_pre <> y___tespec_entry) ” 
  &&  “ (y___tespec_entry <> 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (CNQueueAux y_2 p_pre tl_2 )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> a_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (front_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (front_pre + 0)) # Int  |-> a)
  **  ((( &( "front_spec_447" ) )) # Ptr  |-> front_pre)
  **  ((( &( "p_spec_444" ) )) # Ptr  |-> p_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> v___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> y___tespec_entry)
.

Definition push_induction_partial_solve_wit_3 := 
forall (p_pre: Z) (front_pre: Z) (l___tespec_entry: (@list Z)) (y___tespec_entry: Z) (v___tespec_entry: Z) (a: Z) (tl: (@list Z)) (y: Z) (a_2: Z) (tl_2: (@list Z)) (y_2: Z) (PreH1 : (y_2 <> p_pre)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (tl = (cons (a_2) (tl_2)))) (PreH5 : (y <> p_pre)) (PreH6 : (y <> 0)) (PreH7 : (front_pre <> 0)) (PreH8 : (l___tespec_entry = (cons (a) (tl)))) (PreH9 : (front_pre <> p_pre)) (PreH10 : (front_pre = 8192)) (PreH11 : (p_pre = 12288)) (PreH12 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH13 : (v___tespec_entry = (-1))) (PreH14 : (y___tespec_entry = 16384)) (PreH15 : (p_pre <> 0)) (PreH16 : (front_pre <> y___tespec_entry)) (PreH17 : (y___tespec_entry <> 0)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (CNQueueAux y_2 p_pre tl_2 )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> a_2)
  **  ((( &( "p_spec_469" ) )) # Ptr  |-> p_pre)
  **  ((( &( "front_spec_468" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (front_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (front_pre + 0)) # Int  |-> a)
  **  ((( &( "front_spec_447" ) )) # Ptr  |-> front_pre)
  **  ((( &( "p_spec_444" ) )) # Ptr  |-> p_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> v___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> y___tespec_entry)
|--
  EX (a_3: Z)  (tl_3: (@list Z))  (y_3: Z) ,
  “ (y_3 <> 0) ” 
  &&  “ (y_2 <> 0) ” 
  &&  “ (tl_2 = (cons (a_3) (tl_3))) ” 
  &&  “ (y_2 <> p_pre) ” 
  &&  “ (y_2 <> 0) ” 
  &&  “ (y <> 0) ” 
  &&  “ (tl = (cons (a_2) (tl_2))) ” 
  &&  “ (y <> p_pre) ” 
  &&  “ (y <> 0) ” 
  &&  “ (front_pre <> 0) ” 
  &&  “ (l___tespec_entry = (cons (a) (tl))) ” 
  &&  “ (front_pre <> p_pre) ” 
  &&  “ (front_pre = 8192) ” 
  &&  “ (p_pre = 12288) ” 
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ” 
  &&  “ (v___tespec_entry = (-1)) ” 
  &&  “ (y___tespec_entry = 16384) ” 
  &&  “ (p_pre <> 0) ” 
  &&  “ (front_pre <> y___tespec_entry) ” 
  &&  “ (y___tespec_entry <> 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (CNQueueAux y_3 p_pre tl_3 )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> a_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> a_2)
  **  ((( &( "p_spec_469" ) )) # Ptr  |-> p_pre)
  **  ((( &( "front_spec_468" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (front_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (front_pre + 0)) # Int  |-> a)
  **  ((( &( "front_spec_447" ) )) # Ptr  |-> front_pre)
  **  ((( &( "p_spec_444" ) )) # Ptr  |-> p_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> v___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> y___tespec_entry)
.

Definition push_induction_partial_solve_wit_4 := 
forall (p_pre: Z) (front_pre: Z) (l___tespec_entry: (@list Z)) (y___tespec_entry: Z) (v___tespec_entry: Z) (a: Z) (tl: (@list Z)) (y: Z) (a_2: Z) (tl_2: (@list Z)) (y_2: Z) (a_3: Z) (tl_3: (@list Z)) (y_3: Z) (PreH1 : (y_3 <> p_pre)) (PreH2 : (y_3 <> 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (tl_2 = (cons (a_3) (tl_3)))) (PreH5 : (y_2 <> p_pre)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (tl = (cons (a_2) (tl_2)))) (PreH9 : (y <> p_pre)) (PreH10 : (y <> 0)) (PreH11 : (front_pre <> 0)) (PreH12 : (l___tespec_entry = (cons (a) (tl)))) (PreH13 : (front_pre <> p_pre)) (PreH14 : (front_pre = 8192)) (PreH15 : (p_pre = 12288)) (PreH16 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH17 : (v___tespec_entry = (-1))) (PreH18 : (y___tespec_entry = 16384)) (PreH19 : (p_pre <> 0)) (PreH20 : (front_pre <> y___tespec_entry)) (PreH21 : (y___tespec_entry <> 0)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (CNQueueAux y_3 p_pre tl_3 )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> a_3)
  **  ((( &( "p_spec_481" ) )) # Ptr  |-> p_pre)
  **  ((( &( "front_spec_480" ) )) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> a_2)
  **  ((( &( "p_spec_469" ) )) # Ptr  |-> p_pre)
  **  ((( &( "front_spec_468" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (front_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (front_pre + 0)) # Int  |-> a)
  **  ((( &( "front_spec_447" ) )) # Ptr  |-> front_pre)
  **  ((( &( "p_spec_444" ) )) # Ptr  |-> p_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> v___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> y___tespec_entry)
|--
  EX (a_4: Z)  (tl_4: (@list Z))  (y_4: Z) ,
  “ (tl_4 = (@nil Z)) ” 
  &&  “ (y_4 <> 0) ” 
  &&  “ (y_3 <> 0) ” 
  &&  “ (tl_3 = (cons (a_4) (tl_4))) ” 
  &&  “ (y_3 <> p_pre) ” 
  &&  “ (y_3 <> 0) ” 
  &&  “ (y_2 <> 0) ” 
  &&  “ (tl_2 = (cons (a_3) (tl_3))) ” 
  &&  “ (y_2 <> p_pre) ” 
  &&  “ (y_2 <> 0) ” 
  &&  “ (y <> 0) ” 
  &&  “ (tl = (cons (a_2) (tl_2))) ” 
  &&  “ (y <> p_pre) ” 
  &&  “ (y <> 0) ” 
  &&  “ (front_pre <> 0) ” 
  &&  “ (l___tespec_entry = (cons (a) (tl))) ” 
  &&  “ (front_pre <> p_pre) ” 
  &&  “ (front_pre = 8192) ” 
  &&  “ (p_pre = 12288) ” 
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ” 
  &&  “ (v___tespec_entry = (-1)) ” 
  &&  “ (y___tespec_entry = 16384) ” 
  &&  “ (p_pre <> 0) ” 
  &&  “ (front_pre <> y___tespec_entry) ” 
  &&  “ (y___tespec_entry <> 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> a_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> a_3)
  **  ((( &( "p_spec_481" ) )) # Ptr  |-> p_pre)
  **  ((( &( "front_spec_480" ) )) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> a_2)
  **  ((( &( "p_spec_469" ) )) # Ptr  |-> p_pre)
  **  ((( &( "front_spec_468" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (front_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (front_pre + 0)) # Int  |-> a)
  **  ((( &( "front_spec_447" ) )) # Ptr  |-> front_pre)
  **  ((( &( "p_spec_444" ) )) # Ptr  |-> p_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> v___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> y___tespec_entry)
.

Definition push_induction_precondition_wit_1 :=
exists (p_pre: Z) ,
exists (front_pre: Z) ,
exists (l___tespec_entry: (@list Z)) ,
exists (y___tespec_entry: Z) ,
exists (v___tespec_entry: Z) ,
~ ((  “ (front_pre = 8192) ” 
  &&  “ (p_pre = 12288) ” 
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ” 
  &&  “ (v___tespec_entry = (-1)) ” 
  &&  “ (y___tespec_entry = 16384) ” 
  &&  “ (p_pre <> 0) ” 
  &&  “ (front_pre <> y___tespec_entry) ” 
  &&  “ (y___tespec_entry <> 0) ”
  &&  (CNQueueAux front_pre p_pre l___tespec_entry )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> v___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> y___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_push_induction_safety_wit_1 : push_induction_safety_wit_1.
Axiom proof_of_push_induction_safety_wit_2 : push_induction_safety_wit_2.
Axiom proof_of_push_induction_safety_wit_3 : push_induction_safety_wit_3.
Axiom proof_of_push_induction_safety_wit_4 : push_induction_safety_wit_4.
Axiom proof_of_push_induction_safety_wit_5 : push_induction_safety_wit_5.
Axiom proof_of_push_induction_return_wit_1 : push_induction_return_wit_1.
Axiom proof_of_push_induction_partial_solve_wit_1 : push_induction_partial_solve_wit_1.
Axiom proof_of_push_induction_partial_solve_wit_2 : push_induction_partial_solve_wit_2.
Axiom proof_of_push_induction_partial_solve_wit_3 : push_induction_partial_solve_wit_3.
Axiom proof_of_push_induction_partial_solve_wit_4 : push_induction_partial_solve_wit_4.
Axiom proof_of_push_induction_precondition_wit_1 : push_induction_precondition_wit_1.

End VC_Correct.
