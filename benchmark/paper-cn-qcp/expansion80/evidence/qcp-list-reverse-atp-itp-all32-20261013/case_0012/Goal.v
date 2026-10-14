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
Require Import SimpleC.EE.QCP_demos_human.sll_layout32.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function reverse -----*)

Definition reverse_safety_wit_1 := 
  ((( &( "w_spec_421" ) )) # Ptr  |->_)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
  **  (sll32 4096 (cons (1) ((cons (100) ((cons (2147483646) ((cons (INT_MAX) ((cons ((INT_MIN)) ((cons ((-INT_MAX)) ((cons ((-100)) ((cons ((-1)) ((cons (0) ((cons (1) ((cons (100) ((cons (2147483646) ((cons (INT_MAX) ((cons ((INT_MIN)) ((cons ((-INT_MAX)) ((cons ((-100)) ((@nil Z))))))))))))))))))))))))))))))))) )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition reverse_safety_wit_2 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (y_9: Z) (y_10: Z) (y_11: Z) (y_12: Z) (y_13: Z) (y_14: Z) (y_15: Z) (y_16: Z) (PreH1 : (y_16 = 0)) (PreH2 : (y_15 <> 0)) (PreH3 : (y_14 <> 0)) (PreH4 : (y_13 <> 0)) (PreH5 : (y_12 <> 0)) (PreH6 : (y_11 <> 0)) (PreH7 : (y_10 <> 0)) (PreH8 : (y_9 <> 0)) (PreH9 : (y_8 <> 0)) (PreH10 : (y_7 <> 0)) (PreH11 : (y_6 <> 0)) (PreH12 : (y_5 <> 0)) (PreH13 : (y_4 <> 0)) (PreH14 : (y_3 <> 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (y = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y_15 + 4 )) # Ptr  |-> 0)
  **  ((y_15) # Int  |-> (-100))
  **  (((y_14 + 4 )) # Ptr  |-> y_15)
  **  ((y_14) # Int  |-> (-INT_MAX))
  **  (((y_13 + 4 )) # Ptr  |-> y_14)
  **  ((y_13) # Int  |-> (INT_MIN))
  **  (((y_12 + 4 )) # Ptr  |-> y_13)
  **  ((y_12) # Int  |-> INT_MAX)
  **  (((y_11 + 4 )) # Ptr  |-> y_12)
  **  ((y_11) # Int  |-> 2147483646)
  **  (((y_10 + 4 )) # Ptr  |-> y_11)
  **  ((y_10) # Int  |-> 100)
  **  (((y_9 + 4 )) # Ptr  |-> y_10)
  **  ((y_9) # Int  |-> 1)
  **  (((y_8 + 4 )) # Ptr  |-> y_9)
  **  ((y_8) # Int  |-> 0)
  **  (((y_7 + 4 )) # Ptr  |-> y_8)
  **  ((y_7) # Int  |-> (-1))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (-100))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (-INT_MAX))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> INT_MAX)
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> 2147483646)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 100)
  **  ((4096) # Int  |-> 1)
  **  ((( &( "v_spec_424" ) )) # Ptr  |-> y)
  **  ((( &( "w_spec_421" ) )) # Ptr  |-> 4096)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition reverse_safety_wit_3 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (y_9: Z) (y_10: Z) (y_11: Z) (y_12: Z) (y_13: Z) (y_14: Z) (y_15: Z) (y_16: Z) (PreH1 : (y_16 = 0)) (PreH2 : (y_15 <> 0)) (PreH3 : (y_14 <> 0)) (PreH4 : (y_13 <> 0)) (PreH5 : (y_12 <> 0)) (PreH6 : (y_11 <> 0)) (PreH7 : (y_10 <> 0)) (PreH8 : (y_9 <> 0)) (PreH9 : (y_8 <> 0)) (PreH10 : (y_7 <> 0)) (PreH11 : (y_6 <> 0)) (PreH12 : (y_5 <> 0)) (PreH13 : (y_4 <> 0)) (PreH14 : (y_3 <> 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_2 = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y_15 + 4 )) # Ptr  |-> 0)
  **  ((y_15) # Int  |-> (-100))
  **  (((y_14 + 4 )) # Ptr  |-> y_15)
  **  ((y_14) # Int  |-> (-INT_MAX))
  **  (((y_13 + 4 )) # Ptr  |-> y_14)
  **  ((y_13) # Int  |-> (INT_MIN))
  **  (((y_12 + 4 )) # Ptr  |-> y_13)
  **  ((y_12) # Int  |-> INT_MAX)
  **  (((y_11 + 4 )) # Ptr  |-> y_12)
  **  ((y_11) # Int  |-> 2147483646)
  **  (((y_10 + 4 )) # Ptr  |-> y_11)
  **  ((y_10) # Int  |-> 100)
  **  (((y_9 + 4 )) # Ptr  |-> y_10)
  **  ((y_9) # Int  |-> 1)
  **  (((y_8 + 4 )) # Ptr  |-> y_9)
  **  ((y_8) # Int  |-> 0)
  **  (((y_7 + 4 )) # Ptr  |-> y_8)
  **  ((y_7) # Int  |-> (-1))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (-100))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (-INT_MAX))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> INT_MAX)
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> 2147483646)
  **  (((y + 4 )) # Ptr  |-> 4096)
  **  ((y) # Int  |-> 100)
  **  ((4096) # Int  |-> 1)
  **  ((( &( "v_spec_424" ) )) # Ptr  |-> y_2)
  **  ((( &( "w_spec_421" ) )) # Ptr  |-> y)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition reverse_safety_wit_4 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (y_9: Z) (y_10: Z) (y_11: Z) (y_12: Z) (y_13: Z) (y_14: Z) (y_15: Z) (y_16: Z) (PreH1 : (y_16 = 0)) (PreH2 : (y_15 <> 0)) (PreH3 : (y_14 <> 0)) (PreH4 : (y_13 <> 0)) (PreH5 : (y_12 <> 0)) (PreH6 : (y_11 <> 0)) (PreH7 : (y_10 <> 0)) (PreH8 : (y_9 <> 0)) (PreH9 : (y_8 <> 0)) (PreH10 : (y_7 <> 0)) (PreH11 : (y_6 <> 0)) (PreH12 : (y_5 <> 0)) (PreH13 : (y_4 <> 0)) (PreH14 : (y_3 <> 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_2 <> 0)) (PreH19 : (y_3 = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y_15 + 4 )) # Ptr  |-> 0)
  **  ((y_15) # Int  |-> (-100))
  **  (((y_14 + 4 )) # Ptr  |-> y_15)
  **  ((y_14) # Int  |-> (-INT_MAX))
  **  (((y_13 + 4 )) # Ptr  |-> y_14)
  **  ((y_13) # Int  |-> (INT_MIN))
  **  (((y_12 + 4 )) # Ptr  |-> y_13)
  **  ((y_12) # Int  |-> INT_MAX)
  **  (((y_11 + 4 )) # Ptr  |-> y_12)
  **  ((y_11) # Int  |-> 2147483646)
  **  (((y_10 + 4 )) # Ptr  |-> y_11)
  **  ((y_10) # Int  |-> 100)
  **  (((y_9 + 4 )) # Ptr  |-> y_10)
  **  ((y_9) # Int  |-> 1)
  **  (((y_8 + 4 )) # Ptr  |-> y_9)
  **  ((y_8) # Int  |-> 0)
  **  (((y_7 + 4 )) # Ptr  |-> y_8)
  **  ((y_7) # Int  |-> (-1))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (-100))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (-INT_MAX))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> INT_MAX)
  **  (((y_2 + 4 )) # Ptr  |-> y)
  **  ((y_2) # Int  |-> 2147483646)
  **  (((y + 4 )) # Ptr  |-> 4096)
  **  ((y) # Int  |-> 100)
  **  ((4096) # Int  |-> 1)
  **  ((( &( "v_spec_424" ) )) # Ptr  |-> y_3)
  **  ((( &( "w_spec_421" ) )) # Ptr  |-> y_2)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition reverse_safety_wit_5 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (y_9: Z) (y_10: Z) (y_11: Z) (y_12: Z) (y_13: Z) (y_14: Z) (y_15: Z) (y_16: Z) (PreH1 : (y_16 = 0)) (PreH2 : (y_15 <> 0)) (PreH3 : (y_14 <> 0)) (PreH4 : (y_13 <> 0)) (PreH5 : (y_12 <> 0)) (PreH6 : (y_11 <> 0)) (PreH7 : (y_10 <> 0)) (PreH8 : (y_9 <> 0)) (PreH9 : (y_8 <> 0)) (PreH10 : (y_7 <> 0)) (PreH11 : (y_6 <> 0)) (PreH12 : (y_5 <> 0)) (PreH13 : (y_4 <> 0)) (PreH14 : (y_3 <> 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_2 <> 0)) (PreH19 : (y_3 <> 0)) (PreH20 : (y_4 = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y_15 + 4 )) # Ptr  |-> 0)
  **  ((y_15) # Int  |-> (-100))
  **  (((y_14 + 4 )) # Ptr  |-> y_15)
  **  ((y_14) # Int  |-> (-INT_MAX))
  **  (((y_13 + 4 )) # Ptr  |-> y_14)
  **  ((y_13) # Int  |-> (INT_MIN))
  **  (((y_12 + 4 )) # Ptr  |-> y_13)
  **  ((y_12) # Int  |-> INT_MAX)
  **  (((y_11 + 4 )) # Ptr  |-> y_12)
  **  ((y_11) # Int  |-> 2147483646)
  **  (((y_10 + 4 )) # Ptr  |-> y_11)
  **  ((y_10) # Int  |-> 100)
  **  (((y_9 + 4 )) # Ptr  |-> y_10)
  **  ((y_9) # Int  |-> 1)
  **  (((y_8 + 4 )) # Ptr  |-> y_9)
  **  ((y_8) # Int  |-> 0)
  **  (((y_7 + 4 )) # Ptr  |-> y_8)
  **  ((y_7) # Int  |-> (-1))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (-100))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (-INT_MAX))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_2)
  **  ((y_3) # Int  |-> INT_MAX)
  **  (((y_2 + 4 )) # Ptr  |-> y)
  **  ((y_2) # Int  |-> 2147483646)
  **  (((y + 4 )) # Ptr  |-> 4096)
  **  ((y) # Int  |-> 100)
  **  ((4096) # Int  |-> 1)
  **  ((( &( "v_spec_424" ) )) # Ptr  |-> y_4)
  **  ((( &( "w_spec_421" ) )) # Ptr  |-> y_3)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition reverse_safety_wit_6 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (y_9: Z) (y_10: Z) (y_11: Z) (y_12: Z) (y_13: Z) (y_14: Z) (y_15: Z) (y_16: Z) (PreH1 : (y_16 = 0)) (PreH2 : (y_15 <> 0)) (PreH3 : (y_14 <> 0)) (PreH4 : (y_13 <> 0)) (PreH5 : (y_12 <> 0)) (PreH6 : (y_11 <> 0)) (PreH7 : (y_10 <> 0)) (PreH8 : (y_9 <> 0)) (PreH9 : (y_8 <> 0)) (PreH10 : (y_7 <> 0)) (PreH11 : (y_6 <> 0)) (PreH12 : (y_5 <> 0)) (PreH13 : (y_4 <> 0)) (PreH14 : (y_3 <> 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_2 <> 0)) (PreH19 : (y_3 <> 0)) (PreH20 : (y_4 <> 0)) (PreH21 : (y_5 = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y_15 + 4 )) # Ptr  |-> 0)
  **  ((y_15) # Int  |-> (-100))
  **  (((y_14 + 4 )) # Ptr  |-> y_15)
  **  ((y_14) # Int  |-> (-INT_MAX))
  **  (((y_13 + 4 )) # Ptr  |-> y_14)
  **  ((y_13) # Int  |-> (INT_MIN))
  **  (((y_12 + 4 )) # Ptr  |-> y_13)
  **  ((y_12) # Int  |-> INT_MAX)
  **  (((y_11 + 4 )) # Ptr  |-> y_12)
  **  ((y_11) # Int  |-> 2147483646)
  **  (((y_10 + 4 )) # Ptr  |-> y_11)
  **  ((y_10) # Int  |-> 100)
  **  (((y_9 + 4 )) # Ptr  |-> y_10)
  **  ((y_9) # Int  |-> 1)
  **  (((y_8 + 4 )) # Ptr  |-> y_9)
  **  ((y_8) # Int  |-> 0)
  **  (((y_7 + 4 )) # Ptr  |-> y_8)
  **  ((y_7) # Int  |-> (-1))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (-100))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (-INT_MAX))
  **  (((y_4 + 4 )) # Ptr  |-> y_3)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_2)
  **  ((y_3) # Int  |-> INT_MAX)
  **  (((y_2 + 4 )) # Ptr  |-> y)
  **  ((y_2) # Int  |-> 2147483646)
  **  (((y + 4 )) # Ptr  |-> 4096)
  **  ((y) # Int  |-> 100)
  **  ((4096) # Int  |-> 1)
  **  ((( &( "v_spec_424" ) )) # Ptr  |-> y_5)
  **  ((( &( "w_spec_421" ) )) # Ptr  |-> y_4)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition reverse_safety_wit_7 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (y_9: Z) (y_10: Z) (y_11: Z) (y_12: Z) (y_13: Z) (y_14: Z) (y_15: Z) (y_16: Z) (PreH1 : (y_16 = 0)) (PreH2 : (y_15 <> 0)) (PreH3 : (y_14 <> 0)) (PreH4 : (y_13 <> 0)) (PreH5 : (y_12 <> 0)) (PreH6 : (y_11 <> 0)) (PreH7 : (y_10 <> 0)) (PreH8 : (y_9 <> 0)) (PreH9 : (y_8 <> 0)) (PreH10 : (y_7 <> 0)) (PreH11 : (y_6 <> 0)) (PreH12 : (y_5 <> 0)) (PreH13 : (y_4 <> 0)) (PreH14 : (y_3 <> 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_2 <> 0)) (PreH19 : (y_3 <> 0)) (PreH20 : (y_4 <> 0)) (PreH21 : (y_5 <> 0)) (PreH22 : (y_6 = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y_15 + 4 )) # Ptr  |-> 0)
  **  ((y_15) # Int  |-> (-100))
  **  (((y_14 + 4 )) # Ptr  |-> y_15)
  **  ((y_14) # Int  |-> (-INT_MAX))
  **  (((y_13 + 4 )) # Ptr  |-> y_14)
  **  ((y_13) # Int  |-> (INT_MIN))
  **  (((y_12 + 4 )) # Ptr  |-> y_13)
  **  ((y_12) # Int  |-> INT_MAX)
  **  (((y_11 + 4 )) # Ptr  |-> y_12)
  **  ((y_11) # Int  |-> 2147483646)
  **  (((y_10 + 4 )) # Ptr  |-> y_11)
  **  ((y_10) # Int  |-> 100)
  **  (((y_9 + 4 )) # Ptr  |-> y_10)
  **  ((y_9) # Int  |-> 1)
  **  (((y_8 + 4 )) # Ptr  |-> y_9)
  **  ((y_8) # Int  |-> 0)
  **  (((y_7 + 4 )) # Ptr  |-> y_8)
  **  ((y_7) # Int  |-> (-1))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (-100))
  **  (((y_5 + 4 )) # Ptr  |-> y_4)
  **  ((y_5) # Int  |-> (-INT_MAX))
  **  (((y_4 + 4 )) # Ptr  |-> y_3)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_2)
  **  ((y_3) # Int  |-> INT_MAX)
  **  (((y_2 + 4 )) # Ptr  |-> y)
  **  ((y_2) # Int  |-> 2147483646)
  **  (((y + 4 )) # Ptr  |-> 4096)
  **  ((y) # Int  |-> 100)
  **  ((4096) # Int  |-> 1)
  **  ((( &( "v_spec_424" ) )) # Ptr  |-> y_6)
  **  ((( &( "w_spec_421" ) )) # Ptr  |-> y_5)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition reverse_safety_wit_8 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (y_9: Z) (y_10: Z) (y_11: Z) (y_12: Z) (y_13: Z) (y_14: Z) (y_15: Z) (y_16: Z) (PreH1 : (y_16 = 0)) (PreH2 : (y_15 <> 0)) (PreH3 : (y_14 <> 0)) (PreH4 : (y_13 <> 0)) (PreH5 : (y_12 <> 0)) (PreH6 : (y_11 <> 0)) (PreH7 : (y_10 <> 0)) (PreH8 : (y_9 <> 0)) (PreH9 : (y_8 <> 0)) (PreH10 : (y_7 <> 0)) (PreH11 : (y_6 <> 0)) (PreH12 : (y_5 <> 0)) (PreH13 : (y_4 <> 0)) (PreH14 : (y_3 <> 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_2 <> 0)) (PreH19 : (y_3 <> 0)) (PreH20 : (y_4 <> 0)) (PreH21 : (y_5 <> 0)) (PreH22 : (y_6 <> 0)) (PreH23 : (y_7 = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y_15 + 4 )) # Ptr  |-> 0)
  **  ((y_15) # Int  |-> (-100))
  **  (((y_14 + 4 )) # Ptr  |-> y_15)
  **  ((y_14) # Int  |-> (-INT_MAX))
  **  (((y_13 + 4 )) # Ptr  |-> y_14)
  **  ((y_13) # Int  |-> (INT_MIN))
  **  (((y_12 + 4 )) # Ptr  |-> y_13)
  **  ((y_12) # Int  |-> INT_MAX)
  **  (((y_11 + 4 )) # Ptr  |-> y_12)
  **  ((y_11) # Int  |-> 2147483646)
  **  (((y_10 + 4 )) # Ptr  |-> y_11)
  **  ((y_10) # Int  |-> 100)
  **  (((y_9 + 4 )) # Ptr  |-> y_10)
  **  ((y_9) # Int  |-> 1)
  **  (((y_8 + 4 )) # Ptr  |-> y_9)
  **  ((y_8) # Int  |-> 0)
  **  (((y_7 + 4 )) # Ptr  |-> y_8)
  **  ((y_7) # Int  |-> (-1))
  **  (((y_6 + 4 )) # Ptr  |-> y_5)
  **  ((y_6) # Int  |-> (-100))
  **  (((y_5 + 4 )) # Ptr  |-> y_4)
  **  ((y_5) # Int  |-> (-INT_MAX))
  **  (((y_4 + 4 )) # Ptr  |-> y_3)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_2)
  **  ((y_3) # Int  |-> INT_MAX)
  **  (((y_2 + 4 )) # Ptr  |-> y)
  **  ((y_2) # Int  |-> 2147483646)
  **  (((y + 4 )) # Ptr  |-> 4096)
  **  ((y) # Int  |-> 100)
  **  ((4096) # Int  |-> 1)
  **  ((( &( "v_spec_424" ) )) # Ptr  |-> y_7)
  **  ((( &( "w_spec_421" ) )) # Ptr  |-> y_6)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition reverse_safety_wit_9 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (y_9: Z) (y_10: Z) (y_11: Z) (y_12: Z) (y_13: Z) (y_14: Z) (y_15: Z) (y_16: Z) (PreH1 : (y_16 = 0)) (PreH2 : (y_15 <> 0)) (PreH3 : (y_14 <> 0)) (PreH4 : (y_13 <> 0)) (PreH5 : (y_12 <> 0)) (PreH6 : (y_11 <> 0)) (PreH7 : (y_10 <> 0)) (PreH8 : (y_9 <> 0)) (PreH9 : (y_8 <> 0)) (PreH10 : (y_7 <> 0)) (PreH11 : (y_6 <> 0)) (PreH12 : (y_5 <> 0)) (PreH13 : (y_4 <> 0)) (PreH14 : (y_3 <> 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_2 <> 0)) (PreH19 : (y_3 <> 0)) (PreH20 : (y_4 <> 0)) (PreH21 : (y_5 <> 0)) (PreH22 : (y_6 <> 0)) (PreH23 : (y_7 <> 0)) (PreH24 : (y_8 = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y_15 + 4 )) # Ptr  |-> 0)
  **  ((y_15) # Int  |-> (-100))
  **  (((y_14 + 4 )) # Ptr  |-> y_15)
  **  ((y_14) # Int  |-> (-INT_MAX))
  **  (((y_13 + 4 )) # Ptr  |-> y_14)
  **  ((y_13) # Int  |-> (INT_MIN))
  **  (((y_12 + 4 )) # Ptr  |-> y_13)
  **  ((y_12) # Int  |-> INT_MAX)
  **  (((y_11 + 4 )) # Ptr  |-> y_12)
  **  ((y_11) # Int  |-> 2147483646)
  **  (((y_10 + 4 )) # Ptr  |-> y_11)
  **  ((y_10) # Int  |-> 100)
  **  (((y_9 + 4 )) # Ptr  |-> y_10)
  **  ((y_9) # Int  |-> 1)
  **  (((y_8 + 4 )) # Ptr  |-> y_9)
  **  ((y_8) # Int  |-> 0)
  **  (((y_7 + 4 )) # Ptr  |-> y_6)
  **  ((y_7) # Int  |-> (-1))
  **  (((y_6 + 4 )) # Ptr  |-> y_5)
  **  ((y_6) # Int  |-> (-100))
  **  (((y_5 + 4 )) # Ptr  |-> y_4)
  **  ((y_5) # Int  |-> (-INT_MAX))
  **  (((y_4 + 4 )) # Ptr  |-> y_3)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_2)
  **  ((y_3) # Int  |-> INT_MAX)
  **  (((y_2 + 4 )) # Ptr  |-> y)
  **  ((y_2) # Int  |-> 2147483646)
  **  (((y + 4 )) # Ptr  |-> 4096)
  **  ((y) # Int  |-> 100)
  **  ((4096) # Int  |-> 1)
  **  ((( &( "v_spec_424" ) )) # Ptr  |-> y_8)
  **  ((( &( "w_spec_421" ) )) # Ptr  |-> y_7)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition reverse_safety_wit_10 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (y_9: Z) (y_10: Z) (y_11: Z) (y_12: Z) (y_13: Z) (y_14: Z) (y_15: Z) (y_16: Z) (PreH1 : (y_16 = 0)) (PreH2 : (y_15 <> 0)) (PreH3 : (y_14 <> 0)) (PreH4 : (y_13 <> 0)) (PreH5 : (y_12 <> 0)) (PreH6 : (y_11 <> 0)) (PreH7 : (y_10 <> 0)) (PreH8 : (y_9 <> 0)) (PreH9 : (y_8 <> 0)) (PreH10 : (y_7 <> 0)) (PreH11 : (y_6 <> 0)) (PreH12 : (y_5 <> 0)) (PreH13 : (y_4 <> 0)) (PreH14 : (y_3 <> 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_2 <> 0)) (PreH19 : (y_3 <> 0)) (PreH20 : (y_4 <> 0)) (PreH21 : (y_5 <> 0)) (PreH22 : (y_6 <> 0)) (PreH23 : (y_7 <> 0)) (PreH24 : (y_8 <> 0)) (PreH25 : (y_9 = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y_15 + 4 )) # Ptr  |-> 0)
  **  ((y_15) # Int  |-> (-100))
  **  (((y_14 + 4 )) # Ptr  |-> y_15)
  **  ((y_14) # Int  |-> (-INT_MAX))
  **  (((y_13 + 4 )) # Ptr  |-> y_14)
  **  ((y_13) # Int  |-> (INT_MIN))
  **  (((y_12 + 4 )) # Ptr  |-> y_13)
  **  ((y_12) # Int  |-> INT_MAX)
  **  (((y_11 + 4 )) # Ptr  |-> y_12)
  **  ((y_11) # Int  |-> 2147483646)
  **  (((y_10 + 4 )) # Ptr  |-> y_11)
  **  ((y_10) # Int  |-> 100)
  **  (((y_9 + 4 )) # Ptr  |-> y_10)
  **  ((y_9) # Int  |-> 1)
  **  (((y_8 + 4 )) # Ptr  |-> y_7)
  **  ((y_8) # Int  |-> 0)
  **  (((y_7 + 4 )) # Ptr  |-> y_6)
  **  ((y_7) # Int  |-> (-1))
  **  (((y_6 + 4 )) # Ptr  |-> y_5)
  **  ((y_6) # Int  |-> (-100))
  **  (((y_5 + 4 )) # Ptr  |-> y_4)
  **  ((y_5) # Int  |-> (-INT_MAX))
  **  (((y_4 + 4 )) # Ptr  |-> y_3)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_2)
  **  ((y_3) # Int  |-> INT_MAX)
  **  (((y_2 + 4 )) # Ptr  |-> y)
  **  ((y_2) # Int  |-> 2147483646)
  **  (((y + 4 )) # Ptr  |-> 4096)
  **  ((y) # Int  |-> 100)
  **  ((4096) # Int  |-> 1)
  **  ((( &( "v_spec_424" ) )) # Ptr  |-> y_9)
  **  ((( &( "w_spec_421" ) )) # Ptr  |-> y_8)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition reverse_safety_wit_11 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (y_9: Z) (y_10: Z) (y_11: Z) (y_12: Z) (y_13: Z) (y_14: Z) (y_15: Z) (y_16: Z) (PreH1 : (y_16 = 0)) (PreH2 : (y_15 <> 0)) (PreH3 : (y_14 <> 0)) (PreH4 : (y_13 <> 0)) (PreH5 : (y_12 <> 0)) (PreH6 : (y_11 <> 0)) (PreH7 : (y_10 <> 0)) (PreH8 : (y_9 <> 0)) (PreH9 : (y_8 <> 0)) (PreH10 : (y_7 <> 0)) (PreH11 : (y_6 <> 0)) (PreH12 : (y_5 <> 0)) (PreH13 : (y_4 <> 0)) (PreH14 : (y_3 <> 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_2 <> 0)) (PreH19 : (y_3 <> 0)) (PreH20 : (y_4 <> 0)) (PreH21 : (y_5 <> 0)) (PreH22 : (y_6 <> 0)) (PreH23 : (y_7 <> 0)) (PreH24 : (y_8 <> 0)) (PreH25 : (y_9 <> 0)) (PreH26 : (y_10 = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y_15 + 4 )) # Ptr  |-> 0)
  **  ((y_15) # Int  |-> (-100))
  **  (((y_14 + 4 )) # Ptr  |-> y_15)
  **  ((y_14) # Int  |-> (-INT_MAX))
  **  (((y_13 + 4 )) # Ptr  |-> y_14)
  **  ((y_13) # Int  |-> (INT_MIN))
  **  (((y_12 + 4 )) # Ptr  |-> y_13)
  **  ((y_12) # Int  |-> INT_MAX)
  **  (((y_11 + 4 )) # Ptr  |-> y_12)
  **  ((y_11) # Int  |-> 2147483646)
  **  (((y_10 + 4 )) # Ptr  |-> y_11)
  **  ((y_10) # Int  |-> 100)
  **  (((y_9 + 4 )) # Ptr  |-> y_8)
  **  ((y_9) # Int  |-> 1)
  **  (((y_8 + 4 )) # Ptr  |-> y_7)
  **  ((y_8) # Int  |-> 0)
  **  (((y_7 + 4 )) # Ptr  |-> y_6)
  **  ((y_7) # Int  |-> (-1))
  **  (((y_6 + 4 )) # Ptr  |-> y_5)
  **  ((y_6) # Int  |-> (-100))
  **  (((y_5 + 4 )) # Ptr  |-> y_4)
  **  ((y_5) # Int  |-> (-INT_MAX))
  **  (((y_4 + 4 )) # Ptr  |-> y_3)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_2)
  **  ((y_3) # Int  |-> INT_MAX)
  **  (((y_2 + 4 )) # Ptr  |-> y)
  **  ((y_2) # Int  |-> 2147483646)
  **  (((y + 4 )) # Ptr  |-> 4096)
  **  ((y) # Int  |-> 100)
  **  ((4096) # Int  |-> 1)
  **  ((( &( "v_spec_424" ) )) # Ptr  |-> y_10)
  **  ((( &( "w_spec_421" ) )) # Ptr  |-> y_9)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition reverse_safety_wit_12 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (y_9: Z) (y_10: Z) (y_11: Z) (y_12: Z) (y_13: Z) (y_14: Z) (y_15: Z) (y_16: Z) (PreH1 : (y_16 = 0)) (PreH2 : (y_15 <> 0)) (PreH3 : (y_14 <> 0)) (PreH4 : (y_13 <> 0)) (PreH5 : (y_12 <> 0)) (PreH6 : (y_11 <> 0)) (PreH7 : (y_10 <> 0)) (PreH8 : (y_9 <> 0)) (PreH9 : (y_8 <> 0)) (PreH10 : (y_7 <> 0)) (PreH11 : (y_6 <> 0)) (PreH12 : (y_5 <> 0)) (PreH13 : (y_4 <> 0)) (PreH14 : (y_3 <> 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_2 <> 0)) (PreH19 : (y_3 <> 0)) (PreH20 : (y_4 <> 0)) (PreH21 : (y_5 <> 0)) (PreH22 : (y_6 <> 0)) (PreH23 : (y_7 <> 0)) (PreH24 : (y_8 <> 0)) (PreH25 : (y_9 <> 0)) (PreH26 : (y_10 <> 0)) (PreH27 : (y_11 = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y_15 + 4 )) # Ptr  |-> 0)
  **  ((y_15) # Int  |-> (-100))
  **  (((y_14 + 4 )) # Ptr  |-> y_15)
  **  ((y_14) # Int  |-> (-INT_MAX))
  **  (((y_13 + 4 )) # Ptr  |-> y_14)
  **  ((y_13) # Int  |-> (INT_MIN))
  **  (((y_12 + 4 )) # Ptr  |-> y_13)
  **  ((y_12) # Int  |-> INT_MAX)
  **  (((y_11 + 4 )) # Ptr  |-> y_12)
  **  ((y_11) # Int  |-> 2147483646)
  **  (((y_10 + 4 )) # Ptr  |-> y_9)
  **  ((y_10) # Int  |-> 100)
  **  (((y_9 + 4 )) # Ptr  |-> y_8)
  **  ((y_9) # Int  |-> 1)
  **  (((y_8 + 4 )) # Ptr  |-> y_7)
  **  ((y_8) # Int  |-> 0)
  **  (((y_7 + 4 )) # Ptr  |-> y_6)
  **  ((y_7) # Int  |-> (-1))
  **  (((y_6 + 4 )) # Ptr  |-> y_5)
  **  ((y_6) # Int  |-> (-100))
  **  (((y_5 + 4 )) # Ptr  |-> y_4)
  **  ((y_5) # Int  |-> (-INT_MAX))
  **  (((y_4 + 4 )) # Ptr  |-> y_3)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_2)
  **  ((y_3) # Int  |-> INT_MAX)
  **  (((y_2 + 4 )) # Ptr  |-> y)
  **  ((y_2) # Int  |-> 2147483646)
  **  (((y + 4 )) # Ptr  |-> 4096)
  **  ((y) # Int  |-> 100)
  **  ((4096) # Int  |-> 1)
  **  ((( &( "v_spec_424" ) )) # Ptr  |-> y_11)
  **  ((( &( "w_spec_421" ) )) # Ptr  |-> y_10)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition reverse_safety_wit_13 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (y_9: Z) (y_10: Z) (y_11: Z) (y_12: Z) (y_13: Z) (y_14: Z) (y_15: Z) (y_16: Z) (PreH1 : (y_16 = 0)) (PreH2 : (y_15 <> 0)) (PreH3 : (y_14 <> 0)) (PreH4 : (y_13 <> 0)) (PreH5 : (y_12 <> 0)) (PreH6 : (y_11 <> 0)) (PreH7 : (y_10 <> 0)) (PreH8 : (y_9 <> 0)) (PreH9 : (y_8 <> 0)) (PreH10 : (y_7 <> 0)) (PreH11 : (y_6 <> 0)) (PreH12 : (y_5 <> 0)) (PreH13 : (y_4 <> 0)) (PreH14 : (y_3 <> 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_2 <> 0)) (PreH19 : (y_3 <> 0)) (PreH20 : (y_4 <> 0)) (PreH21 : (y_5 <> 0)) (PreH22 : (y_6 <> 0)) (PreH23 : (y_7 <> 0)) (PreH24 : (y_8 <> 0)) (PreH25 : (y_9 <> 0)) (PreH26 : (y_10 <> 0)) (PreH27 : (y_11 <> 0)) (PreH28 : (y_12 = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y_15 + 4 )) # Ptr  |-> 0)
  **  ((y_15) # Int  |-> (-100))
  **  (((y_14 + 4 )) # Ptr  |-> y_15)
  **  ((y_14) # Int  |-> (-INT_MAX))
  **  (((y_13 + 4 )) # Ptr  |-> y_14)
  **  ((y_13) # Int  |-> (INT_MIN))
  **  (((y_12 + 4 )) # Ptr  |-> y_13)
  **  ((y_12) # Int  |-> INT_MAX)
  **  (((y_11 + 4 )) # Ptr  |-> y_10)
  **  ((y_11) # Int  |-> 2147483646)
  **  (((y_10 + 4 )) # Ptr  |-> y_9)
  **  ((y_10) # Int  |-> 100)
  **  (((y_9 + 4 )) # Ptr  |-> y_8)
  **  ((y_9) # Int  |-> 1)
  **  (((y_8 + 4 )) # Ptr  |-> y_7)
  **  ((y_8) # Int  |-> 0)
  **  (((y_7 + 4 )) # Ptr  |-> y_6)
  **  ((y_7) # Int  |-> (-1))
  **  (((y_6 + 4 )) # Ptr  |-> y_5)
  **  ((y_6) # Int  |-> (-100))
  **  (((y_5 + 4 )) # Ptr  |-> y_4)
  **  ((y_5) # Int  |-> (-INT_MAX))
  **  (((y_4 + 4 )) # Ptr  |-> y_3)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_2)
  **  ((y_3) # Int  |-> INT_MAX)
  **  (((y_2 + 4 )) # Ptr  |-> y)
  **  ((y_2) # Int  |-> 2147483646)
  **  (((y + 4 )) # Ptr  |-> 4096)
  **  ((y) # Int  |-> 100)
  **  ((4096) # Int  |-> 1)
  **  ((( &( "v_spec_424" ) )) # Ptr  |-> y_12)
  **  ((( &( "w_spec_421" ) )) # Ptr  |-> y_11)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition reverse_safety_wit_14 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (y_9: Z) (y_10: Z) (y_11: Z) (y_12: Z) (y_13: Z) (y_14: Z) (y_15: Z) (y_16: Z) (PreH1 : (y_16 = 0)) (PreH2 : (y_15 <> 0)) (PreH3 : (y_14 <> 0)) (PreH4 : (y_13 <> 0)) (PreH5 : (y_12 <> 0)) (PreH6 : (y_11 <> 0)) (PreH7 : (y_10 <> 0)) (PreH8 : (y_9 <> 0)) (PreH9 : (y_8 <> 0)) (PreH10 : (y_7 <> 0)) (PreH11 : (y_6 <> 0)) (PreH12 : (y_5 <> 0)) (PreH13 : (y_4 <> 0)) (PreH14 : (y_3 <> 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_2 <> 0)) (PreH19 : (y_3 <> 0)) (PreH20 : (y_4 <> 0)) (PreH21 : (y_5 <> 0)) (PreH22 : (y_6 <> 0)) (PreH23 : (y_7 <> 0)) (PreH24 : (y_8 <> 0)) (PreH25 : (y_9 <> 0)) (PreH26 : (y_10 <> 0)) (PreH27 : (y_11 <> 0)) (PreH28 : (y_12 <> 0)) (PreH29 : (y_13 = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y_15 + 4 )) # Ptr  |-> 0)
  **  ((y_15) # Int  |-> (-100))
  **  (((y_14 + 4 )) # Ptr  |-> y_15)
  **  ((y_14) # Int  |-> (-INT_MAX))
  **  (((y_13 + 4 )) # Ptr  |-> y_14)
  **  ((y_13) # Int  |-> (INT_MIN))
  **  (((y_12 + 4 )) # Ptr  |-> y_11)
  **  ((y_12) # Int  |-> INT_MAX)
  **  (((y_11 + 4 )) # Ptr  |-> y_10)
  **  ((y_11) # Int  |-> 2147483646)
  **  (((y_10 + 4 )) # Ptr  |-> y_9)
  **  ((y_10) # Int  |-> 100)
  **  (((y_9 + 4 )) # Ptr  |-> y_8)
  **  ((y_9) # Int  |-> 1)
  **  (((y_8 + 4 )) # Ptr  |-> y_7)
  **  ((y_8) # Int  |-> 0)
  **  (((y_7 + 4 )) # Ptr  |-> y_6)
  **  ((y_7) # Int  |-> (-1))
  **  (((y_6 + 4 )) # Ptr  |-> y_5)
  **  ((y_6) # Int  |-> (-100))
  **  (((y_5 + 4 )) # Ptr  |-> y_4)
  **  ((y_5) # Int  |-> (-INT_MAX))
  **  (((y_4 + 4 )) # Ptr  |-> y_3)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_2)
  **  ((y_3) # Int  |-> INT_MAX)
  **  (((y_2 + 4 )) # Ptr  |-> y)
  **  ((y_2) # Int  |-> 2147483646)
  **  (((y + 4 )) # Ptr  |-> 4096)
  **  ((y) # Int  |-> 100)
  **  ((4096) # Int  |-> 1)
  **  ((( &( "v_spec_424" ) )) # Ptr  |-> y_13)
  **  ((( &( "w_spec_421" ) )) # Ptr  |-> y_12)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition reverse_safety_wit_15 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (y_9: Z) (y_10: Z) (y_11: Z) (y_12: Z) (y_13: Z) (y_14: Z) (y_15: Z) (y_16: Z) (PreH1 : (y_16 = 0)) (PreH2 : (y_15 <> 0)) (PreH3 : (y_14 <> 0)) (PreH4 : (y_13 <> 0)) (PreH5 : (y_12 <> 0)) (PreH6 : (y_11 <> 0)) (PreH7 : (y_10 <> 0)) (PreH8 : (y_9 <> 0)) (PreH9 : (y_8 <> 0)) (PreH10 : (y_7 <> 0)) (PreH11 : (y_6 <> 0)) (PreH12 : (y_5 <> 0)) (PreH13 : (y_4 <> 0)) (PreH14 : (y_3 <> 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_2 <> 0)) (PreH19 : (y_3 <> 0)) (PreH20 : (y_4 <> 0)) (PreH21 : (y_5 <> 0)) (PreH22 : (y_6 <> 0)) (PreH23 : (y_7 <> 0)) (PreH24 : (y_8 <> 0)) (PreH25 : (y_9 <> 0)) (PreH26 : (y_10 <> 0)) (PreH27 : (y_11 <> 0)) (PreH28 : (y_12 <> 0)) (PreH29 : (y_13 <> 0)) (PreH30 : (y_14 = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y_15 + 4 )) # Ptr  |-> 0)
  **  ((y_15) # Int  |-> (-100))
  **  (((y_14 + 4 )) # Ptr  |-> y_15)
  **  ((y_14) # Int  |-> (-INT_MAX))
  **  (((y_13 + 4 )) # Ptr  |-> y_12)
  **  ((y_13) # Int  |-> (INT_MIN))
  **  (((y_12 + 4 )) # Ptr  |-> y_11)
  **  ((y_12) # Int  |-> INT_MAX)
  **  (((y_11 + 4 )) # Ptr  |-> y_10)
  **  ((y_11) # Int  |-> 2147483646)
  **  (((y_10 + 4 )) # Ptr  |-> y_9)
  **  ((y_10) # Int  |-> 100)
  **  (((y_9 + 4 )) # Ptr  |-> y_8)
  **  ((y_9) # Int  |-> 1)
  **  (((y_8 + 4 )) # Ptr  |-> y_7)
  **  ((y_8) # Int  |-> 0)
  **  (((y_7 + 4 )) # Ptr  |-> y_6)
  **  ((y_7) # Int  |-> (-1))
  **  (((y_6 + 4 )) # Ptr  |-> y_5)
  **  ((y_6) # Int  |-> (-100))
  **  (((y_5 + 4 )) # Ptr  |-> y_4)
  **  ((y_5) # Int  |-> (-INT_MAX))
  **  (((y_4 + 4 )) # Ptr  |-> y_3)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_2)
  **  ((y_3) # Int  |-> INT_MAX)
  **  (((y_2 + 4 )) # Ptr  |-> y)
  **  ((y_2) # Int  |-> 2147483646)
  **  (((y + 4 )) # Ptr  |-> 4096)
  **  ((y) # Int  |-> 100)
  **  ((4096) # Int  |-> 1)
  **  ((( &( "v_spec_424" ) )) # Ptr  |-> y_14)
  **  ((( &( "w_spec_421" ) )) # Ptr  |-> y_13)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition reverse_safety_wit_16 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (y_9: Z) (y_10: Z) (y_11: Z) (y_12: Z) (y_13: Z) (y_14: Z) (y_15: Z) (y_16: Z) (PreH1 : (y_16 = 0)) (PreH2 : (y_15 <> 0)) (PreH3 : (y_14 <> 0)) (PreH4 : (y_13 <> 0)) (PreH5 : (y_12 <> 0)) (PreH6 : (y_11 <> 0)) (PreH7 : (y_10 <> 0)) (PreH8 : (y_9 <> 0)) (PreH9 : (y_8 <> 0)) (PreH10 : (y_7 <> 0)) (PreH11 : (y_6 <> 0)) (PreH12 : (y_5 <> 0)) (PreH13 : (y_4 <> 0)) (PreH14 : (y_3 <> 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_2 <> 0)) (PreH19 : (y_3 <> 0)) (PreH20 : (y_4 <> 0)) (PreH21 : (y_5 <> 0)) (PreH22 : (y_6 <> 0)) (PreH23 : (y_7 <> 0)) (PreH24 : (y_8 <> 0)) (PreH25 : (y_9 <> 0)) (PreH26 : (y_10 <> 0)) (PreH27 : (y_11 <> 0)) (PreH28 : (y_12 <> 0)) (PreH29 : (y_13 <> 0)) (PreH30 : (y_14 <> 0)) (PreH31 : (y_15 = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y_15 + 4 )) # Ptr  |-> 0)
  **  ((y_15) # Int  |-> (-100))
  **  (((y_14 + 4 )) # Ptr  |-> y_13)
  **  ((y_14) # Int  |-> (-INT_MAX))
  **  (((y_13 + 4 )) # Ptr  |-> y_12)
  **  ((y_13) # Int  |-> (INT_MIN))
  **  (((y_12 + 4 )) # Ptr  |-> y_11)
  **  ((y_12) # Int  |-> INT_MAX)
  **  (((y_11 + 4 )) # Ptr  |-> y_10)
  **  ((y_11) # Int  |-> 2147483646)
  **  (((y_10 + 4 )) # Ptr  |-> y_9)
  **  ((y_10) # Int  |-> 100)
  **  (((y_9 + 4 )) # Ptr  |-> y_8)
  **  ((y_9) # Int  |-> 1)
  **  (((y_8 + 4 )) # Ptr  |-> y_7)
  **  ((y_8) # Int  |-> 0)
  **  (((y_7 + 4 )) # Ptr  |-> y_6)
  **  ((y_7) # Int  |-> (-1))
  **  (((y_6 + 4 )) # Ptr  |-> y_5)
  **  ((y_6) # Int  |-> (-100))
  **  (((y_5 + 4 )) # Ptr  |-> y_4)
  **  ((y_5) # Int  |-> (-INT_MAX))
  **  (((y_4 + 4 )) # Ptr  |-> y_3)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_2)
  **  ((y_3) # Int  |-> INT_MAX)
  **  (((y_2 + 4 )) # Ptr  |-> y)
  **  ((y_2) # Int  |-> 2147483646)
  **  (((y + 4 )) # Ptr  |-> 4096)
  **  ((y) # Int  |-> 100)
  **  ((4096) # Int  |-> 1)
  **  ((( &( "v_spec_424" ) )) # Ptr  |-> y_15)
  **  ((( &( "w_spec_421" ) )) # Ptr  |-> y_14)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition reverse_return_wit_1 := 
forall (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (y_9: Z) (y_10: Z) (y_11: Z) (y_12: Z) (y_13: Z) (y_14: Z) (y_15: Z) (y: Z) (y_16: Z) (PreH1 : (y_16 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_15 <> 0)) (PreH4 : (y_14 <> 0)) (PreH5 : (y_13 <> 0)) (PreH6 : (y_12 <> 0)) (PreH7 : (y_11 <> 0)) (PreH8 : (y_10 <> 0)) (PreH9 : (y_9 <> 0)) (PreH10 : (y_8 <> 0)) (PreH11 : (y_7 <> 0)) (PreH12 : (y_6 <> 0)) (PreH13 : (y_5 <> 0)) (PreH14 : (y_4 <> 0)) (PreH15 : (y_3 <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y_2 <> 0)) (PreH18 : (y_3 <> 0)) (PreH19 : (y_4 <> 0)) (PreH20 : (y_5 <> 0)) (PreH21 : (y_6 <> 0)) (PreH22 : (y_7 <> 0)) (PreH23 : (y_8 <> 0)) (PreH24 : (y_9 <> 0)) (PreH25 : (y_10 <> 0)) (PreH26 : (y_11 <> 0)) (PreH27 : (y_12 <> 0)) (PreH28 : (y_13 <> 0)) (PreH29 : (y_14 <> 0)) (PreH30 : (y_15 <> 0)) (PreH31 : (y <> 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y + 4 )) # Ptr  |-> y_15)
  **  ((y) # Int  |-> (-100))
  **  (((y_15 + 4 )) # Ptr  |-> y_14)
  **  ((y_15) # Int  |-> (-INT_MAX))
  **  (((y_14 + 4 )) # Ptr  |-> y_13)
  **  ((y_14) # Int  |-> (INT_MIN))
  **  (((y_13 + 4 )) # Ptr  |-> y_12)
  **  ((y_13) # Int  |-> INT_MAX)
  **  (((y_12 + 4 )) # Ptr  |-> y_11)
  **  ((y_12) # Int  |-> 2147483646)
  **  (((y_11 + 4 )) # Ptr  |-> y_10)
  **  ((y_11) # Int  |-> 100)
  **  (((y_10 + 4 )) # Ptr  |-> y_9)
  **  ((y_10) # Int  |-> 1)
  **  (((y_9 + 4 )) # Ptr  |-> y_8)
  **  ((y_9) # Int  |-> 0)
  **  (((y_8 + 4 )) # Ptr  |-> y_7)
  **  ((y_8) # Int  |-> (-1))
  **  (((y_7 + 4 )) # Ptr  |-> y_6)
  **  ((y_7) # Int  |-> (-100))
  **  (((y_6 + 4 )) # Ptr  |-> y_5)
  **  ((y_6) # Int  |-> (-INT_MAX))
  **  (((y_5 + 4 )) # Ptr  |-> y_4)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_3)
  **  ((y_4) # Int  |-> INT_MAX)
  **  (((y_3 + 4 )) # Ptr  |-> y_2)
  **  ((y_3) # Int  |-> 2147483646)
  **  (((y_2 + 4 )) # Ptr  |-> 4096)
  **  ((y_2) # Int  |-> 100)
  **  ((4096) # Int  |-> 1)
|--
  (sll32 y (cons ((-100)) ((cons ((-INT_MAX)) ((cons ((INT_MIN)) ((cons (INT_MAX) ((cons (2147483646) ((cons (100) ((cons (1) ((cons (0) ((cons ((-1)) ((cons ((-100)) ((cons ((-INT_MAX)) ((cons ((INT_MIN)) ((cons (INT_MAX) ((cons (2147483646) ((cons (100) ((cons (1) ((@nil Z))))))))))))))))))))))))))))))))) )
.

Definition reverse_partial_solve_wit_1 := 
  (sll32 4096 (cons (1) ((cons (100) ((cons (2147483646) ((cons (INT_MAX) ((cons ((INT_MIN)) ((cons ((-INT_MAX)) ((cons ((-100)) ((cons ((-1)) ((cons (0) ((cons (1) ((cons (100) ((cons (2147483646) ((cons (INT_MAX) ((cons ((INT_MIN)) ((cons ((-INT_MAX)) ((cons ((-100)) ((@nil Z))))))))))))))))))))))))))))))))) )
|--
  EX (y: Z)  (y_2: Z)  (y_3: Z)  (y_4: Z)  (y_5: Z)  (y_6: Z)  (y_7: Z)  (y_8: Z)  (y_9: Z)  (y_10: Z)  (y_11: Z)  (y_12: Z)  (y_13: Z)  (y_14: Z)  (y_15: Z)  (y_16: Z) ,
  “ (y_16 = 0) ” 
  &&  “ (y_15 <> 0) ” 
  &&  “ (y_14 <> 0) ” 
  &&  “ (y_13 <> 0) ” 
  &&  “ (y_12 <> 0) ” 
  &&  “ (y_11 <> 0) ” 
  &&  “ (y_10 <> 0) ” 
  &&  “ (y_9 <> 0) ” 
  &&  “ (y_8 <> 0) ” 
  &&  “ (y_7 <> 0) ” 
  &&  “ (y_6 <> 0) ” 
  &&  “ (y_5 <> 0) ” 
  &&  “ (y_4 <> 0) ” 
  &&  “ (y_3 <> 0) ” 
  &&  “ (y_2 <> 0) ” 
  &&  “ (y <> 0) ” 
  &&  “ (4096 <> 0) ”
  &&  ((4100) # Ptr  |-> y)
  **  (((y_15 + 4 )) # Ptr  |-> y_16)
  **  ((y_15) # Int  |-> (-100))
  **  (((y_14 + 4 )) # Ptr  |-> y_15)
  **  ((y_14) # Int  |-> (-INT_MAX))
  **  (((y_13 + 4 )) # Ptr  |-> y_14)
  **  ((y_13) # Int  |-> (INT_MIN))
  **  (((y_12 + 4 )) # Ptr  |-> y_13)
  **  ((y_12) # Int  |-> INT_MAX)
  **  (((y_11 + 4 )) # Ptr  |-> y_12)
  **  ((y_11) # Int  |-> 2147483646)
  **  (((y_10 + 4 )) # Ptr  |-> y_11)
  **  ((y_10) # Int  |-> 100)
  **  (((y_9 + 4 )) # Ptr  |-> y_10)
  **  ((y_9) # Int  |-> 1)
  **  (((y_8 + 4 )) # Ptr  |-> y_9)
  **  ((y_8) # Int  |-> 0)
  **  (((y_7 + 4 )) # Ptr  |-> y_8)
  **  ((y_7) # Int  |-> (-1))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (-100))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (-INT_MAX))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> INT_MAX)
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> 2147483646)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 100)
  **  ((4096) # Int  |-> 1)
.

Definition reverse_precondition_wit_1 :=
~ ((  “ (4096 = 4096) ” 
  &&  “ ((cons (1) ((cons (100) ((cons (2147483646) ((cons (INT_MAX) ((cons ((INT_MIN)) ((cons ((-INT_MAX)) ((cons ((-100)) ((cons ((-1)) ((cons (0) ((cons (1) ((cons (100) ((cons (2147483646) ((cons (INT_MAX) ((cons ((INT_MIN)) ((cons ((-INT_MAX)) ((cons ((-100)) ((@nil Z))))))))))))))))))))))))))))))))) = (cons (1) ((cons (100) ((cons (2147483646) ((cons (INT_MAX) ((cons ((INT_MIN)) ((cons ((-INT_MAX)) ((cons ((-100)) ((cons ((-1)) ((cons (0) ((cons (1) ((cons (100) ((cons (2147483646) ((cons (INT_MAX) ((cons ((INT_MIN)) ((cons ((-INT_MAX)) ((cons ((-100)) ((@nil Z)))))))))))))))))))))))))))))))))) ”
  &&  (sll32 4096 (cons (1) ((cons (100) ((cons (2147483646) ((cons (INT_MAX) ((cons ((INT_MIN)) ((cons ((-INT_MAX)) ((cons ((-100)) ((cons ((-1)) ((cons (0) ((cons (1) ((cons (100) ((cons (2147483646) ((cons (INT_MAX) ((cons ((INT_MIN)) ((cons ((-INT_MAX)) ((cons ((-100)) ((@nil Z))))))))))))))))))))))))))))))))) )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_reverse_safety_wit_1 : reverse_safety_wit_1.
Axiom proof_of_reverse_safety_wit_2 : reverse_safety_wit_2.
Axiom proof_of_reverse_safety_wit_3 : reverse_safety_wit_3.
Axiom proof_of_reverse_safety_wit_4 : reverse_safety_wit_4.
Axiom proof_of_reverse_safety_wit_5 : reverse_safety_wit_5.
Axiom proof_of_reverse_safety_wit_6 : reverse_safety_wit_6.
Axiom proof_of_reverse_safety_wit_7 : reverse_safety_wit_7.
Axiom proof_of_reverse_safety_wit_8 : reverse_safety_wit_8.
Axiom proof_of_reverse_safety_wit_9 : reverse_safety_wit_9.
Axiom proof_of_reverse_safety_wit_10 : reverse_safety_wit_10.
Axiom proof_of_reverse_safety_wit_11 : reverse_safety_wit_11.
Axiom proof_of_reverse_safety_wit_12 : reverse_safety_wit_12.
Axiom proof_of_reverse_safety_wit_13 : reverse_safety_wit_13.
Axiom proof_of_reverse_safety_wit_14 : reverse_safety_wit_14.
Axiom proof_of_reverse_safety_wit_15 : reverse_safety_wit_15.
Axiom proof_of_reverse_safety_wit_16 : reverse_safety_wit_16.
Axiom proof_of_reverse_return_wit_1 : reverse_return_wit_1.
Axiom proof_of_reverse_partial_solve_wit_1 : reverse_partial_solve_wit_1.
Axiom proof_of_reverse_precondition_wit_1 : reverse_precondition_wit_1.

End VC_Correct.
