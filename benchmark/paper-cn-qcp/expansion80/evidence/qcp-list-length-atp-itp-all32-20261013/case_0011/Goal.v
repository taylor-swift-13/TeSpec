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

(*----- Function length -----*)

Definition length_safety_wit_1 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_8 = 0)) (PreH2 : (y_7 <> 0)) (PreH3 : (y_6 <> 0)) (PreH4 : (y_5 <> 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y_3 <> 0)) (PreH12 : (y_4 <> 0)) (PreH13 : (y_5 <> 0)) (PreH14 : (y_6 <> 0)) (PreH15 : (y_7 <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (-100))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (-INT_MAX))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> INT_MAX)
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> 2147483646)
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> 100)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 1)
  **  ((4096) # Int  |-> 0)
  **  ((( &( "n_spec_421" ) )) # Int  |-> 7)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> y_7)
|--
  “ ((7 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (7 + 1 )) ”
.

Definition length_safety_wit_2 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_8 = 0)) (PreH2 : (y_7 <> 0)) (PreH3 : (y_6 <> 0)) (PreH4 : (y_5 <> 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y_3 <> 0)) (PreH12 : (y_4 <> 0)) (PreH13 : (y_5 <> 0)) (PreH14 : (y_6 <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (-100))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (-INT_MAX))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> INT_MAX)
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> 2147483646)
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> 100)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 1)
  **  ((4096) # Int  |-> 0)
  **  ((( &( "n_spec_421" ) )) # Int  |-> 6)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> y_6)
|--
  “ ((6 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (6 + 1 )) ”
.

Definition length_safety_wit_3 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_8 = 0)) (PreH2 : (y_7 <> 0)) (PreH3 : (y_6 <> 0)) (PreH4 : (y_5 <> 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y_3 <> 0)) (PreH12 : (y_4 <> 0)) (PreH13 : (y_5 <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (-100))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (-INT_MAX))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> INT_MAX)
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> 2147483646)
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> 100)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 1)
  **  ((4096) # Int  |-> 0)
  **  ((( &( "n_spec_421" ) )) # Int  |-> 5)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> y_5)
|--
  “ ((5 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (5 + 1 )) ”
.

Definition length_safety_wit_4 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_8 = 0)) (PreH2 : (y_7 <> 0)) (PreH3 : (y_6 <> 0)) (PreH4 : (y_5 <> 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y_3 <> 0)) (PreH12 : (y_4 <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (-100))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (-INT_MAX))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> INT_MAX)
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> 2147483646)
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> 100)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 1)
  **  ((4096) # Int  |-> 0)
  **  ((( &( "n_spec_421" ) )) # Int  |-> 4)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> y_4)
|--
  “ ((4 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (4 + 1 )) ”
.

Definition length_safety_wit_5 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_8 = 0)) (PreH2 : (y_7 <> 0)) (PreH3 : (y_6 <> 0)) (PreH4 : (y_5 <> 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y_3 <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (-100))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (-INT_MAX))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> INT_MAX)
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> 2147483646)
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> 100)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 1)
  **  ((4096) # Int  |-> 0)
  **  ((( &( "n_spec_421" ) )) # Int  |-> 3)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> y_3)
|--
  “ ((3 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (3 + 1 )) ”
.

Definition length_safety_wit_6 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_8 = 0)) (PreH2 : (y_7 <> 0)) (PreH3 : (y_6 <> 0)) (PreH4 : (y_5 <> 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (-100))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (-INT_MAX))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> INT_MAX)
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> 2147483646)
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> 100)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 1)
  **  ((4096) # Int  |-> 0)
  **  ((( &( "n_spec_421" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> y_2)
|--
  “ ((2 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (2 + 1 )) ”
.

Definition length_safety_wit_7 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_8 = 0)) (PreH2 : (y_7 <> 0)) (PreH3 : (y_6 <> 0)) (PreH4 : (y_5 <> 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (-100))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (-INT_MAX))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> INT_MAX)
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> 2147483646)
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> 100)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 1)
  **  ((4096) # Int  |-> 0)
  **  ((( &( "n_spec_421" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> y)
|--
  “ ((1 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 + 1 )) ”
.

Definition length_safety_wit_8 := 
  ((( &( "n_spec_421" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
  **  (sll32 4096 (cons (0) ((cons (1) ((cons (100) ((cons (2147483646) ((cons (INT_MAX) ((cons ((INT_MIN)) ((cons ((-INT_MAX)) ((cons ((-100)) ((@nil Z))))))))))))))))) )
|--
  “ ((0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (0 + 1 )) ”
.

Definition length_safety_wit_9 := 
  ((( &( "n_spec_421" ) )) # Int  |->_)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
  **  (sll32 4096 (cons (0) ((cons (1) ((cons (100) ((cons (2147483646) ((cons (INT_MAX) ((cons ((INT_MIN)) ((cons ((-INT_MAX)) ((cons ((-100)) ((@nil Z))))))))))))))))) )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition length_safety_wit_10 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_8 = 0)) (PreH2 : (y_7 <> 0)) (PreH3 : (y_6 <> 0)) (PreH4 : (y_5 <> 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y = 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (-100))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (-INT_MAX))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> INT_MAX)
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> 2147483646)
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> 100)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 1)
  **  ((4096) # Int  |-> 0)
  **  ((( &( "n_spec_421" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> y)
|--
  “ False ”
.

Definition length_safety_wit_11 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_8 = 0)) (PreH2 : (y_7 <> 0)) (PreH3 : (y_6 <> 0)) (PreH4 : (y_5 <> 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 = 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (-100))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (-INT_MAX))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> INT_MAX)
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> 2147483646)
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> 100)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 1)
  **  ((4096) # Int  |-> 0)
  **  ((( &( "n_spec_421" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> y_2)
|--
  “ False ”
.

Definition length_safety_wit_12 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_8 = 0)) (PreH2 : (y_7 <> 0)) (PreH3 : (y_6 <> 0)) (PreH4 : (y_5 <> 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y_3 = 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (-100))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (-INT_MAX))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> INT_MAX)
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> 2147483646)
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> 100)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 1)
  **  ((4096) # Int  |-> 0)
  **  ((( &( "n_spec_421" ) )) # Int  |-> 3)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> y_3)
|--
  “ False ”
.

Definition length_safety_wit_13 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_8 = 0)) (PreH2 : (y_7 <> 0)) (PreH3 : (y_6 <> 0)) (PreH4 : (y_5 <> 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y_3 <> 0)) (PreH12 : (y_4 = 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (-100))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (-INT_MAX))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> INT_MAX)
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> 2147483646)
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> 100)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 1)
  **  ((4096) # Int  |-> 0)
  **  ((( &( "n_spec_421" ) )) # Int  |-> 4)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> y_4)
|--
  “ False ”
.

Definition length_safety_wit_14 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_8 = 0)) (PreH2 : (y_7 <> 0)) (PreH3 : (y_6 <> 0)) (PreH4 : (y_5 <> 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y_3 <> 0)) (PreH12 : (y_4 <> 0)) (PreH13 : (y_5 = 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (-100))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (-INT_MAX))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> INT_MAX)
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> 2147483646)
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> 100)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 1)
  **  ((4096) # Int  |-> 0)
  **  ((( &( "n_spec_421" ) )) # Int  |-> 5)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> y_5)
|--
  “ False ”
.

Definition length_safety_wit_15 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_8 = 0)) (PreH2 : (y_7 <> 0)) (PreH3 : (y_6 <> 0)) (PreH4 : (y_5 <> 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y_3 <> 0)) (PreH12 : (y_4 <> 0)) (PreH13 : (y_5 <> 0)) (PreH14 : (y_6 = 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (-100))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (-INT_MAX))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> INT_MAX)
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> 2147483646)
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> 100)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 1)
  **  ((4096) # Int  |-> 0)
  **  ((( &( "n_spec_421" ) )) # Int  |-> 6)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> y_6)
|--
  “ False ”
.

Definition length_safety_wit_16 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_8 = 0)) (PreH2 : (y_7 <> 0)) (PreH3 : (y_6 <> 0)) (PreH4 : (y_5 <> 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y_3 <> 0)) (PreH12 : (y_4 <> 0)) (PreH13 : (y_5 <> 0)) (PreH14 : (y_6 <> 0)) (PreH15 : (y_7 = 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (-100))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (-INT_MAX))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> INT_MAX)
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> 2147483646)
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> 100)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 1)
  **  ((4096) # Int  |-> 0)
  **  ((( &( "n_spec_421" ) )) # Int  |-> 7)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> y_7)
|--
  “ False ”
.

Definition length_return_wit_1 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_8 = 0)) (PreH2 : (y_7 <> 0)) (PreH3 : (y_6 <> 0)) (PreH4 : (y_5 <> 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y_3 <> 0)) (PreH12 : (y_4 <> 0)) (PreH13 : (y_5 <> 0)) (PreH14 : (y_6 <> 0)) (PreH15 : (y_7 <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (-100))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (-INT_MAX))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> INT_MAX)
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> 2147483646)
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> 100)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 1)
  **  ((4096) # Int  |-> 0)
|--
  “ (8 = 8) ”
  &&  (sll32 4096 (cons (0) ((cons (1) ((cons (100) ((cons (2147483646) ((cons (INT_MAX) ((cons ((INT_MIN)) ((cons ((-INT_MAX)) ((cons ((-100)) ((@nil Z))))))))))))))))) )
.

Definition length_partial_solve_wit_1 := 
  (sll32 4096 (cons (0) ((cons (1) ((cons (100) ((cons (2147483646) ((cons (INT_MAX) ((cons ((INT_MIN)) ((cons ((-INT_MAX)) ((cons ((-100)) ((@nil Z))))))))))))))))) )
|--
  EX (y: Z)  (y_2: Z)  (y_3: Z)  (y_4: Z)  (y_5: Z)  (y_6: Z)  (y_7: Z)  (y_8: Z) ,
  “ (y_8 = 0) ” 
  &&  “ (y_7 <> 0) ” 
  &&  “ (y_6 <> 0) ” 
  &&  “ (y_5 <> 0) ” 
  &&  “ (y_4 <> 0) ” 
  &&  “ (y_3 <> 0) ” 
  &&  “ (y_2 <> 0) ” 
  &&  “ (y <> 0) ” 
  &&  “ (4096 <> 0) ”
  &&  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> y_8)
  **  ((y_7) # Int  |-> (-100))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (-INT_MAX))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> INT_MAX)
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> 2147483646)
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> 100)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 1)
  **  ((4096) # Int  |-> 0)
.

Definition length_precondition_wit_1 :=
~ ((  “ (4096 = 4096) ” 
  &&  “ ((cons (0) ((cons (1) ((cons (100) ((cons (2147483646) ((cons (INT_MAX) ((cons ((INT_MIN)) ((cons ((-INT_MAX)) ((cons ((-100)) ((@nil Z))))))))))))))))) = (cons (0) ((cons (1) ((cons (100) ((cons (2147483646) ((cons (INT_MAX) ((cons ((INT_MIN)) ((cons ((-INT_MAX)) ((cons ((-100)) ((@nil Z)))))))))))))))))) ” 
  &&  “ ((Zlength ((cons (0) ((cons (1) ((cons (100) ((cons (2147483646) ((cons (INT_MAX) ((cons ((INT_MIN)) ((cons ((-INT_MAX)) ((cons ((-100)) ((@nil Z))))))))))))))))))) <= INT_MAX) ”
  &&  (sll32 4096 (cons (0) ((cons (1) ((cons (100) ((cons (2147483646) ((cons (INT_MAX) ((cons ((INT_MIN)) ((cons ((-INT_MAX)) ((cons ((-100)) ((@nil Z))))))))))))))))) )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_length_safety_wit_1 : length_safety_wit_1.
Axiom proof_of_length_safety_wit_2 : length_safety_wit_2.
Axiom proof_of_length_safety_wit_3 : length_safety_wit_3.
Axiom proof_of_length_safety_wit_4 : length_safety_wit_4.
Axiom proof_of_length_safety_wit_5 : length_safety_wit_5.
Axiom proof_of_length_safety_wit_6 : length_safety_wit_6.
Axiom proof_of_length_safety_wit_7 : length_safety_wit_7.
Axiom proof_of_length_safety_wit_8 : length_safety_wit_8.
Axiom proof_of_length_safety_wit_9 : length_safety_wit_9.
Axiom proof_of_length_safety_wit_10 : length_safety_wit_10.
Axiom proof_of_length_safety_wit_11 : length_safety_wit_11.
Axiom proof_of_length_safety_wit_12 : length_safety_wit_12.
Axiom proof_of_length_safety_wit_13 : length_safety_wit_13.
Axiom proof_of_length_safety_wit_14 : length_safety_wit_14.
Axiom proof_of_length_safety_wit_15 : length_safety_wit_15.
Axiom proof_of_length_safety_wit_16 : length_safety_wit_16.
Axiom proof_of_length_return_wit_1 : length_return_wit_1.
Axiom proof_of_length_partial_solve_wit_1 : length_partial_solve_wit_1.
Axiom proof_of_length_precondition_wit_1 : length_precondition_wit_1.

End VC_Correct.
