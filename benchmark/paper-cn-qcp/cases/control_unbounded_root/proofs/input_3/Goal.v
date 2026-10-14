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
Require Import RootSpec.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function root_cell -----*)

Definition root_cell_safety_wit_1 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 9)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ ((9 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (9 + 1 )) ”
.

Definition root_cell_safety_wit_2 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 9)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition root_cell_safety_wit_3 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ ((8 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (8 + 1 )) ”
.

Definition root_cell_safety_wit_4 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition root_cell_safety_wit_5 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ ((7 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (7 + 1 )) ”
.

Definition root_cell_safety_wit_6 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition root_cell_safety_wit_7 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 6)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ ((6 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (6 + 1 )) ”
.

Definition root_cell_safety_wit_8 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 6)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition root_cell_safety_wit_9 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ ((5 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (5 + 1 )) ”
.

Definition root_cell_safety_wit_10 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition root_cell_safety_wit_11 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ ((4 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (4 + 1 )) ”
.

Definition root_cell_safety_wit_12 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition root_cell_safety_wit_13 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ ((3 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (3 + 1 )) ”
.

Definition root_cell_safety_wit_14 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition root_cell_safety_wit_15 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ ((2 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (2 + 1 )) ”
.

Definition root_cell_safety_wit_16 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition root_cell_safety_wit_17 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ ((1 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 + 1 )) ”
.

Definition root_cell_safety_wit_18 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition root_cell_safety_wit_19 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ ((0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (0 + 1 )) ”
.

Definition root_cell_safety_wit_20 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition root_cell_safety_wit_21 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |->_)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition root_cell_safety_wit_22 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ ((0 * 0 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (0 * 0 )) ”
.

Definition root_cell_safety_wit_23 := 
forall (p_pre: Z) (PreH1 : ((0 * 0 ) >= 100)) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ False ”
.

Definition root_cell_safety_wit_24 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition root_cell_safety_wit_25 := 
forall (p_pre: Z) (PreH1 : ((1 * 1 ) >= 100)) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ False ”
.

Definition root_cell_safety_wit_26 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ ((2 * 2 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (2 * 2 )) ”
.

Definition root_cell_safety_wit_27 := 
forall (p_pre: Z) (PreH1 : ((2 * 2 ) >= 100)) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ False ”
.

Definition root_cell_safety_wit_28 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ ((3 * 3 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (3 * 3 )) ”
.

Definition root_cell_safety_wit_29 := 
forall (p_pre: Z) (PreH1 : ((3 * 3 ) >= 100)) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ False ”
.

Definition root_cell_safety_wit_30 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ ((4 * 4 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (4 * 4 )) ”
.

Definition root_cell_safety_wit_31 := 
forall (p_pre: Z) (PreH1 : ((4 * 4 ) >= 100)) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ False ”
.

Definition root_cell_safety_wit_32 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ ((5 * 5 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (5 * 5 )) ”
.

Definition root_cell_safety_wit_33 := 
forall (p_pre: Z) (PreH1 : ((5 * 5 ) >= 100)) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 5)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ False ”
.

Definition root_cell_safety_wit_34 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 6)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ ((6 * 6 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (6 * 6 )) ”
.

Definition root_cell_safety_wit_35 := 
forall (p_pre: Z) (PreH1 : ((6 * 6 ) >= 100)) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 6)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ False ”
.

Definition root_cell_safety_wit_36 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ ((7 * 7 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (7 * 7 )) ”
.

Definition root_cell_safety_wit_37 := 
forall (p_pre: Z) (PreH1 : ((7 * 7 ) >= 100)) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ False ”
.

Definition root_cell_safety_wit_38 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ ((8 * 8 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (8 * 8 )) ”
.

Definition root_cell_safety_wit_39 := 
forall (p_pre: Z) (PreH1 : ((8 * 8 ) >= 100)) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ False ”
.

Definition root_cell_safety_wit_40 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 9)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ ((9 * 9 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (9 * 9 )) ”
.

Definition root_cell_safety_wit_41 := 
forall (p_pre: Z) (PreH1 : ((9 * 9 ) >= 100)) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 9)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ False ”
.

Definition root_cell_safety_wit_42 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 10)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ ((10 * 10 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (10 * 10 )) ”
.

Definition root_cell_safety_wit_43 := 
forall (p_pre: Z) (PreH1 : ((10 * 10 ) < 100)) ,
  ((( &( "r_spec_388" ) )) # Int  |-> 10)
  **  ((( &( "n_spec_385" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 100)
|--
  “ False ”
.

Definition root_cell_return_wit_1 := 
(
forall (p_pre: Z) ,
  ((p_pre) # Int  |-> 10)
|--
  EX (r: Z) ,
  “ (r = 10) ” 
  &&  “ (least_root 100 r ) ”
  &&  ((p_pre) # Int  |-> r)
) \/
(
  TT && emp 
|--
  “ (least_root 100 10 ) ”
  &&  emp
).

Definition root_cell_return_wit_1_split_goal_1 := 
  (least_root 100 10 )
.

Definition root_cell_precondition_wit_1 :=
exists (p_pre: Z) ,
~ ((  “ (100 = 100) ” 
  &&  “ (0 <= 100) ” 
  &&  “ (100 <= 100) ”
  &&  ((p_pre) # Int  |-> 100)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_root_cell_safety_wit_1 : root_cell_safety_wit_1.
Axiom proof_of_root_cell_safety_wit_2 : root_cell_safety_wit_2.
Axiom proof_of_root_cell_safety_wit_3 : root_cell_safety_wit_3.
Axiom proof_of_root_cell_safety_wit_4 : root_cell_safety_wit_4.
Axiom proof_of_root_cell_safety_wit_5 : root_cell_safety_wit_5.
Axiom proof_of_root_cell_safety_wit_6 : root_cell_safety_wit_6.
Axiom proof_of_root_cell_safety_wit_7 : root_cell_safety_wit_7.
Axiom proof_of_root_cell_safety_wit_8 : root_cell_safety_wit_8.
Axiom proof_of_root_cell_safety_wit_9 : root_cell_safety_wit_9.
Axiom proof_of_root_cell_safety_wit_10 : root_cell_safety_wit_10.
Axiom proof_of_root_cell_safety_wit_11 : root_cell_safety_wit_11.
Axiom proof_of_root_cell_safety_wit_12 : root_cell_safety_wit_12.
Axiom proof_of_root_cell_safety_wit_13 : root_cell_safety_wit_13.
Axiom proof_of_root_cell_safety_wit_14 : root_cell_safety_wit_14.
Axiom proof_of_root_cell_safety_wit_15 : root_cell_safety_wit_15.
Axiom proof_of_root_cell_safety_wit_16 : root_cell_safety_wit_16.
Axiom proof_of_root_cell_safety_wit_17 : root_cell_safety_wit_17.
Axiom proof_of_root_cell_safety_wit_18 : root_cell_safety_wit_18.
Axiom proof_of_root_cell_safety_wit_19 : root_cell_safety_wit_19.
Axiom proof_of_root_cell_safety_wit_20 : root_cell_safety_wit_20.
Axiom proof_of_root_cell_safety_wit_21 : root_cell_safety_wit_21.
Axiom proof_of_root_cell_safety_wit_22 : root_cell_safety_wit_22.
Axiom proof_of_root_cell_safety_wit_23 : root_cell_safety_wit_23.
Axiom proof_of_root_cell_safety_wit_24 : root_cell_safety_wit_24.
Axiom proof_of_root_cell_safety_wit_25 : root_cell_safety_wit_25.
Axiom proof_of_root_cell_safety_wit_26 : root_cell_safety_wit_26.
Axiom proof_of_root_cell_safety_wit_27 : root_cell_safety_wit_27.
Axiom proof_of_root_cell_safety_wit_28 : root_cell_safety_wit_28.
Axiom proof_of_root_cell_safety_wit_29 : root_cell_safety_wit_29.
Axiom proof_of_root_cell_safety_wit_30 : root_cell_safety_wit_30.
Axiom proof_of_root_cell_safety_wit_31 : root_cell_safety_wit_31.
Axiom proof_of_root_cell_safety_wit_32 : root_cell_safety_wit_32.
Axiom proof_of_root_cell_safety_wit_33 : root_cell_safety_wit_33.
Axiom proof_of_root_cell_safety_wit_34 : root_cell_safety_wit_34.
Axiom proof_of_root_cell_safety_wit_35 : root_cell_safety_wit_35.
Axiom proof_of_root_cell_safety_wit_36 : root_cell_safety_wit_36.
Axiom proof_of_root_cell_safety_wit_37 : root_cell_safety_wit_37.
Axiom proof_of_root_cell_safety_wit_38 : root_cell_safety_wit_38.
Axiom proof_of_root_cell_safety_wit_39 : root_cell_safety_wit_39.
Axiom proof_of_root_cell_safety_wit_40 : root_cell_safety_wit_40.
Axiom proof_of_root_cell_safety_wit_41 : root_cell_safety_wit_41.
Axiom proof_of_root_cell_safety_wit_42 : root_cell_safety_wit_42.
Axiom proof_of_root_cell_safety_wit_43 : root_cell_safety_wit_43.
Axiom proof_of_root_cell_return_wit_1 : root_cell_return_wit_1.
Axiom proof_of_root_cell_precondition_wit_1 : root_cell_precondition_wit_1.

End VC_Correct.
