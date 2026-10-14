Require Import StateResources.
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

(*----- Function increment_Plane_Counter -----*)

Definition increment_Plane_Counter_safety_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : (c0 <= 2)) (PreH17 : ((a0 + d0 ) = 1)) (PreH18 : (wd0 >= a0)) (PreH19 : (wa0 >= d0)) ,
  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
|--
  “ ((c0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (c0 + 1 )) ”
.

Definition increment_Plane_Counter_safety_wit_2 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : (c0 <= 2)) (PreH17 : ((a0 + d0 ) = 1)) (PreH18 : (wd0 >= a0)) (PreH19 : (wa0 >= d0)) ,
  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition increment_Plane_Counter_return_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : (c0 <= 2)) (PreH17 : ((a0 + d0 ) = 1)) (PreH18 : (wd0 >= a0)) (PreH19 : (wa0 >= d0)) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> (c0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> a0)
|--
  EX (retval_Plane_Counter: Z) ,
  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter) ” 
  &&  “ (retval_Plane_Counter <= 3) ” 
  &&  “ (retval_Plane_Counter <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (retval_Plane_Counter = (c0 + 1 )) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter)
.

Definition increment_Plane_Counter_partial_solve_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : (c0 <= 2)) (PreH17 : ((a0 + d0 ) = 1)) (PreH18 : (wd0 >= a0)) (PreH19 : (wa0 >= d0)) ,
  (UndefStructPredState ( &( "temp" ) ) )
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (c0 <= 2) ” 
  &&  “ ((a0 + d0 ) = 1) ” 
  &&  “ (wd0 >= a0) ” 
  &&  “ (wa0 >= d0) ”
  &&  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
.

Definition increment_Plane_Counter_partial_solve_wit_2 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : (c0 <= 2)) (PreH17 : ((a0 + d0 ) = 1)) (PreH18 : (wd0 >= a0)) (PreH19 : (wa0 >= d0)) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (c0 + 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
|--
  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (c0 <= 2) ” 
  &&  “ ((a0 + d0 ) = 1) ” 
  &&  “ (wd0 >= a0) ” 
  &&  “ (wa0 >= d0) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (c0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
.

(*----- Function reset_Plane_Counter -----*)

Definition reset_Plane_Counter_safety_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) ,
  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition reset_Plane_Counter_return_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> a0)
|--
  EX (retval_Plane_Counter: Z) ,
  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter) ” 
  &&  “ (retval_Plane_Counter <= 3) ” 
  &&  “ (retval_Plane_Counter <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (retval_Plane_Counter = 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter)
.

Definition reset_Plane_Counter_partial_solve_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) ,
  (UndefStructPredState ( &( "temp" ) ) )
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ”
  &&  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
.

Definition reset_Plane_Counter_partial_solve_wit_2 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
|--
  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
.

(*----- Function increment_Runway_Time -----*)

Definition increment_Runway_Time_safety_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : (t0 <= 4)) (PreH17 : ((a0 + d0 ) = 1)) ,
  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
|--
  “ ((t0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (t0 + 1 )) ”
.

Definition increment_Runway_Time_safety_wit_2 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : (t0 <= 4)) (PreH17 : ((a0 + d0 ) = 1)) ,
  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition increment_Runway_Time_return_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : (t0 <= 4)) (PreH17 : ((a0 + d0 ) = 1)) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> a0)
|--
  EX (retval_Runway_Time: Z)  (retval_W_D: Z)  (retval_W_A: Z) ,
  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (retval_W_A >= 0) ” 
  &&  “ (retval_W_D >= 0) ” 
  &&  “ (0 <= retval_Runway_Time) ” 
  &&  “ (retval_Runway_Time <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (retval_Runway_Time <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + retval_W_D ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + retval_W_A ) )) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
.

Definition increment_Runway_Time_partial_solve_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : (t0 <= 4)) (PreH17 : ((a0 + d0 ) = 1)) ,
  (UndefStructPredState ( &( "temp" ) ) )
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (t0 <= 4) ” 
  &&  “ ((a0 + d0 ) = 1) ”
  &&  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
.

Definition increment_Runway_Time_partial_solve_wit_2 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : (t0 <= 4)) (PreH17 : ((a0 + d0 ) = 1)) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
|--
  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (t0 <= 4) ” 
  &&  “ ((a0 + d0 ) = 1) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
.

(*----- Function reset_Runway_Time -----*)

Definition reset_Runway_Time_safety_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) ,
  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition reset_Runway_Time_return_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> 0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> a0)
|--
  EX (retval_Runway_Time: Z) ,
  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time) ” 
  &&  “ (retval_Runway_Time <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (retval_Runway_Time <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (retval_Runway_Time = 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
.

Definition reset_Runway_Time_partial_solve_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) ,
  (UndefStructPredState ( &( "temp" ) ) )
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ”
  &&  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
.

Definition reset_Runway_Time_partial_solve_wit_2 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
|--
  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> 0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
.

(*----- Function arrive -----*)

Definition arrive_safety_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : (a0 = 1)) (PreH17 : (wa0 >= 1)) (PreH18 : (c0 <= 2)) ,
  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
|--
  “ ((wa0 - 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (wa0 - 1 )) ”
.

Definition arrive_safety_wit_2 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : (a0 = 1)) (PreH17 : (wa0 >= 1)) (PreH18 : (c0 <= 2)) ,
  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition arrive_safety_wit_3 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : (a0 = 1)) (PreH17 : (wa0 >= 1)) (PreH18 : (c0 <= 2)) ,
  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition arrive_safety_wit_4 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (0 <= a0)) (PreH3 : (a0 <= 1)) (PreH4 : (0 <= d0)) (PreH5 : (d0 <= 1)) (PreH6 : ((a0 + d0 ) <= 1)) (PreH7 : (wa0 >= 0)) (PreH8 : (wd0 >= 0)) (PreH9 : (0 <= t0)) (PreH10 : (t0 <= 5)) (PreH11 : (0 <= c0)) (PreH12 : (c0 <= 3)) (PreH13 : (c0 <= (3 * (a0 + d0 ) ))) (PreH14 : (t0 <= (5 * (a0 + d0 ) ))) (PreH15 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH16 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH17 : (a0 = 1)) (PreH18 : (wa0 >= 1)) (PreH19 : (c0 <= 2)) ,
  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
|--
  “ ((c0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (c0 + 1 )) ”
.

Definition arrive_safety_wit_5 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (0 <= a0)) (PreH3 : (a0 <= 1)) (PreH4 : (0 <= d0)) (PreH5 : (d0 <= 1)) (PreH6 : ((a0 + d0 ) <= 1)) (PreH7 : (wa0 >= 0)) (PreH8 : (wd0 >= 0)) (PreH9 : (0 <= t0)) (PreH10 : (t0 <= 5)) (PreH11 : (0 <= c0)) (PreH12 : (c0 <= 3)) (PreH13 : (c0 <= (3 * (a0 + d0 ) ))) (PreH14 : (t0 <= (5 * (a0 + d0 ) ))) (PreH15 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH16 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH17 : (a0 = 1)) (PreH18 : (wa0 >= 1)) (PreH19 : (c0 <= 2)) ,
  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition arrive_return_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wd0 > 0)) (PreH2 : (0 <= a0)) (PreH3 : (a0 <= 1)) (PreH4 : (0 <= d0)) (PreH5 : (d0 <= 1)) (PreH6 : ((a0 + d0 ) <= 1)) (PreH7 : (wa0 >= 0)) (PreH8 : (wd0 >= 0)) (PreH9 : (0 <= t0)) (PreH10 : (t0 <= 5)) (PreH11 : (0 <= c0)) (PreH12 : (c0 <= 3)) (PreH13 : (c0 <= (3 * (a0 + d0 ) ))) (PreH14 : (t0 <= (5 * (a0 + d0 ) ))) (PreH15 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH16 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH17 : (a0 = 1)) (PreH18 : (wa0 >= 1)) (PreH19 : (c0 <= 2)) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> (c0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> a0)
|--
  EX (retval_Plane_Counter_2: Z)  (retval_W_A_4: Z) ,
  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (retval_W_A_4 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_2) ” 
  &&  “ (retval_Plane_Counter_2 <= 3) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - d0 ) + retval_W_A_4 ) )) ” 
  &&  “ (wd0 <> 0) ” 
  &&  “ (retval_Plane_Counter_2 = (c0 + 1 )) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_4)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_2)
.

Definition arrive_return_wit_2 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wd0 <= 0)) (PreH2 : (0 <= a0)) (PreH3 : (a0 <= 1)) (PreH4 : (0 <= d0)) (PreH5 : (d0 <= 1)) (PreH6 : ((a0 + d0 ) <= 1)) (PreH7 : (wa0 >= 0)) (PreH8 : (wd0 >= 0)) (PreH9 : (0 <= t0)) (PreH10 : (t0 <= 5)) (PreH11 : (0 <= c0)) (PreH12 : (c0 <= 3)) (PreH13 : (c0 <= (3 * (a0 + d0 ) ))) (PreH14 : (t0 <= (5 * (a0 + d0 ) ))) (PreH15 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH16 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH17 : (a0 = 1)) (PreH18 : (wa0 >= 1)) (PreH19 : (c0 <= 2)) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> a0)
|--
  EX (retval_W_A: Z) ,
  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (retval_W_A >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + retval_W_A ) )) ” 
  &&  “ (wd0 <= 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
.

Definition arrive_partial_solve_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : (a0 = 1)) (PreH17 : (wa0 >= 1)) (PreH18 : (c0 <= 2)) ,
  (UndefStructPredState ( &( "temp" ) ) )
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (a0 = 1) ” 
  &&  “ (wa0 >= 1) ” 
  &&  “ (c0 <= 2) ”
  &&  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
.

Definition arrive_partial_solve_wit_2 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wd0 > 0)) (PreH2 : (0 <= a0)) (PreH3 : (a0 <= 1)) (PreH4 : (0 <= d0)) (PreH5 : (d0 <= 1)) (PreH6 : ((a0 + d0 ) <= 1)) (PreH7 : (wa0 >= 0)) (PreH8 : (wd0 >= 0)) (PreH9 : (0 <= t0)) (PreH10 : (t0 <= 5)) (PreH11 : (0 <= c0)) (PreH12 : (c0 <= 3)) (PreH13 : (c0 <= (3 * (a0 + d0 ) ))) (PreH14 : (t0 <= (5 * (a0 + d0 ) ))) (PreH15 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH16 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH17 : (a0 = 1)) (PreH18 : (wa0 >= 1)) (PreH19 : (c0 <= 2)) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (c0 + 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
|--
  “ (wd0 > 0) ” 
  &&  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (a0 = 1) ” 
  &&  “ (wa0 >= 1) ” 
  &&  “ (c0 <= 2) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (c0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
.

Definition arrive_partial_solve_wit_3 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wd0 <= 0)) (PreH2 : (0 <= a0)) (PreH3 : (a0 <= 1)) (PreH4 : (0 <= d0)) (PreH5 : (d0 <= 1)) (PreH6 : ((a0 + d0 ) <= 1)) (PreH7 : (wa0 >= 0)) (PreH8 : (wd0 >= 0)) (PreH9 : (0 <= t0)) (PreH10 : (t0 <= 5)) (PreH11 : (0 <= c0)) (PreH12 : (c0 <= 3)) (PreH13 : (c0 <= (3 * (a0 + d0 ) ))) (PreH14 : (t0 <= (5 * (a0 + d0 ) ))) (PreH15 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH16 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH17 : (a0 = 1)) (PreH18 : (wa0 >= 1)) (PreH19 : (c0 <= 2)) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
|--
  “ (wd0 <= 0) ” 
  &&  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (a0 = 1) ” 
  &&  “ (wa0 >= 1) ” 
  &&  “ (c0 <= 2) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
.

(*----- Function depart -----*)

Definition depart_safety_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : (d0 = 1)) (PreH17 : (wd0 >= 1)) (PreH18 : (c0 <= 2)) ,
  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
|--
  “ ((wd0 - 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (wd0 - 1 )) ”
.

Definition depart_safety_wit_2 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : (d0 = 1)) (PreH17 : (wd0 >= 1)) (PreH18 : (c0 <= 2)) ,
  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition depart_safety_wit_3 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : (d0 = 1)) (PreH17 : (wd0 >= 1)) (PreH18 : (c0 <= 2)) ,
  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition depart_safety_wit_4 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 > 0)) (PreH2 : (0 <= a0)) (PreH3 : (a0 <= 1)) (PreH4 : (0 <= d0)) (PreH5 : (d0 <= 1)) (PreH6 : ((a0 + d0 ) <= 1)) (PreH7 : (wa0 >= 0)) (PreH8 : (wd0 >= 0)) (PreH9 : (0 <= t0)) (PreH10 : (t0 <= 5)) (PreH11 : (0 <= c0)) (PreH12 : (c0 <= 3)) (PreH13 : (c0 <= (3 * (a0 + d0 ) ))) (PreH14 : (t0 <= (5 * (a0 + d0 ) ))) (PreH15 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH16 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH17 : (d0 = 1)) (PreH18 : (wd0 >= 1)) (PreH19 : (c0 <= 2)) ,
  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
|--
  “ ((c0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (c0 + 1 )) ”
.

Definition depart_safety_wit_5 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 > 0)) (PreH2 : (0 <= a0)) (PreH3 : (a0 <= 1)) (PreH4 : (0 <= d0)) (PreH5 : (d0 <= 1)) (PreH6 : ((a0 + d0 ) <= 1)) (PreH7 : (wa0 >= 0)) (PreH8 : (wd0 >= 0)) (PreH9 : (0 <= t0)) (PreH10 : (t0 <= 5)) (PreH11 : (0 <= c0)) (PreH12 : (c0 <= 3)) (PreH13 : (c0 <= (3 * (a0 + d0 ) ))) (PreH14 : (t0 <= (5 * (a0 + d0 ) ))) (PreH15 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH16 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH17 : (d0 = 1)) (PreH18 : (wd0 >= 1)) (PreH19 : (c0 <= 2)) ,
  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition depart_return_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wa0 > 0)) (PreH2 : (0 <= a0)) (PreH3 : (a0 <= 1)) (PreH4 : (0 <= d0)) (PreH5 : (d0 <= 1)) (PreH6 : ((a0 + d0 ) <= 1)) (PreH7 : (wa0 >= 0)) (PreH8 : (wd0 >= 0)) (PreH9 : (0 <= t0)) (PreH10 : (t0 <= 5)) (PreH11 : (0 <= c0)) (PreH12 : (c0 <= 3)) (PreH13 : (c0 <= (3 * (a0 + d0 ) ))) (PreH14 : (t0 <= (5 * (a0 + d0 ) ))) (PreH15 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH16 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH17 : (d0 = 1)) (PreH18 : (wd0 >= 1)) (PreH19 : (c0 <= 2)) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> (c0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> a0)
|--
  EX (retval_Plane_Counter: Z)  (retval_W_D: Z) ,
  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (retval_W_D >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter) ” 
  &&  “ (retval_Plane_Counter <= 3) ” 
  &&  “ (retval_Plane_Counter <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - a0 ) + retval_W_D ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - d0 ) + wa0 ) )) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter)
.

Definition depart_return_wit_2 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wa0 <= 0)) (PreH2 : (0 <= a0)) (PreH3 : (a0 <= 1)) (PreH4 : (0 <= d0)) (PreH5 : (d0 <= 1)) (PreH6 : ((a0 + d0 ) <= 1)) (PreH7 : (wa0 >= 0)) (PreH8 : (wd0 >= 0)) (PreH9 : (0 <= t0)) (PreH10 : (t0 <= 5)) (PreH11 : (0 <= c0)) (PreH12 : (c0 <= 3)) (PreH13 : (c0 <= (3 * (a0 + d0 ) ))) (PreH14 : (t0 <= (5 * (a0 + d0 ) ))) (PreH15 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH16 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH17 : (d0 = 1)) (PreH18 : (wd0 >= 1)) (PreH19 : (c0 <= 2)) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> a0)
|--
  EX (retval_Plane_Counter: Z)  (retval_W_D: Z) ,
  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (retval_W_D >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter) ” 
  &&  “ (retval_Plane_Counter <= 3) ” 
  &&  “ (retval_Plane_Counter <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - a0 ) + retval_W_D ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - d0 ) + wa0 ) )) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter)
.

Definition depart_partial_solve_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : (d0 = 1)) (PreH17 : (wd0 >= 1)) (PreH18 : (c0 <= 2)) ,
  (UndefStructPredState ( &( "temp" ) ) )
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (d0 = 1) ” 
  &&  “ (wd0 >= 1) ” 
  &&  “ (c0 <= 2) ”
  &&  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
.

Definition depart_partial_solve_wit_2 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wa0 > 0)) (PreH2 : (0 <= a0)) (PreH3 : (a0 <= 1)) (PreH4 : (0 <= d0)) (PreH5 : (d0 <= 1)) (PreH6 : ((a0 + d0 ) <= 1)) (PreH7 : (wa0 >= 0)) (PreH8 : (wd0 >= 0)) (PreH9 : (0 <= t0)) (PreH10 : (t0 <= 5)) (PreH11 : (0 <= c0)) (PreH12 : (c0 <= 3)) (PreH13 : (c0 <= (3 * (a0 + d0 ) ))) (PreH14 : (t0 <= (5 * (a0 + d0 ) ))) (PreH15 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH16 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH17 : (d0 = 1)) (PreH18 : (wd0 >= 1)) (PreH19 : (c0 <= 2)) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (c0 + 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
|--
  “ (wa0 > 0) ” 
  &&  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (d0 = 1) ” 
  &&  “ (wd0 >= 1) ” 
  &&  “ (c0 <= 2) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (c0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
.

Definition depart_partial_solve_wit_3 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wa0 <= 0)) (PreH2 : (0 <= a0)) (PreH3 : (a0 <= 1)) (PreH4 : (0 <= d0)) (PreH5 : (d0 <= 1)) (PreH6 : ((a0 + d0 ) <= 1)) (PreH7 : (wa0 >= 0)) (PreH8 : (wd0 >= 0)) (PreH9 : (0 <= t0)) (PreH10 : (t0 <= 5)) (PreH11 : (0 <= c0)) (PreH12 : (c0 <= 3)) (PreH13 : (c0 <= (3 * (a0 + d0 ) ))) (PreH14 : (t0 <= (5 * (a0 + d0 ) ))) (PreH15 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH16 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH17 : (d0 = 1)) (PreH18 : (wd0 >= 1)) (PreH19 : (c0 <= 2)) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
|--
  “ (wa0 <= 0) ” 
  &&  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (d0 = 1) ” 
  &&  “ (wd0 >= 1) ” 
  &&  “ (c0 <= 2) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
.

(*----- Function switch_modes -----*)

Definition switch_modes_safety_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : ((a0 + d0 ) = 1)) (PreH17 : (c0 = 0)) ,
  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition switch_modes_safety_wit_2 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 = 0)) (PreH2 : (0 <= a0)) (PreH3 : (a0 <= 1)) (PreH4 : (0 <= d0)) (PreH5 : (d0 <= 1)) (PreH6 : ((a0 + d0 ) <= 1)) (PreH7 : (wa0 >= 0)) (PreH8 : (wd0 >= 0)) (PreH9 : (0 <= t0)) (PreH10 : (t0 <= 5)) (PreH11 : (0 <= c0)) (PreH12 : (c0 <= 3)) (PreH13 : (c0 <= (3 * (a0 + d0 ) ))) (PreH14 : (t0 <= (5 * (a0 + d0 ) ))) (PreH15 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH16 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH17 : ((a0 + d0 ) = 1)) (PreH18 : (c0 = 0)) ,
  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition switch_modes_safety_wit_3 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 <> 0)) (PreH2 : (0 <= a0)) (PreH3 : (a0 <= 1)) (PreH4 : (0 <= d0)) (PreH5 : (d0 <= 1)) (PreH6 : ((a0 + d0 ) <= 1)) (PreH7 : (wa0 >= 0)) (PreH8 : (wd0 >= 0)) (PreH9 : (0 <= t0)) (PreH10 : (t0 <= 5)) (PreH11 : (0 <= c0)) (PreH12 : (c0 <= 3)) (PreH13 : (c0 <= (3 * (a0 + d0 ) ))) (PreH14 : (t0 <= (5 * (a0 + d0 ) ))) (PreH15 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH16 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH17 : ((a0 + d0 ) = 1)) (PreH18 : (c0 = 0)) ,
  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition switch_modes_safety_wit_4 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 <> 0)) (PreH2 : (0 <= a0)) (PreH3 : (a0 <= 1)) (PreH4 : (0 <= d0)) (PreH5 : (d0 <= 1)) (PreH6 : ((a0 + d0 ) <= 1)) (PreH7 : (wa0 >= 0)) (PreH8 : (wd0 >= 0)) (PreH9 : (0 <= t0)) (PreH10 : (t0 <= 5)) (PreH11 : (0 <= c0)) (PreH12 : (c0 <= 3)) (PreH13 : (c0 <= (3 * (a0 + d0 ) ))) (PreH14 : (t0 <= (5 * (a0 + d0 ) ))) (PreH15 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH16 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH17 : ((a0 + d0 ) = 1)) (PreH18 : (c0 = 0)) ,
  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition switch_modes_safety_wit_5 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 = 0)) (PreH2 : (0 <= a0)) (PreH3 : (a0 <= 1)) (PreH4 : (0 <= d0)) (PreH5 : (d0 <= 1)) (PreH6 : ((a0 + d0 ) <= 1)) (PreH7 : (wa0 >= 0)) (PreH8 : (wd0 >= 0)) (PreH9 : (0 <= t0)) (PreH10 : (t0 <= 5)) (PreH11 : (0 <= c0)) (PreH12 : (c0 <= 3)) (PreH13 : (c0 <= (3 * (a0 + d0 ) ))) (PreH14 : (t0 <= (5 * (a0 + d0 ) ))) (PreH15 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH16 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH17 : ((a0 + d0 ) = 1)) (PreH18 : (c0 = 0)) ,
  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition switch_modes_safety_wit_6 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 <> 0)) (PreH2 : (a0 <> 0)) (PreH3 : (0 <= a0)) (PreH4 : (a0 <= 1)) (PreH5 : (0 <= d0)) (PreH6 : (d0 <= 1)) (PreH7 : ((a0 + d0 ) <= 1)) (PreH8 : (wa0 >= 0)) (PreH9 : (wd0 >= 0)) (PreH10 : (0 <= t0)) (PreH11 : (t0 <= 5)) (PreH12 : (0 <= c0)) (PreH13 : (c0 <= 3)) (PreH14 : (c0 <= (3 * (a0 + d0 ) ))) (PreH15 : (t0 <= (5 * (a0 + d0 ) ))) (PreH16 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH17 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH18 : ((a0 + d0 ) = 1)) (PreH19 : (c0 = 0)) ,
  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
|--
  “ False ”
.

Definition switch_modes_safety_wit_7 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 = 0)) (PreH2 : (a0 = 0)) (PreH3 : (0 <= a0)) (PreH4 : (a0 <= 1)) (PreH5 : (0 <= d0)) (PreH6 : (d0 <= 1)) (PreH7 : ((a0 + d0 ) <= 1)) (PreH8 : (wa0 >= 0)) (PreH9 : (wd0 >= 0)) (PreH10 : (0 <= t0)) (PreH11 : (t0 <= 5)) (PreH12 : (0 <= c0)) (PreH13 : (c0 <= 3)) (PreH14 : (c0 <= (3 * (a0 + d0 ) ))) (PreH15 : (t0 <= (5 * (a0 + d0 ) ))) (PreH16 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH17 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH18 : ((a0 + d0 ) = 1)) (PreH19 : (c0 = 0)) ,
  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
|--
  “ False ”
.

Definition switch_modes_safety_wit_8 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 = 0)) (PreH2 : (a0 <> 0)) (PreH3 : (0 <= a0)) (PreH4 : (a0 <= 1)) (PreH5 : (0 <= d0)) (PreH6 : (d0 <= 1)) (PreH7 : ((a0 + d0 ) <= 1)) (PreH8 : (wa0 >= 0)) (PreH9 : (wd0 >= 0)) (PreH10 : (0 <= t0)) (PreH11 : (t0 <= 5)) (PreH12 : (0 <= c0)) (PreH13 : (c0 <= 3)) (PreH14 : (c0 <= (3 * (a0 + d0 ) ))) (PreH15 : (t0 <= (5 * (a0 + d0 ) ))) (PreH16 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH17 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH18 : ((a0 + d0 ) = 1)) (PreH19 : (c0 = 0)) ,
  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition switch_modes_safety_wit_9 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 <> 0)) (PreH2 : (a0 = 0)) (PreH3 : (0 <= a0)) (PreH4 : (a0 <= 1)) (PreH5 : (0 <= d0)) (PreH6 : (d0 <= 1)) (PreH7 : ((a0 + d0 ) <= 1)) (PreH8 : (wa0 >= 0)) (PreH9 : (wd0 >= 0)) (PreH10 : (0 <= t0)) (PreH11 : (t0 <= 5)) (PreH12 : (0 <= c0)) (PreH13 : (c0 <= 3)) (PreH14 : (c0 <= (3 * (a0 + d0 ) ))) (PreH15 : (t0 <= (5 * (a0 + d0 ) ))) (PreH16 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH17 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH18 : ((a0 + d0 ) = 1)) (PreH19 : (c0 = 0)) ,
  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition switch_modes_return_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (d0 = 0)) (PreH2 : (a0 <> 0)) (PreH3 : (0 <= a0)) (PreH4 : (a0 <= 1)) (PreH5 : (0 <= d0)) (PreH6 : (d0 <= 1)) (PreH7 : ((a0 + d0 ) <= 1)) (PreH8 : (wa0 >= 0)) (PreH9 : (wd0 >= 0)) (PreH10 : (0 <= t0)) (PreH11 : (t0 <= 5)) (PreH12 : (0 <= c0)) (PreH13 : (c0 <= 3)) (PreH14 : (c0 <= (3 * (a0 + d0 ) ))) (PreH15 : (t0 <= (5 * (a0 + d0 ) ))) (PreH16 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH17 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH18 : ((a0 + d0 ) = 1)) (PreH19 : (c0 = 0)) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> 0)
|--
  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ ((d0 + a0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (d0 + a0 ) )) ” 
  &&  “ (t0 <= (5 * (d0 + a0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wa0 ) )) ” 
  &&  “ ((d0 + a0 ) = 1) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> a0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
.

Definition switch_modes_return_wit_2 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (d0 <> 0)) (PreH2 : (a0 = 0)) (PreH3 : (0 <= a0)) (PreH4 : (a0 <= 1)) (PreH5 : (0 <= d0)) (PreH6 : (d0 <= 1)) (PreH7 : ((a0 + d0 ) <= 1)) (PreH8 : (wa0 >= 0)) (PreH9 : (wd0 >= 0)) (PreH10 : (0 <= t0)) (PreH11 : (t0 <= 5)) (PreH12 : (0 <= c0)) (PreH13 : (c0 <= 3)) (PreH14 : (c0 <= (3 * (a0 + d0 ) ))) (PreH15 : (t0 <= (5 * (a0 + d0 ) ))) (PreH16 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH17 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH18 : ((a0 + d0 ) = 1)) (PreH19 : (c0 = 0)) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> 1)
|--
  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ ((d0 + a0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (d0 + a0 ) )) ” 
  &&  “ (t0 <= (5 * (d0 + a0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wa0 ) )) ” 
  &&  “ ((d0 + a0 ) = 1) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> a0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
.

Definition switch_modes_partial_solve_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : ((a0 + d0 ) = 1)) (PreH17 : (c0 = 0)) ,
  (UndefStructPredState ( &( "temp" ) ) )
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ ((a0 + d0 ) = 1) ” 
  &&  “ (c0 = 0) ”
  &&  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
.

Definition switch_modes_partial_solve_wit_2 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (d0 = 0)) (PreH2 : (a0 <> 0)) (PreH3 : (0 <= a0)) (PreH4 : (a0 <= 1)) (PreH5 : (0 <= d0)) (PreH6 : (d0 <= 1)) (PreH7 : ((a0 + d0 ) <= 1)) (PreH8 : (wa0 >= 0)) (PreH9 : (wd0 >= 0)) (PreH10 : (0 <= t0)) (PreH11 : (t0 <= 5)) (PreH12 : (0 <= c0)) (PreH13 : (c0 <= 3)) (PreH14 : (c0 <= (3 * (a0 + d0 ) ))) (PreH15 : (t0 <= (5 * (a0 + d0 ) ))) (PreH16 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH17 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH18 : ((a0 + d0 ) = 1)) (PreH19 : (c0 = 0)) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
|--
  “ (d0 = 0) ” 
  &&  “ (a0 <> 0) ” 
  &&  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ ((a0 + d0 ) = 1) ” 
  &&  “ (c0 = 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
.

Definition switch_modes_partial_solve_wit_3 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (d0 <> 0)) (PreH2 : (a0 = 0)) (PreH3 : (0 <= a0)) (PreH4 : (a0 <= 1)) (PreH5 : (0 <= d0)) (PreH6 : (d0 <= 1)) (PreH7 : ((a0 + d0 ) <= 1)) (PreH8 : (wa0 >= 0)) (PreH9 : (wd0 >= 0)) (PreH10 : (0 <= t0)) (PreH11 : (t0 <= 5)) (PreH12 : (0 <= c0)) (PreH13 : (c0 <= 3)) (PreH14 : (c0 <= (3 * (a0 + d0 ) ))) (PreH15 : (t0 <= (5 * (a0 + d0 ) ))) (PreH16 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH17 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH18 : ((a0 + d0 ) = 1)) (PreH19 : (c0 = 0)) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
|--
  “ (d0 <> 0) ” 
  &&  “ (a0 = 0) ” 
  &&  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ ((a0 + d0 ) = 1) ” 
  &&  “ (c0 = 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "temp" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
.

(*----- Function tick -----*)

Definition tick_safety_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : (c0 < INT_MAX)) (PreH17 : (wa0 < INT_MAX)) (PreH18 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_2 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (t0 > 0)) (PreH2 : (0 <= a0)) (PreH3 : (a0 <= 1)) (PreH4 : (0 <= d0)) (PreH5 : (d0 <= 1)) (PreH6 : ((a0 + d0 ) <= 1)) (PreH7 : (wa0 >= 0)) (PreH8 : (wd0 >= 0)) (PreH9 : (0 <= t0)) (PreH10 : (t0 <= 5)) (PreH11 : (0 <= c0)) (PreH12 : (c0 <= 3)) (PreH13 : (c0 <= (3 * (a0 + d0 ) ))) (PreH14 : (t0 <= (5 * (a0 + d0 ) ))) (PreH15 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH16 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH17 : (c0 < INT_MAX)) (PreH18 : (wa0 < INT_MAX)) (PreH19 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (5 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 5) ”
.

Definition tick_safety_wit_3 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (t0 = 5)) (PreH2 : (t0 > 0)) (PreH3 : (0 <= a0)) (PreH4 : (a0 <= 1)) (PreH5 : (0 <= d0)) (PreH6 : (d0 <= 1)) (PreH7 : ((a0 + d0 ) <= 1)) (PreH8 : (wa0 >= 0)) (PreH9 : (wd0 >= 0)) (PreH10 : (0 <= t0)) (PreH11 : (t0 <= 5)) (PreH12 : (0 <= c0)) (PreH13 : (c0 <= 3)) (PreH14 : (c0 <= (3 * (a0 + d0 ) ))) (PreH15 : (t0 <= (5 * (a0 + d0 ) ))) (PreH16 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH17 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH18 : (c0 < INT_MAX)) (PreH19 : (wa0 < INT_MAX)) (PreH20 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_4 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (t0 <> 5)) (PreH2 : (t0 > 0)) (PreH3 : (0 <= a0)) (PreH4 : (a0 <= 1)) (PreH5 : (0 <= d0)) (PreH6 : (d0 <= 1)) (PreH7 : ((a0 + d0 ) <= 1)) (PreH8 : (wa0 >= 0)) (PreH9 : (wd0 >= 0)) (PreH10 : (0 <= t0)) (PreH11 : (t0 <= 5)) (PreH12 : (0 <= c0)) (PreH13 : (c0 <= 3)) (PreH14 : (c0 <= (3 * (a0 + d0 ) ))) (PreH15 : (t0 <= (5 * (a0 + d0 ) ))) (PreH16 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH17 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH18 : (c0 < INT_MAX)) (PreH19 : (wa0 < INT_MAX)) (PreH20 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ ((t0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (t0 + 1 )) ”
.

Definition tick_safety_wit_5 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (t0 <> 5)) (PreH2 : (t0 > 0)) (PreH3 : (0 <= a0)) (PreH4 : (a0 <= 1)) (PreH5 : (0 <= d0)) (PreH6 : (d0 <= 1)) (PreH7 : ((a0 + d0 ) <= 1)) (PreH8 : (wa0 >= 0)) (PreH9 : (wd0 >= 0)) (PreH10 : (0 <= t0)) (PreH11 : (t0 <= 5)) (PreH12 : (0 <= c0)) (PreH13 : (c0 <= 3)) (PreH14 : (c0 <= (3 * (a0 + d0 ) ))) (PreH15 : (t0 <= (5 * (a0 + d0 ) ))) (PreH16 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH17 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH18 : (c0 < INT_MAX)) (PreH19 : (wa0 < INT_MAX)) (PreH20 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_6 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (t0 <= 0)) (PreH2 : (0 <= a0)) (PreH3 : (a0 <= 1)) (PreH4 : (0 <= d0)) (PreH5 : (d0 <= 1)) (PreH6 : ((a0 + d0 ) <= 1)) (PreH7 : (wa0 >= 0)) (PreH8 : (wd0 >= 0)) (PreH9 : (0 <= t0)) (PreH10 : (t0 <= 5)) (PreH11 : (0 <= c0)) (PreH12 : (c0 <= 3)) (PreH13 : (c0 <= (3 * (a0 + d0 ) ))) (PreH14 : (t0 <= (5 * (a0 + d0 ) ))) (PreH15 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH16 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH17 : (c0 < INT_MAX)) (PreH18 : (wa0 < INT_MAX)) (PreH19 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_7 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 = 1)) (PreH2 : (t0 <= 0)) (PreH3 : (0 <= a0)) (PreH4 : (a0 <= 1)) (PreH5 : (0 <= d0)) (PreH6 : (d0 <= 1)) (PreH7 : ((a0 + d0 ) <= 1)) (PreH8 : (wa0 >= 0)) (PreH9 : (wd0 >= 0)) (PreH10 : (0 <= t0)) (PreH11 : (t0 <= 5)) (PreH12 : (0 <= c0)) (PreH13 : (c0 <= 3)) (PreH14 : (c0 <= (3 * (a0 + d0 ) ))) (PreH15 : (t0 <= (5 * (a0 + d0 ) ))) (PreH16 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH17 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH18 : (c0 < INT_MAX)) (PreH19 : (wa0 < INT_MAX)) (PreH20 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_8 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 > 0)) (PreH2 : (a0 = 1)) (PreH3 : (t0 <= 0)) (PreH4 : (0 <= a0)) (PreH5 : (a0 <= 1)) (PreH6 : (0 <= d0)) (PreH7 : (d0 <= 1)) (PreH8 : ((a0 + d0 ) <= 1)) (PreH9 : (wa0 >= 0)) (PreH10 : (wd0 >= 0)) (PreH11 : (0 <= t0)) (PreH12 : (t0 <= 5)) (PreH13 : (0 <= c0)) (PreH14 : (c0 <= 3)) (PreH15 : (c0 <= (3 * (a0 + d0 ) ))) (PreH16 : (t0 <= (5 * (a0 + d0 ) ))) (PreH17 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH18 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH19 : (c0 < INT_MAX)) (PreH20 : (wa0 < INT_MAX)) (PreH21 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (3 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 3) ”
.

Definition tick_safety_wit_9 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (c0 < 3)) (PreH2 : (wa0 > 0)) (PreH3 : (a0 = 1)) (PreH4 : (t0 <= 0)) (PreH5 : (0 <= a0)) (PreH6 : (a0 <= 1)) (PreH7 : (0 <= d0)) (PreH8 : (d0 <= 1)) (PreH9 : ((a0 + d0 ) <= 1)) (PreH10 : (wa0 >= 0)) (PreH11 : (wd0 >= 0)) (PreH12 : (0 <= t0)) (PreH13 : (t0 <= 5)) (PreH14 : (0 <= c0)) (PreH15 : (c0 <= 3)) (PreH16 : (c0 <= (3 * (a0 + d0 ) ))) (PreH17 : (t0 <= (5 * (a0 + d0 ) ))) (PreH18 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH19 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH20 : (c0 < INT_MAX)) (PreH21 : (wa0 < INT_MAX)) (PreH22 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ ((wa0 - 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (wa0 - 1 )) ”
.

Definition tick_safety_wit_10 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (c0 < 3)) (PreH2 : (wa0 > 0)) (PreH3 : (a0 = 1)) (PreH4 : (t0 <= 0)) (PreH5 : (0 <= a0)) (PreH6 : (a0 <= 1)) (PreH7 : (0 <= d0)) (PreH8 : (d0 <= 1)) (PreH9 : ((a0 + d0 ) <= 1)) (PreH10 : (wa0 >= 0)) (PreH11 : (wd0 >= 0)) (PreH12 : (0 <= t0)) (PreH13 : (t0 <= 5)) (PreH14 : (0 <= c0)) (PreH15 : (c0 <= 3)) (PreH16 : (c0 <= (3 * (a0 + d0 ) ))) (PreH17 : (t0 <= (5 * (a0 + d0 ) ))) (PreH18 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH19 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH20 : (c0 < INT_MAX)) (PreH21 : (wa0 < INT_MAX)) (PreH22 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_11 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (c0 < 3)) (PreH2 : (wa0 > 0)) (PreH3 : (a0 = 1)) (PreH4 : (t0 <= 0)) (PreH5 : (0 <= a0)) (PreH6 : (a0 <= 1)) (PreH7 : (0 <= d0)) (PreH8 : (d0 <= 1)) (PreH9 : ((a0 + d0 ) <= 1)) (PreH10 : (wa0 >= 0)) (PreH11 : (wd0 >= 0)) (PreH12 : (0 <= t0)) (PreH13 : (t0 <= 5)) (PreH14 : (0 <= c0)) (PreH15 : (c0 <= 3)) (PreH16 : (c0 <= (3 * (a0 + d0 ) ))) (PreH17 : (t0 <= (5 * (a0 + d0 ) ))) (PreH18 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH19 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH20 : (c0 < INT_MAX)) (PreH21 : (wa0 < INT_MAX)) (PreH22 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_12 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (c0 < 3)) (PreH3 : (wa0 > 0)) (PreH4 : (a0 = 1)) (PreH5 : (t0 <= 0)) (PreH6 : (0 <= a0)) (PreH7 : (a0 <= 1)) (PreH8 : (0 <= d0)) (PreH9 : (d0 <= 1)) (PreH10 : ((a0 + d0 ) <= 1)) (PreH11 : (wa0 >= 0)) (PreH12 : (wd0 >= 0)) (PreH13 : (0 <= t0)) (PreH14 : (t0 <= 5)) (PreH15 : (0 <= c0)) (PreH16 : (c0 <= 3)) (PreH17 : (c0 <= (3 * (a0 + d0 ) ))) (PreH18 : (t0 <= (5 * (a0 + d0 ) ))) (PreH19 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH20 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH21 : (c0 < INT_MAX)) (PreH22 : (wa0 < INT_MAX)) (PreH23 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ ((c0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (c0 + 1 )) ”
.

Definition tick_safety_wit_13 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (c0 < 3)) (PreH3 : (wa0 > 0)) (PreH4 : (a0 = 1)) (PreH5 : (t0 <= 0)) (PreH6 : (0 <= a0)) (PreH7 : (a0 <= 1)) (PreH8 : (0 <= d0)) (PreH9 : (d0 <= 1)) (PreH10 : ((a0 + d0 ) <= 1)) (PreH11 : (wa0 >= 0)) (PreH12 : (wd0 >= 0)) (PreH13 : (0 <= t0)) (PreH14 : (t0 <= 5)) (PreH15 : (0 <= c0)) (PreH16 : (c0 <= 3)) (PreH17 : (c0 <= (3 * (a0 + d0 ) ))) (PreH18 : (t0 <= (5 * (a0 + d0 ) ))) (PreH19 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH20 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH21 : (c0 < INT_MAX)) (PreH22 : (wa0 < INT_MAX)) (PreH23 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_14 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (c0 < 3)) (PreH3 : (wa0 > 0)) (PreH4 : (a0 = 1)) (PreH5 : (t0 <= 0)) (PreH6 : (0 <= a0)) (PreH7 : (a0 <= 1)) (PreH8 : (0 <= d0)) (PreH9 : (d0 <= 1)) (PreH10 : ((a0 + d0 ) <= 1)) (PreH11 : (wa0 >= 0)) (PreH12 : (wd0 >= 0)) (PreH13 : (0 <= t0)) (PreH14 : (t0 <= 5)) (PreH15 : (0 <= c0)) (PreH16 : (c0 <= 3)) (PreH17 : (c0 <= (3 * (a0 + d0 ) ))) (PreH18 : (t0 <= (5 * (a0 + d0 ) ))) (PreH19 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH20 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH21 : (c0 < INT_MAX)) (PreH22 : (wa0 < INT_MAX)) (PreH23 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (c0 + 1 ))
|--
  “ ((t0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (t0 + 1 )) ”
.

Definition tick_safety_wit_15 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (c0 < 3)) (PreH3 : (wa0 > 0)) (PreH4 : (a0 = 1)) (PreH5 : (t0 <= 0)) (PreH6 : (0 <= a0)) (PreH7 : (a0 <= 1)) (PreH8 : (0 <= d0)) (PreH9 : (d0 <= 1)) (PreH10 : ((a0 + d0 ) <= 1)) (PreH11 : (wa0 >= 0)) (PreH12 : (wd0 >= 0)) (PreH13 : (0 <= t0)) (PreH14 : (t0 <= 5)) (PreH15 : (0 <= c0)) (PreH16 : (c0 <= 3)) (PreH17 : (c0 <= (3 * (a0 + d0 ) ))) (PreH18 : (t0 <= (5 * (a0 + d0 ) ))) (PreH19 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH20 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH21 : (c0 < INT_MAX)) (PreH22 : (wa0 < INT_MAX)) (PreH23 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (c0 + 1 ))
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_16 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 <= 0)) (PreH2 : (c0 < 3)) (PreH3 : (wa0 > 0)) (PreH4 : (a0 = 1)) (PreH5 : (t0 <= 0)) (PreH6 : (0 <= a0)) (PreH7 : (a0 <= 1)) (PreH8 : (0 <= d0)) (PreH9 : (d0 <= 1)) (PreH10 : ((a0 + d0 ) <= 1)) (PreH11 : (wa0 >= 0)) (PreH12 : (wd0 >= 0)) (PreH13 : (0 <= t0)) (PreH14 : (t0 <= 5)) (PreH15 : (0 <= c0)) (PreH16 : (c0 <= 3)) (PreH17 : (c0 <= (3 * (a0 + d0 ) ))) (PreH18 : (t0 <= (5 * (a0 + d0 ) ))) (PreH19 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH20 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH21 : (c0 < INT_MAX)) (PreH22 : (wa0 < INT_MAX)) (PreH23 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ ((t0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (t0 + 1 )) ”
.

Definition tick_safety_wit_17 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 <= 0)) (PreH2 : (c0 < 3)) (PreH3 : (wa0 > 0)) (PreH4 : (a0 = 1)) (PreH5 : (t0 <= 0)) (PreH6 : (0 <= a0)) (PreH7 : (a0 <= 1)) (PreH8 : (0 <= d0)) (PreH9 : (d0 <= 1)) (PreH10 : ((a0 + d0 ) <= 1)) (PreH11 : (wa0 >= 0)) (PreH12 : (wd0 >= 0)) (PreH13 : (0 <= t0)) (PreH14 : (t0 <= 5)) (PreH15 : (0 <= c0)) (PreH16 : (c0 <= 3)) (PreH17 : (c0 <= (3 * (a0 + d0 ) ))) (PreH18 : (t0 <= (5 * (a0 + d0 ) ))) (PreH19 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH20 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH21 : (c0 < INT_MAX)) (PreH22 : (wa0 < INT_MAX)) (PreH23 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_18 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (c0 >= 3)) (PreH2 : (wa0 > 0)) (PreH3 : (a0 = 1)) (PreH4 : (t0 <= 0)) (PreH5 : (0 <= a0)) (PreH6 : (a0 <= 1)) (PreH7 : (0 <= d0)) (PreH8 : (d0 <= 1)) (PreH9 : ((a0 + d0 ) <= 1)) (PreH10 : (wa0 >= 0)) (PreH11 : (wd0 >= 0)) (PreH12 : (0 <= t0)) (PreH13 : (t0 <= 5)) (PreH14 : (0 <= c0)) (PreH15 : (c0 <= 3)) (PreH16 : (c0 <= (3 * (a0 + d0 ) ))) (PreH17 : (t0 <= (5 * (a0 + d0 ) ))) (PreH18 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH19 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH20 : (c0 < INT_MAX)) (PreH21 : (wa0 < INT_MAX)) (PreH22 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_19 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 <> 1)) (PreH2 : (t0 <= 0)) (PreH3 : (0 <= a0)) (PreH4 : (a0 <= 1)) (PreH5 : (0 <= d0)) (PreH6 : (d0 <= 1)) (PreH7 : ((a0 + d0 ) <= 1)) (PreH8 : (wa0 >= 0)) (PreH9 : (wd0 >= 0)) (PreH10 : (0 <= t0)) (PreH11 : (t0 <= 5)) (PreH12 : (0 <= c0)) (PreH13 : (c0 <= 3)) (PreH14 : (c0 <= (3 * (a0 + d0 ) ))) (PreH15 : (t0 <= (5 * (a0 + d0 ) ))) (PreH16 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH17 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH18 : (c0 < INT_MAX)) (PreH19 : (wa0 < INT_MAX)) (PreH20 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_20 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 <= 0)) (PreH2 : (a0 = 1)) (PreH3 : (t0 <= 0)) (PreH4 : (0 <= a0)) (PreH5 : (a0 <= 1)) (PreH6 : (0 <= d0)) (PreH7 : (d0 <= 1)) (PreH8 : ((a0 + d0 ) <= 1)) (PreH9 : (wa0 >= 0)) (PreH10 : (wd0 >= 0)) (PreH11 : (0 <= t0)) (PreH12 : (t0 <= 5)) (PreH13 : (0 <= c0)) (PreH14 : (c0 <= 3)) (PreH15 : (c0 <= (3 * (a0 + d0 ) ))) (PreH16 : (t0 <= (5 * (a0 + d0 ) ))) (PreH17 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH18 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH19 : (c0 < INT_MAX)) (PreH20 : (wa0 < INT_MAX)) (PreH21 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_21 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 = 1)) (PreH2 : (c0 >= 3)) (PreH3 : (wa0 > 0)) (PreH4 : (a0 = 1)) (PreH5 : (t0 <= 0)) (PreH6 : (0 <= a0)) (PreH7 : (a0 <= 1)) (PreH8 : (0 <= d0)) (PreH9 : (d0 <= 1)) (PreH10 : ((a0 + d0 ) <= 1)) (PreH11 : (wa0 >= 0)) (PreH12 : (wd0 >= 0)) (PreH13 : (0 <= t0)) (PreH14 : (t0 <= 5)) (PreH15 : (0 <= c0)) (PreH16 : (c0 <= 3)) (PreH17 : (c0 <= (3 * (a0 + d0 ) ))) (PreH18 : (t0 <= (5 * (a0 + d0 ) ))) (PreH19 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH20 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH21 : (c0 < INT_MAX)) (PreH22 : (wa0 < INT_MAX)) (PreH23 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ False ”
.

Definition tick_safety_wit_22 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 = 1)) (PreH2 : (wa0 <= 0)) (PreH3 : (a0 = 1)) (PreH4 : (t0 <= 0)) (PreH5 : (0 <= a0)) (PreH6 : (a0 <= 1)) (PreH7 : (0 <= d0)) (PreH8 : (d0 <= 1)) (PreH9 : ((a0 + d0 ) <= 1)) (PreH10 : (wa0 >= 0)) (PreH11 : (wd0 >= 0)) (PreH12 : (0 <= t0)) (PreH13 : (t0 <= 5)) (PreH14 : (0 <= c0)) (PreH15 : (c0 <= 3)) (PreH16 : (c0 <= (3 * (a0 + d0 ) ))) (PreH17 : (t0 <= (5 * (a0 + d0 ) ))) (PreH18 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH19 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH20 : (c0 < INT_MAX)) (PreH21 : (wa0 < INT_MAX)) (PreH22 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ False ”
.

Definition tick_safety_wit_23 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 = 1)) (PreH2 : (a0 <> 1)) (PreH3 : (t0 <= 0)) (PreH4 : (0 <= a0)) (PreH5 : (a0 <= 1)) (PreH6 : (0 <= d0)) (PreH7 : (d0 <= 1)) (PreH8 : ((a0 + d0 ) <= 1)) (PreH9 : (wa0 >= 0)) (PreH10 : (wd0 >= 0)) (PreH11 : (0 <= t0)) (PreH12 : (t0 <= 5)) (PreH13 : (0 <= c0)) (PreH14 : (c0 <= 3)) (PreH15 : (c0 <= (3 * (a0 + d0 ) ))) (PreH16 : (t0 <= (5 * (a0 + d0 ) ))) (PreH17 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH18 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH19 : (c0 < INT_MAX)) (PreH20 : (wa0 < INT_MAX)) (PreH21 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_24 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (d0 = 1)) (PreH3 : (a0 <> 1)) (PreH4 : (t0 <= 0)) (PreH5 : (0 <= a0)) (PreH6 : (a0 <= 1)) (PreH7 : (0 <= d0)) (PreH8 : (d0 <= 1)) (PreH9 : ((a0 + d0 ) <= 1)) (PreH10 : (wa0 >= 0)) (PreH11 : (wd0 >= 0)) (PreH12 : (0 <= t0)) (PreH13 : (t0 <= 5)) (PreH14 : (0 <= c0)) (PreH15 : (c0 <= 3)) (PreH16 : (c0 <= (3 * (a0 + d0 ) ))) (PreH17 : (t0 <= (5 * (a0 + d0 ) ))) (PreH18 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH19 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH20 : (c0 < INT_MAX)) (PreH21 : (wa0 < INT_MAX)) (PreH22 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (3 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 3) ”
.

Definition tick_safety_wit_25 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (c0 < 3)) (PreH2 : (wd0 > 0)) (PreH3 : (d0 = 1)) (PreH4 : (a0 <> 1)) (PreH5 : (t0 <= 0)) (PreH6 : (0 <= a0)) (PreH7 : (a0 <= 1)) (PreH8 : (0 <= d0)) (PreH9 : (d0 <= 1)) (PreH10 : ((a0 + d0 ) <= 1)) (PreH11 : (wa0 >= 0)) (PreH12 : (wd0 >= 0)) (PreH13 : (0 <= t0)) (PreH14 : (t0 <= 5)) (PreH15 : (0 <= c0)) (PreH16 : (c0 <= 3)) (PreH17 : (c0 <= (3 * (a0 + d0 ) ))) (PreH18 : (t0 <= (5 * (a0 + d0 ) ))) (PreH19 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH20 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH21 : (c0 < INT_MAX)) (PreH22 : (wa0 < INT_MAX)) (PreH23 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ ((wd0 - 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (wd0 - 1 )) ”
.

Definition tick_safety_wit_26 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (c0 < 3)) (PreH2 : (wd0 > 0)) (PreH3 : (d0 = 1)) (PreH4 : (a0 <> 1)) (PreH5 : (t0 <= 0)) (PreH6 : (0 <= a0)) (PreH7 : (a0 <= 1)) (PreH8 : (0 <= d0)) (PreH9 : (d0 <= 1)) (PreH10 : ((a0 + d0 ) <= 1)) (PreH11 : (wa0 >= 0)) (PreH12 : (wd0 >= 0)) (PreH13 : (0 <= t0)) (PreH14 : (t0 <= 5)) (PreH15 : (0 <= c0)) (PreH16 : (c0 <= 3)) (PreH17 : (c0 <= (3 * (a0 + d0 ) ))) (PreH18 : (t0 <= (5 * (a0 + d0 ) ))) (PreH19 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH20 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH21 : (c0 < INT_MAX)) (PreH22 : (wa0 < INT_MAX)) (PreH23 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_27 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (c0 < 3)) (PreH2 : (wd0 > 0)) (PreH3 : (d0 = 1)) (PreH4 : (a0 <> 1)) (PreH5 : (t0 <= 0)) (PreH6 : (0 <= a0)) (PreH7 : (a0 <= 1)) (PreH8 : (0 <= d0)) (PreH9 : (d0 <= 1)) (PreH10 : ((a0 + d0 ) <= 1)) (PreH11 : (wa0 >= 0)) (PreH12 : (wd0 >= 0)) (PreH13 : (0 <= t0)) (PreH14 : (t0 <= 5)) (PreH15 : (0 <= c0)) (PreH16 : (c0 <= 3)) (PreH17 : (c0 <= (3 * (a0 + d0 ) ))) (PreH18 : (t0 <= (5 * (a0 + d0 ) ))) (PreH19 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH20 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH21 : (c0 < INT_MAX)) (PreH22 : (wa0 < INT_MAX)) (PreH23 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_28 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 > 0)) (PreH2 : (c0 < 3)) (PreH3 : (wd0 > 0)) (PreH4 : (d0 = 1)) (PreH5 : (a0 <> 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ ((c0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (c0 + 1 )) ”
.

Definition tick_safety_wit_29 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 > 0)) (PreH2 : (c0 < 3)) (PreH3 : (wd0 > 0)) (PreH4 : (d0 = 1)) (PreH5 : (a0 <> 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_30 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 > 0)) (PreH2 : (c0 < 3)) (PreH3 : (wd0 > 0)) (PreH4 : (d0 = 1)) (PreH5 : (a0 <> 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (c0 + 1 ))
|--
  “ ((t0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (t0 + 1 )) ”
.

Definition tick_safety_wit_31 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 > 0)) (PreH2 : (c0 < 3)) (PreH3 : (wd0 > 0)) (PreH4 : (d0 = 1)) (PreH5 : (a0 <> 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (c0 + 1 ))
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_32 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 <= 0)) (PreH2 : (c0 < 3)) (PreH3 : (wd0 > 0)) (PreH4 : (d0 = 1)) (PreH5 : (a0 <> 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ ((t0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (t0 + 1 )) ”
.

Definition tick_safety_wit_33 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 <= 0)) (PreH2 : (c0 < 3)) (PreH3 : (wd0 > 0)) (PreH4 : (d0 = 1)) (PreH5 : (a0 <> 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_34 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (c0 >= 3)) (PreH2 : (wd0 > 0)) (PreH3 : (d0 = 1)) (PreH4 : (a0 <> 1)) (PreH5 : (t0 <= 0)) (PreH6 : (0 <= a0)) (PreH7 : (a0 <= 1)) (PreH8 : (0 <= d0)) (PreH9 : (d0 <= 1)) (PreH10 : ((a0 + d0 ) <= 1)) (PreH11 : (wa0 >= 0)) (PreH12 : (wd0 >= 0)) (PreH13 : (0 <= t0)) (PreH14 : (t0 <= 5)) (PreH15 : (0 <= c0)) (PreH16 : (c0 <= 3)) (PreH17 : (c0 <= (3 * (a0 + d0 ) ))) (PreH18 : (t0 <= (5 * (a0 + d0 ) ))) (PreH19 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH20 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH21 : (c0 < INT_MAX)) (PreH22 : (wa0 < INT_MAX)) (PreH23 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_35 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 <> 1)) (PreH2 : (wa0 <= 0)) (PreH3 : (a0 = 1)) (PreH4 : (t0 <= 0)) (PreH5 : (0 <= a0)) (PreH6 : (a0 <= 1)) (PreH7 : (0 <= d0)) (PreH8 : (d0 <= 1)) (PreH9 : ((a0 + d0 ) <= 1)) (PreH10 : (wa0 >= 0)) (PreH11 : (wd0 >= 0)) (PreH12 : (0 <= t0)) (PreH13 : (t0 <= 5)) (PreH14 : (0 <= c0)) (PreH15 : (c0 <= 3)) (PreH16 : (c0 <= (3 * (a0 + d0 ) ))) (PreH17 : (t0 <= (5 * (a0 + d0 ) ))) (PreH18 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH19 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH20 : (c0 < INT_MAX)) (PreH21 : (wa0 < INT_MAX)) (PreH22 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_36 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 <> 1)) (PreH2 : (a0 <> 1)) (PreH3 : (t0 <= 0)) (PreH4 : (0 <= a0)) (PreH5 : (a0 <= 1)) (PreH6 : (0 <= d0)) (PreH7 : (d0 <= 1)) (PreH8 : ((a0 + d0 ) <= 1)) (PreH9 : (wa0 >= 0)) (PreH10 : (wd0 >= 0)) (PreH11 : (0 <= t0)) (PreH12 : (t0 <= 5)) (PreH13 : (0 <= c0)) (PreH14 : (c0 <= 3)) (PreH15 : (c0 <= (3 * (a0 + d0 ) ))) (PreH16 : (t0 <= (5 * (a0 + d0 ) ))) (PreH17 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH18 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH19 : (c0 < INT_MAX)) (PreH20 : (wa0 < INT_MAX)) (PreH21 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_37 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 <> 1)) (PreH2 : (c0 >= 3)) (PreH3 : (wa0 > 0)) (PreH4 : (a0 = 1)) (PreH5 : (t0 <= 0)) (PreH6 : (0 <= a0)) (PreH7 : (a0 <= 1)) (PreH8 : (0 <= d0)) (PreH9 : (d0 <= 1)) (PreH10 : ((a0 + d0 ) <= 1)) (PreH11 : (wa0 >= 0)) (PreH12 : (wd0 >= 0)) (PreH13 : (0 <= t0)) (PreH14 : (t0 <= 5)) (PreH15 : (0 <= c0)) (PreH16 : (c0 <= 3)) (PreH17 : (c0 <= (3 * (a0 + d0 ) ))) (PreH18 : (t0 <= (5 * (a0 + d0 ) ))) (PreH19 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH20 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH21 : (c0 < INT_MAX)) (PreH22 : (wa0 < INT_MAX)) (PreH23 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_38 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 <= 0)) (PreH2 : (d0 = 1)) (PreH3 : (a0 <> 1)) (PreH4 : (t0 <= 0)) (PreH5 : (0 <= a0)) (PreH6 : (a0 <= 1)) (PreH7 : (0 <= d0)) (PreH8 : (d0 <= 1)) (PreH9 : ((a0 + d0 ) <= 1)) (PreH10 : (wa0 >= 0)) (PreH11 : (wd0 >= 0)) (PreH12 : (0 <= t0)) (PreH13 : (t0 <= 5)) (PreH14 : (0 <= c0)) (PreH15 : (c0 <= 3)) (PreH16 : (c0 <= (3 * (a0 + d0 ) ))) (PreH17 : (t0 <= (5 * (a0 + d0 ) ))) (PreH18 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH19 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH20 : (c0 < INT_MAX)) (PreH21 : (wa0 < INT_MAX)) (PreH22 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_39 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 = 1)) (PreH2 : (c0 >= 3)) (PreH3 : (wd0 > 0)) (PreH4 : (d0 = 1)) (PreH5 : (a0 <> 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ False ”
.

Definition tick_safety_wit_40 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 <> 1)) (PreH2 : (d0 <> 1)) (PreH3 : (wa0 <= 0)) (PreH4 : (a0 = 1)) (PreH5 : (t0 <= 0)) (PreH6 : (0 <= a0)) (PreH7 : (a0 <= 1)) (PreH8 : (0 <= d0)) (PreH9 : (d0 <= 1)) (PreH10 : ((a0 + d0 ) <= 1)) (PreH11 : (wa0 >= 0)) (PreH12 : (wd0 >= 0)) (PreH13 : (0 <= t0)) (PreH14 : (t0 <= 5)) (PreH15 : (0 <= c0)) (PreH16 : (c0 <= 3)) (PreH17 : (c0 <= (3 * (a0 + d0 ) ))) (PreH18 : (t0 <= (5 * (a0 + d0 ) ))) (PreH19 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH20 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH21 : (c0 < INT_MAX)) (PreH22 : (wa0 < INT_MAX)) (PreH23 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ False ”
.

Definition tick_safety_wit_41 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 = 1)) (PreH2 : (d0 <> 1)) (PreH3 : (a0 <> 1)) (PreH4 : (t0 <= 0)) (PreH5 : (0 <= a0)) (PreH6 : (a0 <= 1)) (PreH7 : (0 <= d0)) (PreH8 : (d0 <= 1)) (PreH9 : ((a0 + d0 ) <= 1)) (PreH10 : (wa0 >= 0)) (PreH11 : (wd0 >= 0)) (PreH12 : (0 <= t0)) (PreH13 : (t0 <= 5)) (PreH14 : (0 <= c0)) (PreH15 : (c0 <= 3)) (PreH16 : (c0 <= (3 * (a0 + d0 ) ))) (PreH17 : (t0 <= (5 * (a0 + d0 ) ))) (PreH18 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH19 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH20 : (c0 < INT_MAX)) (PreH21 : (wa0 < INT_MAX)) (PreH22 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ False ”
.

Definition tick_safety_wit_42 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 <> 1)) (PreH2 : (d0 <> 1)) (PreH3 : (c0 >= 3)) (PreH4 : (wa0 > 0)) (PreH5 : (a0 = 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ False ”
.

Definition tick_safety_wit_43 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 = 1)) (PreH2 : (wd0 <= 0)) (PreH3 : (d0 = 1)) (PreH4 : (a0 <> 1)) (PreH5 : (t0 <= 0)) (PreH6 : (0 <= a0)) (PreH7 : (a0 <= 1)) (PreH8 : (0 <= d0)) (PreH9 : (d0 <= 1)) (PreH10 : ((a0 + d0 ) <= 1)) (PreH11 : (wa0 >= 0)) (PreH12 : (wd0 >= 0)) (PreH13 : (0 <= t0)) (PreH14 : (t0 <= 5)) (PreH15 : (0 <= c0)) (PreH16 : (c0 <= 3)) (PreH17 : (c0 <= (3 * (a0 + d0 ) ))) (PreH18 : (t0 <= (5 * (a0 + d0 ) ))) (PreH19 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH20 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH21 : (c0 < INT_MAX)) (PreH22 : (wa0 < INT_MAX)) (PreH23 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ False ”
.

Definition tick_safety_wit_44 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 = 1)) (PreH2 : (d0 <> 1)) (PreH3 : (wa0 <= 0)) (PreH4 : (a0 = 1)) (PreH5 : (t0 <= 0)) (PreH6 : (0 <= a0)) (PreH7 : (a0 <= 1)) (PreH8 : (0 <= d0)) (PreH9 : (d0 <= 1)) (PreH10 : ((a0 + d0 ) <= 1)) (PreH11 : (wa0 >= 0)) (PreH12 : (wd0 >= 0)) (PreH13 : (0 <= t0)) (PreH14 : (t0 <= 5)) (PreH15 : (0 <= c0)) (PreH16 : (c0 <= 3)) (PreH17 : (c0 <= (3 * (a0 + d0 ) ))) (PreH18 : (t0 <= (5 * (a0 + d0 ) ))) (PreH19 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH20 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH21 : (c0 < INT_MAX)) (PreH22 : (wa0 < INT_MAX)) (PreH23 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_45 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 = 1)) (PreH2 : (d0 <> 1)) (PreH3 : (c0 >= 3)) (PreH4 : (wa0 > 0)) (PreH5 : (a0 = 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_46 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 = 1)) (PreH2 : (d0 <> 1)) (PreH3 : (c0 >= 3)) (PreH4 : (wa0 > 0)) (PreH5 : (a0 = 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_47 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 = 1)) (PreH2 : (d0 <> 1)) (PreH3 : (wa0 <= 0)) (PreH4 : (a0 = 1)) (PreH5 : (t0 <= 0)) (PreH6 : (0 <= a0)) (PreH7 : (a0 <= 1)) (PreH8 : (0 <= d0)) (PreH9 : (d0 <= 1)) (PreH10 : ((a0 + d0 ) <= 1)) (PreH11 : (wa0 >= 0)) (PreH12 : (wd0 >= 0)) (PreH13 : (0 <= t0)) (PreH14 : (t0 <= 5)) (PreH15 : (0 <= c0)) (PreH16 : (c0 <= 3)) (PreH17 : (c0 <= (3 * (a0 + d0 ) ))) (PreH18 : (t0 <= (5 * (a0 + d0 ) ))) (PreH19 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH20 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH21 : (c0 < INT_MAX)) (PreH22 : (wa0 < INT_MAX)) (PreH23 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_48 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 = 0)) (PreH2 : (a0 = 1)) (PreH3 : (d0 <> 1)) (PreH4 : (c0 >= 3)) (PreH5 : (wa0 > 0)) (PreH6 : (a0 = 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ False ”
.

Definition tick_safety_wit_49 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 = 0)) (PreH2 : (a0 = 1)) (PreH3 : (d0 <> 1)) (PreH4 : (wa0 <= 0)) (PreH5 : (a0 = 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ False ”
.

Definition tick_safety_wit_50 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 <> 0)) (PreH2 : (a0 = 1)) (PreH3 : (d0 <> 1)) (PreH4 : (c0 >= 3)) (PreH5 : (wa0 > 0)) (PreH6 : (a0 = 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_51 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 <> 0)) (PreH2 : (a0 = 1)) (PreH3 : (d0 <> 1)) (PreH4 : (wa0 <= 0)) (PreH5 : (a0 = 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_52 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 <> 0)) (PreH2 : (a0 = 1)) (PreH3 : (d0 <> 1)) (PreH4 : (wa0 <= 0)) (PreH5 : (a0 = 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_53 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 <> 0)) (PreH2 : (a0 = 1)) (PreH3 : (d0 <> 1)) (PreH4 : (c0 >= 3)) (PreH5 : (wa0 > 0)) (PreH6 : (a0 = 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_54 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 <> 0)) (PreH2 : (a0 <> 0)) (PreH3 : (a0 = 1)) (PreH4 : (d0 <> 1)) (PreH5 : (wa0 <= 0)) (PreH6 : (a0 = 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ False ”
.

Definition tick_safety_wit_55 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 <> 0)) (PreH2 : (a0 <> 0)) (PreH3 : (a0 = 1)) (PreH4 : (d0 <> 1)) (PreH5 : (c0 >= 3)) (PreH6 : (wa0 > 0)) (PreH7 : (a0 = 1)) (PreH8 : (t0 <= 0)) (PreH9 : (0 <= a0)) (PreH10 : (a0 <= 1)) (PreH11 : (0 <= d0)) (PreH12 : (d0 <= 1)) (PreH13 : ((a0 + d0 ) <= 1)) (PreH14 : (wa0 >= 0)) (PreH15 : (wd0 >= 0)) (PreH16 : (0 <= t0)) (PreH17 : (t0 <= 5)) (PreH18 : (0 <= c0)) (PreH19 : (c0 <= 3)) (PreH20 : (c0 <= (3 * (a0 + d0 ) ))) (PreH21 : (t0 <= (5 * (a0 + d0 ) ))) (PreH22 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH23 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH24 : (c0 < INT_MAX)) (PreH25 : (wa0 < INT_MAX)) (PreH26 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ False ”
.

Definition tick_safety_wit_56 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 = 0)) (PreH2 : (a0 <> 0)) (PreH3 : (a0 = 1)) (PreH4 : (d0 <> 1)) (PreH5 : (wa0 <= 0)) (PreH6 : (a0 = 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_57 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 = 0)) (PreH2 : (a0 <> 0)) (PreH3 : (a0 = 1)) (PreH4 : (d0 <> 1)) (PreH5 : (c0 >= 3)) (PreH6 : (wa0 > 0)) (PreH7 : (a0 = 1)) (PreH8 : (t0 <= 0)) (PreH9 : (0 <= a0)) (PreH10 : (a0 <= 1)) (PreH11 : (0 <= d0)) (PreH12 : (d0 <= 1)) (PreH13 : ((a0 + d0 ) <= 1)) (PreH14 : (wa0 >= 0)) (PreH15 : (wd0 >= 0)) (PreH16 : (0 <= t0)) (PreH17 : (t0 <= 5)) (PreH18 : (0 <= c0)) (PreH19 : (c0 <= 3)) (PreH20 : (c0 <= (3 * (a0 + d0 ) ))) (PreH21 : (t0 <= (5 * (a0 + d0 ) ))) (PreH22 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH23 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH24 : (c0 < INT_MAX)) (PreH25 : (wa0 < INT_MAX)) (PreH26 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_58 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 = 0)) (PreH2 : (a0 <> 0)) (PreH3 : (a0 = 1)) (PreH4 : (d0 <> 1)) (PreH5 : (c0 >= 3)) (PreH6 : (wa0 > 0)) (PreH7 : (a0 = 1)) (PreH8 : (t0 <= 0)) (PreH9 : (0 <= a0)) (PreH10 : (a0 <= 1)) (PreH11 : (0 <= d0)) (PreH12 : (d0 <= 1)) (PreH13 : ((a0 + d0 ) <= 1)) (PreH14 : (wa0 >= 0)) (PreH15 : (wd0 >= 0)) (PreH16 : (0 <= t0)) (PreH17 : (t0 <= 5)) (PreH18 : (0 <= c0)) (PreH19 : (c0 <= 3)) (PreH20 : (c0 <= (3 * (a0 + d0 ) ))) (PreH21 : (t0 <= (5 * (a0 + d0 ) ))) (PreH22 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH23 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH24 : (c0 < INT_MAX)) (PreH25 : (wa0 < INT_MAX)) (PreH26 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_59 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 = 0)) (PreH2 : (a0 <> 0)) (PreH3 : (a0 = 1)) (PreH4 : (d0 <> 1)) (PreH5 : (wa0 <= 0)) (PreH6 : (a0 = 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_60 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 <= 0)) (PreH2 : (d0 = 0)) (PreH3 : (a0 <> 0)) (PreH4 : (a0 = 1)) (PreH5 : (d0 <> 1)) (PreH6 : (c0 >= 3)) (PreH7 : (wa0 > 0)) (PreH8 : (a0 = 1)) (PreH9 : (t0 <= 0)) (PreH10 : (0 <= a0)) (PreH11 : (a0 <= 1)) (PreH12 : (0 <= d0)) (PreH13 : (d0 <= 1)) (PreH14 : ((a0 + d0 ) <= 1)) (PreH15 : (wa0 >= 0)) (PreH16 : (wd0 >= 0)) (PreH17 : (0 <= t0)) (PreH18 : (t0 <= 5)) (PreH19 : (0 <= c0)) (PreH20 : (c0 <= 3)) (PreH21 : (c0 <= (3 * (a0 + d0 ) ))) (PreH22 : (t0 <= (5 * (a0 + d0 ) ))) (PreH23 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH24 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH25 : (c0 < INT_MAX)) (PreH26 : (wa0 < INT_MAX)) (PreH27 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ False ”
.

Definition tick_safety_wit_61 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (d0 = 0)) (PreH3 : (a0 <> 0)) (PreH4 : (a0 = 1)) (PreH5 : (d0 <> 1)) (PreH6 : (c0 >= 3)) (PreH7 : (wa0 > 0)) (PreH8 : (a0 = 1)) (PreH9 : (t0 <= 0)) (PreH10 : (0 <= a0)) (PreH11 : (a0 <= 1)) (PreH12 : (0 <= d0)) (PreH13 : (d0 <= 1)) (PreH14 : ((a0 + d0 ) <= 1)) (PreH15 : (wa0 >= 0)) (PreH16 : (wd0 >= 0)) (PreH17 : (0 <= t0)) (PreH18 : (t0 <= 5)) (PreH19 : (0 <= c0)) (PreH20 : (c0 <= 3)) (PreH21 : (c0 <= (3 * (a0 + d0 ) ))) (PreH22 : (t0 <= (5 * (a0 + d0 ) ))) (PreH23 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH24 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH25 : (c0 < INT_MAX)) (PreH26 : (wa0 < INT_MAX)) (PreH27 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ ((wd0 - 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (wd0 - 1 )) ”
.

Definition tick_safety_wit_62 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (d0 = 0)) (PreH3 : (a0 <> 0)) (PreH4 : (a0 = 1)) (PreH5 : (d0 <> 1)) (PreH6 : (c0 >= 3)) (PreH7 : (wa0 > 0)) (PreH8 : (a0 = 1)) (PreH9 : (t0 <= 0)) (PreH10 : (0 <= a0)) (PreH11 : (a0 <= 1)) (PreH12 : (0 <= d0)) (PreH13 : (d0 <= 1)) (PreH14 : ((a0 + d0 ) <= 1)) (PreH15 : (wa0 >= 0)) (PreH16 : (wd0 >= 0)) (PreH17 : (0 <= t0)) (PreH18 : (t0 <= 5)) (PreH19 : (0 <= c0)) (PreH20 : (c0 <= 3)) (PreH21 : (c0 <= (3 * (a0 + d0 ) ))) (PreH22 : (t0 <= (5 * (a0 + d0 ) ))) (PreH23 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH24 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH25 : (c0 < INT_MAX)) (PreH26 : (wa0 < INT_MAX)) (PreH27 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_63 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (d0 = 0)) (PreH3 : (a0 <> 0)) (PreH4 : (a0 = 1)) (PreH5 : (d0 <> 1)) (PreH6 : (wa0 <= 0)) (PreH7 : (a0 = 1)) (PreH8 : (t0 <= 0)) (PreH9 : (0 <= a0)) (PreH10 : (a0 <= 1)) (PreH11 : (0 <= d0)) (PreH12 : (d0 <= 1)) (PreH13 : ((a0 + d0 ) <= 1)) (PreH14 : (wa0 >= 0)) (PreH15 : (wd0 >= 0)) (PreH16 : (0 <= t0)) (PreH17 : (t0 <= 5)) (PreH18 : (0 <= c0)) (PreH19 : (c0 <= 3)) (PreH20 : (c0 <= (3 * (a0 + d0 ) ))) (PreH21 : (t0 <= (5 * (a0 + d0 ) ))) (PreH22 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH23 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH24 : (c0 < INT_MAX)) (PreH25 : (wa0 < INT_MAX)) (PreH26 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ ((wd0 - 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (wd0 - 1 )) ”
.

Definition tick_safety_wit_64 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (d0 = 0)) (PreH3 : (a0 <> 0)) (PreH4 : (a0 = 1)) (PreH5 : (d0 <> 1)) (PreH6 : (wa0 <= 0)) (PreH7 : (a0 = 1)) (PreH8 : (t0 <= 0)) (PreH9 : (0 <= a0)) (PreH10 : (a0 <= 1)) (PreH11 : (0 <= d0)) (PreH12 : (d0 <= 1)) (PreH13 : ((a0 + d0 ) <= 1)) (PreH14 : (wa0 >= 0)) (PreH15 : (wd0 >= 0)) (PreH16 : (0 <= t0)) (PreH17 : (t0 <= 5)) (PreH18 : (0 <= c0)) (PreH19 : (c0 <= 3)) (PreH20 : (c0 <= (3 * (a0 + d0 ) ))) (PreH21 : (t0 <= (5 * (a0 + d0 ) ))) (PreH22 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH23 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH24 : (c0 < INT_MAX)) (PreH25 : (wa0 < INT_MAX)) (PreH26 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_65 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (d0 = 0)) (PreH3 : (a0 <> 0)) (PreH4 : (a0 = 1)) (PreH5 : (d0 <> 1)) (PreH6 : (wa0 <= 0)) (PreH7 : (a0 = 1)) (PreH8 : (t0 <= 0)) (PreH9 : (0 <= a0)) (PreH10 : (a0 <= 1)) (PreH11 : (0 <= d0)) (PreH12 : (d0 <= 1)) (PreH13 : ((a0 + d0 ) <= 1)) (PreH14 : (wa0 >= 0)) (PreH15 : (wd0 >= 0)) (PreH16 : (0 <= t0)) (PreH17 : (t0 <= 5)) (PreH18 : (0 <= c0)) (PreH19 : (c0 <= 3)) (PreH20 : (c0 <= (3 * (a0 + d0 ) ))) (PreH21 : (t0 <= (5 * (a0 + d0 ) ))) (PreH22 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH23 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH24 : (c0 < INT_MAX)) (PreH25 : (wa0 < INT_MAX)) (PreH26 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_66 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (d0 = 0)) (PreH3 : (a0 <> 0)) (PreH4 : (a0 = 1)) (PreH5 : (d0 <> 1)) (PreH6 : (c0 >= 3)) (PreH7 : (wa0 > 0)) (PreH8 : (a0 = 1)) (PreH9 : (t0 <= 0)) (PreH10 : (0 <= a0)) (PreH11 : (a0 <= 1)) (PreH12 : (0 <= d0)) (PreH13 : (d0 <= 1)) (PreH14 : ((a0 + d0 ) <= 1)) (PreH15 : (wa0 >= 0)) (PreH16 : (wd0 >= 0)) (PreH17 : (0 <= t0)) (PreH18 : (t0 <= 5)) (PreH19 : (0 <= c0)) (PreH20 : (c0 <= 3)) (PreH21 : (c0 <= (3 * (a0 + d0 ) ))) (PreH22 : (t0 <= (5 * (a0 + d0 ) ))) (PreH23 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH24 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH25 : (c0 < INT_MAX)) (PreH26 : (wa0 < INT_MAX)) (PreH27 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_67 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 > 0)) (PreH2 : (wd0 > 0)) (PreH3 : (d0 = 0)) (PreH4 : (a0 <> 0)) (PreH5 : (a0 = 1)) (PreH6 : (d0 <> 1)) (PreH7 : (wa0 <= 0)) (PreH8 : (a0 = 1)) (PreH9 : (t0 <= 0)) (PreH10 : (0 <= a0)) (PreH11 : (a0 <= 1)) (PreH12 : (0 <= d0)) (PreH13 : (d0 <= 1)) (PreH14 : ((a0 + d0 ) <= 1)) (PreH15 : (wa0 >= 0)) (PreH16 : (wd0 >= 0)) (PreH17 : (0 <= t0)) (PreH18 : (t0 <= 5)) (PreH19 : (0 <= c0)) (PreH20 : (c0 <= 3)) (PreH21 : (c0 <= (3 * (a0 + d0 ) ))) (PreH22 : (t0 <= (5 * (a0 + d0 ) ))) (PreH23 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH24 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH25 : (c0 < INT_MAX)) (PreH26 : (wa0 < INT_MAX)) (PreH27 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ False ”
.

Definition tick_safety_wit_68 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 <= 0)) (PreH2 : (wd0 > 0)) (PreH3 : (d0 = 0)) (PreH4 : (a0 <> 0)) (PreH5 : (a0 = 1)) (PreH6 : (d0 <> 1)) (PreH7 : (c0 >= 3)) (PreH8 : (wa0 > 0)) (PreH9 : (a0 = 1)) (PreH10 : (t0 <= 0)) (PreH11 : (0 <= a0)) (PreH12 : (a0 <= 1)) (PreH13 : (0 <= d0)) (PreH14 : (d0 <= 1)) (PreH15 : ((a0 + d0 ) <= 1)) (PreH16 : (wa0 >= 0)) (PreH17 : (wd0 >= 0)) (PreH18 : (0 <= t0)) (PreH19 : (t0 <= 5)) (PreH20 : (0 <= c0)) (PreH21 : (c0 <= 3)) (PreH22 : (c0 <= (3 * (a0 + d0 ) ))) (PreH23 : (t0 <= (5 * (a0 + d0 ) ))) (PreH24 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH25 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH26 : (c0 < INT_MAX)) (PreH27 : (wa0 < INT_MAX)) (PreH28 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ False ”
.

Definition tick_safety_wit_69 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 > 0)) (PreH2 : (wd0 > 0)) (PreH3 : (d0 = 0)) (PreH4 : (a0 <> 0)) (PreH5 : (a0 = 1)) (PreH6 : (d0 <> 1)) (PreH7 : (c0 >= 3)) (PreH8 : (wa0 > 0)) (PreH9 : (a0 = 1)) (PreH10 : (t0 <= 0)) (PreH11 : (0 <= a0)) (PreH12 : (a0 <= 1)) (PreH13 : (0 <= d0)) (PreH14 : (d0 <= 1)) (PreH15 : ((a0 + d0 ) <= 1)) (PreH16 : (wa0 >= 0)) (PreH17 : (wd0 >= 0)) (PreH18 : (0 <= t0)) (PreH19 : (t0 <= 5)) (PreH20 : (0 <= c0)) (PreH21 : (c0 <= 3)) (PreH22 : (c0 <= (3 * (a0 + d0 ) ))) (PreH23 : (t0 <= (5 * (a0 + d0 ) ))) (PreH24 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH25 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH26 : (c0 < INT_MAX)) (PreH27 : (wa0 < INT_MAX)) (PreH28 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ ((0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (0 + 1 )) ”
.

Definition tick_safety_wit_70 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 > 0)) (PreH2 : (wd0 > 0)) (PreH3 : (d0 = 0)) (PreH4 : (a0 <> 0)) (PreH5 : (a0 = 1)) (PreH6 : (d0 <> 1)) (PreH7 : (c0 >= 3)) (PreH8 : (wa0 > 0)) (PreH9 : (a0 = 1)) (PreH10 : (t0 <= 0)) (PreH11 : (0 <= a0)) (PreH12 : (a0 <= 1)) (PreH13 : (0 <= d0)) (PreH14 : (d0 <= 1)) (PreH15 : ((a0 + d0 ) <= 1)) (PreH16 : (wa0 >= 0)) (PreH17 : (wd0 >= 0)) (PreH18 : (0 <= t0)) (PreH19 : (t0 <= 5)) (PreH20 : (0 <= c0)) (PreH21 : (c0 <= 3)) (PreH22 : (c0 <= (3 * (a0 + d0 ) ))) (PreH23 : (t0 <= (5 * (a0 + d0 ) ))) (PreH24 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH25 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH26 : (c0 < INT_MAX)) (PreH27 : (wa0 < INT_MAX)) (PreH28 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_71 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 > 0)) (PreH2 : (wd0 > 0)) (PreH3 : (d0 = 0)) (PreH4 : (a0 <> 0)) (PreH5 : (a0 = 1)) (PreH6 : (d0 <> 1)) (PreH7 : (c0 >= 3)) (PreH8 : (wa0 > 0)) (PreH9 : (a0 = 1)) (PreH10 : (t0 <= 0)) (PreH11 : (0 <= a0)) (PreH12 : (a0 <= 1)) (PreH13 : (0 <= d0)) (PreH14 : (d0 <= 1)) (PreH15 : ((a0 + d0 ) <= 1)) (PreH16 : (wa0 >= 0)) (PreH17 : (wd0 >= 0)) (PreH18 : (0 <= t0)) (PreH19 : (t0 <= 5)) (PreH20 : (0 <= c0)) (PreH21 : (c0 <= 3)) (PreH22 : (c0 <= (3 * (a0 + d0 ) ))) (PreH23 : (t0 <= (5 * (a0 + d0 ) ))) (PreH24 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH25 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH26 : (c0 < INT_MAX)) (PreH27 : (wa0 < INT_MAX)) (PreH28 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (0 + 1 ))
|--
  “ ((t0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (t0 + 1 )) ”
.

Definition tick_safety_wit_72 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 > 0)) (PreH2 : (wd0 > 0)) (PreH3 : (d0 = 0)) (PreH4 : (a0 <> 0)) (PreH5 : (a0 = 1)) (PreH6 : (d0 <> 1)) (PreH7 : (c0 >= 3)) (PreH8 : (wa0 > 0)) (PreH9 : (a0 = 1)) (PreH10 : (t0 <= 0)) (PreH11 : (0 <= a0)) (PreH12 : (a0 <= 1)) (PreH13 : (0 <= d0)) (PreH14 : (d0 <= 1)) (PreH15 : ((a0 + d0 ) <= 1)) (PreH16 : (wa0 >= 0)) (PreH17 : (wd0 >= 0)) (PreH18 : (0 <= t0)) (PreH19 : (t0 <= 5)) (PreH20 : (0 <= c0)) (PreH21 : (c0 <= 3)) (PreH22 : (c0 <= (3 * (a0 + d0 ) ))) (PreH23 : (t0 <= (5 * (a0 + d0 ) ))) (PreH24 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH25 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH26 : (c0 < INT_MAX)) (PreH27 : (wa0 < INT_MAX)) (PreH28 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (0 + 1 ))
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_73 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 <= 0)) (PreH2 : (wd0 > 0)) (PreH3 : (d0 = 0)) (PreH4 : (a0 <> 0)) (PreH5 : (a0 = 1)) (PreH6 : (d0 <> 1)) (PreH7 : (wa0 <= 0)) (PreH8 : (a0 = 1)) (PreH9 : (t0 <= 0)) (PreH10 : (0 <= a0)) (PreH11 : (a0 <= 1)) (PreH12 : (0 <= d0)) (PreH13 : (d0 <= 1)) (PreH14 : ((a0 + d0 ) <= 1)) (PreH15 : (wa0 >= 0)) (PreH16 : (wd0 >= 0)) (PreH17 : (0 <= t0)) (PreH18 : (t0 <= 5)) (PreH19 : (0 <= c0)) (PreH20 : (c0 <= 3)) (PreH21 : (c0 <= (3 * (a0 + d0 ) ))) (PreH22 : (t0 <= (5 * (a0 + d0 ) ))) (PreH23 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH24 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH25 : (c0 < INT_MAX)) (PreH26 : (wa0 < INT_MAX)) (PreH27 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ ((t0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (t0 + 1 )) ”
.

Definition tick_safety_wit_74 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 <= 0)) (PreH2 : (wd0 > 0)) (PreH3 : (d0 = 0)) (PreH4 : (a0 <> 0)) (PreH5 : (a0 = 1)) (PreH6 : (d0 <> 1)) (PreH7 : (wa0 <= 0)) (PreH8 : (a0 = 1)) (PreH9 : (t0 <= 0)) (PreH10 : (0 <= a0)) (PreH11 : (a0 <= 1)) (PreH12 : (0 <= d0)) (PreH13 : (d0 <= 1)) (PreH14 : ((a0 + d0 ) <= 1)) (PreH15 : (wa0 >= 0)) (PreH16 : (wd0 >= 0)) (PreH17 : (0 <= t0)) (PreH18 : (t0 <= 5)) (PreH19 : (0 <= c0)) (PreH20 : (c0 <= 3)) (PreH21 : (c0 <= (3 * (a0 + d0 ) ))) (PreH22 : (t0 <= (5 * (a0 + d0 ) ))) (PreH23 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH24 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH25 : (c0 < INT_MAX)) (PreH26 : (wa0 < INT_MAX)) (PreH27 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_75 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 <> 1)) (PreH2 : (wd0 <= 0)) (PreH3 : (d0 = 1)) (PreH4 : (a0 <> 1)) (PreH5 : (t0 <= 0)) (PreH6 : (0 <= a0)) (PreH7 : (a0 <= 1)) (PreH8 : (0 <= d0)) (PreH9 : (d0 <= 1)) (PreH10 : ((a0 + d0 ) <= 1)) (PreH11 : (wa0 >= 0)) (PreH12 : (wd0 >= 0)) (PreH13 : (0 <= t0)) (PreH14 : (t0 <= 5)) (PreH15 : (0 <= c0)) (PreH16 : (c0 <= 3)) (PreH17 : (c0 <= (3 * (a0 + d0 ) ))) (PreH18 : (t0 <= (5 * (a0 + d0 ) ))) (PreH19 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH20 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH21 : (c0 < INT_MAX)) (PreH22 : (wa0 < INT_MAX)) (PreH23 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_76 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 <> 1)) (PreH2 : (d0 <> 1)) (PreH3 : (a0 <> 1)) (PreH4 : (t0 <= 0)) (PreH5 : (0 <= a0)) (PreH6 : (a0 <= 1)) (PreH7 : (0 <= d0)) (PreH8 : (d0 <= 1)) (PreH9 : ((a0 + d0 ) <= 1)) (PreH10 : (wa0 >= 0)) (PreH11 : (wd0 >= 0)) (PreH12 : (0 <= t0)) (PreH13 : (t0 <= 5)) (PreH14 : (0 <= c0)) (PreH15 : (c0 <= 3)) (PreH16 : (c0 <= (3 * (a0 + d0 ) ))) (PreH17 : (t0 <= (5 * (a0 + d0 ) ))) (PreH18 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH19 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH20 : (c0 < INT_MAX)) (PreH21 : (wa0 < INT_MAX)) (PreH22 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_77 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 <> 1)) (PreH2 : (c0 >= 3)) (PreH3 : (wd0 > 0)) (PreH4 : (d0 = 1)) (PreH5 : (a0 <> 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_78 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 <> 1)) (PreH2 : (a0 <> 1)) (PreH3 : (wd0 <= 0)) (PreH4 : (d0 = 1)) (PreH5 : (a0 <> 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ False ”
.

Definition tick_safety_wit_79 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 = 1)) (PreH2 : (a0 <> 1)) (PreH3 : (d0 <> 1)) (PreH4 : (a0 <> 1)) (PreH5 : (t0 <= 0)) (PreH6 : (0 <= a0)) (PreH7 : (a0 <= 1)) (PreH8 : (0 <= d0)) (PreH9 : (d0 <= 1)) (PreH10 : ((a0 + d0 ) <= 1)) (PreH11 : (wa0 >= 0)) (PreH12 : (wd0 >= 0)) (PreH13 : (0 <= t0)) (PreH14 : (t0 <= 5)) (PreH15 : (0 <= c0)) (PreH16 : (c0 <= 3)) (PreH17 : (c0 <= (3 * (a0 + d0 ) ))) (PreH18 : (t0 <= (5 * (a0 + d0 ) ))) (PreH19 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH20 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH21 : (c0 < INT_MAX)) (PreH22 : (wa0 < INT_MAX)) (PreH23 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ False ”
.

Definition tick_safety_wit_80 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 <> 1)) (PreH2 : (a0 <> 1)) (PreH3 : (c0 >= 3)) (PreH4 : (wd0 > 0)) (PreH5 : (d0 = 1)) (PreH6 : (a0 <> 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ False ”
.

Definition tick_safety_wit_81 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 = 1)) (PreH2 : (a0 <> 1)) (PreH3 : (wd0 <= 0)) (PreH4 : (d0 = 1)) (PreH5 : (a0 <> 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_82 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 = 1)) (PreH2 : (a0 <> 1)) (PreH3 : (c0 >= 3)) (PreH4 : (wd0 > 0)) (PreH5 : (d0 = 1)) (PreH6 : (a0 <> 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_83 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 = 1)) (PreH2 : (a0 <> 1)) (PreH3 : (c0 >= 3)) (PreH4 : (wd0 > 0)) (PreH5 : (d0 = 1)) (PreH6 : (a0 <> 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_84 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 = 1)) (PreH2 : (a0 <> 1)) (PreH3 : (wd0 <= 0)) (PreH4 : (d0 = 1)) (PreH5 : (a0 <> 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_85 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 <> 0)) (PreH2 : (d0 = 1)) (PreH3 : (a0 <> 1)) (PreH4 : (c0 >= 3)) (PreH5 : (wd0 > 0)) (PreH6 : (d0 = 1)) (PreH7 : (a0 <> 1)) (PreH8 : (t0 <= 0)) (PreH9 : (0 <= a0)) (PreH10 : (a0 <= 1)) (PreH11 : (0 <= d0)) (PreH12 : (d0 <= 1)) (PreH13 : ((a0 + d0 ) <= 1)) (PreH14 : (wa0 >= 0)) (PreH15 : (wd0 >= 0)) (PreH16 : (0 <= t0)) (PreH17 : (t0 <= 5)) (PreH18 : (0 <= c0)) (PreH19 : (c0 <= 3)) (PreH20 : (c0 <= (3 * (a0 + d0 ) ))) (PreH21 : (t0 <= (5 * (a0 + d0 ) ))) (PreH22 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH23 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH24 : (c0 < INT_MAX)) (PreH25 : (wa0 < INT_MAX)) (PreH26 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ False ”
.

Definition tick_safety_wit_86 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 <> 0)) (PreH2 : (d0 = 1)) (PreH3 : (a0 <> 1)) (PreH4 : (wd0 <= 0)) (PreH5 : (d0 = 1)) (PreH6 : (a0 <> 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ False ”
.

Definition tick_safety_wit_87 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 = 0)) (PreH2 : (d0 = 1)) (PreH3 : (a0 <> 1)) (PreH4 : (c0 >= 3)) (PreH5 : (wd0 > 0)) (PreH6 : (d0 = 1)) (PreH7 : (a0 <> 1)) (PreH8 : (t0 <= 0)) (PreH9 : (0 <= a0)) (PreH10 : (a0 <= 1)) (PreH11 : (0 <= d0)) (PreH12 : (d0 <= 1)) (PreH13 : ((a0 + d0 ) <= 1)) (PreH14 : (wa0 >= 0)) (PreH15 : (wd0 >= 0)) (PreH16 : (0 <= t0)) (PreH17 : (t0 <= 5)) (PreH18 : (0 <= c0)) (PreH19 : (c0 <= 3)) (PreH20 : (c0 <= (3 * (a0 + d0 ) ))) (PreH21 : (t0 <= (5 * (a0 + d0 ) ))) (PreH22 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH23 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH24 : (c0 < INT_MAX)) (PreH25 : (wa0 < INT_MAX)) (PreH26 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_88 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 = 0)) (PreH2 : (d0 = 1)) (PreH3 : (a0 <> 1)) (PreH4 : (wd0 <= 0)) (PreH5 : (d0 = 1)) (PreH6 : (a0 <> 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_89 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 = 0)) (PreH2 : (d0 = 1)) (PreH3 : (a0 <> 1)) (PreH4 : (wd0 <= 0)) (PreH5 : (d0 = 1)) (PreH6 : (a0 <> 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_90 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (a0 = 0)) (PreH2 : (d0 = 1)) (PreH3 : (a0 <> 1)) (PreH4 : (c0 >= 3)) (PreH5 : (wd0 > 0)) (PreH6 : (d0 = 1)) (PreH7 : (a0 <> 1)) (PreH8 : (t0 <= 0)) (PreH9 : (0 <= a0)) (PreH10 : (a0 <= 1)) (PreH11 : (0 <= d0)) (PreH12 : (d0 <= 1)) (PreH13 : ((a0 + d0 ) <= 1)) (PreH14 : (wa0 >= 0)) (PreH15 : (wd0 >= 0)) (PreH16 : (0 <= t0)) (PreH17 : (t0 <= 5)) (PreH18 : (0 <= c0)) (PreH19 : (c0 <= 3)) (PreH20 : (c0 <= (3 * (a0 + d0 ) ))) (PreH21 : (t0 <= (5 * (a0 + d0 ) ))) (PreH22 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH23 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH24 : (c0 < INT_MAX)) (PreH25 : (wa0 < INT_MAX)) (PreH26 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_91 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 = 0)) (PreH2 : (a0 = 0)) (PreH3 : (d0 = 1)) (PreH4 : (a0 <> 1)) (PreH5 : (wd0 <= 0)) (PreH6 : (d0 = 1)) (PreH7 : (a0 <> 1)) (PreH8 : (t0 <= 0)) (PreH9 : (0 <= a0)) (PreH10 : (a0 <= 1)) (PreH11 : (0 <= d0)) (PreH12 : (d0 <= 1)) (PreH13 : ((a0 + d0 ) <= 1)) (PreH14 : (wa0 >= 0)) (PreH15 : (wd0 >= 0)) (PreH16 : (0 <= t0)) (PreH17 : (t0 <= 5)) (PreH18 : (0 <= c0)) (PreH19 : (c0 <= 3)) (PreH20 : (c0 <= (3 * (a0 + d0 ) ))) (PreH21 : (t0 <= (5 * (a0 + d0 ) ))) (PreH22 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH23 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH24 : (c0 < INT_MAX)) (PreH25 : (wa0 < INT_MAX)) (PreH26 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ False ”
.

Definition tick_safety_wit_92 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 = 0)) (PreH2 : (a0 = 0)) (PreH3 : (d0 = 1)) (PreH4 : (a0 <> 1)) (PreH5 : (c0 >= 3)) (PreH6 : (wd0 > 0)) (PreH7 : (d0 = 1)) (PreH8 : (a0 <> 1)) (PreH9 : (t0 <= 0)) (PreH10 : (0 <= a0)) (PreH11 : (a0 <= 1)) (PreH12 : (0 <= d0)) (PreH13 : (d0 <= 1)) (PreH14 : ((a0 + d0 ) <= 1)) (PreH15 : (wa0 >= 0)) (PreH16 : (wd0 >= 0)) (PreH17 : (0 <= t0)) (PreH18 : (t0 <= 5)) (PreH19 : (0 <= c0)) (PreH20 : (c0 <= 3)) (PreH21 : (c0 <= (3 * (a0 + d0 ) ))) (PreH22 : (t0 <= (5 * (a0 + d0 ) ))) (PreH23 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH24 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH25 : (c0 < INT_MAX)) (PreH26 : (wa0 < INT_MAX)) (PreH27 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ False ”
.

Definition tick_safety_wit_93 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 <> 0)) (PreH2 : (a0 = 0)) (PreH3 : (d0 = 1)) (PreH4 : (a0 <> 1)) (PreH5 : (wd0 <= 0)) (PreH6 : (d0 = 1)) (PreH7 : (a0 <> 1)) (PreH8 : (t0 <= 0)) (PreH9 : (0 <= a0)) (PreH10 : (a0 <= 1)) (PreH11 : (0 <= d0)) (PreH12 : (d0 <= 1)) (PreH13 : ((a0 + d0 ) <= 1)) (PreH14 : (wa0 >= 0)) (PreH15 : (wd0 >= 0)) (PreH16 : (0 <= t0)) (PreH17 : (t0 <= 5)) (PreH18 : (0 <= c0)) (PreH19 : (c0 <= 3)) (PreH20 : (c0 <= (3 * (a0 + d0 ) ))) (PreH21 : (t0 <= (5 * (a0 + d0 ) ))) (PreH22 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH23 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH24 : (c0 < INT_MAX)) (PreH25 : (wa0 < INT_MAX)) (PreH26 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_94 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 <> 0)) (PreH2 : (a0 = 0)) (PreH3 : (d0 = 1)) (PreH4 : (a0 <> 1)) (PreH5 : (c0 >= 3)) (PreH6 : (wd0 > 0)) (PreH7 : (d0 = 1)) (PreH8 : (a0 <> 1)) (PreH9 : (t0 <= 0)) (PreH10 : (0 <= a0)) (PreH11 : (a0 <= 1)) (PreH12 : (0 <= d0)) (PreH13 : (d0 <= 1)) (PreH14 : ((a0 + d0 ) <= 1)) (PreH15 : (wa0 >= 0)) (PreH16 : (wd0 >= 0)) (PreH17 : (0 <= t0)) (PreH18 : (t0 <= 5)) (PreH19 : (0 <= c0)) (PreH20 : (c0 <= 3)) (PreH21 : (c0 <= (3 * (a0 + d0 ) ))) (PreH22 : (t0 <= (5 * (a0 + d0 ) ))) (PreH23 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH24 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH25 : (c0 < INT_MAX)) (PreH26 : (wa0 < INT_MAX)) (PreH27 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_95 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 <> 0)) (PreH2 : (a0 = 0)) (PreH3 : (d0 = 1)) (PreH4 : (a0 <> 1)) (PreH5 : (c0 >= 3)) (PreH6 : (wd0 > 0)) (PreH7 : (d0 = 1)) (PreH8 : (a0 <> 1)) (PreH9 : (t0 <= 0)) (PreH10 : (0 <= a0)) (PreH11 : (a0 <= 1)) (PreH12 : (0 <= d0)) (PreH13 : (d0 <= 1)) (PreH14 : ((a0 + d0 ) <= 1)) (PreH15 : (wa0 >= 0)) (PreH16 : (wd0 >= 0)) (PreH17 : (0 <= t0)) (PreH18 : (t0 <= 5)) (PreH19 : (0 <= c0)) (PreH20 : (c0 <= 3)) (PreH21 : (c0 <= (3 * (a0 + d0 ) ))) (PreH22 : (t0 <= (5 * (a0 + d0 ) ))) (PreH23 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH24 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH25 : (c0 < INT_MAX)) (PreH26 : (wa0 < INT_MAX)) (PreH27 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_96 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 <> 0)) (PreH2 : (a0 = 0)) (PreH3 : (d0 = 1)) (PreH4 : (a0 <> 1)) (PreH5 : (wd0 <= 0)) (PreH6 : (d0 = 1)) (PreH7 : (a0 <> 1)) (PreH8 : (t0 <= 0)) (PreH9 : (0 <= a0)) (PreH10 : (a0 <= 1)) (PreH11 : (0 <= d0)) (PreH12 : (d0 <= 1)) (PreH13 : ((a0 + d0 ) <= 1)) (PreH14 : (wa0 >= 0)) (PreH15 : (wd0 >= 0)) (PreH16 : (0 <= t0)) (PreH17 : (t0 <= 5)) (PreH18 : (0 <= c0)) (PreH19 : (c0 <= 3)) (PreH20 : (c0 <= (3 * (a0 + d0 ) ))) (PreH21 : (t0 <= (5 * (a0 + d0 ) ))) (PreH22 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH23 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH24 : (c0 < INT_MAX)) (PreH25 : (wa0 < INT_MAX)) (PreH26 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_97 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 <= 0)) (PreH2 : (d0 <> 0)) (PreH3 : (a0 = 0)) (PreH4 : (d0 = 1)) (PreH5 : (a0 <> 1)) (PreH6 : (c0 >= 3)) (PreH7 : (wd0 > 0)) (PreH8 : (d0 = 1)) (PreH9 : (a0 <> 1)) (PreH10 : (t0 <= 0)) (PreH11 : (0 <= a0)) (PreH12 : (a0 <= 1)) (PreH13 : (0 <= d0)) (PreH14 : (d0 <= 1)) (PreH15 : ((a0 + d0 ) <= 1)) (PreH16 : (wa0 >= 0)) (PreH17 : (wd0 >= 0)) (PreH18 : (0 <= t0)) (PreH19 : (t0 <= 5)) (PreH20 : (0 <= c0)) (PreH21 : (c0 <= 3)) (PreH22 : (c0 <= (3 * (a0 + d0 ) ))) (PreH23 : (t0 <= (5 * (a0 + d0 ) ))) (PreH24 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH25 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH26 : (c0 < INT_MAX)) (PreH27 : (wa0 < INT_MAX)) (PreH28 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ False ”
.

Definition tick_safety_wit_98 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 > 0)) (PreH2 : (d0 <> 0)) (PreH3 : (a0 = 0)) (PreH4 : (d0 = 1)) (PreH5 : (a0 <> 1)) (PreH6 : (c0 >= 3)) (PreH7 : (wd0 > 0)) (PreH8 : (d0 = 1)) (PreH9 : (a0 <> 1)) (PreH10 : (t0 <= 0)) (PreH11 : (0 <= a0)) (PreH12 : (a0 <= 1)) (PreH13 : (0 <= d0)) (PreH14 : (d0 <= 1)) (PreH15 : ((a0 + d0 ) <= 1)) (PreH16 : (wa0 >= 0)) (PreH17 : (wd0 >= 0)) (PreH18 : (0 <= t0)) (PreH19 : (t0 <= 5)) (PreH20 : (0 <= c0)) (PreH21 : (c0 <= 3)) (PreH22 : (c0 <= (3 * (a0 + d0 ) ))) (PreH23 : (t0 <= (5 * (a0 + d0 ) ))) (PreH24 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH25 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH26 : (c0 < INT_MAX)) (PreH27 : (wa0 < INT_MAX)) (PreH28 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ ((wa0 - 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (wa0 - 1 )) ”
.

Definition tick_safety_wit_99 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 > 0)) (PreH2 : (d0 <> 0)) (PreH3 : (a0 = 0)) (PreH4 : (d0 = 1)) (PreH5 : (a0 <> 1)) (PreH6 : (c0 >= 3)) (PreH7 : (wd0 > 0)) (PreH8 : (d0 = 1)) (PreH9 : (a0 <> 1)) (PreH10 : (t0 <= 0)) (PreH11 : (0 <= a0)) (PreH12 : (a0 <= 1)) (PreH13 : (0 <= d0)) (PreH14 : (d0 <= 1)) (PreH15 : ((a0 + d0 ) <= 1)) (PreH16 : (wa0 >= 0)) (PreH17 : (wd0 >= 0)) (PreH18 : (0 <= t0)) (PreH19 : (t0 <= 5)) (PreH20 : (0 <= c0)) (PreH21 : (c0 <= 3)) (PreH22 : (c0 <= (3 * (a0 + d0 ) ))) (PreH23 : (t0 <= (5 * (a0 + d0 ) ))) (PreH24 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH25 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH26 : (c0 < INT_MAX)) (PreH27 : (wa0 < INT_MAX)) (PreH28 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_100 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 > 0)) (PreH2 : (d0 <> 0)) (PreH3 : (a0 = 0)) (PreH4 : (d0 = 1)) (PreH5 : (a0 <> 1)) (PreH6 : (wd0 <= 0)) (PreH7 : (d0 = 1)) (PreH8 : (a0 <> 1)) (PreH9 : (t0 <= 0)) (PreH10 : (0 <= a0)) (PreH11 : (a0 <= 1)) (PreH12 : (0 <= d0)) (PreH13 : (d0 <= 1)) (PreH14 : ((a0 + d0 ) <= 1)) (PreH15 : (wa0 >= 0)) (PreH16 : (wd0 >= 0)) (PreH17 : (0 <= t0)) (PreH18 : (t0 <= 5)) (PreH19 : (0 <= c0)) (PreH20 : (c0 <= 3)) (PreH21 : (c0 <= (3 * (a0 + d0 ) ))) (PreH22 : (t0 <= (5 * (a0 + d0 ) ))) (PreH23 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH24 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH25 : (c0 < INT_MAX)) (PreH26 : (wa0 < INT_MAX)) (PreH27 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ ((wa0 - 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (wa0 - 1 )) ”
.

Definition tick_safety_wit_101 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 > 0)) (PreH2 : (d0 <> 0)) (PreH3 : (a0 = 0)) (PreH4 : (d0 = 1)) (PreH5 : (a0 <> 1)) (PreH6 : (wd0 <= 0)) (PreH7 : (d0 = 1)) (PreH8 : (a0 <> 1)) (PreH9 : (t0 <= 0)) (PreH10 : (0 <= a0)) (PreH11 : (a0 <= 1)) (PreH12 : (0 <= d0)) (PreH13 : (d0 <= 1)) (PreH14 : ((a0 + d0 ) <= 1)) (PreH15 : (wa0 >= 0)) (PreH16 : (wd0 >= 0)) (PreH17 : (0 <= t0)) (PreH18 : (t0 <= 5)) (PreH19 : (0 <= c0)) (PreH20 : (c0 <= 3)) (PreH21 : (c0 <= (3 * (a0 + d0 ) ))) (PreH22 : (t0 <= (5 * (a0 + d0 ) ))) (PreH23 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH24 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH25 : (c0 < INT_MAX)) (PreH26 : (wa0 < INT_MAX)) (PreH27 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_102 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 > 0)) (PreH2 : (d0 <> 0)) (PreH3 : (a0 = 0)) (PreH4 : (d0 = 1)) (PreH5 : (a0 <> 1)) (PreH6 : (wd0 <= 0)) (PreH7 : (d0 = 1)) (PreH8 : (a0 <> 1)) (PreH9 : (t0 <= 0)) (PreH10 : (0 <= a0)) (PreH11 : (a0 <= 1)) (PreH12 : (0 <= d0)) (PreH13 : (d0 <= 1)) (PreH14 : ((a0 + d0 ) <= 1)) (PreH15 : (wa0 >= 0)) (PreH16 : (wd0 >= 0)) (PreH17 : (0 <= t0)) (PreH18 : (t0 <= 5)) (PreH19 : (0 <= c0)) (PreH20 : (c0 <= 3)) (PreH21 : (c0 <= (3 * (a0 + d0 ) ))) (PreH22 : (t0 <= (5 * (a0 + d0 ) ))) (PreH23 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH24 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH25 : (c0 < INT_MAX)) (PreH26 : (wa0 < INT_MAX)) (PreH27 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_103 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 > 0)) (PreH2 : (d0 <> 0)) (PreH3 : (a0 = 0)) (PreH4 : (d0 = 1)) (PreH5 : (a0 <> 1)) (PreH6 : (c0 >= 3)) (PreH7 : (wd0 > 0)) (PreH8 : (d0 = 1)) (PreH9 : (a0 <> 1)) (PreH10 : (t0 <= 0)) (PreH11 : (0 <= a0)) (PreH12 : (a0 <= 1)) (PreH13 : (0 <= d0)) (PreH14 : (d0 <= 1)) (PreH15 : ((a0 + d0 ) <= 1)) (PreH16 : (wa0 >= 0)) (PreH17 : (wd0 >= 0)) (PreH18 : (0 <= t0)) (PreH19 : (t0 <= 5)) (PreH20 : (0 <= c0)) (PreH21 : (c0 <= 3)) (PreH22 : (c0 <= (3 * (a0 + d0 ) ))) (PreH23 : (t0 <= (5 * (a0 + d0 ) ))) (PreH24 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH25 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH26 : (c0 < INT_MAX)) (PreH27 : (wa0 < INT_MAX)) (PreH28 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_104 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (wa0 > 0)) (PreH3 : (d0 <> 0)) (PreH4 : (a0 = 0)) (PreH5 : (d0 = 1)) (PreH6 : (a0 <> 1)) (PreH7 : (wd0 <= 0)) (PreH8 : (d0 = 1)) (PreH9 : (a0 <> 1)) (PreH10 : (t0 <= 0)) (PreH11 : (0 <= a0)) (PreH12 : (a0 <= 1)) (PreH13 : (0 <= d0)) (PreH14 : (d0 <= 1)) (PreH15 : ((a0 + d0 ) <= 1)) (PreH16 : (wa0 >= 0)) (PreH17 : (wd0 >= 0)) (PreH18 : (0 <= t0)) (PreH19 : (t0 <= 5)) (PreH20 : (0 <= c0)) (PreH21 : (c0 <= 3)) (PreH22 : (c0 <= (3 * (a0 + d0 ) ))) (PreH23 : (t0 <= (5 * (a0 + d0 ) ))) (PreH24 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH25 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH26 : (c0 < INT_MAX)) (PreH27 : (wa0 < INT_MAX)) (PreH28 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ False ”
.

Definition tick_safety_wit_105 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 <= 0)) (PreH2 : (wa0 > 0)) (PreH3 : (d0 <> 0)) (PreH4 : (a0 = 0)) (PreH5 : (d0 = 1)) (PreH6 : (a0 <> 1)) (PreH7 : (c0 >= 3)) (PreH8 : (wd0 > 0)) (PreH9 : (d0 = 1)) (PreH10 : (a0 <> 1)) (PreH11 : (t0 <= 0)) (PreH12 : (0 <= a0)) (PreH13 : (a0 <= 1)) (PreH14 : (0 <= d0)) (PreH15 : (d0 <= 1)) (PreH16 : ((a0 + d0 ) <= 1)) (PreH17 : (wa0 >= 0)) (PreH18 : (wd0 >= 0)) (PreH19 : (0 <= t0)) (PreH20 : (t0 <= 5)) (PreH21 : (0 <= c0)) (PreH22 : (c0 <= 3)) (PreH23 : (c0 <= (3 * (a0 + d0 ) ))) (PreH24 : (t0 <= (5 * (a0 + d0 ) ))) (PreH25 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH26 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH27 : (c0 < INT_MAX)) (PreH28 : (wa0 < INT_MAX)) (PreH29 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ False ”
.

Definition tick_safety_wit_106 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (wa0 > 0)) (PreH3 : (d0 <> 0)) (PreH4 : (a0 = 0)) (PreH5 : (d0 = 1)) (PreH6 : (a0 <> 1)) (PreH7 : (c0 >= 3)) (PreH8 : (wd0 > 0)) (PreH9 : (d0 = 1)) (PreH10 : (a0 <> 1)) (PreH11 : (t0 <= 0)) (PreH12 : (0 <= a0)) (PreH13 : (a0 <= 1)) (PreH14 : (0 <= d0)) (PreH15 : (d0 <= 1)) (PreH16 : ((a0 + d0 ) <= 1)) (PreH17 : (wa0 >= 0)) (PreH18 : (wd0 >= 0)) (PreH19 : (0 <= t0)) (PreH20 : (t0 <= 5)) (PreH21 : (0 <= c0)) (PreH22 : (c0 <= 3)) (PreH23 : (c0 <= (3 * (a0 + d0 ) ))) (PreH24 : (t0 <= (5 * (a0 + d0 ) ))) (PreH25 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH26 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH27 : (c0 < INT_MAX)) (PreH28 : (wa0 < INT_MAX)) (PreH29 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ ((0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (0 + 1 )) ”
.

Definition tick_safety_wit_107 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (wa0 > 0)) (PreH3 : (d0 <> 0)) (PreH4 : (a0 = 0)) (PreH5 : (d0 = 1)) (PreH6 : (a0 <> 1)) (PreH7 : (c0 >= 3)) (PreH8 : (wd0 > 0)) (PreH9 : (d0 = 1)) (PreH10 : (a0 <> 1)) (PreH11 : (t0 <= 0)) (PreH12 : (0 <= a0)) (PreH13 : (a0 <= 1)) (PreH14 : (0 <= d0)) (PreH15 : (d0 <= 1)) (PreH16 : ((a0 + d0 ) <= 1)) (PreH17 : (wa0 >= 0)) (PreH18 : (wd0 >= 0)) (PreH19 : (0 <= t0)) (PreH20 : (t0 <= 5)) (PreH21 : (0 <= c0)) (PreH22 : (c0 <= 3)) (PreH23 : (c0 <= (3 * (a0 + d0 ) ))) (PreH24 : (t0 <= (5 * (a0 + d0 ) ))) (PreH25 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH26 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH27 : (c0 < INT_MAX)) (PreH28 : (wa0 < INT_MAX)) (PreH29 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_108 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (wa0 > 0)) (PreH3 : (d0 <> 0)) (PreH4 : (a0 = 0)) (PreH5 : (d0 = 1)) (PreH6 : (a0 <> 1)) (PreH7 : (c0 >= 3)) (PreH8 : (wd0 > 0)) (PreH9 : (d0 = 1)) (PreH10 : (a0 <> 1)) (PreH11 : (t0 <= 0)) (PreH12 : (0 <= a0)) (PreH13 : (a0 <= 1)) (PreH14 : (0 <= d0)) (PreH15 : (d0 <= 1)) (PreH16 : ((a0 + d0 ) <= 1)) (PreH17 : (wa0 >= 0)) (PreH18 : (wd0 >= 0)) (PreH19 : (0 <= t0)) (PreH20 : (t0 <= 5)) (PreH21 : (0 <= c0)) (PreH22 : (c0 <= 3)) (PreH23 : (c0 <= (3 * (a0 + d0 ) ))) (PreH24 : (t0 <= (5 * (a0 + d0 ) ))) (PreH25 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH26 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH27 : (c0 < INT_MAX)) (PreH28 : (wa0 < INT_MAX)) (PreH29 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (0 + 1 ))
|--
  “ ((t0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (t0 + 1 )) ”
.

Definition tick_safety_wit_109 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (wa0 > 0)) (PreH3 : (d0 <> 0)) (PreH4 : (a0 = 0)) (PreH5 : (d0 = 1)) (PreH6 : (a0 <> 1)) (PreH7 : (c0 >= 3)) (PreH8 : (wd0 > 0)) (PreH9 : (d0 = 1)) (PreH10 : (a0 <> 1)) (PreH11 : (t0 <= 0)) (PreH12 : (0 <= a0)) (PreH13 : (a0 <= 1)) (PreH14 : (0 <= d0)) (PreH15 : (d0 <= 1)) (PreH16 : ((a0 + d0 ) <= 1)) (PreH17 : (wa0 >= 0)) (PreH18 : (wd0 >= 0)) (PreH19 : (0 <= t0)) (PreH20 : (t0 <= 5)) (PreH21 : (0 <= c0)) (PreH22 : (c0 <= 3)) (PreH23 : (c0 <= (3 * (a0 + d0 ) ))) (PreH24 : (t0 <= (5 * (a0 + d0 ) ))) (PreH25 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH26 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH27 : (c0 < INT_MAX)) (PreH28 : (wa0 < INT_MAX)) (PreH29 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (0 + 1 ))
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_110 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 <= 0)) (PreH2 : (wa0 > 0)) (PreH3 : (d0 <> 0)) (PreH4 : (a0 = 0)) (PreH5 : (d0 = 1)) (PreH6 : (a0 <> 1)) (PreH7 : (wd0 <= 0)) (PreH8 : (d0 = 1)) (PreH9 : (a0 <> 1)) (PreH10 : (t0 <= 0)) (PreH11 : (0 <= a0)) (PreH12 : (a0 <= 1)) (PreH13 : (0 <= d0)) (PreH14 : (d0 <= 1)) (PreH15 : ((a0 + d0 ) <= 1)) (PreH16 : (wa0 >= 0)) (PreH17 : (wd0 >= 0)) (PreH18 : (0 <= t0)) (PreH19 : (t0 <= 5)) (PreH20 : (0 <= c0)) (PreH21 : (c0 <= 3)) (PreH22 : (c0 <= (3 * (a0 + d0 ) ))) (PreH23 : (t0 <= (5 * (a0 + d0 ) ))) (PreH24 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH25 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH26 : (c0 < INT_MAX)) (PreH27 : (wa0 < INT_MAX)) (PreH28 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ ((t0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (t0 + 1 )) ”
.

Definition tick_safety_wit_111 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 <= 0)) (PreH2 : (wa0 > 0)) (PreH3 : (d0 <> 0)) (PreH4 : (a0 = 0)) (PreH5 : (d0 = 1)) (PreH6 : (a0 <> 1)) (PreH7 : (wd0 <= 0)) (PreH8 : (d0 = 1)) (PreH9 : (a0 <> 1)) (PreH10 : (t0 <= 0)) (PreH11 : (0 <= a0)) (PreH12 : (a0 <= 1)) (PreH13 : (0 <= d0)) (PreH14 : (d0 <= 1)) (PreH15 : ((a0 + d0 ) <= 1)) (PreH16 : (wa0 >= 0)) (PreH17 : (wd0 >= 0)) (PreH18 : (0 <= t0)) (PreH19 : (t0 <= 5)) (PreH20 : (0 <= c0)) (PreH21 : (c0 <= 3)) (PreH22 : (c0 <= (3 * (a0 + d0 ) ))) (PreH23 : (t0 <= (5 * (a0 + d0 ) ))) (PreH24 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH25 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH26 : (c0 < INT_MAX)) (PreH27 : (wa0 < INT_MAX)) (PreH28 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_112 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (d0 <> 1)) (PreH2 : (a0 <> 1)) (PreH3 : (d0 <> 1)) (PreH4 : (a0 <> 1)) (PreH5 : (t0 <= 0)) (PreH6 : (0 <= a0)) (PreH7 : (a0 <= 1)) (PreH8 : (0 <= d0)) (PreH9 : (d0 <= 1)) (PreH10 : ((a0 + d0 ) <= 1)) (PreH11 : (wa0 >= 0)) (PreH12 : (wd0 >= 0)) (PreH13 : (0 <= t0)) (PreH14 : (t0 <= 5)) (PreH15 : (0 <= c0)) (PreH16 : (c0 <= 3)) (PreH17 : (c0 <= (3 * (a0 + d0 ) ))) (PreH18 : (t0 <= (5 * (a0 + d0 ) ))) (PreH19 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH20 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH21 : (c0 < INT_MAX)) (PreH22 : (wa0 < INT_MAX)) (PreH23 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_113 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 > 0)) (PreH2 : (d0 <> 1)) (PreH3 : (a0 <> 1)) (PreH4 : (d0 <> 1)) (PreH5 : (a0 <> 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_114 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 > 0)) (PreH2 : (d0 <> 1)) (PreH3 : (a0 <> 1)) (PreH4 : (d0 <> 1)) (PreH5 : (a0 <> 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ ((wa0 - 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (wa0 - 1 )) ”
.

Definition tick_safety_wit_115 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 > 0)) (PreH2 : (d0 <> 1)) (PreH3 : (a0 <> 1)) (PreH4 : (d0 <> 1)) (PreH5 : (a0 <> 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_116 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 > 0)) (PreH2 : (d0 <> 1)) (PreH3 : (a0 <> 1)) (PreH4 : (d0 <> 1)) (PreH5 : (a0 <> 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_117 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (wa0 > 0)) (PreH3 : (d0 <> 1)) (PreH4 : (a0 <> 1)) (PreH5 : (d0 <> 1)) (PreH6 : (a0 <> 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ ((c0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (c0 + 1 )) ”
.

Definition tick_safety_wit_118 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (wa0 > 0)) (PreH3 : (d0 <> 1)) (PreH4 : (a0 <> 1)) (PreH5 : (d0 <> 1)) (PreH6 : (a0 <> 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_119 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (wa0 > 0)) (PreH3 : (d0 <> 1)) (PreH4 : (a0 <> 1)) (PreH5 : (d0 <> 1)) (PreH6 : (a0 <> 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (c0 + 1 ))
|--
  “ ((t0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (t0 + 1 )) ”
.

Definition tick_safety_wit_120 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (wa0 > 0)) (PreH3 : (d0 <> 1)) (PreH4 : (a0 <> 1)) (PreH5 : (d0 <> 1)) (PreH6 : (a0 <> 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (c0 + 1 ))
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_121 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 <= 0)) (PreH2 : (wa0 > 0)) (PreH3 : (d0 <> 1)) (PreH4 : (a0 <> 1)) (PreH5 : (d0 <> 1)) (PreH6 : (a0 <> 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ ((t0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (t0 + 1 )) ”
.

Definition tick_safety_wit_122 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 <= 0)) (PreH2 : (wa0 > 0)) (PreH3 : (d0 <> 1)) (PreH4 : (a0 <> 1)) (PreH5 : (d0 <> 1)) (PreH6 : (a0 <> 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_123 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 <= 0)) (PreH2 : (d0 <> 1)) (PreH3 : (a0 <> 1)) (PreH4 : (d0 <> 1)) (PreH5 : (a0 <> 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_124 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (wa0 <= 0)) (PreH3 : (d0 <> 1)) (PreH4 : (a0 <> 1)) (PreH5 : (d0 <> 1)) (PreH6 : (a0 <> 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_125 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (wa0 <= 0)) (PreH3 : (d0 <> 1)) (PreH4 : (a0 <> 1)) (PreH5 : (d0 <> 1)) (PreH6 : (a0 <> 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ ((wd0 - 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (wd0 - 1 )) ”
.

Definition tick_safety_wit_126 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (wa0 <= 0)) (PreH3 : (d0 <> 1)) (PreH4 : (a0 <> 1)) (PreH5 : (d0 <> 1)) (PreH6 : (a0 <> 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_127 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 > 0)) (PreH2 : (wa0 <= 0)) (PreH3 : (d0 <> 1)) (PreH4 : (a0 <> 1)) (PreH5 : (d0 <> 1)) (PreH6 : (a0 <> 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition tick_safety_wit_128 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 > 0)) (PreH2 : (wd0 > 0)) (PreH3 : (wa0 <= 0)) (PreH4 : (d0 <> 1)) (PreH5 : (a0 <> 1)) (PreH6 : (d0 <> 1)) (PreH7 : (a0 <> 1)) (PreH8 : (t0 <= 0)) (PreH9 : (0 <= a0)) (PreH10 : (a0 <= 1)) (PreH11 : (0 <= d0)) (PreH12 : (d0 <= 1)) (PreH13 : ((a0 + d0 ) <= 1)) (PreH14 : (wa0 >= 0)) (PreH15 : (wd0 >= 0)) (PreH16 : (0 <= t0)) (PreH17 : (t0 <= 5)) (PreH18 : (0 <= c0)) (PreH19 : (c0 <= 3)) (PreH20 : (c0 <= (3 * (a0 + d0 ) ))) (PreH21 : (t0 <= (5 * (a0 + d0 ) ))) (PreH22 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH23 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH24 : (c0 < INT_MAX)) (PreH25 : (wa0 < INT_MAX)) (PreH26 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ False ”
.

Definition tick_safety_wit_129 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 <= 0)) (PreH2 : (wd0 > 0)) (PreH3 : (wa0 <= 0)) (PreH4 : (d0 <> 1)) (PreH5 : (a0 <> 1)) (PreH6 : (d0 <> 1)) (PreH7 : (a0 <> 1)) (PreH8 : (t0 <= 0)) (PreH9 : (0 <= a0)) (PreH10 : (a0 <= 1)) (PreH11 : (0 <= d0)) (PreH12 : (d0 <= 1)) (PreH13 : ((a0 + d0 ) <= 1)) (PreH14 : (wa0 >= 0)) (PreH15 : (wd0 >= 0)) (PreH16 : (0 <= t0)) (PreH17 : (t0 <= 5)) (PreH18 : (0 <= c0)) (PreH19 : (c0 <= 3)) (PreH20 : (c0 <= (3 * (a0 + d0 ) ))) (PreH21 : (t0 <= (5 * (a0 + d0 ) ))) (PreH22 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH23 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH24 : (c0 < INT_MAX)) (PreH25 : (wa0 < INT_MAX)) (PreH26 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ ((t0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (t0 + 1 )) ”
.

Definition tick_safety_wit_130 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wa0 <= 0)) (PreH2 : (wd0 > 0)) (PreH3 : (wa0 <= 0)) (PreH4 : (d0 <> 1)) (PreH5 : (a0 <> 1)) (PreH6 : (d0 <> 1)) (PreH7 : (a0 <> 1)) (PreH8 : (t0 <= 0)) (PreH9 : (0 <= a0)) (PreH10 : (a0 <= 1)) (PreH11 : (0 <= d0)) (PreH12 : (d0 <= 1)) (PreH13 : ((a0 + d0 ) <= 1)) (PreH14 : (wa0 >= 0)) (PreH15 : (wd0 >= 0)) (PreH16 : (0 <= t0)) (PreH17 : (t0 <= 5)) (PreH18 : (0 <= c0)) (PreH19 : (c0 <= 3)) (PreH20 : (c0 <= (3 * (a0 + d0 ) ))) (PreH21 : (t0 <= (5 * (a0 + d0 ) ))) (PreH22 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH23 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH24 : (c0 < INT_MAX)) (PreH25 : (wa0 < INT_MAX)) (PreH26 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_safety_wit_131 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (wd0 <= 0)) (PreH2 : (wa0 <= 0)) (PreH3 : (d0 <> 1)) (PreH4 : (a0 <> 1)) (PreH5 : (d0 <> 1)) (PreH6 : (a0 <> 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((( &( "s" ) )) # Ptr  |-> ( &( "s" ) ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition tick_return_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wd0 <= 0)) (PreH2 : (wa0 <= 0)) (PreH3 : (d0 <> 1)) (PreH4 : (a0 <> 1)) (PreH5 : (d0 <> 1)) (PreH6 : (a0 <> 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> 1)
|--
  (EX (retval_Plane_Counter: Z)  (retval_Runway_Time: Z)  (retval_W_D: Z)  (retval_W_A: Z)  (retval_ModeD: Z)  (retval_ModeA: Z) ,
  “ (0 <= retval_ModeA) ” 
  &&  “ (retval_ModeA <= 1) ” 
  &&  “ (0 <= retval_ModeD) ” 
  &&  “ (retval_ModeD <= 1) ” 
  &&  “ ((retval_ModeA + retval_ModeD ) <= 1) ” 
  &&  “ (retval_W_A >= 0) ” 
  &&  “ (retval_W_D >= 0) ” 
  &&  “ (0 <= retval_Runway_Time) ” 
  &&  “ (retval_Runway_Time <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter) ” 
  &&  “ (retval_Plane_Counter <= 3) ” 
  &&  “ (retval_Plane_Counter <= (3 * (retval_ModeA + retval_ModeD ) )) ” 
  &&  “ (retval_Runway_Time <= (5 * (retval_ModeA + retval_ModeD ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - retval_ModeA ) + retval_W_D ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - retval_ModeD ) + retval_W_A ) )) ” 
  &&  “ (retval_ModeA = 1) ” 
  &&  “ (wd0 <= 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter))
  ||
  (EX (retval_Plane_Counter_13: Z)  (retval_Runway_Time_13: Z)  (retval_W_D_13: Z)  (retval_W_A_13: Z)  (retval_ModeD_13: Z)  (retval_ModeA_13: Z) ,
  “ (0 <= retval_ModeA_13) ” 
  &&  “ (retval_ModeA_13 <= 1) ” 
  &&  “ (0 <= retval_ModeD_13) ” 
  &&  “ (retval_ModeD_13 <= 1) ” 
  &&  “ ((retval_ModeA_13 + retval_ModeD_13 ) <= 1) ” 
  &&  “ (retval_W_A_13 >= 0) ” 
  &&  “ (retval_W_D_13 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_13) ” 
  &&  “ (retval_Runway_Time_13 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_13) ” 
  &&  “ (retval_Plane_Counter_13 <= 3) ” 
  &&  “ (retval_Plane_Counter_13 <= (3 * (retval_ModeA_13 + retval_ModeD_13 ) )) ” 
  &&  “ (retval_Runway_Time_13 <= (5 * (retval_ModeA_13 + retval_ModeD_13 ) )) ” 
  &&  “ (retval_Plane_Counter_13 <= (3 * ((1 - retval_ModeA_13 ) + retval_W_D_13 ) )) ” 
  &&  “ (retval_Plane_Counter_13 <= (3 * ((1 - retval_ModeD_13 ) + retval_W_A_13 ) )) ” 
  &&  “ (wa0 <= 0) ” 
  &&  “ (wd0 <= 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_13)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_13)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_13)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_13)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_13)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_13))
  ||
  (EX (retval_Plane_Counter_16: Z)  (retval_Runway_Time_16: Z)  (retval_W_D_16: Z)  (retval_W_A_16: Z)  (retval_ModeD_16: Z)  (retval_ModeA_16: Z) ,
  “ (0 <= retval_ModeA_16) ” 
  &&  “ (retval_ModeA_16 <= 1) ” 
  &&  “ (0 <= retval_ModeD_16) ” 
  &&  “ (retval_ModeD_16 <= 1) ” 
  &&  “ ((retval_ModeA_16 + retval_ModeD_16 ) <= 1) ” 
  &&  “ (retval_W_A_16 >= 0) ” 
  &&  “ (retval_W_D_16 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_16) ” 
  &&  “ (retval_Runway_Time_16 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_16) ” 
  &&  “ (retval_Plane_Counter_16 <= 3) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * (retval_ModeA_16 + retval_ModeD_16 ) )) ” 
  &&  “ (retval_Runway_Time_16 <= (5 * (retval_ModeA_16 + retval_ModeD_16 ) )) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * ((1 - retval_ModeA_16 ) + retval_W_D_16 ) )) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * ((1 - retval_ModeD_16 ) + retval_W_A_16 ) )) ” 
  &&  “ (wa0 <= 0) ” 
  &&  “ (retval_ModeD_16 = 1) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_16)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_16)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_16)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_16)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_16)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_16))
.

Definition tick_return_wit_2 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wa0 <= 0)) (PreH2 : (wd0 > 0)) (PreH3 : (wa0 <= 0)) (PreH4 : (d0 <> 1)) (PreH5 : (a0 <> 1)) (PreH6 : (d0 <> 1)) (PreH7 : (a0 <> 1)) (PreH8 : (t0 <= 0)) (PreH9 : (0 <= a0)) (PreH10 : (a0 <= 1)) (PreH11 : (0 <= d0)) (PreH12 : (d0 <= 1)) (PreH13 : ((a0 + d0 ) <= 1)) (PreH14 : (wa0 >= 0)) (PreH15 : (wd0 >= 0)) (PreH16 : (0 <= t0)) (PreH17 : (t0 <= 5)) (PreH18 : (0 <= c0)) (PreH19 : (c0 <= 3)) (PreH20 : (c0 <= (3 * (a0 + d0 ) ))) (PreH21 : (t0 <= (5 * (a0 + d0 ) ))) (PreH22 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH23 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH24 : (c0 < INT_MAX)) (PreH25 : (wa0 < INT_MAX)) (PreH26 : (wd0 < INT_MAX)) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> a0)
|--
  (EX (retval_Plane_Counter_12: Z)  (retval_Runway_Time_12: Z)  (retval_W_D_12: Z)  (retval_W_A_12: Z)  (retval_ModeD_12: Z)  (retval_ModeA_12: Z) ,
  “ (0 <= retval_ModeA_12) ” 
  &&  “ (retval_ModeA_12 <= 1) ” 
  &&  “ (0 <= retval_ModeD_12) ” 
  &&  “ (retval_ModeD_12 <= 1) ” 
  &&  “ ((retval_ModeA_12 + retval_ModeD_12 ) <= 1) ” 
  &&  “ (retval_W_A_12 >= 0) ” 
  &&  “ (retval_W_D_12 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_12) ” 
  &&  “ (retval_Runway_Time_12 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_12) ” 
  &&  “ (retval_Plane_Counter_12 <= 3) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * (retval_ModeA_12 + retval_ModeD_12 ) )) ” 
  &&  “ (retval_Runway_Time_12 <= (5 * (retval_ModeA_12 + retval_ModeD_12 ) )) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * ((1 - retval_ModeA_12 ) + retval_W_D_12 ) )) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * ((1 - retval_ModeD_12 ) + retval_W_A_12 ) )) ” 
  &&  “ (wd0 <> 0) ” 
  &&  “ (retval_ModeD_12 = 1) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_12)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_12)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_12)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_12)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_12)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_12))
  ||
  (EX (retval_Plane_Counter_16: Z)  (retval_Runway_Time_16: Z)  (retval_W_D_16: Z)  (retval_W_A_16: Z)  (retval_ModeD_16: Z)  (retval_ModeA_16: Z) ,
  “ (0 <= retval_ModeA_16) ” 
  &&  “ (retval_ModeA_16 <= 1) ” 
  &&  “ (0 <= retval_ModeD_16) ” 
  &&  “ (retval_ModeD_16 <= 1) ” 
  &&  “ ((retval_ModeA_16 + retval_ModeD_16 ) <= 1) ” 
  &&  “ (retval_W_A_16 >= 0) ” 
  &&  “ (retval_W_D_16 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_16) ” 
  &&  “ (retval_Runway_Time_16 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_16) ” 
  &&  “ (retval_Plane_Counter_16 <= 3) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * (retval_ModeA_16 + retval_ModeD_16 ) )) ” 
  &&  “ (retval_Runway_Time_16 <= (5 * (retval_ModeA_16 + retval_ModeD_16 ) )) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * ((1 - retval_ModeA_16 ) + retval_W_D_16 ) )) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * ((1 - retval_ModeD_16 ) + retval_W_A_16 ) )) ” 
  &&  “ (wa0 <= 0) ” 
  &&  “ (retval_ModeD_16 = 1) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_16)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_16)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_16)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_16)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_16)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_16))
.

Definition tick_return_wit_3 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wd0 > 0)) (PreH2 : (wa0 > 0)) (PreH3 : (d0 <> 1)) (PreH4 : (a0 <> 1)) (PreH5 : (d0 <> 1)) (PreH6 : (a0 <> 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> (c0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> 1)
|--
  (EX (retval_Plane_Counter_2: Z)  (retval_Runway_Time_2: Z)  (retval_W_D_2: Z)  (retval_W_A_2: Z)  (retval_ModeD_2: Z)  (retval_ModeA_2: Z) ,
  “ (0 <= retval_ModeA_2) ” 
  &&  “ (retval_ModeA_2 <= 1) ” 
  &&  “ (0 <= retval_ModeD_2) ” 
  &&  “ (retval_ModeD_2 <= 1) ” 
  &&  “ ((retval_ModeA_2 + retval_ModeD_2 ) <= 1) ” 
  &&  “ (retval_W_A_2 >= 0) ” 
  &&  “ (retval_W_D_2 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_2) ” 
  &&  “ (retval_Runway_Time_2 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_2) ” 
  &&  “ (retval_Plane_Counter_2 <= 3) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * (retval_ModeA_2 + retval_ModeD_2 ) )) ” 
  &&  “ (retval_Runway_Time_2 <= (5 * (retval_ModeA_2 + retval_ModeD_2 ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - retval_ModeA_2 ) + retval_W_D_2 ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - retval_ModeD_2 ) + retval_W_A_2 ) )) ” 
  &&  “ (retval_ModeA_2 = 1) ” 
  &&  “ (wa0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_2)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_2)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_2)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_2)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_2)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_2))
  ||
  (EX (retval_Plane_Counter_10: Z)  (retval_Runway_Time_10: Z)  (retval_W_D_10: Z)  (retval_W_A_10: Z)  (retval_ModeD_10: Z)  (retval_ModeA_10: Z) ,
  “ (0 <= retval_ModeA_10) ” 
  &&  “ (retval_ModeA_10 <= 1) ” 
  &&  “ (0 <= retval_ModeD_10) ” 
  &&  “ (retval_ModeD_10 <= 1) ” 
  &&  “ ((retval_ModeA_10 + retval_ModeD_10 ) <= 1) ” 
  &&  “ (retval_W_A_10 >= 0) ” 
  &&  “ (retval_W_D_10 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_10) ” 
  &&  “ (retval_Runway_Time_10 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_10) ” 
  &&  “ (retval_Plane_Counter_10 <= 3) ” 
  &&  “ (retval_Plane_Counter_10 <= (3 * (retval_ModeA_10 + retval_ModeD_10 ) )) ” 
  &&  “ (retval_Runway_Time_10 <= (5 * (retval_ModeA_10 + retval_ModeD_10 ) )) ” 
  &&  “ (retval_Plane_Counter_10 <= (3 * ((1 - retval_ModeA_10 ) + retval_W_D_10 ) )) ” 
  &&  “ (retval_Plane_Counter_10 <= (3 * ((1 - retval_ModeD_10 ) + retval_W_A_10 ) )) ” 
  &&  “ (wd0 <> 0) ” 
  &&  “ (wa0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_10)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_10)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_10)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_10)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_10)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_10))
  ||
  (EX (retval_Plane_Counter_12: Z)  (retval_Runway_Time_12: Z)  (retval_W_D_12: Z)  (retval_W_A_12: Z)  (retval_ModeD_12: Z)  (retval_ModeA_12: Z) ,
  “ (0 <= retval_ModeA_12) ” 
  &&  “ (retval_ModeA_12 <= 1) ” 
  &&  “ (0 <= retval_ModeD_12) ” 
  &&  “ (retval_ModeD_12 <= 1) ” 
  &&  “ ((retval_ModeA_12 + retval_ModeD_12 ) <= 1) ” 
  &&  “ (retval_W_A_12 >= 0) ” 
  &&  “ (retval_W_D_12 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_12) ” 
  &&  “ (retval_Runway_Time_12 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_12) ” 
  &&  “ (retval_Plane_Counter_12 <= 3) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * (retval_ModeA_12 + retval_ModeD_12 ) )) ” 
  &&  “ (retval_Runway_Time_12 <= (5 * (retval_ModeA_12 + retval_ModeD_12 ) )) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * ((1 - retval_ModeA_12 ) + retval_W_D_12 ) )) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * ((1 - retval_ModeD_12 ) + retval_W_A_12 ) )) ” 
  &&  “ (wd0 <> 0) ” 
  &&  “ (retval_ModeD_12 = 1) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_12)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_12)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_12)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_12)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_12)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_12))
.

Definition tick_return_wit_4 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wd0 <= 0)) (PreH2 : (wa0 > 0)) (PreH3 : (d0 <> 1)) (PreH4 : (a0 <> 1)) (PreH5 : (d0 <> 1)) (PreH6 : (a0 <> 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> 1)
|--
  (EX (retval_Plane_Counter: Z)  (retval_Runway_Time: Z)  (retval_W_D: Z)  (retval_W_A: Z)  (retval_ModeD: Z)  (retval_ModeA: Z) ,
  “ (0 <= retval_ModeA) ” 
  &&  “ (retval_ModeA <= 1) ” 
  &&  “ (0 <= retval_ModeD) ” 
  &&  “ (retval_ModeD <= 1) ” 
  &&  “ ((retval_ModeA + retval_ModeD ) <= 1) ” 
  &&  “ (retval_W_A >= 0) ” 
  &&  “ (retval_W_D >= 0) ” 
  &&  “ (0 <= retval_Runway_Time) ” 
  &&  “ (retval_Runway_Time <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter) ” 
  &&  “ (retval_Plane_Counter <= 3) ” 
  &&  “ (retval_Plane_Counter <= (3 * (retval_ModeA + retval_ModeD ) )) ” 
  &&  “ (retval_Runway_Time <= (5 * (retval_ModeA + retval_ModeD ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - retval_ModeA ) + retval_W_D ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - retval_ModeD ) + retval_W_A ) )) ” 
  &&  “ (retval_ModeA = 1) ” 
  &&  “ (wd0 <= 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter))
  ||
  (EX (retval_Plane_Counter_2: Z)  (retval_Runway_Time_2: Z)  (retval_W_D_2: Z)  (retval_W_A_2: Z)  (retval_ModeD_2: Z)  (retval_ModeA_2: Z) ,
  “ (0 <= retval_ModeA_2) ” 
  &&  “ (retval_ModeA_2 <= 1) ” 
  &&  “ (0 <= retval_ModeD_2) ” 
  &&  “ (retval_ModeD_2 <= 1) ” 
  &&  “ ((retval_ModeA_2 + retval_ModeD_2 ) <= 1) ” 
  &&  “ (retval_W_A_2 >= 0) ” 
  &&  “ (retval_W_D_2 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_2) ” 
  &&  “ (retval_Runway_Time_2 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_2) ” 
  &&  “ (retval_Plane_Counter_2 <= 3) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * (retval_ModeA_2 + retval_ModeD_2 ) )) ” 
  &&  “ (retval_Runway_Time_2 <= (5 * (retval_ModeA_2 + retval_ModeD_2 ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - retval_ModeA_2 ) + retval_W_D_2 ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - retval_ModeD_2 ) + retval_W_A_2 ) )) ” 
  &&  “ (retval_ModeA_2 = 1) ” 
  &&  “ (wa0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_2)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_2)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_2)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_2)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_2)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_2))
.

Definition tick_return_wit_5 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wd0 > 0)) (PreH2 : (wa0 > 0)) (PreH3 : (d0 <> 0)) (PreH4 : (a0 = 0)) (PreH5 : (d0 = 1)) (PreH6 : (a0 <> 1)) (PreH7 : (c0 >= 3)) (PreH8 : (wd0 > 0)) (PreH9 : (d0 = 1)) (PreH10 : (a0 <> 1)) (PreH11 : (t0 <= 0)) (PreH12 : (0 <= a0)) (PreH13 : (a0 <= 1)) (PreH14 : (0 <= d0)) (PreH15 : (d0 <= 1)) (PreH16 : ((a0 + d0 ) <= 1)) (PreH17 : (wa0 >= 0)) (PreH18 : (wd0 >= 0)) (PreH19 : (0 <= t0)) (PreH20 : (t0 <= 5)) (PreH21 : (0 <= c0)) (PreH22 : (c0 <= 3)) (PreH23 : (c0 <= (3 * (a0 + d0 ) ))) (PreH24 : (t0 <= (5 * (a0 + d0 ) ))) (PreH25 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH26 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH27 : (c0 < INT_MAX)) (PreH28 : (wa0 < INT_MAX)) (PreH29 : (wd0 < INT_MAX)) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> (0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> 1)
|--
  (EX (retval_Plane_Counter_2: Z)  (retval_Runway_Time_2: Z)  (retval_W_D_2: Z)  (retval_W_A_2: Z)  (retval_ModeD_2: Z)  (retval_ModeA_2: Z) ,
  “ (0 <= retval_ModeA_2) ” 
  &&  “ (retval_ModeA_2 <= 1) ” 
  &&  “ (0 <= retval_ModeD_2) ” 
  &&  “ (retval_ModeD_2 <= 1) ” 
  &&  “ ((retval_ModeA_2 + retval_ModeD_2 ) <= 1) ” 
  &&  “ (retval_W_A_2 >= 0) ” 
  &&  “ (retval_W_D_2 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_2) ” 
  &&  “ (retval_Runway_Time_2 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_2) ” 
  &&  “ (retval_Plane_Counter_2 <= 3) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * (retval_ModeA_2 + retval_ModeD_2 ) )) ” 
  &&  “ (retval_Runway_Time_2 <= (5 * (retval_ModeA_2 + retval_ModeD_2 ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - retval_ModeA_2 ) + retval_W_D_2 ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - retval_ModeD_2 ) + retval_W_A_2 ) )) ” 
  &&  “ (retval_ModeA_2 = 1) ” 
  &&  “ (wa0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_2)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_2)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_2)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_2)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_2)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_2))
  ||
  (EX (retval_Plane_Counter_10: Z)  (retval_Runway_Time_10: Z)  (retval_W_D_10: Z)  (retval_W_A_10: Z)  (retval_ModeD_10: Z)  (retval_ModeA_10: Z) ,
  “ (0 <= retval_ModeA_10) ” 
  &&  “ (retval_ModeA_10 <= 1) ” 
  &&  “ (0 <= retval_ModeD_10) ” 
  &&  “ (retval_ModeD_10 <= 1) ” 
  &&  “ ((retval_ModeA_10 + retval_ModeD_10 ) <= 1) ” 
  &&  “ (retval_W_A_10 >= 0) ” 
  &&  “ (retval_W_D_10 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_10) ” 
  &&  “ (retval_Runway_Time_10 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_10) ” 
  &&  “ (retval_Plane_Counter_10 <= 3) ” 
  &&  “ (retval_Plane_Counter_10 <= (3 * (retval_ModeA_10 + retval_ModeD_10 ) )) ” 
  &&  “ (retval_Runway_Time_10 <= (5 * (retval_ModeA_10 + retval_ModeD_10 ) )) ” 
  &&  “ (retval_Plane_Counter_10 <= (3 * ((1 - retval_ModeA_10 ) + retval_W_D_10 ) )) ” 
  &&  “ (retval_Plane_Counter_10 <= (3 * ((1 - retval_ModeD_10 ) + retval_W_A_10 ) )) ” 
  &&  “ (wd0 <> 0) ” 
  &&  “ (wa0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_10)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_10)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_10)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_10)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_10)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_10))
  ||
  (EX (retval_Plane_Counter_12: Z)  (retval_Runway_Time_12: Z)  (retval_W_D_12: Z)  (retval_W_A_12: Z)  (retval_ModeD_12: Z)  (retval_ModeA_12: Z) ,
  “ (0 <= retval_ModeA_12) ” 
  &&  “ (retval_ModeA_12 <= 1) ” 
  &&  “ (0 <= retval_ModeD_12) ” 
  &&  “ (retval_ModeD_12 <= 1) ” 
  &&  “ ((retval_ModeA_12 + retval_ModeD_12 ) <= 1) ” 
  &&  “ (retval_W_A_12 >= 0) ” 
  &&  “ (retval_W_D_12 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_12) ” 
  &&  “ (retval_Runway_Time_12 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_12) ” 
  &&  “ (retval_Plane_Counter_12 <= 3) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * (retval_ModeA_12 + retval_ModeD_12 ) )) ” 
  &&  “ (retval_Runway_Time_12 <= (5 * (retval_ModeA_12 + retval_ModeD_12 ) )) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * ((1 - retval_ModeA_12 ) + retval_W_D_12 ) )) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * ((1 - retval_ModeD_12 ) + retval_W_A_12 ) )) ” 
  &&  “ (wd0 <> 0) ” 
  &&  “ (retval_ModeD_12 = 1) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_12)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_12)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_12)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_12)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_12)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_12))
.

Definition tick_return_wit_6 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wd0 <= 0)) (PreH2 : (wa0 > 0)) (PreH3 : (d0 <> 0)) (PreH4 : (a0 = 0)) (PreH5 : (d0 = 1)) (PreH6 : (a0 <> 1)) (PreH7 : (wd0 <= 0)) (PreH8 : (d0 = 1)) (PreH9 : (a0 <> 1)) (PreH10 : (t0 <= 0)) (PreH11 : (0 <= a0)) (PreH12 : (a0 <= 1)) (PreH13 : (0 <= d0)) (PreH14 : (d0 <= 1)) (PreH15 : ((a0 + d0 ) <= 1)) (PreH16 : (wa0 >= 0)) (PreH17 : (wd0 >= 0)) (PreH18 : (0 <= t0)) (PreH19 : (t0 <= 5)) (PreH20 : (0 <= c0)) (PreH21 : (c0 <= 3)) (PreH22 : (c0 <= (3 * (a0 + d0 ) ))) (PreH23 : (t0 <= (5 * (a0 + d0 ) ))) (PreH24 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH25 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH26 : (c0 < INT_MAX)) (PreH27 : (wa0 < INT_MAX)) (PreH28 : (wd0 < INT_MAX)) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> 1)
|--
  (EX (retval_Plane_Counter: Z)  (retval_Runway_Time: Z)  (retval_W_D: Z)  (retval_W_A: Z)  (retval_ModeD: Z)  (retval_ModeA: Z) ,
  “ (0 <= retval_ModeA) ” 
  &&  “ (retval_ModeA <= 1) ” 
  &&  “ (0 <= retval_ModeD) ” 
  &&  “ (retval_ModeD <= 1) ” 
  &&  “ ((retval_ModeA + retval_ModeD ) <= 1) ” 
  &&  “ (retval_W_A >= 0) ” 
  &&  “ (retval_W_D >= 0) ” 
  &&  “ (0 <= retval_Runway_Time) ” 
  &&  “ (retval_Runway_Time <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter) ” 
  &&  “ (retval_Plane_Counter <= 3) ” 
  &&  “ (retval_Plane_Counter <= (3 * (retval_ModeA + retval_ModeD ) )) ” 
  &&  “ (retval_Runway_Time <= (5 * (retval_ModeA + retval_ModeD ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - retval_ModeA ) + retval_W_D ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - retval_ModeD ) + retval_W_A ) )) ” 
  &&  “ (retval_ModeA = 1) ” 
  &&  “ (wd0 <= 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter))
  ||
  (EX (retval_Plane_Counter_2: Z)  (retval_Runway_Time_2: Z)  (retval_W_D_2: Z)  (retval_W_A_2: Z)  (retval_ModeD_2: Z)  (retval_ModeA_2: Z) ,
  “ (0 <= retval_ModeA_2) ” 
  &&  “ (retval_ModeA_2 <= 1) ” 
  &&  “ (0 <= retval_ModeD_2) ” 
  &&  “ (retval_ModeD_2 <= 1) ” 
  &&  “ ((retval_ModeA_2 + retval_ModeD_2 ) <= 1) ” 
  &&  “ (retval_W_A_2 >= 0) ” 
  &&  “ (retval_W_D_2 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_2) ” 
  &&  “ (retval_Runway_Time_2 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_2) ” 
  &&  “ (retval_Plane_Counter_2 <= 3) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * (retval_ModeA_2 + retval_ModeD_2 ) )) ” 
  &&  “ (retval_Runway_Time_2 <= (5 * (retval_ModeA_2 + retval_ModeD_2 ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - retval_ModeA_2 ) + retval_W_D_2 ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - retval_ModeD_2 ) + retval_W_A_2 ) )) ” 
  &&  “ (retval_ModeA_2 = 1) ” 
  &&  “ (wa0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_2)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_2)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_2)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_2)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_2)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_2))
.

Definition tick_return_wit_7 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wa0 <= 0)) (PreH2 : (d0 <> 0)) (PreH3 : (a0 = 0)) (PreH4 : (d0 = 1)) (PreH5 : (a0 <> 1)) (PreH6 : (wd0 <= 0)) (PreH7 : (d0 = 1)) (PreH8 : (a0 <> 1)) (PreH9 : (t0 <= 0)) (PreH10 : (0 <= a0)) (PreH11 : (a0 <= 1)) (PreH12 : (0 <= d0)) (PreH13 : (d0 <= 1)) (PreH14 : ((a0 + d0 ) <= 1)) (PreH15 : (wa0 >= 0)) (PreH16 : (wd0 >= 0)) (PreH17 : (0 <= t0)) (PreH18 : (t0 <= 5)) (PreH19 : (0 <= c0)) (PreH20 : (c0 <= 3)) (PreH21 : (c0 <= (3 * (a0 + d0 ) ))) (PreH22 : (t0 <= (5 * (a0 + d0 ) ))) (PreH23 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH24 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH25 : (c0 < INT_MAX)) (PreH26 : (wa0 < INT_MAX)) (PreH27 : (wd0 < INT_MAX)) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> 1)
|--
  (EX (retval_Plane_Counter: Z)  (retval_Runway_Time: Z)  (retval_W_D: Z)  (retval_W_A: Z)  (retval_ModeD: Z)  (retval_ModeA: Z) ,
  “ (0 <= retval_ModeA) ” 
  &&  “ (retval_ModeA <= 1) ” 
  &&  “ (0 <= retval_ModeD) ” 
  &&  “ (retval_ModeD <= 1) ” 
  &&  “ ((retval_ModeA + retval_ModeD ) <= 1) ” 
  &&  “ (retval_W_A >= 0) ” 
  &&  “ (retval_W_D >= 0) ” 
  &&  “ (0 <= retval_Runway_Time) ” 
  &&  “ (retval_Runway_Time <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter) ” 
  &&  “ (retval_Plane_Counter <= 3) ” 
  &&  “ (retval_Plane_Counter <= (3 * (retval_ModeA + retval_ModeD ) )) ” 
  &&  “ (retval_Runway_Time <= (5 * (retval_ModeA + retval_ModeD ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - retval_ModeA ) + retval_W_D ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - retval_ModeD ) + retval_W_A ) )) ” 
  &&  “ (retval_ModeA = 1) ” 
  &&  “ (wd0 <= 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter))
  ||
  (EX (retval_Plane_Counter_13: Z)  (retval_Runway_Time_13: Z)  (retval_W_D_13: Z)  (retval_W_A_13: Z)  (retval_ModeD_13: Z)  (retval_ModeA_13: Z) ,
  “ (0 <= retval_ModeA_13) ” 
  &&  “ (retval_ModeA_13 <= 1) ” 
  &&  “ (0 <= retval_ModeD_13) ” 
  &&  “ (retval_ModeD_13 <= 1) ” 
  &&  “ ((retval_ModeA_13 + retval_ModeD_13 ) <= 1) ” 
  &&  “ (retval_W_A_13 >= 0) ” 
  &&  “ (retval_W_D_13 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_13) ” 
  &&  “ (retval_Runway_Time_13 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_13) ” 
  &&  “ (retval_Plane_Counter_13 <= 3) ” 
  &&  “ (retval_Plane_Counter_13 <= (3 * (retval_ModeA_13 + retval_ModeD_13 ) )) ” 
  &&  “ (retval_Runway_Time_13 <= (5 * (retval_ModeA_13 + retval_ModeD_13 ) )) ” 
  &&  “ (retval_Plane_Counter_13 <= (3 * ((1 - retval_ModeA_13 ) + retval_W_D_13 ) )) ” 
  &&  “ (retval_Plane_Counter_13 <= (3 * ((1 - retval_ModeD_13 ) + retval_W_A_13 ) )) ” 
  &&  “ (wa0 <= 0) ” 
  &&  “ (wd0 <= 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_13)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_13)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_13)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_13)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_13)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_13))
  ||
  (EX (retval_Plane_Counter_16: Z)  (retval_Runway_Time_16: Z)  (retval_W_D_16: Z)  (retval_W_A_16: Z)  (retval_ModeD_16: Z)  (retval_ModeA_16: Z) ,
  “ (0 <= retval_ModeA_16) ” 
  &&  “ (retval_ModeA_16 <= 1) ” 
  &&  “ (0 <= retval_ModeD_16) ” 
  &&  “ (retval_ModeD_16 <= 1) ” 
  &&  “ ((retval_ModeA_16 + retval_ModeD_16 ) <= 1) ” 
  &&  “ (retval_W_A_16 >= 0) ” 
  &&  “ (retval_W_D_16 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_16) ” 
  &&  “ (retval_Runway_Time_16 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_16) ” 
  &&  “ (retval_Plane_Counter_16 <= 3) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * (retval_ModeA_16 + retval_ModeD_16 ) )) ” 
  &&  “ (retval_Runway_Time_16 <= (5 * (retval_ModeA_16 + retval_ModeD_16 ) )) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * ((1 - retval_ModeA_16 ) + retval_W_D_16 ) )) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * ((1 - retval_ModeD_16 ) + retval_W_A_16 ) )) ” 
  &&  “ (wa0 <= 0) ” 
  &&  “ (retval_ModeD_16 = 1) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_16)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_16)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_16)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_16)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_16)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_16))
.

Definition tick_return_wit_8 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wa0 > 0)) (PreH2 : (wd0 > 0)) (PreH3 : (d0 = 0)) (PreH4 : (a0 <> 0)) (PreH5 : (a0 = 1)) (PreH6 : (d0 <> 1)) (PreH7 : (c0 >= 3)) (PreH8 : (wa0 > 0)) (PreH9 : (a0 = 1)) (PreH10 : (t0 <= 0)) (PreH11 : (0 <= a0)) (PreH12 : (a0 <= 1)) (PreH13 : (0 <= d0)) (PreH14 : (d0 <= 1)) (PreH15 : ((a0 + d0 ) <= 1)) (PreH16 : (wa0 >= 0)) (PreH17 : (wd0 >= 0)) (PreH18 : (0 <= t0)) (PreH19 : (t0 <= 5)) (PreH20 : (0 <= c0)) (PreH21 : (c0 <= 3)) (PreH22 : (c0 <= (3 * (a0 + d0 ) ))) (PreH23 : (t0 <= (5 * (a0 + d0 ) ))) (PreH24 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH25 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH26 : (c0 < INT_MAX)) (PreH27 : (wa0 < INT_MAX)) (PreH28 : (wd0 < INT_MAX)) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> (0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> 0)
|--
  (EX (retval_Plane_Counter_2: Z)  (retval_Runway_Time_2: Z)  (retval_W_D_2: Z)  (retval_W_A_2: Z)  (retval_ModeD_2: Z)  (retval_ModeA_2: Z) ,
  “ (0 <= retval_ModeA_2) ” 
  &&  “ (retval_ModeA_2 <= 1) ” 
  &&  “ (0 <= retval_ModeD_2) ” 
  &&  “ (retval_ModeD_2 <= 1) ” 
  &&  “ ((retval_ModeA_2 + retval_ModeD_2 ) <= 1) ” 
  &&  “ (retval_W_A_2 >= 0) ” 
  &&  “ (retval_W_D_2 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_2) ” 
  &&  “ (retval_Runway_Time_2 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_2) ” 
  &&  “ (retval_Plane_Counter_2 <= 3) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * (retval_ModeA_2 + retval_ModeD_2 ) )) ” 
  &&  “ (retval_Runway_Time_2 <= (5 * (retval_ModeA_2 + retval_ModeD_2 ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - retval_ModeA_2 ) + retval_W_D_2 ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - retval_ModeD_2 ) + retval_W_A_2 ) )) ” 
  &&  “ (retval_ModeA_2 = 1) ” 
  &&  “ (wa0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_2)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_2)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_2)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_2)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_2)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_2))
  ||
  (EX (retval_Plane_Counter_10: Z)  (retval_Runway_Time_10: Z)  (retval_W_D_10: Z)  (retval_W_A_10: Z)  (retval_ModeD_10: Z)  (retval_ModeA_10: Z) ,
  “ (0 <= retval_ModeA_10) ” 
  &&  “ (retval_ModeA_10 <= 1) ” 
  &&  “ (0 <= retval_ModeD_10) ” 
  &&  “ (retval_ModeD_10 <= 1) ” 
  &&  “ ((retval_ModeA_10 + retval_ModeD_10 ) <= 1) ” 
  &&  “ (retval_W_A_10 >= 0) ” 
  &&  “ (retval_W_D_10 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_10) ” 
  &&  “ (retval_Runway_Time_10 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_10) ” 
  &&  “ (retval_Plane_Counter_10 <= 3) ” 
  &&  “ (retval_Plane_Counter_10 <= (3 * (retval_ModeA_10 + retval_ModeD_10 ) )) ” 
  &&  “ (retval_Runway_Time_10 <= (5 * (retval_ModeA_10 + retval_ModeD_10 ) )) ” 
  &&  “ (retval_Plane_Counter_10 <= (3 * ((1 - retval_ModeA_10 ) + retval_W_D_10 ) )) ” 
  &&  “ (retval_Plane_Counter_10 <= (3 * ((1 - retval_ModeD_10 ) + retval_W_A_10 ) )) ” 
  &&  “ (wd0 <> 0) ” 
  &&  “ (wa0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_10)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_10)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_10)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_10)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_10)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_10))
  ||
  (EX (retval_Plane_Counter_12: Z)  (retval_Runway_Time_12: Z)  (retval_W_D_12: Z)  (retval_W_A_12: Z)  (retval_ModeD_12: Z)  (retval_ModeA_12: Z) ,
  “ (0 <= retval_ModeA_12) ” 
  &&  “ (retval_ModeA_12 <= 1) ” 
  &&  “ (0 <= retval_ModeD_12) ” 
  &&  “ (retval_ModeD_12 <= 1) ” 
  &&  “ ((retval_ModeA_12 + retval_ModeD_12 ) <= 1) ” 
  &&  “ (retval_W_A_12 >= 0) ” 
  &&  “ (retval_W_D_12 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_12) ” 
  &&  “ (retval_Runway_Time_12 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_12) ” 
  &&  “ (retval_Plane_Counter_12 <= 3) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * (retval_ModeA_12 + retval_ModeD_12 ) )) ” 
  &&  “ (retval_Runway_Time_12 <= (5 * (retval_ModeA_12 + retval_ModeD_12 ) )) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * ((1 - retval_ModeA_12 ) + retval_W_D_12 ) )) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * ((1 - retval_ModeD_12 ) + retval_W_A_12 ) )) ” 
  &&  “ (wd0 <> 0) ” 
  &&  “ (retval_ModeD_12 = 1) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_12)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_12)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_12)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_12)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_12)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_12))
.

Definition tick_return_wit_9 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wa0 <= 0)) (PreH2 : (wd0 > 0)) (PreH3 : (d0 = 0)) (PreH4 : (a0 <> 0)) (PreH5 : (a0 = 1)) (PreH6 : (d0 <> 1)) (PreH7 : (wa0 <= 0)) (PreH8 : (a0 = 1)) (PreH9 : (t0 <= 0)) (PreH10 : (0 <= a0)) (PreH11 : (a0 <= 1)) (PreH12 : (0 <= d0)) (PreH13 : (d0 <= 1)) (PreH14 : ((a0 + d0 ) <= 1)) (PreH15 : (wa0 >= 0)) (PreH16 : (wd0 >= 0)) (PreH17 : (0 <= t0)) (PreH18 : (t0 <= 5)) (PreH19 : (0 <= c0)) (PreH20 : (c0 <= 3)) (PreH21 : (c0 <= (3 * (a0 + d0 ) ))) (PreH22 : (t0 <= (5 * (a0 + d0 ) ))) (PreH23 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH24 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH25 : (c0 < INT_MAX)) (PreH26 : (wa0 < INT_MAX)) (PreH27 : (wd0 < INT_MAX)) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> 0)
|--
  (EX (retval_Plane_Counter_12: Z)  (retval_Runway_Time_12: Z)  (retval_W_D_12: Z)  (retval_W_A_12: Z)  (retval_ModeD_12: Z)  (retval_ModeA_12: Z) ,
  “ (0 <= retval_ModeA_12) ” 
  &&  “ (retval_ModeA_12 <= 1) ” 
  &&  “ (0 <= retval_ModeD_12) ” 
  &&  “ (retval_ModeD_12 <= 1) ” 
  &&  “ ((retval_ModeA_12 + retval_ModeD_12 ) <= 1) ” 
  &&  “ (retval_W_A_12 >= 0) ” 
  &&  “ (retval_W_D_12 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_12) ” 
  &&  “ (retval_Runway_Time_12 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_12) ” 
  &&  “ (retval_Plane_Counter_12 <= 3) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * (retval_ModeA_12 + retval_ModeD_12 ) )) ” 
  &&  “ (retval_Runway_Time_12 <= (5 * (retval_ModeA_12 + retval_ModeD_12 ) )) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * ((1 - retval_ModeA_12 ) + retval_W_D_12 ) )) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * ((1 - retval_ModeD_12 ) + retval_W_A_12 ) )) ” 
  &&  “ (wd0 <> 0) ” 
  &&  “ (retval_ModeD_12 = 1) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_12)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_12)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_12)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_12)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_12)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_12))
  ||
  (EX (retval_Plane_Counter_16: Z)  (retval_Runway_Time_16: Z)  (retval_W_D_16: Z)  (retval_W_A_16: Z)  (retval_ModeD_16: Z)  (retval_ModeA_16: Z) ,
  “ (0 <= retval_ModeA_16) ” 
  &&  “ (retval_ModeA_16 <= 1) ” 
  &&  “ (0 <= retval_ModeD_16) ” 
  &&  “ (retval_ModeD_16 <= 1) ” 
  &&  “ ((retval_ModeA_16 + retval_ModeD_16 ) <= 1) ” 
  &&  “ (retval_W_A_16 >= 0) ” 
  &&  “ (retval_W_D_16 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_16) ” 
  &&  “ (retval_Runway_Time_16 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_16) ” 
  &&  “ (retval_Plane_Counter_16 <= 3) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * (retval_ModeA_16 + retval_ModeD_16 ) )) ” 
  &&  “ (retval_Runway_Time_16 <= (5 * (retval_ModeA_16 + retval_ModeD_16 ) )) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * ((1 - retval_ModeA_16 ) + retval_W_D_16 ) )) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * ((1 - retval_ModeD_16 ) + retval_W_A_16 ) )) ” 
  &&  “ (wa0 <= 0) ” 
  &&  “ (retval_ModeD_16 = 1) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_16)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_16)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_16)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_16)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_16)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_16))
.

Definition tick_return_wit_10 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wd0 <= 0)) (PreH2 : (d0 = 0)) (PreH3 : (a0 <> 0)) (PreH4 : (a0 = 1)) (PreH5 : (d0 <> 1)) (PreH6 : (wa0 <= 0)) (PreH7 : (a0 = 1)) (PreH8 : (t0 <= 0)) (PreH9 : (0 <= a0)) (PreH10 : (a0 <= 1)) (PreH11 : (0 <= d0)) (PreH12 : (d0 <= 1)) (PreH13 : ((a0 + d0 ) <= 1)) (PreH14 : (wa0 >= 0)) (PreH15 : (wd0 >= 0)) (PreH16 : (0 <= t0)) (PreH17 : (t0 <= 5)) (PreH18 : (0 <= c0)) (PreH19 : (c0 <= 3)) (PreH20 : (c0 <= (3 * (a0 + d0 ) ))) (PreH21 : (t0 <= (5 * (a0 + d0 ) ))) (PreH22 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH23 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH24 : (c0 < INT_MAX)) (PreH25 : (wa0 < INT_MAX)) (PreH26 : (wd0 < INT_MAX)) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> 0)
|--
  (EX (retval_Plane_Counter: Z)  (retval_Runway_Time: Z)  (retval_W_D: Z)  (retval_W_A: Z)  (retval_ModeD: Z)  (retval_ModeA: Z) ,
  “ (0 <= retval_ModeA) ” 
  &&  “ (retval_ModeA <= 1) ” 
  &&  “ (0 <= retval_ModeD) ” 
  &&  “ (retval_ModeD <= 1) ” 
  &&  “ ((retval_ModeA + retval_ModeD ) <= 1) ” 
  &&  “ (retval_W_A >= 0) ” 
  &&  “ (retval_W_D >= 0) ” 
  &&  “ (0 <= retval_Runway_Time) ” 
  &&  “ (retval_Runway_Time <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter) ” 
  &&  “ (retval_Plane_Counter <= 3) ” 
  &&  “ (retval_Plane_Counter <= (3 * (retval_ModeA + retval_ModeD ) )) ” 
  &&  “ (retval_Runway_Time <= (5 * (retval_ModeA + retval_ModeD ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - retval_ModeA ) + retval_W_D ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - retval_ModeD ) + retval_W_A ) )) ” 
  &&  “ (retval_ModeA = 1) ” 
  &&  “ (wd0 <= 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter))
  ||
  (EX (retval_Plane_Counter_13: Z)  (retval_Runway_Time_13: Z)  (retval_W_D_13: Z)  (retval_W_A_13: Z)  (retval_ModeD_13: Z)  (retval_ModeA_13: Z) ,
  “ (0 <= retval_ModeA_13) ” 
  &&  “ (retval_ModeA_13 <= 1) ” 
  &&  “ (0 <= retval_ModeD_13) ” 
  &&  “ (retval_ModeD_13 <= 1) ” 
  &&  “ ((retval_ModeA_13 + retval_ModeD_13 ) <= 1) ” 
  &&  “ (retval_W_A_13 >= 0) ” 
  &&  “ (retval_W_D_13 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_13) ” 
  &&  “ (retval_Runway_Time_13 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_13) ” 
  &&  “ (retval_Plane_Counter_13 <= 3) ” 
  &&  “ (retval_Plane_Counter_13 <= (3 * (retval_ModeA_13 + retval_ModeD_13 ) )) ” 
  &&  “ (retval_Runway_Time_13 <= (5 * (retval_ModeA_13 + retval_ModeD_13 ) )) ” 
  &&  “ (retval_Plane_Counter_13 <= (3 * ((1 - retval_ModeA_13 ) + retval_W_D_13 ) )) ” 
  &&  “ (retval_Plane_Counter_13 <= (3 * ((1 - retval_ModeD_13 ) + retval_W_A_13 ) )) ” 
  &&  “ (wa0 <= 0) ” 
  &&  “ (wd0 <= 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_13)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_13)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_13)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_13)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_13)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_13))
  ||
  (EX (retval_Plane_Counter_16: Z)  (retval_Runway_Time_16: Z)  (retval_W_D_16: Z)  (retval_W_A_16: Z)  (retval_ModeD_16: Z)  (retval_ModeA_16: Z) ,
  “ (0 <= retval_ModeA_16) ” 
  &&  “ (retval_ModeA_16 <= 1) ” 
  &&  “ (0 <= retval_ModeD_16) ” 
  &&  “ (retval_ModeD_16 <= 1) ” 
  &&  “ ((retval_ModeA_16 + retval_ModeD_16 ) <= 1) ” 
  &&  “ (retval_W_A_16 >= 0) ” 
  &&  “ (retval_W_D_16 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_16) ” 
  &&  “ (retval_Runway_Time_16 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_16) ” 
  &&  “ (retval_Plane_Counter_16 <= 3) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * (retval_ModeA_16 + retval_ModeD_16 ) )) ” 
  &&  “ (retval_Runway_Time_16 <= (5 * (retval_ModeA_16 + retval_ModeD_16 ) )) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * ((1 - retval_ModeA_16 ) + retval_W_D_16 ) )) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * ((1 - retval_ModeD_16 ) + retval_W_A_16 ) )) ” 
  &&  “ (wa0 <= 0) ” 
  &&  “ (retval_ModeD_16 = 1) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_16)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_16)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_16)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_16)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_16)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_16))
.

Definition tick_return_wit_11 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wa0 > 0)) (PreH2 : (c0 < 3)) (PreH3 : (wd0 > 0)) (PreH4 : (d0 = 1)) (PreH5 : (a0 <> 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> (c0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> a0)
|--
  (EX (retval_Plane_Counter_2: Z)  (retval_Runway_Time_2: Z)  (retval_W_D_2: Z)  (retval_W_A_2: Z)  (retval_ModeD_2: Z)  (retval_ModeA_2: Z) ,
  “ (0 <= retval_ModeA_2) ” 
  &&  “ (retval_ModeA_2 <= 1) ” 
  &&  “ (0 <= retval_ModeD_2) ” 
  &&  “ (retval_ModeD_2 <= 1) ” 
  &&  “ ((retval_ModeA_2 + retval_ModeD_2 ) <= 1) ” 
  &&  “ (retval_W_A_2 >= 0) ” 
  &&  “ (retval_W_D_2 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_2) ” 
  &&  “ (retval_Runway_Time_2 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_2) ” 
  &&  “ (retval_Plane_Counter_2 <= 3) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * (retval_ModeA_2 + retval_ModeD_2 ) )) ” 
  &&  “ (retval_Runway_Time_2 <= (5 * (retval_ModeA_2 + retval_ModeD_2 ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - retval_ModeA_2 ) + retval_W_D_2 ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - retval_ModeD_2 ) + retval_W_A_2 ) )) ” 
  &&  “ (retval_ModeA_2 = 1) ” 
  &&  “ (wa0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_2)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_2)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_2)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_2)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_2)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_2))
  ||
  (EX (retval_Plane_Counter_10: Z)  (retval_Runway_Time_10: Z)  (retval_W_D_10: Z)  (retval_W_A_10: Z)  (retval_ModeD_10: Z)  (retval_ModeA_10: Z) ,
  “ (0 <= retval_ModeA_10) ” 
  &&  “ (retval_ModeA_10 <= 1) ” 
  &&  “ (0 <= retval_ModeD_10) ” 
  &&  “ (retval_ModeD_10 <= 1) ” 
  &&  “ ((retval_ModeA_10 + retval_ModeD_10 ) <= 1) ” 
  &&  “ (retval_W_A_10 >= 0) ” 
  &&  “ (retval_W_D_10 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_10) ” 
  &&  “ (retval_Runway_Time_10 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_10) ” 
  &&  “ (retval_Plane_Counter_10 <= 3) ” 
  &&  “ (retval_Plane_Counter_10 <= (3 * (retval_ModeA_10 + retval_ModeD_10 ) )) ” 
  &&  “ (retval_Runway_Time_10 <= (5 * (retval_ModeA_10 + retval_ModeD_10 ) )) ” 
  &&  “ (retval_Plane_Counter_10 <= (3 * ((1 - retval_ModeA_10 ) + retval_W_D_10 ) )) ” 
  &&  “ (retval_Plane_Counter_10 <= (3 * ((1 - retval_ModeD_10 ) + retval_W_A_10 ) )) ” 
  &&  “ (wd0 <> 0) ” 
  &&  “ (wa0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_10)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_10)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_10)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_10)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_10)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_10))
  ||
  (EX (retval_Plane_Counter_12: Z)  (retval_Runway_Time_12: Z)  (retval_W_D_12: Z)  (retval_W_A_12: Z)  (retval_ModeD_12: Z)  (retval_ModeA_12: Z) ,
  “ (0 <= retval_ModeA_12) ” 
  &&  “ (retval_ModeA_12 <= 1) ” 
  &&  “ (0 <= retval_ModeD_12) ” 
  &&  “ (retval_ModeD_12 <= 1) ” 
  &&  “ ((retval_ModeA_12 + retval_ModeD_12 ) <= 1) ” 
  &&  “ (retval_W_A_12 >= 0) ” 
  &&  “ (retval_W_D_12 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_12) ” 
  &&  “ (retval_Runway_Time_12 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_12) ” 
  &&  “ (retval_Plane_Counter_12 <= 3) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * (retval_ModeA_12 + retval_ModeD_12 ) )) ” 
  &&  “ (retval_Runway_Time_12 <= (5 * (retval_ModeA_12 + retval_ModeD_12 ) )) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * ((1 - retval_ModeA_12 ) + retval_W_D_12 ) )) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * ((1 - retval_ModeD_12 ) + retval_W_A_12 ) )) ” 
  &&  “ (wd0 <> 0) ” 
  &&  “ (retval_ModeD_12 = 1) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_12)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_12)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_12)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_12)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_12)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_12))
.

Definition tick_return_wit_12 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wa0 <= 0)) (PreH2 : (c0 < 3)) (PreH3 : (wd0 > 0)) (PreH4 : (d0 = 1)) (PreH5 : (a0 <> 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> a0)
|--
  (EX (retval_Plane_Counter_12: Z)  (retval_Runway_Time_12: Z)  (retval_W_D_12: Z)  (retval_W_A_12: Z)  (retval_ModeD_12: Z)  (retval_ModeA_12: Z) ,
  “ (0 <= retval_ModeA_12) ” 
  &&  “ (retval_ModeA_12 <= 1) ” 
  &&  “ (0 <= retval_ModeD_12) ” 
  &&  “ (retval_ModeD_12 <= 1) ” 
  &&  “ ((retval_ModeA_12 + retval_ModeD_12 ) <= 1) ” 
  &&  “ (retval_W_A_12 >= 0) ” 
  &&  “ (retval_W_D_12 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_12) ” 
  &&  “ (retval_Runway_Time_12 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_12) ” 
  &&  “ (retval_Plane_Counter_12 <= 3) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * (retval_ModeA_12 + retval_ModeD_12 ) )) ” 
  &&  “ (retval_Runway_Time_12 <= (5 * (retval_ModeA_12 + retval_ModeD_12 ) )) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * ((1 - retval_ModeA_12 ) + retval_W_D_12 ) )) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * ((1 - retval_ModeD_12 ) + retval_W_A_12 ) )) ” 
  &&  “ (wd0 <> 0) ” 
  &&  “ (retval_ModeD_12 = 1) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_12)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_12)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_12)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_12)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_12)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_12))
  ||
  (EX (retval_Plane_Counter_16: Z)  (retval_Runway_Time_16: Z)  (retval_W_D_16: Z)  (retval_W_A_16: Z)  (retval_ModeD_16: Z)  (retval_ModeA_16: Z) ,
  “ (0 <= retval_ModeA_16) ” 
  &&  “ (retval_ModeA_16 <= 1) ” 
  &&  “ (0 <= retval_ModeD_16) ” 
  &&  “ (retval_ModeD_16 <= 1) ” 
  &&  “ ((retval_ModeA_16 + retval_ModeD_16 ) <= 1) ” 
  &&  “ (retval_W_A_16 >= 0) ” 
  &&  “ (retval_W_D_16 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_16) ” 
  &&  “ (retval_Runway_Time_16 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_16) ” 
  &&  “ (retval_Plane_Counter_16 <= 3) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * (retval_ModeA_16 + retval_ModeD_16 ) )) ” 
  &&  “ (retval_Runway_Time_16 <= (5 * (retval_ModeA_16 + retval_ModeD_16 ) )) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * ((1 - retval_ModeA_16 ) + retval_W_D_16 ) )) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * ((1 - retval_ModeD_16 ) + retval_W_A_16 ) )) ” 
  &&  “ (wa0 <= 0) ” 
  &&  “ (retval_ModeD_16 = 1) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_16)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_16)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_16)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_16)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_16)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_16))
.

Definition tick_return_wit_13 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wd0 > 0)) (PreH2 : (c0 < 3)) (PreH3 : (wa0 > 0)) (PreH4 : (a0 = 1)) (PreH5 : (t0 <= 0)) (PreH6 : (0 <= a0)) (PreH7 : (a0 <= 1)) (PreH8 : (0 <= d0)) (PreH9 : (d0 <= 1)) (PreH10 : ((a0 + d0 ) <= 1)) (PreH11 : (wa0 >= 0)) (PreH12 : (wd0 >= 0)) (PreH13 : (0 <= t0)) (PreH14 : (t0 <= 5)) (PreH15 : (0 <= c0)) (PreH16 : (c0 <= 3)) (PreH17 : (c0 <= (3 * (a0 + d0 ) ))) (PreH18 : (t0 <= (5 * (a0 + d0 ) ))) (PreH19 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH20 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH21 : (c0 < INT_MAX)) (PreH22 : (wa0 < INT_MAX)) (PreH23 : (wd0 < INT_MAX)) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> (c0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> a0)
|--
  (EX (retval_Plane_Counter_2: Z)  (retval_Runway_Time_2: Z)  (retval_W_D_2: Z)  (retval_W_A_2: Z)  (retval_ModeD_2: Z)  (retval_ModeA_2: Z) ,
  “ (0 <= retval_ModeA_2) ” 
  &&  “ (retval_ModeA_2 <= 1) ” 
  &&  “ (0 <= retval_ModeD_2) ” 
  &&  “ (retval_ModeD_2 <= 1) ” 
  &&  “ ((retval_ModeA_2 + retval_ModeD_2 ) <= 1) ” 
  &&  “ (retval_W_A_2 >= 0) ” 
  &&  “ (retval_W_D_2 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_2) ” 
  &&  “ (retval_Runway_Time_2 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_2) ” 
  &&  “ (retval_Plane_Counter_2 <= 3) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * (retval_ModeA_2 + retval_ModeD_2 ) )) ” 
  &&  “ (retval_Runway_Time_2 <= (5 * (retval_ModeA_2 + retval_ModeD_2 ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - retval_ModeA_2 ) + retval_W_D_2 ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - retval_ModeD_2 ) + retval_W_A_2 ) )) ” 
  &&  “ (retval_ModeA_2 = 1) ” 
  &&  “ (wa0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_2)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_2)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_2)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_2)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_2)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_2))
  ||
  (EX (retval_Plane_Counter_10: Z)  (retval_Runway_Time_10: Z)  (retval_W_D_10: Z)  (retval_W_A_10: Z)  (retval_ModeD_10: Z)  (retval_ModeA_10: Z) ,
  “ (0 <= retval_ModeA_10) ” 
  &&  “ (retval_ModeA_10 <= 1) ” 
  &&  “ (0 <= retval_ModeD_10) ” 
  &&  “ (retval_ModeD_10 <= 1) ” 
  &&  “ ((retval_ModeA_10 + retval_ModeD_10 ) <= 1) ” 
  &&  “ (retval_W_A_10 >= 0) ” 
  &&  “ (retval_W_D_10 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_10) ” 
  &&  “ (retval_Runway_Time_10 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_10) ” 
  &&  “ (retval_Plane_Counter_10 <= 3) ” 
  &&  “ (retval_Plane_Counter_10 <= (3 * (retval_ModeA_10 + retval_ModeD_10 ) )) ” 
  &&  “ (retval_Runway_Time_10 <= (5 * (retval_ModeA_10 + retval_ModeD_10 ) )) ” 
  &&  “ (retval_Plane_Counter_10 <= (3 * ((1 - retval_ModeA_10 ) + retval_W_D_10 ) )) ” 
  &&  “ (retval_Plane_Counter_10 <= (3 * ((1 - retval_ModeD_10 ) + retval_W_A_10 ) )) ” 
  &&  “ (wd0 <> 0) ” 
  &&  “ (wa0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_10)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_10)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_10)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_10)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_10)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_10))
  ||
  (EX (retval_Plane_Counter_12: Z)  (retval_Runway_Time_12: Z)  (retval_W_D_12: Z)  (retval_W_A_12: Z)  (retval_ModeD_12: Z)  (retval_ModeA_12: Z) ,
  “ (0 <= retval_ModeA_12) ” 
  &&  “ (retval_ModeA_12 <= 1) ” 
  &&  “ (0 <= retval_ModeD_12) ” 
  &&  “ (retval_ModeD_12 <= 1) ” 
  &&  “ ((retval_ModeA_12 + retval_ModeD_12 ) <= 1) ” 
  &&  “ (retval_W_A_12 >= 0) ” 
  &&  “ (retval_W_D_12 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_12) ” 
  &&  “ (retval_Runway_Time_12 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_12) ” 
  &&  “ (retval_Plane_Counter_12 <= 3) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * (retval_ModeA_12 + retval_ModeD_12 ) )) ” 
  &&  “ (retval_Runway_Time_12 <= (5 * (retval_ModeA_12 + retval_ModeD_12 ) )) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * ((1 - retval_ModeA_12 ) + retval_W_D_12 ) )) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * ((1 - retval_ModeD_12 ) + retval_W_A_12 ) )) ” 
  &&  “ (wd0 <> 0) ” 
  &&  “ (retval_ModeD_12 = 1) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_12)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_12)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_12)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_12)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_12)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_12))
.

Definition tick_return_wit_14 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wd0 <= 0)) (PreH2 : (c0 < 3)) (PreH3 : (wa0 > 0)) (PreH4 : (a0 = 1)) (PreH5 : (t0 <= 0)) (PreH6 : (0 <= a0)) (PreH7 : (a0 <= 1)) (PreH8 : (0 <= d0)) (PreH9 : (d0 <= 1)) (PreH10 : ((a0 + d0 ) <= 1)) (PreH11 : (wa0 >= 0)) (PreH12 : (wd0 >= 0)) (PreH13 : (0 <= t0)) (PreH14 : (t0 <= 5)) (PreH15 : (0 <= c0)) (PreH16 : (c0 <= 3)) (PreH17 : (c0 <= (3 * (a0 + d0 ) ))) (PreH18 : (t0 <= (5 * (a0 + d0 ) ))) (PreH19 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH20 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH21 : (c0 < INT_MAX)) (PreH22 : (wa0 < INT_MAX)) (PreH23 : (wd0 < INT_MAX)) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> a0)
|--
  (EX (retval_Plane_Counter: Z)  (retval_Runway_Time: Z)  (retval_W_D: Z)  (retval_W_A: Z)  (retval_ModeD: Z)  (retval_ModeA: Z) ,
  “ (0 <= retval_ModeA) ” 
  &&  “ (retval_ModeA <= 1) ” 
  &&  “ (0 <= retval_ModeD) ” 
  &&  “ (retval_ModeD <= 1) ” 
  &&  “ ((retval_ModeA + retval_ModeD ) <= 1) ” 
  &&  “ (retval_W_A >= 0) ” 
  &&  “ (retval_W_D >= 0) ” 
  &&  “ (0 <= retval_Runway_Time) ” 
  &&  “ (retval_Runway_Time <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter) ” 
  &&  “ (retval_Plane_Counter <= 3) ” 
  &&  “ (retval_Plane_Counter <= (3 * (retval_ModeA + retval_ModeD ) )) ” 
  &&  “ (retval_Runway_Time <= (5 * (retval_ModeA + retval_ModeD ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - retval_ModeA ) + retval_W_D ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - retval_ModeD ) + retval_W_A ) )) ” 
  &&  “ (retval_ModeA = 1) ” 
  &&  “ (wd0 <= 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter))
  ||
  (EX (retval_Plane_Counter_2: Z)  (retval_Runway_Time_2: Z)  (retval_W_D_2: Z)  (retval_W_A_2: Z)  (retval_ModeD_2: Z)  (retval_ModeA_2: Z) ,
  “ (0 <= retval_ModeA_2) ” 
  &&  “ (retval_ModeA_2 <= 1) ” 
  &&  “ (0 <= retval_ModeD_2) ” 
  &&  “ (retval_ModeD_2 <= 1) ” 
  &&  “ ((retval_ModeA_2 + retval_ModeD_2 ) <= 1) ” 
  &&  “ (retval_W_A_2 >= 0) ” 
  &&  “ (retval_W_D_2 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_2) ” 
  &&  “ (retval_Runway_Time_2 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_2) ” 
  &&  “ (retval_Plane_Counter_2 <= 3) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * (retval_ModeA_2 + retval_ModeD_2 ) )) ” 
  &&  “ (retval_Runway_Time_2 <= (5 * (retval_ModeA_2 + retval_ModeD_2 ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - retval_ModeA_2 ) + retval_W_D_2 ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - retval_ModeD_2 ) + retval_W_A_2 ) )) ” 
  &&  “ (retval_ModeA_2 = 1) ” 
  &&  “ (wa0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_2)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_2)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_2)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_2)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_2)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_2))
.

Definition tick_return_wit_15 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (t0 = 5)) (PreH2 : (t0 > 0)) (PreH3 : (0 <= a0)) (PreH4 : (a0 <= 1)) (PreH5 : (0 <= d0)) (PreH6 : (d0 <= 1)) (PreH7 : ((a0 + d0 ) <= 1)) (PreH8 : (wa0 >= 0)) (PreH9 : (wd0 >= 0)) (PreH10 : (0 <= t0)) (PreH11 : (t0 <= 5)) (PreH12 : (0 <= c0)) (PreH13 : (c0 <= 3)) (PreH14 : (c0 <= (3 * (a0 + d0 ) ))) (PreH15 : (t0 <= (5 * (a0 + d0 ) ))) (PreH16 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH17 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH18 : (c0 < INT_MAX)) (PreH19 : (wa0 < INT_MAX)) (PreH20 : (wd0 < INT_MAX)) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> 0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> a0)
|--
  (EX (retval_Plane_Counter: Z)  (retval_Runway_Time: Z)  (retval_W_D: Z)  (retval_W_A: Z)  (retval_ModeD: Z)  (retval_ModeA: Z) ,
  “ (0 <= retval_ModeA) ” 
  &&  “ (retval_ModeA <= 1) ” 
  &&  “ (0 <= retval_ModeD) ” 
  &&  “ (retval_ModeD <= 1) ” 
  &&  “ ((retval_ModeA + retval_ModeD ) <= 1) ” 
  &&  “ (retval_W_A >= 0) ” 
  &&  “ (retval_W_D >= 0) ” 
  &&  “ (0 <= retval_Runway_Time) ” 
  &&  “ (retval_Runway_Time <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter) ” 
  &&  “ (retval_Plane_Counter <= 3) ” 
  &&  “ (retval_Plane_Counter <= (3 * (retval_ModeA + retval_ModeD ) )) ” 
  &&  “ (retval_Runway_Time <= (5 * (retval_ModeA + retval_ModeD ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - retval_ModeA ) + retval_W_D ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - retval_ModeD ) + retval_W_A ) )) ” 
  &&  “ (retval_ModeA = 1) ” 
  &&  “ (wd0 <= 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter))
  ||
  (EX (retval_Plane_Counter_2: Z)  (retval_Runway_Time_2: Z)  (retval_W_D_2: Z)  (retval_W_A_2: Z)  (retval_ModeD_2: Z)  (retval_ModeA_2: Z) ,
  “ (0 <= retval_ModeA_2) ” 
  &&  “ (retval_ModeA_2 <= 1) ” 
  &&  “ (0 <= retval_ModeD_2) ” 
  &&  “ (retval_ModeD_2 <= 1) ” 
  &&  “ ((retval_ModeA_2 + retval_ModeD_2 ) <= 1) ” 
  &&  “ (retval_W_A_2 >= 0) ” 
  &&  “ (retval_W_D_2 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_2) ” 
  &&  “ (retval_Runway_Time_2 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_2) ” 
  &&  “ (retval_Plane_Counter_2 <= 3) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * (retval_ModeA_2 + retval_ModeD_2 ) )) ” 
  &&  “ (retval_Runway_Time_2 <= (5 * (retval_ModeA_2 + retval_ModeD_2 ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - retval_ModeA_2 ) + retval_W_D_2 ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - retval_ModeD_2 ) + retval_W_A_2 ) )) ” 
  &&  “ (retval_ModeA_2 = 1) ” 
  &&  “ (wa0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_2)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_2)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_2)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_2)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_2)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_2))
  ||
  (EX (retval_Plane_Counter_3: Z)  (retval_Runway_Time_3: Z)  (retval_W_D_3: Z)  (retval_W_A_3: Z)  (retval_ModeD_3: Z)  (retval_ModeA_3: Z) ,
  “ (0 <= retval_ModeA_3) ” 
  &&  “ (retval_ModeA_3 <= 1) ” 
  &&  “ (0 <= retval_ModeD_3) ” 
  &&  “ (retval_ModeD_3 <= 1) ” 
  &&  “ ((retval_ModeA_3 + retval_ModeD_3 ) <= 1) ” 
  &&  “ (retval_W_A_3 >= 0) ” 
  &&  “ (retval_W_D_3 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_3) ” 
  &&  “ (retval_Runway_Time_3 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_3) ” 
  &&  “ (retval_Plane_Counter_3 <= 3) ” 
  &&  “ (retval_Plane_Counter_3 <= (3 * (retval_ModeA_3 + retval_ModeD_3 ) )) ” 
  &&  “ (retval_Runway_Time_3 <= (5 * (retval_ModeA_3 + retval_ModeD_3 ) )) ” 
  &&  “ (retval_Plane_Counter_3 <= (3 * ((1 - retval_ModeA_3 ) + retval_W_D_3 ) )) ” 
  &&  “ (retval_Plane_Counter_3 <= (3 * ((1 - retval_ModeD_3 ) + retval_W_A_3 ) )) ” 
  &&  “ (retval_ModeA_3 = 1) ” 
  &&  “ (t0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_3)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_3)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_3)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_3)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_3)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_3))
  ||
  (EX (retval_Plane_Counter_5: Z)  (retval_Runway_Time_5: Z)  (retval_W_D_5: Z)  (retval_W_A_5: Z)  (retval_ModeD_5: Z)  (retval_ModeA_5: Z) ,
  “ (0 <= retval_ModeA_5) ” 
  &&  “ (retval_ModeA_5 <= 1) ” 
  &&  “ (0 <= retval_ModeD_5) ” 
  &&  “ (retval_ModeD_5 <= 1) ” 
  &&  “ ((retval_ModeA_5 + retval_ModeD_5 ) <= 1) ” 
  &&  “ (retval_W_A_5 >= 0) ” 
  &&  “ (retval_W_D_5 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_5) ” 
  &&  “ (retval_Runway_Time_5 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_5) ” 
  &&  “ (retval_Plane_Counter_5 <= 3) ” 
  &&  “ (retval_Plane_Counter_5 <= (3 * (retval_ModeA_5 + retval_ModeD_5 ) )) ” 
  &&  “ (retval_Runway_Time_5 <= (5 * (retval_ModeA_5 + retval_ModeD_5 ) )) ” 
  &&  “ (retval_Plane_Counter_5 <= (3 * ((1 - retval_ModeA_5 ) + retval_W_D_5 ) )) ” 
  &&  “ (retval_Plane_Counter_5 <= (3 * ((1 - retval_ModeD_5 ) + retval_W_A_5 ) )) ” 
  &&  “ (t0 <> 0) ” 
  &&  “ (wd0 <= 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_5)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_5)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_5)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_5)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_5)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_5))
  ||
  (EX (retval_Plane_Counter_6: Z)  (retval_Runway_Time_6: Z)  (retval_W_D_6: Z)  (retval_W_A_6: Z)  (retval_ModeD_6: Z)  (retval_ModeA_6: Z) ,
  “ (0 <= retval_ModeA_6) ” 
  &&  “ (retval_ModeA_6 <= 1) ” 
  &&  “ (0 <= retval_ModeD_6) ” 
  &&  “ (retval_ModeD_6 <= 1) ” 
  &&  “ ((retval_ModeA_6 + retval_ModeD_6 ) <= 1) ” 
  &&  “ (retval_W_A_6 >= 0) ” 
  &&  “ (retval_W_D_6 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_6) ” 
  &&  “ (retval_Runway_Time_6 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_6) ” 
  &&  “ (retval_Plane_Counter_6 <= 3) ” 
  &&  “ (retval_Plane_Counter_6 <= (3 * (retval_ModeA_6 + retval_ModeD_6 ) )) ” 
  &&  “ (retval_Runway_Time_6 <= (5 * (retval_ModeA_6 + retval_ModeD_6 ) )) ” 
  &&  “ (retval_Plane_Counter_6 <= (3 * ((1 - retval_ModeA_6 ) + retval_W_D_6 ) )) ” 
  &&  “ (retval_Plane_Counter_6 <= (3 * ((1 - retval_ModeD_6 ) + retval_W_A_6 ) )) ” 
  &&  “ (t0 <> 0) ” 
  &&  “ (wa0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_6)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_6)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_6)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_6)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_6)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_6))
  ||
  (EX (retval_Plane_Counter_7: Z)  (retval_Runway_Time_7: Z)  (retval_W_D_7: Z)  (retval_W_A_7: Z)  (retval_ModeD_7: Z)  (retval_ModeA_7: Z) ,
  “ (0 <= retval_ModeA_7) ” 
  &&  “ (retval_ModeA_7 <= 1) ” 
  &&  “ (0 <= retval_ModeD_7) ” 
  &&  “ (retval_ModeD_7 <= 1) ” 
  &&  “ ((retval_ModeA_7 + retval_ModeD_7 ) <= 1) ” 
  &&  “ (retval_W_A_7 >= 0) ” 
  &&  “ (retval_W_D_7 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_7) ” 
  &&  “ (retval_Runway_Time_7 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_7) ” 
  &&  “ (retval_Plane_Counter_7 <= 3) ” 
  &&  “ (retval_Plane_Counter_7 <= (3 * (retval_ModeA_7 + retval_ModeD_7 ) )) ” 
  &&  “ (retval_Runway_Time_7 <= (5 * (retval_ModeA_7 + retval_ModeD_7 ) )) ” 
  &&  “ (retval_Plane_Counter_7 <= (3 * ((1 - retval_ModeA_7 ) + retval_W_D_7 ) )) ” 
  &&  “ (retval_Plane_Counter_7 <= (3 * ((1 - retval_ModeD_7 ) + retval_W_A_7 ) )) ” 
  &&  “ (t0 <> 0) ” 
  &&  “ (t0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_7)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_7)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_7)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_7)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_7)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_7))
  ||
  (EX (retval_Plane_Counter_8: Z)  (retval_Runway_Time_8: Z)  (retval_W_D_8: Z)  (retval_W_A_8: Z)  (retval_ModeD_8: Z)  (retval_ModeA_8: Z) ,
  “ (0 <= retval_ModeA_8) ” 
  &&  “ (retval_ModeA_8 <= 1) ” 
  &&  “ (0 <= retval_ModeD_8) ” 
  &&  “ (retval_ModeD_8 <= 1) ” 
  &&  “ ((retval_ModeA_8 + retval_ModeD_8 ) <= 1) ” 
  &&  “ (retval_W_A_8 >= 0) ” 
  &&  “ (retval_W_D_8 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_8) ” 
  &&  “ (retval_Runway_Time_8 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_8) ” 
  &&  “ (retval_Plane_Counter_8 <= 3) ” 
  &&  “ (retval_Plane_Counter_8 <= (3 * (retval_ModeA_8 + retval_ModeD_8 ) )) ” 
  &&  “ (retval_Runway_Time_8 <= (5 * (retval_ModeA_8 + retval_ModeD_8 ) )) ” 
  &&  “ (retval_Plane_Counter_8 <= (3 * ((1 - retval_ModeA_8 ) + retval_W_D_8 ) )) ” 
  &&  “ (retval_Plane_Counter_8 <= (3 * ((1 - retval_ModeD_8 ) + retval_W_A_8 ) )) ” 
  &&  “ (t0 <> 0) ” 
  &&  “ (retval_ModeD_8 = 1) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_8)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_8)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_8)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_8)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_8)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_8))
  ||
  (EX (retval_Plane_Counter_10: Z)  (retval_Runway_Time_10: Z)  (retval_W_D_10: Z)  (retval_W_A_10: Z)  (retval_ModeD_10: Z)  (retval_ModeA_10: Z) ,
  “ (0 <= retval_ModeA_10) ” 
  &&  “ (retval_ModeA_10 <= 1) ” 
  &&  “ (0 <= retval_ModeD_10) ” 
  &&  “ (retval_ModeD_10 <= 1) ” 
  &&  “ ((retval_ModeA_10 + retval_ModeD_10 ) <= 1) ” 
  &&  “ (retval_W_A_10 >= 0) ” 
  &&  “ (retval_W_D_10 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_10) ” 
  &&  “ (retval_Runway_Time_10 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_10) ” 
  &&  “ (retval_Plane_Counter_10 <= 3) ” 
  &&  “ (retval_Plane_Counter_10 <= (3 * (retval_ModeA_10 + retval_ModeD_10 ) )) ” 
  &&  “ (retval_Runway_Time_10 <= (5 * (retval_ModeA_10 + retval_ModeD_10 ) )) ” 
  &&  “ (retval_Plane_Counter_10 <= (3 * ((1 - retval_ModeA_10 ) + retval_W_D_10 ) )) ” 
  &&  “ (retval_Plane_Counter_10 <= (3 * ((1 - retval_ModeD_10 ) + retval_W_A_10 ) )) ” 
  &&  “ (wd0 <> 0) ” 
  &&  “ (wa0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_10)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_10)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_10)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_10)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_10)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_10))
  ||
  (EX (retval_Plane_Counter_11: Z)  (retval_Runway_Time_11: Z)  (retval_W_D_11: Z)  (retval_W_A_11: Z)  (retval_ModeD_11: Z)  (retval_ModeA_11: Z) ,
  “ (0 <= retval_ModeA_11) ” 
  &&  “ (retval_ModeA_11 <= 1) ” 
  &&  “ (0 <= retval_ModeD_11) ” 
  &&  “ (retval_ModeD_11 <= 1) ” 
  &&  “ ((retval_ModeA_11 + retval_ModeD_11 ) <= 1) ” 
  &&  “ (retval_W_A_11 >= 0) ” 
  &&  “ (retval_W_D_11 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_11) ” 
  &&  “ (retval_Runway_Time_11 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_11) ” 
  &&  “ (retval_Plane_Counter_11 <= 3) ” 
  &&  “ (retval_Plane_Counter_11 <= (3 * (retval_ModeA_11 + retval_ModeD_11 ) )) ” 
  &&  “ (retval_Runway_Time_11 <= (5 * (retval_ModeA_11 + retval_ModeD_11 ) )) ” 
  &&  “ (retval_Plane_Counter_11 <= (3 * ((1 - retval_ModeA_11 ) + retval_W_D_11 ) )) ” 
  &&  “ (retval_Plane_Counter_11 <= (3 * ((1 - retval_ModeD_11 ) + retval_W_A_11 ) )) ” 
  &&  “ (wd0 <> 0) ” 
  &&  “ (t0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_11)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_11)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_11)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_11)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_11)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_11))
  ||
  (EX (retval_Plane_Counter_12: Z)  (retval_Runway_Time_12: Z)  (retval_W_D_12: Z)  (retval_W_A_12: Z)  (retval_ModeD_12: Z)  (retval_ModeA_12: Z) ,
  “ (0 <= retval_ModeA_12) ” 
  &&  “ (retval_ModeA_12 <= 1) ” 
  &&  “ (0 <= retval_ModeD_12) ” 
  &&  “ (retval_ModeD_12 <= 1) ” 
  &&  “ ((retval_ModeA_12 + retval_ModeD_12 ) <= 1) ” 
  &&  “ (retval_W_A_12 >= 0) ” 
  &&  “ (retval_W_D_12 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_12) ” 
  &&  “ (retval_Runway_Time_12 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_12) ” 
  &&  “ (retval_Plane_Counter_12 <= 3) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * (retval_ModeA_12 + retval_ModeD_12 ) )) ” 
  &&  “ (retval_Runway_Time_12 <= (5 * (retval_ModeA_12 + retval_ModeD_12 ) )) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * ((1 - retval_ModeA_12 ) + retval_W_D_12 ) )) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * ((1 - retval_ModeD_12 ) + retval_W_A_12 ) )) ” 
  &&  “ (wd0 <> 0) ” 
  &&  “ (retval_ModeD_12 = 1) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_12)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_12)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_12)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_12)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_12)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_12))
  ||
  (EX (retval_Plane_Counter_13: Z)  (retval_Runway_Time_13: Z)  (retval_W_D_13: Z)  (retval_W_A_13: Z)  (retval_ModeD_13: Z)  (retval_ModeA_13: Z) ,
  “ (0 <= retval_ModeA_13) ” 
  &&  “ (retval_ModeA_13 <= 1) ” 
  &&  “ (0 <= retval_ModeD_13) ” 
  &&  “ (retval_ModeD_13 <= 1) ” 
  &&  “ ((retval_ModeA_13 + retval_ModeD_13 ) <= 1) ” 
  &&  “ (retval_W_A_13 >= 0) ” 
  &&  “ (retval_W_D_13 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_13) ” 
  &&  “ (retval_Runway_Time_13 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_13) ” 
  &&  “ (retval_Plane_Counter_13 <= 3) ” 
  &&  “ (retval_Plane_Counter_13 <= (3 * (retval_ModeA_13 + retval_ModeD_13 ) )) ” 
  &&  “ (retval_Runway_Time_13 <= (5 * (retval_ModeA_13 + retval_ModeD_13 ) )) ” 
  &&  “ (retval_Plane_Counter_13 <= (3 * ((1 - retval_ModeA_13 ) + retval_W_D_13 ) )) ” 
  &&  “ (retval_Plane_Counter_13 <= (3 * ((1 - retval_ModeD_13 ) + retval_W_A_13 ) )) ” 
  &&  “ (wa0 <= 0) ” 
  &&  “ (wd0 <= 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_13)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_13)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_13)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_13)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_13)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_13))
  ||
  (EX (retval_Plane_Counter_15: Z)  (retval_Runway_Time_15: Z)  (retval_W_D_15: Z)  (retval_W_A_15: Z)  (retval_ModeD_15: Z)  (retval_ModeA_15: Z) ,
  “ (0 <= retval_ModeA_15) ” 
  &&  “ (retval_ModeA_15 <= 1) ” 
  &&  “ (0 <= retval_ModeD_15) ” 
  &&  “ (retval_ModeD_15 <= 1) ” 
  &&  “ ((retval_ModeA_15 + retval_ModeD_15 ) <= 1) ” 
  &&  “ (retval_W_A_15 >= 0) ” 
  &&  “ (retval_W_D_15 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_15) ” 
  &&  “ (retval_Runway_Time_15 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_15) ” 
  &&  “ (retval_Plane_Counter_15 <= 3) ” 
  &&  “ (retval_Plane_Counter_15 <= (3 * (retval_ModeA_15 + retval_ModeD_15 ) )) ” 
  &&  “ (retval_Runway_Time_15 <= (5 * (retval_ModeA_15 + retval_ModeD_15 ) )) ” 
  &&  “ (retval_Plane_Counter_15 <= (3 * ((1 - retval_ModeA_15 ) + retval_W_D_15 ) )) ” 
  &&  “ (retval_Plane_Counter_15 <= (3 * ((1 - retval_ModeD_15 ) + retval_W_A_15 ) )) ” 
  &&  “ (wa0 <= 0) ” 
  &&  “ (t0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_15)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_15)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_15)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_15)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_15)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_15))
  ||
  (EX (retval_Plane_Counter_16: Z)  (retval_Runway_Time_16: Z)  (retval_W_D_16: Z)  (retval_W_A_16: Z)  (retval_ModeD_16: Z)  (retval_ModeA_16: Z) ,
  “ (0 <= retval_ModeA_16) ” 
  &&  “ (retval_ModeA_16 <= 1) ” 
  &&  “ (0 <= retval_ModeD_16) ” 
  &&  “ (retval_ModeD_16 <= 1) ” 
  &&  “ ((retval_ModeA_16 + retval_ModeD_16 ) <= 1) ” 
  &&  “ (retval_W_A_16 >= 0) ” 
  &&  “ (retval_W_D_16 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_16) ” 
  &&  “ (retval_Runway_Time_16 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_16) ” 
  &&  “ (retval_Plane_Counter_16 <= 3) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * (retval_ModeA_16 + retval_ModeD_16 ) )) ” 
  &&  “ (retval_Runway_Time_16 <= (5 * (retval_ModeA_16 + retval_ModeD_16 ) )) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * ((1 - retval_ModeA_16 ) + retval_W_D_16 ) )) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * ((1 - retval_ModeD_16 ) + retval_W_A_16 ) )) ” 
  &&  “ (wa0 <= 0) ” 
  &&  “ (retval_ModeD_16 = 1) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_16)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_16)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_16)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_16)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_16)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_16))
.

Definition tick_return_wit_16 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (t0 <> 5)) (PreH2 : (t0 > 0)) (PreH3 : (0 <= a0)) (PreH4 : (a0 <= 1)) (PreH5 : (0 <= d0)) (PreH6 : (d0 <= 1)) (PreH7 : ((a0 + d0 ) <= 1)) (PreH8 : (wa0 >= 0)) (PreH9 : (wd0 >= 0)) (PreH10 : (0 <= t0)) (PreH11 : (t0 <= 5)) (PreH12 : (0 <= c0)) (PreH13 : (c0 <= 3)) (PreH14 : (c0 <= (3 * (a0 + d0 ) ))) (PreH15 : (t0 <= (5 * (a0 + d0 ) ))) (PreH16 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH17 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH18 : (c0 < INT_MAX)) (PreH19 : (wa0 < INT_MAX)) (PreH20 : (wd0 < INT_MAX)) ,
  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> a0)
|--
  (EX (retval_Plane_Counter: Z)  (retval_Runway_Time: Z)  (retval_W_D: Z)  (retval_W_A: Z)  (retval_ModeD: Z)  (retval_ModeA: Z) ,
  “ (0 <= retval_ModeA) ” 
  &&  “ (retval_ModeA <= 1) ” 
  &&  “ (0 <= retval_ModeD) ” 
  &&  “ (retval_ModeD <= 1) ” 
  &&  “ ((retval_ModeA + retval_ModeD ) <= 1) ” 
  &&  “ (retval_W_A >= 0) ” 
  &&  “ (retval_W_D >= 0) ” 
  &&  “ (0 <= retval_Runway_Time) ” 
  &&  “ (retval_Runway_Time <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter) ” 
  &&  “ (retval_Plane_Counter <= 3) ” 
  &&  “ (retval_Plane_Counter <= (3 * (retval_ModeA + retval_ModeD ) )) ” 
  &&  “ (retval_Runway_Time <= (5 * (retval_ModeA + retval_ModeD ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - retval_ModeA ) + retval_W_D ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - retval_ModeD ) + retval_W_A ) )) ” 
  &&  “ (retval_ModeA = 1) ” 
  &&  “ (wd0 <= 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter))
  ||
  (EX (retval_Plane_Counter_2: Z)  (retval_Runway_Time_2: Z)  (retval_W_D_2: Z)  (retval_W_A_2: Z)  (retval_ModeD_2: Z)  (retval_ModeA_2: Z) ,
  “ (0 <= retval_ModeA_2) ” 
  &&  “ (retval_ModeA_2 <= 1) ” 
  &&  “ (0 <= retval_ModeD_2) ” 
  &&  “ (retval_ModeD_2 <= 1) ” 
  &&  “ ((retval_ModeA_2 + retval_ModeD_2 ) <= 1) ” 
  &&  “ (retval_W_A_2 >= 0) ” 
  &&  “ (retval_W_D_2 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_2) ” 
  &&  “ (retval_Runway_Time_2 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_2) ” 
  &&  “ (retval_Plane_Counter_2 <= 3) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * (retval_ModeA_2 + retval_ModeD_2 ) )) ” 
  &&  “ (retval_Runway_Time_2 <= (5 * (retval_ModeA_2 + retval_ModeD_2 ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - retval_ModeA_2 ) + retval_W_D_2 ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - retval_ModeD_2 ) + retval_W_A_2 ) )) ” 
  &&  “ (retval_ModeA_2 = 1) ” 
  &&  “ (wa0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_2)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_2)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_2)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_2)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_2)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_2))
  ||
  (EX (retval_Plane_Counter_3: Z)  (retval_Runway_Time_3: Z)  (retval_W_D_3: Z)  (retval_W_A_3: Z)  (retval_ModeD_3: Z)  (retval_ModeA_3: Z) ,
  “ (0 <= retval_ModeA_3) ” 
  &&  “ (retval_ModeA_3 <= 1) ” 
  &&  “ (0 <= retval_ModeD_3) ” 
  &&  “ (retval_ModeD_3 <= 1) ” 
  &&  “ ((retval_ModeA_3 + retval_ModeD_3 ) <= 1) ” 
  &&  “ (retval_W_A_3 >= 0) ” 
  &&  “ (retval_W_D_3 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_3) ” 
  &&  “ (retval_Runway_Time_3 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_3) ” 
  &&  “ (retval_Plane_Counter_3 <= 3) ” 
  &&  “ (retval_Plane_Counter_3 <= (3 * (retval_ModeA_3 + retval_ModeD_3 ) )) ” 
  &&  “ (retval_Runway_Time_3 <= (5 * (retval_ModeA_3 + retval_ModeD_3 ) )) ” 
  &&  “ (retval_Plane_Counter_3 <= (3 * ((1 - retval_ModeA_3 ) + retval_W_D_3 ) )) ” 
  &&  “ (retval_Plane_Counter_3 <= (3 * ((1 - retval_ModeD_3 ) + retval_W_A_3 ) )) ” 
  &&  “ (retval_ModeA_3 = 1) ” 
  &&  “ (t0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_3)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_3)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_3)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_3)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_3)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_3))
  ||
  (EX (retval_Plane_Counter_5: Z)  (retval_Runway_Time_5: Z)  (retval_W_D_5: Z)  (retval_W_A_5: Z)  (retval_ModeD_5: Z)  (retval_ModeA_5: Z) ,
  “ (0 <= retval_ModeA_5) ” 
  &&  “ (retval_ModeA_5 <= 1) ” 
  &&  “ (0 <= retval_ModeD_5) ” 
  &&  “ (retval_ModeD_5 <= 1) ” 
  &&  “ ((retval_ModeA_5 + retval_ModeD_5 ) <= 1) ” 
  &&  “ (retval_W_A_5 >= 0) ” 
  &&  “ (retval_W_D_5 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_5) ” 
  &&  “ (retval_Runway_Time_5 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_5) ” 
  &&  “ (retval_Plane_Counter_5 <= 3) ” 
  &&  “ (retval_Plane_Counter_5 <= (3 * (retval_ModeA_5 + retval_ModeD_5 ) )) ” 
  &&  “ (retval_Runway_Time_5 <= (5 * (retval_ModeA_5 + retval_ModeD_5 ) )) ” 
  &&  “ (retval_Plane_Counter_5 <= (3 * ((1 - retval_ModeA_5 ) + retval_W_D_5 ) )) ” 
  &&  “ (retval_Plane_Counter_5 <= (3 * ((1 - retval_ModeD_5 ) + retval_W_A_5 ) )) ” 
  &&  “ (t0 <> 0) ” 
  &&  “ (wd0 <= 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_5)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_5)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_5)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_5)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_5)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_5))
  ||
  (EX (retval_Plane_Counter_6: Z)  (retval_Runway_Time_6: Z)  (retval_W_D_6: Z)  (retval_W_A_6: Z)  (retval_ModeD_6: Z)  (retval_ModeA_6: Z) ,
  “ (0 <= retval_ModeA_6) ” 
  &&  “ (retval_ModeA_6 <= 1) ” 
  &&  “ (0 <= retval_ModeD_6) ” 
  &&  “ (retval_ModeD_6 <= 1) ” 
  &&  “ ((retval_ModeA_6 + retval_ModeD_6 ) <= 1) ” 
  &&  “ (retval_W_A_6 >= 0) ” 
  &&  “ (retval_W_D_6 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_6) ” 
  &&  “ (retval_Runway_Time_6 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_6) ” 
  &&  “ (retval_Plane_Counter_6 <= 3) ” 
  &&  “ (retval_Plane_Counter_6 <= (3 * (retval_ModeA_6 + retval_ModeD_6 ) )) ” 
  &&  “ (retval_Runway_Time_6 <= (5 * (retval_ModeA_6 + retval_ModeD_6 ) )) ” 
  &&  “ (retval_Plane_Counter_6 <= (3 * ((1 - retval_ModeA_6 ) + retval_W_D_6 ) )) ” 
  &&  “ (retval_Plane_Counter_6 <= (3 * ((1 - retval_ModeD_6 ) + retval_W_A_6 ) )) ” 
  &&  “ (t0 <> 0) ” 
  &&  “ (wa0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_6)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_6)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_6)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_6)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_6)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_6))
  ||
  (EX (retval_Plane_Counter_7: Z)  (retval_Runway_Time_7: Z)  (retval_W_D_7: Z)  (retval_W_A_7: Z)  (retval_ModeD_7: Z)  (retval_ModeA_7: Z) ,
  “ (0 <= retval_ModeA_7) ” 
  &&  “ (retval_ModeA_7 <= 1) ” 
  &&  “ (0 <= retval_ModeD_7) ” 
  &&  “ (retval_ModeD_7 <= 1) ” 
  &&  “ ((retval_ModeA_7 + retval_ModeD_7 ) <= 1) ” 
  &&  “ (retval_W_A_7 >= 0) ” 
  &&  “ (retval_W_D_7 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_7) ” 
  &&  “ (retval_Runway_Time_7 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_7) ” 
  &&  “ (retval_Plane_Counter_7 <= 3) ” 
  &&  “ (retval_Plane_Counter_7 <= (3 * (retval_ModeA_7 + retval_ModeD_7 ) )) ” 
  &&  “ (retval_Runway_Time_7 <= (5 * (retval_ModeA_7 + retval_ModeD_7 ) )) ” 
  &&  “ (retval_Plane_Counter_7 <= (3 * ((1 - retval_ModeA_7 ) + retval_W_D_7 ) )) ” 
  &&  “ (retval_Plane_Counter_7 <= (3 * ((1 - retval_ModeD_7 ) + retval_W_A_7 ) )) ” 
  &&  “ (t0 <> 0) ” 
  &&  “ (t0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_7)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_7)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_7)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_7)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_7)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_7))
  ||
  (EX (retval_Plane_Counter_8: Z)  (retval_Runway_Time_8: Z)  (retval_W_D_8: Z)  (retval_W_A_8: Z)  (retval_ModeD_8: Z)  (retval_ModeA_8: Z) ,
  “ (0 <= retval_ModeA_8) ” 
  &&  “ (retval_ModeA_8 <= 1) ” 
  &&  “ (0 <= retval_ModeD_8) ” 
  &&  “ (retval_ModeD_8 <= 1) ” 
  &&  “ ((retval_ModeA_8 + retval_ModeD_8 ) <= 1) ” 
  &&  “ (retval_W_A_8 >= 0) ” 
  &&  “ (retval_W_D_8 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_8) ” 
  &&  “ (retval_Runway_Time_8 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_8) ” 
  &&  “ (retval_Plane_Counter_8 <= 3) ” 
  &&  “ (retval_Plane_Counter_8 <= (3 * (retval_ModeA_8 + retval_ModeD_8 ) )) ” 
  &&  “ (retval_Runway_Time_8 <= (5 * (retval_ModeA_8 + retval_ModeD_8 ) )) ” 
  &&  “ (retval_Plane_Counter_8 <= (3 * ((1 - retval_ModeA_8 ) + retval_W_D_8 ) )) ” 
  &&  “ (retval_Plane_Counter_8 <= (3 * ((1 - retval_ModeD_8 ) + retval_W_A_8 ) )) ” 
  &&  “ (t0 <> 0) ” 
  &&  “ (retval_ModeD_8 = 1) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_8)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_8)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_8)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_8)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_8)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_8))
  ||
  (EX (retval_Plane_Counter_10: Z)  (retval_Runway_Time_10: Z)  (retval_W_D_10: Z)  (retval_W_A_10: Z)  (retval_ModeD_10: Z)  (retval_ModeA_10: Z) ,
  “ (0 <= retval_ModeA_10) ” 
  &&  “ (retval_ModeA_10 <= 1) ” 
  &&  “ (0 <= retval_ModeD_10) ” 
  &&  “ (retval_ModeD_10 <= 1) ” 
  &&  “ ((retval_ModeA_10 + retval_ModeD_10 ) <= 1) ” 
  &&  “ (retval_W_A_10 >= 0) ” 
  &&  “ (retval_W_D_10 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_10) ” 
  &&  “ (retval_Runway_Time_10 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_10) ” 
  &&  “ (retval_Plane_Counter_10 <= 3) ” 
  &&  “ (retval_Plane_Counter_10 <= (3 * (retval_ModeA_10 + retval_ModeD_10 ) )) ” 
  &&  “ (retval_Runway_Time_10 <= (5 * (retval_ModeA_10 + retval_ModeD_10 ) )) ” 
  &&  “ (retval_Plane_Counter_10 <= (3 * ((1 - retval_ModeA_10 ) + retval_W_D_10 ) )) ” 
  &&  “ (retval_Plane_Counter_10 <= (3 * ((1 - retval_ModeD_10 ) + retval_W_A_10 ) )) ” 
  &&  “ (wd0 <> 0) ” 
  &&  “ (wa0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_10)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_10)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_10)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_10)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_10)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_10))
  ||
  (EX (retval_Plane_Counter_11: Z)  (retval_Runway_Time_11: Z)  (retval_W_D_11: Z)  (retval_W_A_11: Z)  (retval_ModeD_11: Z)  (retval_ModeA_11: Z) ,
  “ (0 <= retval_ModeA_11) ” 
  &&  “ (retval_ModeA_11 <= 1) ” 
  &&  “ (0 <= retval_ModeD_11) ” 
  &&  “ (retval_ModeD_11 <= 1) ” 
  &&  “ ((retval_ModeA_11 + retval_ModeD_11 ) <= 1) ” 
  &&  “ (retval_W_A_11 >= 0) ” 
  &&  “ (retval_W_D_11 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_11) ” 
  &&  “ (retval_Runway_Time_11 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_11) ” 
  &&  “ (retval_Plane_Counter_11 <= 3) ” 
  &&  “ (retval_Plane_Counter_11 <= (3 * (retval_ModeA_11 + retval_ModeD_11 ) )) ” 
  &&  “ (retval_Runway_Time_11 <= (5 * (retval_ModeA_11 + retval_ModeD_11 ) )) ” 
  &&  “ (retval_Plane_Counter_11 <= (3 * ((1 - retval_ModeA_11 ) + retval_W_D_11 ) )) ” 
  &&  “ (retval_Plane_Counter_11 <= (3 * ((1 - retval_ModeD_11 ) + retval_W_A_11 ) )) ” 
  &&  “ (wd0 <> 0) ” 
  &&  “ (t0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_11)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_11)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_11)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_11)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_11)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_11))
  ||
  (EX (retval_Plane_Counter_12: Z)  (retval_Runway_Time_12: Z)  (retval_W_D_12: Z)  (retval_W_A_12: Z)  (retval_ModeD_12: Z)  (retval_ModeA_12: Z) ,
  “ (0 <= retval_ModeA_12) ” 
  &&  “ (retval_ModeA_12 <= 1) ” 
  &&  “ (0 <= retval_ModeD_12) ” 
  &&  “ (retval_ModeD_12 <= 1) ” 
  &&  “ ((retval_ModeA_12 + retval_ModeD_12 ) <= 1) ” 
  &&  “ (retval_W_A_12 >= 0) ” 
  &&  “ (retval_W_D_12 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_12) ” 
  &&  “ (retval_Runway_Time_12 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_12) ” 
  &&  “ (retval_Plane_Counter_12 <= 3) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * (retval_ModeA_12 + retval_ModeD_12 ) )) ” 
  &&  “ (retval_Runway_Time_12 <= (5 * (retval_ModeA_12 + retval_ModeD_12 ) )) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * ((1 - retval_ModeA_12 ) + retval_W_D_12 ) )) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * ((1 - retval_ModeD_12 ) + retval_W_A_12 ) )) ” 
  &&  “ (wd0 <> 0) ” 
  &&  “ (retval_ModeD_12 = 1) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_12)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_12)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_12)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_12)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_12)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_12))
  ||
  (EX (retval_Plane_Counter_13: Z)  (retval_Runway_Time_13: Z)  (retval_W_D_13: Z)  (retval_W_A_13: Z)  (retval_ModeD_13: Z)  (retval_ModeA_13: Z) ,
  “ (0 <= retval_ModeA_13) ” 
  &&  “ (retval_ModeA_13 <= 1) ” 
  &&  “ (0 <= retval_ModeD_13) ” 
  &&  “ (retval_ModeD_13 <= 1) ” 
  &&  “ ((retval_ModeA_13 + retval_ModeD_13 ) <= 1) ” 
  &&  “ (retval_W_A_13 >= 0) ” 
  &&  “ (retval_W_D_13 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_13) ” 
  &&  “ (retval_Runway_Time_13 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_13) ” 
  &&  “ (retval_Plane_Counter_13 <= 3) ” 
  &&  “ (retval_Plane_Counter_13 <= (3 * (retval_ModeA_13 + retval_ModeD_13 ) )) ” 
  &&  “ (retval_Runway_Time_13 <= (5 * (retval_ModeA_13 + retval_ModeD_13 ) )) ” 
  &&  “ (retval_Plane_Counter_13 <= (3 * ((1 - retval_ModeA_13 ) + retval_W_D_13 ) )) ” 
  &&  “ (retval_Plane_Counter_13 <= (3 * ((1 - retval_ModeD_13 ) + retval_W_A_13 ) )) ” 
  &&  “ (wa0 <= 0) ” 
  &&  “ (wd0 <= 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_13)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_13)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_13)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_13)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_13)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_13))
  ||
  (EX (retval_Plane_Counter_15: Z)  (retval_Runway_Time_15: Z)  (retval_W_D_15: Z)  (retval_W_A_15: Z)  (retval_ModeD_15: Z)  (retval_ModeA_15: Z) ,
  “ (0 <= retval_ModeA_15) ” 
  &&  “ (retval_ModeA_15 <= 1) ” 
  &&  “ (0 <= retval_ModeD_15) ” 
  &&  “ (retval_ModeD_15 <= 1) ” 
  &&  “ ((retval_ModeA_15 + retval_ModeD_15 ) <= 1) ” 
  &&  “ (retval_W_A_15 >= 0) ” 
  &&  “ (retval_W_D_15 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_15) ” 
  &&  “ (retval_Runway_Time_15 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_15) ” 
  &&  “ (retval_Plane_Counter_15 <= 3) ” 
  &&  “ (retval_Plane_Counter_15 <= (3 * (retval_ModeA_15 + retval_ModeD_15 ) )) ” 
  &&  “ (retval_Runway_Time_15 <= (5 * (retval_ModeA_15 + retval_ModeD_15 ) )) ” 
  &&  “ (retval_Plane_Counter_15 <= (3 * ((1 - retval_ModeA_15 ) + retval_W_D_15 ) )) ” 
  &&  “ (retval_Plane_Counter_15 <= (3 * ((1 - retval_ModeD_15 ) + retval_W_A_15 ) )) ” 
  &&  “ (wa0 <= 0) ” 
  &&  “ (t0 <> 0) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_15)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_15)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_15)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_15)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_15)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_15))
  ||
  (EX (retval_Plane_Counter_16: Z)  (retval_Runway_Time_16: Z)  (retval_W_D_16: Z)  (retval_W_A_16: Z)  (retval_ModeD_16: Z)  (retval_ModeA_16: Z) ,
  “ (0 <= retval_ModeA_16) ” 
  &&  “ (retval_ModeA_16 <= 1) ” 
  &&  “ (0 <= retval_ModeD_16) ” 
  &&  “ (retval_ModeD_16 <= 1) ” 
  &&  “ ((retval_ModeA_16 + retval_ModeD_16 ) <= 1) ” 
  &&  “ (retval_W_A_16 >= 0) ” 
  &&  “ (retval_W_D_16 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_16) ” 
  &&  “ (retval_Runway_Time_16 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_16) ” 
  &&  “ (retval_Plane_Counter_16 <= 3) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * (retval_ModeA_16 + retval_ModeD_16 ) )) ” 
  &&  “ (retval_Runway_Time_16 <= (5 * (retval_ModeA_16 + retval_ModeD_16 ) )) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * ((1 - retval_ModeA_16 ) + retval_W_D_16 ) )) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * ((1 - retval_ModeD_16 ) + retval_W_A_16 ) )) ” 
  &&  “ (wa0 <= 0) ” 
  &&  “ (retval_ModeD_16 = 1) ”
  &&  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |-> retval_ModeA_16)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |-> retval_ModeD_16)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |-> retval_W_A_16)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |-> retval_W_D_16)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |-> retval_Runway_Time_16)
  **  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |-> retval_Plane_Counter_16))
.

Definition tick_partial_solve_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (t0 = 5)) (PreH2 : (t0 > 0)) (PreH3 : (0 <= a0)) (PreH4 : (a0 <= 1)) (PreH5 : (0 <= d0)) (PreH6 : (d0 <= 1)) (PreH7 : ((a0 + d0 ) <= 1)) (PreH8 : (wa0 >= 0)) (PreH9 : (wd0 >= 0)) (PreH10 : (0 <= t0)) (PreH11 : (t0 <= 5)) (PreH12 : (0 <= c0)) (PreH13 : (c0 <= 3)) (PreH14 : (c0 <= (3 * (a0 + d0 ) ))) (PreH15 : (t0 <= (5 * (a0 + d0 ) ))) (PreH16 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH17 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH18 : (c0 < INT_MAX)) (PreH19 : (wa0 < INT_MAX)) (PreH20 : (wd0 < INT_MAX)) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (t0 = 5) ” 
  &&  “ (t0 > 0) ” 
  &&  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (c0 < INT_MAX) ” 
  &&  “ (wa0 < INT_MAX) ” 
  &&  “ (wd0 < INT_MAX) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> 0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
.

Definition tick_partial_solve_wit_2 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (t0 <> 5)) (PreH2 : (t0 > 0)) (PreH3 : (0 <= a0)) (PreH4 : (a0 <= 1)) (PreH5 : (0 <= d0)) (PreH6 : (d0 <= 1)) (PreH7 : ((a0 + d0 ) <= 1)) (PreH8 : (wa0 >= 0)) (PreH9 : (wd0 >= 0)) (PreH10 : (0 <= t0)) (PreH11 : (t0 <= 5)) (PreH12 : (0 <= c0)) (PreH13 : (c0 <= 3)) (PreH14 : (c0 <= (3 * (a0 + d0 ) ))) (PreH15 : (t0 <= (5 * (a0 + d0 ) ))) (PreH16 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH17 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH18 : (c0 < INT_MAX)) (PreH19 : (wa0 < INT_MAX)) (PreH20 : (wd0 < INT_MAX)) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (t0 <> 5) ” 
  &&  “ (t0 > 0) ” 
  &&  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (c0 < INT_MAX) ” 
  &&  “ (wa0 < INT_MAX) ” 
  &&  “ (wd0 < INT_MAX) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
.

Definition tick_partial_solve_wit_3 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wd0 > 0)) (PreH2 : (c0 < 3)) (PreH3 : (wa0 > 0)) (PreH4 : (a0 = 1)) (PreH5 : (t0 <= 0)) (PreH6 : (0 <= a0)) (PreH7 : (a0 <= 1)) (PreH8 : (0 <= d0)) (PreH9 : (d0 <= 1)) (PreH10 : ((a0 + d0 ) <= 1)) (PreH11 : (wa0 >= 0)) (PreH12 : (wd0 >= 0)) (PreH13 : (0 <= t0)) (PreH14 : (t0 <= 5)) (PreH15 : (0 <= c0)) (PreH16 : (c0 <= 3)) (PreH17 : (c0 <= (3 * (a0 + d0 ) ))) (PreH18 : (t0 <= (5 * (a0 + d0 ) ))) (PreH19 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH20 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH21 : (c0 < INT_MAX)) (PreH22 : (wa0 < INT_MAX)) (PreH23 : (wd0 < INT_MAX)) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (c0 + 1 ))
|--
  “ (wd0 > 0) ” 
  &&  “ (c0 < 3) ” 
  &&  “ (wa0 > 0) ” 
  &&  “ (a0 = 1) ” 
  &&  “ (t0 <= 0) ” 
  &&  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (c0 < INT_MAX) ” 
  &&  “ (wa0 < INT_MAX) ” 
  &&  “ (wd0 < INT_MAX) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (c0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
.

Definition tick_partial_solve_wit_4 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wd0 <= 0)) (PreH2 : (c0 < 3)) (PreH3 : (wa0 > 0)) (PreH4 : (a0 = 1)) (PreH5 : (t0 <= 0)) (PreH6 : (0 <= a0)) (PreH7 : (a0 <= 1)) (PreH8 : (0 <= d0)) (PreH9 : (d0 <= 1)) (PreH10 : ((a0 + d0 ) <= 1)) (PreH11 : (wa0 >= 0)) (PreH12 : (wd0 >= 0)) (PreH13 : (0 <= t0)) (PreH14 : (t0 <= 5)) (PreH15 : (0 <= c0)) (PreH16 : (c0 <= 3)) (PreH17 : (c0 <= (3 * (a0 + d0 ) ))) (PreH18 : (t0 <= (5 * (a0 + d0 ) ))) (PreH19 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH20 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH21 : (c0 < INT_MAX)) (PreH22 : (wa0 < INT_MAX)) (PreH23 : (wd0 < INT_MAX)) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (wd0 <= 0) ” 
  &&  “ (c0 < 3) ” 
  &&  “ (wa0 > 0) ” 
  &&  “ (a0 = 1) ” 
  &&  “ (t0 <= 0) ” 
  &&  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (c0 < INT_MAX) ” 
  &&  “ (wa0 < INT_MAX) ” 
  &&  “ (wd0 < INT_MAX) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
.

Definition tick_partial_solve_wit_5 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wa0 > 0)) (PreH2 : (c0 < 3)) (PreH3 : (wd0 > 0)) (PreH4 : (d0 = 1)) (PreH5 : (a0 <> 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (c0 + 1 ))
|--
  “ (wa0 > 0) ” 
  &&  “ (c0 < 3) ” 
  &&  “ (wd0 > 0) ” 
  &&  “ (d0 = 1) ” 
  &&  “ (a0 <> 1) ” 
  &&  “ (t0 <= 0) ” 
  &&  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (c0 < INT_MAX) ” 
  &&  “ (wa0 < INT_MAX) ” 
  &&  “ (wd0 < INT_MAX) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (c0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
.

Definition tick_partial_solve_wit_6 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wa0 <= 0)) (PreH2 : (c0 < 3)) (PreH3 : (wd0 > 0)) (PreH4 : (d0 = 1)) (PreH5 : (a0 <> 1)) (PreH6 : (t0 <= 0)) (PreH7 : (0 <= a0)) (PreH8 : (a0 <= 1)) (PreH9 : (0 <= d0)) (PreH10 : (d0 <= 1)) (PreH11 : ((a0 + d0 ) <= 1)) (PreH12 : (wa0 >= 0)) (PreH13 : (wd0 >= 0)) (PreH14 : (0 <= t0)) (PreH15 : (t0 <= 5)) (PreH16 : (0 <= c0)) (PreH17 : (c0 <= 3)) (PreH18 : (c0 <= (3 * (a0 + d0 ) ))) (PreH19 : (t0 <= (5 * (a0 + d0 ) ))) (PreH20 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH21 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH22 : (c0 < INT_MAX)) (PreH23 : (wa0 < INT_MAX)) (PreH24 : (wd0 < INT_MAX)) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (wa0 <= 0) ” 
  &&  “ (c0 < 3) ” 
  &&  “ (wd0 > 0) ” 
  &&  “ (d0 = 1) ” 
  &&  “ (a0 <> 1) ” 
  &&  “ (t0 <= 0) ” 
  &&  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (c0 < INT_MAX) ” 
  &&  “ (wa0 < INT_MAX) ” 
  &&  “ (wd0 < INT_MAX) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
.

Definition tick_partial_solve_wit_7 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wa0 > 0)) (PreH2 : (wd0 > 0)) (PreH3 : (d0 = 0)) (PreH4 : (a0 <> 0)) (PreH5 : (a0 = 1)) (PreH6 : (d0 <> 1)) (PreH7 : (c0 >= 3)) (PreH8 : (wa0 > 0)) (PreH9 : (a0 = 1)) (PreH10 : (t0 <= 0)) (PreH11 : (0 <= a0)) (PreH12 : (a0 <= 1)) (PreH13 : (0 <= d0)) (PreH14 : (d0 <= 1)) (PreH15 : ((a0 + d0 ) <= 1)) (PreH16 : (wa0 >= 0)) (PreH17 : (wd0 >= 0)) (PreH18 : (0 <= t0)) (PreH19 : (t0 <= 5)) (PreH20 : (0 <= c0)) (PreH21 : (c0 <= 3)) (PreH22 : (c0 <= (3 * (a0 + d0 ) ))) (PreH23 : (t0 <= (5 * (a0 + d0 ) ))) (PreH24 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH25 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH26 : (c0 < INT_MAX)) (PreH27 : (wa0 < INT_MAX)) (PreH28 : (wd0 < INT_MAX)) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (0 + 1 ))
|--
  “ (wa0 > 0) ” 
  &&  “ (wd0 > 0) ” 
  &&  “ (d0 = 0) ” 
  &&  “ (a0 <> 0) ” 
  &&  “ (a0 = 1) ” 
  &&  “ (d0 <> 1) ” 
  &&  “ (c0 >= 3) ” 
  &&  “ (wa0 > 0) ” 
  &&  “ (a0 = 1) ” 
  &&  “ (t0 <= 0) ” 
  &&  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (c0 < INT_MAX) ” 
  &&  “ (wa0 < INT_MAX) ” 
  &&  “ (wd0 < INT_MAX) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
.

Definition tick_partial_solve_wit_8 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wa0 <= 0)) (PreH2 : (wd0 > 0)) (PreH3 : (d0 = 0)) (PreH4 : (a0 <> 0)) (PreH5 : (a0 = 1)) (PreH6 : (d0 <> 1)) (PreH7 : (wa0 <= 0)) (PreH8 : (a0 = 1)) (PreH9 : (t0 <= 0)) (PreH10 : (0 <= a0)) (PreH11 : (a0 <= 1)) (PreH12 : (0 <= d0)) (PreH13 : (d0 <= 1)) (PreH14 : ((a0 + d0 ) <= 1)) (PreH15 : (wa0 >= 0)) (PreH16 : (wd0 >= 0)) (PreH17 : (0 <= t0)) (PreH18 : (t0 <= 5)) (PreH19 : (0 <= c0)) (PreH20 : (c0 <= 3)) (PreH21 : (c0 <= (3 * (a0 + d0 ) ))) (PreH22 : (t0 <= (5 * (a0 + d0 ) ))) (PreH23 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH24 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH25 : (c0 < INT_MAX)) (PreH26 : (wa0 < INT_MAX)) (PreH27 : (wd0 < INT_MAX)) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (wa0 <= 0) ” 
  &&  “ (wd0 > 0) ” 
  &&  “ (d0 = 0) ” 
  &&  “ (a0 <> 0) ” 
  &&  “ (a0 = 1) ” 
  &&  “ (d0 <> 1) ” 
  &&  “ (wa0 <= 0) ” 
  &&  “ (a0 = 1) ” 
  &&  “ (t0 <= 0) ” 
  &&  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (c0 < INT_MAX) ” 
  &&  “ (wa0 < INT_MAX) ” 
  &&  “ (wd0 < INT_MAX) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
.

Definition tick_partial_solve_wit_9 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wd0 <= 0)) (PreH2 : (d0 = 0)) (PreH3 : (a0 <> 0)) (PreH4 : (a0 = 1)) (PreH5 : (d0 <> 1)) (PreH6 : (wa0 <= 0)) (PreH7 : (a0 = 1)) (PreH8 : (t0 <= 0)) (PreH9 : (0 <= a0)) (PreH10 : (a0 <= 1)) (PreH11 : (0 <= d0)) (PreH12 : (d0 <= 1)) (PreH13 : ((a0 + d0 ) <= 1)) (PreH14 : (wa0 >= 0)) (PreH15 : (wd0 >= 0)) (PreH16 : (0 <= t0)) (PreH17 : (t0 <= 5)) (PreH18 : (0 <= c0)) (PreH19 : (c0 <= 3)) (PreH20 : (c0 <= (3 * (a0 + d0 ) ))) (PreH21 : (t0 <= (5 * (a0 + d0 ) ))) (PreH22 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH23 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH24 : (c0 < INT_MAX)) (PreH25 : (wa0 < INT_MAX)) (PreH26 : (wd0 < INT_MAX)) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (wd0 <= 0) ” 
  &&  “ (d0 = 0) ” 
  &&  “ (a0 <> 0) ” 
  &&  “ (a0 = 1) ” 
  &&  “ (d0 <> 1) ” 
  &&  “ (wa0 <= 0) ” 
  &&  “ (a0 = 1) ” 
  &&  “ (t0 <= 0) ” 
  &&  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (c0 < INT_MAX) ” 
  &&  “ (wa0 < INT_MAX) ” 
  &&  “ (wd0 < INT_MAX) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 0)
.

Definition tick_partial_solve_wit_10 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wd0 > 0)) (PreH2 : (wa0 > 0)) (PreH3 : (d0 <> 0)) (PreH4 : (a0 = 0)) (PreH5 : (d0 = 1)) (PreH6 : (a0 <> 1)) (PreH7 : (c0 >= 3)) (PreH8 : (wd0 > 0)) (PreH9 : (d0 = 1)) (PreH10 : (a0 <> 1)) (PreH11 : (t0 <= 0)) (PreH12 : (0 <= a0)) (PreH13 : (a0 <= 1)) (PreH14 : (0 <= d0)) (PreH15 : (d0 <= 1)) (PreH16 : ((a0 + d0 ) <= 1)) (PreH17 : (wa0 >= 0)) (PreH18 : (wd0 >= 0)) (PreH19 : (0 <= t0)) (PreH20 : (t0 <= 5)) (PreH21 : (0 <= c0)) (PreH22 : (c0 <= 3)) (PreH23 : (c0 <= (3 * (a0 + d0 ) ))) (PreH24 : (t0 <= (5 * (a0 + d0 ) ))) (PreH25 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH26 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH27 : (c0 < INT_MAX)) (PreH28 : (wa0 < INT_MAX)) (PreH29 : (wd0 < INT_MAX)) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (0 + 1 ))
|--
  “ (wd0 > 0) ” 
  &&  “ (wa0 > 0) ” 
  &&  “ (d0 <> 0) ” 
  &&  “ (a0 = 0) ” 
  &&  “ (d0 = 1) ” 
  &&  “ (a0 <> 1) ” 
  &&  “ (c0 >= 3) ” 
  &&  “ (wd0 > 0) ” 
  &&  “ (d0 = 1) ” 
  &&  “ (a0 <> 1) ” 
  &&  “ (t0 <= 0) ” 
  &&  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (c0 < INT_MAX) ” 
  &&  “ (wa0 < INT_MAX) ” 
  &&  “ (wd0 < INT_MAX) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
.

Definition tick_partial_solve_wit_11 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wd0 <= 0)) (PreH2 : (wa0 > 0)) (PreH3 : (d0 <> 0)) (PreH4 : (a0 = 0)) (PreH5 : (d0 = 1)) (PreH6 : (a0 <> 1)) (PreH7 : (wd0 <= 0)) (PreH8 : (d0 = 1)) (PreH9 : (a0 <> 1)) (PreH10 : (t0 <= 0)) (PreH11 : (0 <= a0)) (PreH12 : (a0 <= 1)) (PreH13 : (0 <= d0)) (PreH14 : (d0 <= 1)) (PreH15 : ((a0 + d0 ) <= 1)) (PreH16 : (wa0 >= 0)) (PreH17 : (wd0 >= 0)) (PreH18 : (0 <= t0)) (PreH19 : (t0 <= 5)) (PreH20 : (0 <= c0)) (PreH21 : (c0 <= 3)) (PreH22 : (c0 <= (3 * (a0 + d0 ) ))) (PreH23 : (t0 <= (5 * (a0 + d0 ) ))) (PreH24 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH25 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH26 : (c0 < INT_MAX)) (PreH27 : (wa0 < INT_MAX)) (PreH28 : (wd0 < INT_MAX)) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (wd0 <= 0) ” 
  &&  “ (wa0 > 0) ” 
  &&  “ (d0 <> 0) ” 
  &&  “ (a0 = 0) ” 
  &&  “ (d0 = 1) ” 
  &&  “ (a0 <> 1) ” 
  &&  “ (wd0 <= 0) ” 
  &&  “ (d0 = 1) ” 
  &&  “ (a0 <> 1) ” 
  &&  “ (t0 <= 0) ” 
  &&  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (c0 < INT_MAX) ” 
  &&  “ (wa0 < INT_MAX) ” 
  &&  “ (wd0 < INT_MAX) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
.

Definition tick_partial_solve_wit_12 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wa0 <= 0)) (PreH2 : (d0 <> 0)) (PreH3 : (a0 = 0)) (PreH4 : (d0 = 1)) (PreH5 : (a0 <> 1)) (PreH6 : (wd0 <= 0)) (PreH7 : (d0 = 1)) (PreH8 : (a0 <> 1)) (PreH9 : (t0 <= 0)) (PreH10 : (0 <= a0)) (PreH11 : (a0 <= 1)) (PreH12 : (0 <= d0)) (PreH13 : (d0 <= 1)) (PreH14 : ((a0 + d0 ) <= 1)) (PreH15 : (wa0 >= 0)) (PreH16 : (wd0 >= 0)) (PreH17 : (0 <= t0)) (PreH18 : (t0 <= 5)) (PreH19 : (0 <= c0)) (PreH20 : (c0 <= 3)) (PreH21 : (c0 <= (3 * (a0 + d0 ) ))) (PreH22 : (t0 <= (5 * (a0 + d0 ) ))) (PreH23 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH24 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH25 : (c0 < INT_MAX)) (PreH26 : (wa0 < INT_MAX)) (PreH27 : (wd0 < INT_MAX)) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
|--
  “ (wa0 <= 0) ” 
  &&  “ (d0 <> 0) ” 
  &&  “ (a0 = 0) ” 
  &&  “ (d0 = 1) ” 
  &&  “ (a0 <> 1) ” 
  &&  “ (wd0 <= 0) ” 
  &&  “ (d0 = 1) ” 
  &&  “ (a0 <> 1) ” 
  &&  “ (t0 <= 0) ” 
  &&  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (c0 < INT_MAX) ” 
  &&  “ (wa0 < INT_MAX) ” 
  &&  “ (wd0 < INT_MAX) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> 0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
.

Definition tick_partial_solve_wit_13 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wd0 > 0)) (PreH2 : (wa0 > 0)) (PreH3 : (d0 <> 1)) (PreH4 : (a0 <> 1)) (PreH5 : (d0 <> 1)) (PreH6 : (a0 <> 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (c0 + 1 ))
|--
  “ (wd0 > 0) ” 
  &&  “ (wa0 > 0) ” 
  &&  “ (d0 <> 1) ” 
  &&  “ (a0 <> 1) ” 
  &&  “ (d0 <> 1) ” 
  &&  “ (a0 <> 1) ” 
  &&  “ (t0 <= 0) ” 
  &&  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (c0 < INT_MAX) ” 
  &&  “ (wa0 < INT_MAX) ” 
  &&  “ (wd0 < INT_MAX) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> (c0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
.

Definition tick_partial_solve_wit_14 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wd0 <= 0)) (PreH2 : (wa0 > 0)) (PreH3 : (d0 <> 1)) (PreH4 : (a0 <> 1)) (PreH5 : (d0 <> 1)) (PreH6 : (a0 <> 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (wd0 <= 0) ” 
  &&  “ (wa0 > 0) ” 
  &&  “ (d0 <> 1) ” 
  &&  “ (a0 <> 1) ” 
  &&  “ (d0 <> 1) ” 
  &&  “ (a0 <> 1) ” 
  &&  “ (t0 <= 0) ” 
  &&  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (c0 < INT_MAX) ” 
  &&  “ (wa0 < INT_MAX) ” 
  &&  “ (wd0 < INT_MAX) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> (wa0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
.

Definition tick_partial_solve_wit_15 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wa0 <= 0)) (PreH2 : (wd0 > 0)) (PreH3 : (wa0 <= 0)) (PreH4 : (d0 <> 1)) (PreH5 : (a0 <> 1)) (PreH6 : (d0 <> 1)) (PreH7 : (a0 <> 1)) (PreH8 : (t0 <= 0)) (PreH9 : (0 <= a0)) (PreH10 : (a0 <= 1)) (PreH11 : (0 <= d0)) (PreH12 : (d0 <= 1)) (PreH13 : ((a0 + d0 ) <= 1)) (PreH14 : (wa0 >= 0)) (PreH15 : (wd0 >= 0)) (PreH16 : (0 <= t0)) (PreH17 : (t0 <= 5)) (PreH18 : (0 <= c0)) (PreH19 : (c0 <= 3)) (PreH20 : (c0 <= (3 * (a0 + d0 ) ))) (PreH21 : (t0 <= (5 * (a0 + d0 ) ))) (PreH22 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH23 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH24 : (c0 < INT_MAX)) (PreH25 : (wa0 < INT_MAX)) (PreH26 : (wd0 < INT_MAX)) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (wa0 <= 0) ” 
  &&  “ (wd0 > 0) ” 
  &&  “ (wa0 <= 0) ” 
  &&  “ (d0 <> 1) ” 
  &&  “ (a0 <> 1) ” 
  &&  “ (d0 <> 1) ” 
  &&  “ (a0 <> 1) ” 
  &&  “ (t0 <= 0) ” 
  &&  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (c0 < INT_MAX) ” 
  &&  “ (wa0 < INT_MAX) ” 
  &&  “ (wd0 < INT_MAX) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> (t0 + 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> (wd0 - 1 ))
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> 1)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> a0)
.

Definition tick_partial_solve_wit_16 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (wd0 <= 0)) (PreH2 : (wa0 <= 0)) (PreH3 : (d0 <> 1)) (PreH4 : (a0 <> 1)) (PreH5 : (d0 <> 1)) (PreH6 : (a0 <> 1)) (PreH7 : (t0 <= 0)) (PreH8 : (0 <= a0)) (PreH9 : (a0 <= 1)) (PreH10 : (0 <= d0)) (PreH11 : (d0 <= 1)) (PreH12 : ((a0 + d0 ) <= 1)) (PreH13 : (wa0 >= 0)) (PreH14 : (wd0 >= 0)) (PreH15 : (0 <= t0)) (PreH16 : (t0 <= 5)) (PreH17 : (0 <= c0)) (PreH18 : (c0 <= 3)) (PreH19 : (c0 <= (3 * (a0 + d0 ) ))) (PreH20 : (t0 <= (5 * (a0 + d0 ) ))) (PreH21 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH22 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH23 : (c0 < INT_MAX)) (PreH24 : (wa0 < INT_MAX)) (PreH25 : (wd0 < INT_MAX)) ,
  (UndefStructPredState record_return )
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
|--
  “ (wd0 <= 0) ” 
  &&  “ (wa0 <= 0) ” 
  &&  “ (d0 <> 1) ” 
  &&  “ (a0 <> 1) ” 
  &&  “ (d0 <> 1) ” 
  &&  “ (a0 <> 1) ” 
  &&  “ (t0 <= 0) ” 
  &&  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (c0 < INT_MAX) ” 
  &&  “ (wa0 < INT_MAX) ” 
  &&  “ (wd0 < INT_MAX) ”
  &&  ((&((record_return)  # "State" ->ₛ "Plane_Counter")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Plane_Counter")) # Int  |-> c0)
  **  ((&((record_return)  # "State" ->ₛ "Runway_Time")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "Runway_Time")) # Int  |-> t0)
  **  ((&((record_return)  # "State" ->ₛ "W_D")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_D")) # Int  |-> wd0)
  **  ((&((record_return)  # "State" ->ₛ "W_A")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "W_A")) # Int  |-> wa0)
  **  ((&((record_return)  # "State" ->ₛ "ModeD")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeD")) # Int  |-> d0)
  **  ((&((record_return)  # "State" ->ₛ "ModeA")) # Int  |->_)
  **  ((&((( &( "s" ) ))  # "State" ->ₛ "ModeA")) # Int  |-> 1)
.

Module Type VC_Correct.

Axiom proof_of_increment_Plane_Counter_safety_wit_1 : increment_Plane_Counter_safety_wit_1.
Axiom proof_of_increment_Plane_Counter_safety_wit_2 : increment_Plane_Counter_safety_wit_2.
Axiom proof_of_increment_Plane_Counter_return_wit_1 : increment_Plane_Counter_return_wit_1.
Axiom proof_of_increment_Plane_Counter_partial_solve_wit_1 : increment_Plane_Counter_partial_solve_wit_1.
Axiom proof_of_increment_Plane_Counter_partial_solve_wit_2 : increment_Plane_Counter_partial_solve_wit_2.
Axiom proof_of_reset_Plane_Counter_safety_wit_1 : reset_Plane_Counter_safety_wit_1.
Axiom proof_of_reset_Plane_Counter_return_wit_1 : reset_Plane_Counter_return_wit_1.
Axiom proof_of_reset_Plane_Counter_partial_solve_wit_1 : reset_Plane_Counter_partial_solve_wit_1.
Axiom proof_of_reset_Plane_Counter_partial_solve_wit_2 : reset_Plane_Counter_partial_solve_wit_2.
Axiom proof_of_increment_Runway_Time_safety_wit_1 : increment_Runway_Time_safety_wit_1.
Axiom proof_of_increment_Runway_Time_safety_wit_2 : increment_Runway_Time_safety_wit_2.
Axiom proof_of_increment_Runway_Time_return_wit_1 : increment_Runway_Time_return_wit_1.
Axiom proof_of_increment_Runway_Time_partial_solve_wit_1 : increment_Runway_Time_partial_solve_wit_1.
Axiom proof_of_increment_Runway_Time_partial_solve_wit_2 : increment_Runway_Time_partial_solve_wit_2.
Axiom proof_of_reset_Runway_Time_safety_wit_1 : reset_Runway_Time_safety_wit_1.
Axiom proof_of_reset_Runway_Time_return_wit_1 : reset_Runway_Time_return_wit_1.
Axiom proof_of_reset_Runway_Time_partial_solve_wit_1 : reset_Runway_Time_partial_solve_wit_1.
Axiom proof_of_reset_Runway_Time_partial_solve_wit_2 : reset_Runway_Time_partial_solve_wit_2.
Axiom proof_of_arrive_safety_wit_1 : arrive_safety_wit_1.
Axiom proof_of_arrive_safety_wit_2 : arrive_safety_wit_2.
Axiom proof_of_arrive_safety_wit_3 : arrive_safety_wit_3.
Axiom proof_of_arrive_safety_wit_4 : arrive_safety_wit_4.
Axiom proof_of_arrive_safety_wit_5 : arrive_safety_wit_5.
Axiom proof_of_arrive_return_wit_1 : arrive_return_wit_1.
Axiom proof_of_arrive_return_wit_2 : arrive_return_wit_2.
Axiom proof_of_arrive_partial_solve_wit_1 : arrive_partial_solve_wit_1.
Axiom proof_of_arrive_partial_solve_wit_2 : arrive_partial_solve_wit_2.
Axiom proof_of_arrive_partial_solve_wit_3 : arrive_partial_solve_wit_3.
Axiom proof_of_depart_safety_wit_1 : depart_safety_wit_1.
Axiom proof_of_depart_safety_wit_2 : depart_safety_wit_2.
Axiom proof_of_depart_safety_wit_3 : depart_safety_wit_3.
Axiom proof_of_depart_safety_wit_4 : depart_safety_wit_4.
Axiom proof_of_depart_safety_wit_5 : depart_safety_wit_5.
Axiom proof_of_depart_return_wit_1 : depart_return_wit_1.
Axiom proof_of_depart_return_wit_2 : depart_return_wit_2.
Axiom proof_of_depart_partial_solve_wit_1 : depart_partial_solve_wit_1.
Axiom proof_of_depart_partial_solve_wit_2 : depart_partial_solve_wit_2.
Axiom proof_of_depart_partial_solve_wit_3 : depart_partial_solve_wit_3.
Axiom proof_of_switch_modes_safety_wit_1 : switch_modes_safety_wit_1.
Axiom proof_of_switch_modes_safety_wit_2 : switch_modes_safety_wit_2.
Axiom proof_of_switch_modes_safety_wit_3 : switch_modes_safety_wit_3.
Axiom proof_of_switch_modes_safety_wit_4 : switch_modes_safety_wit_4.
Axiom proof_of_switch_modes_safety_wit_5 : switch_modes_safety_wit_5.
Axiom proof_of_switch_modes_safety_wit_6 : switch_modes_safety_wit_6.
Axiom proof_of_switch_modes_safety_wit_7 : switch_modes_safety_wit_7.
Axiom proof_of_switch_modes_safety_wit_8 : switch_modes_safety_wit_8.
Axiom proof_of_switch_modes_safety_wit_9 : switch_modes_safety_wit_9.
Axiom proof_of_switch_modes_return_wit_1 : switch_modes_return_wit_1.
Axiom proof_of_switch_modes_return_wit_2 : switch_modes_return_wit_2.
Axiom proof_of_switch_modes_partial_solve_wit_1 : switch_modes_partial_solve_wit_1.
Axiom proof_of_switch_modes_partial_solve_wit_2 : switch_modes_partial_solve_wit_2.
Axiom proof_of_switch_modes_partial_solve_wit_3 : switch_modes_partial_solve_wit_3.
Axiom proof_of_tick_safety_wit_1 : tick_safety_wit_1.
Axiom proof_of_tick_safety_wit_2 : tick_safety_wit_2.
Axiom proof_of_tick_safety_wit_3 : tick_safety_wit_3.
Axiom proof_of_tick_safety_wit_4 : tick_safety_wit_4.
Axiom proof_of_tick_safety_wit_5 : tick_safety_wit_5.
Axiom proof_of_tick_safety_wit_6 : tick_safety_wit_6.
Axiom proof_of_tick_safety_wit_7 : tick_safety_wit_7.
Axiom proof_of_tick_safety_wit_8 : tick_safety_wit_8.
Axiom proof_of_tick_safety_wit_9 : tick_safety_wit_9.
Axiom proof_of_tick_safety_wit_10 : tick_safety_wit_10.
Axiom proof_of_tick_safety_wit_11 : tick_safety_wit_11.
Axiom proof_of_tick_safety_wit_12 : tick_safety_wit_12.
Axiom proof_of_tick_safety_wit_13 : tick_safety_wit_13.
Axiom proof_of_tick_safety_wit_14 : tick_safety_wit_14.
Axiom proof_of_tick_safety_wit_15 : tick_safety_wit_15.
Axiom proof_of_tick_safety_wit_16 : tick_safety_wit_16.
Axiom proof_of_tick_safety_wit_17 : tick_safety_wit_17.
Axiom proof_of_tick_safety_wit_18 : tick_safety_wit_18.
Axiom proof_of_tick_safety_wit_19 : tick_safety_wit_19.
Axiom proof_of_tick_safety_wit_20 : tick_safety_wit_20.
Axiom proof_of_tick_safety_wit_21 : tick_safety_wit_21.
Axiom proof_of_tick_safety_wit_22 : tick_safety_wit_22.
Axiom proof_of_tick_safety_wit_23 : tick_safety_wit_23.
Axiom proof_of_tick_safety_wit_24 : tick_safety_wit_24.
Axiom proof_of_tick_safety_wit_25 : tick_safety_wit_25.
Axiom proof_of_tick_safety_wit_26 : tick_safety_wit_26.
Axiom proof_of_tick_safety_wit_27 : tick_safety_wit_27.
Axiom proof_of_tick_safety_wit_28 : tick_safety_wit_28.
Axiom proof_of_tick_safety_wit_29 : tick_safety_wit_29.
Axiom proof_of_tick_safety_wit_30 : tick_safety_wit_30.
Axiom proof_of_tick_safety_wit_31 : tick_safety_wit_31.
Axiom proof_of_tick_safety_wit_32 : tick_safety_wit_32.
Axiom proof_of_tick_safety_wit_33 : tick_safety_wit_33.
Axiom proof_of_tick_safety_wit_34 : tick_safety_wit_34.
Axiom proof_of_tick_safety_wit_35 : tick_safety_wit_35.
Axiom proof_of_tick_safety_wit_36 : tick_safety_wit_36.
Axiom proof_of_tick_safety_wit_37 : tick_safety_wit_37.
Axiom proof_of_tick_safety_wit_38 : tick_safety_wit_38.
Axiom proof_of_tick_safety_wit_39 : tick_safety_wit_39.
Axiom proof_of_tick_safety_wit_40 : tick_safety_wit_40.
Axiom proof_of_tick_safety_wit_41 : tick_safety_wit_41.
Axiom proof_of_tick_safety_wit_42 : tick_safety_wit_42.
Axiom proof_of_tick_safety_wit_43 : tick_safety_wit_43.
Axiom proof_of_tick_safety_wit_44 : tick_safety_wit_44.
Axiom proof_of_tick_safety_wit_45 : tick_safety_wit_45.
Axiom proof_of_tick_safety_wit_46 : tick_safety_wit_46.
Axiom proof_of_tick_safety_wit_47 : tick_safety_wit_47.
Axiom proof_of_tick_safety_wit_48 : tick_safety_wit_48.
Axiom proof_of_tick_safety_wit_49 : tick_safety_wit_49.
Axiom proof_of_tick_safety_wit_50 : tick_safety_wit_50.
Axiom proof_of_tick_safety_wit_51 : tick_safety_wit_51.
Axiom proof_of_tick_safety_wit_52 : tick_safety_wit_52.
Axiom proof_of_tick_safety_wit_53 : tick_safety_wit_53.
Axiom proof_of_tick_safety_wit_54 : tick_safety_wit_54.
Axiom proof_of_tick_safety_wit_55 : tick_safety_wit_55.
Axiom proof_of_tick_safety_wit_56 : tick_safety_wit_56.
Axiom proof_of_tick_safety_wit_57 : tick_safety_wit_57.
Axiom proof_of_tick_safety_wit_58 : tick_safety_wit_58.
Axiom proof_of_tick_safety_wit_59 : tick_safety_wit_59.
Axiom proof_of_tick_safety_wit_60 : tick_safety_wit_60.
Axiom proof_of_tick_safety_wit_61 : tick_safety_wit_61.
Axiom proof_of_tick_safety_wit_62 : tick_safety_wit_62.
Axiom proof_of_tick_safety_wit_63 : tick_safety_wit_63.
Axiom proof_of_tick_safety_wit_64 : tick_safety_wit_64.
Axiom proof_of_tick_safety_wit_65 : tick_safety_wit_65.
Axiom proof_of_tick_safety_wit_66 : tick_safety_wit_66.
Axiom proof_of_tick_safety_wit_67 : tick_safety_wit_67.
Axiom proof_of_tick_safety_wit_68 : tick_safety_wit_68.
Axiom proof_of_tick_safety_wit_69 : tick_safety_wit_69.
Axiom proof_of_tick_safety_wit_70 : tick_safety_wit_70.
Axiom proof_of_tick_safety_wit_71 : tick_safety_wit_71.
Axiom proof_of_tick_safety_wit_72 : tick_safety_wit_72.
Axiom proof_of_tick_safety_wit_73 : tick_safety_wit_73.
Axiom proof_of_tick_safety_wit_74 : tick_safety_wit_74.
Axiom proof_of_tick_safety_wit_75 : tick_safety_wit_75.
Axiom proof_of_tick_safety_wit_76 : tick_safety_wit_76.
Axiom proof_of_tick_safety_wit_77 : tick_safety_wit_77.
Axiom proof_of_tick_safety_wit_78 : tick_safety_wit_78.
Axiom proof_of_tick_safety_wit_79 : tick_safety_wit_79.
Axiom proof_of_tick_safety_wit_80 : tick_safety_wit_80.
Axiom proof_of_tick_safety_wit_81 : tick_safety_wit_81.
Axiom proof_of_tick_safety_wit_82 : tick_safety_wit_82.
Axiom proof_of_tick_safety_wit_83 : tick_safety_wit_83.
Axiom proof_of_tick_safety_wit_84 : tick_safety_wit_84.
Axiom proof_of_tick_safety_wit_85 : tick_safety_wit_85.
Axiom proof_of_tick_safety_wit_86 : tick_safety_wit_86.
Axiom proof_of_tick_safety_wit_87 : tick_safety_wit_87.
Axiom proof_of_tick_safety_wit_88 : tick_safety_wit_88.
Axiom proof_of_tick_safety_wit_89 : tick_safety_wit_89.
Axiom proof_of_tick_safety_wit_90 : tick_safety_wit_90.
Axiom proof_of_tick_safety_wit_91 : tick_safety_wit_91.
Axiom proof_of_tick_safety_wit_92 : tick_safety_wit_92.
Axiom proof_of_tick_safety_wit_93 : tick_safety_wit_93.
Axiom proof_of_tick_safety_wit_94 : tick_safety_wit_94.
Axiom proof_of_tick_safety_wit_95 : tick_safety_wit_95.
Axiom proof_of_tick_safety_wit_96 : tick_safety_wit_96.
Axiom proof_of_tick_safety_wit_97 : tick_safety_wit_97.
Axiom proof_of_tick_safety_wit_98 : tick_safety_wit_98.
Axiom proof_of_tick_safety_wit_99 : tick_safety_wit_99.
Axiom proof_of_tick_safety_wit_100 : tick_safety_wit_100.
Axiom proof_of_tick_safety_wit_101 : tick_safety_wit_101.
Axiom proof_of_tick_safety_wit_102 : tick_safety_wit_102.
Axiom proof_of_tick_safety_wit_103 : tick_safety_wit_103.
Axiom proof_of_tick_safety_wit_104 : tick_safety_wit_104.
Axiom proof_of_tick_safety_wit_105 : tick_safety_wit_105.
Axiom proof_of_tick_safety_wit_106 : tick_safety_wit_106.
Axiom proof_of_tick_safety_wit_107 : tick_safety_wit_107.
Axiom proof_of_tick_safety_wit_108 : tick_safety_wit_108.
Axiom proof_of_tick_safety_wit_109 : tick_safety_wit_109.
Axiom proof_of_tick_safety_wit_110 : tick_safety_wit_110.
Axiom proof_of_tick_safety_wit_111 : tick_safety_wit_111.
Axiom proof_of_tick_safety_wit_112 : tick_safety_wit_112.
Axiom proof_of_tick_safety_wit_113 : tick_safety_wit_113.
Axiom proof_of_tick_safety_wit_114 : tick_safety_wit_114.
Axiom proof_of_tick_safety_wit_115 : tick_safety_wit_115.
Axiom proof_of_tick_safety_wit_116 : tick_safety_wit_116.
Axiom proof_of_tick_safety_wit_117 : tick_safety_wit_117.
Axiom proof_of_tick_safety_wit_118 : tick_safety_wit_118.
Axiom proof_of_tick_safety_wit_119 : tick_safety_wit_119.
Axiom proof_of_tick_safety_wit_120 : tick_safety_wit_120.
Axiom proof_of_tick_safety_wit_121 : tick_safety_wit_121.
Axiom proof_of_tick_safety_wit_122 : tick_safety_wit_122.
Axiom proof_of_tick_safety_wit_123 : tick_safety_wit_123.
Axiom proof_of_tick_safety_wit_124 : tick_safety_wit_124.
Axiom proof_of_tick_safety_wit_125 : tick_safety_wit_125.
Axiom proof_of_tick_safety_wit_126 : tick_safety_wit_126.
Axiom proof_of_tick_safety_wit_127 : tick_safety_wit_127.
Axiom proof_of_tick_safety_wit_128 : tick_safety_wit_128.
Axiom proof_of_tick_safety_wit_129 : tick_safety_wit_129.
Axiom proof_of_tick_safety_wit_130 : tick_safety_wit_130.
Axiom proof_of_tick_safety_wit_131 : tick_safety_wit_131.
Axiom proof_of_tick_return_wit_1 : tick_return_wit_1.
Axiom proof_of_tick_return_wit_2 : tick_return_wit_2.
Axiom proof_of_tick_return_wit_3 : tick_return_wit_3.
Axiom proof_of_tick_return_wit_4 : tick_return_wit_4.
Axiom proof_of_tick_return_wit_5 : tick_return_wit_5.
Axiom proof_of_tick_return_wit_6 : tick_return_wit_6.
Axiom proof_of_tick_return_wit_7 : tick_return_wit_7.
Axiom proof_of_tick_return_wit_8 : tick_return_wit_8.
Axiom proof_of_tick_return_wit_9 : tick_return_wit_9.
Axiom proof_of_tick_return_wit_10 : tick_return_wit_10.
Axiom proof_of_tick_return_wit_11 : tick_return_wit_11.
Axiom proof_of_tick_return_wit_12 : tick_return_wit_12.
Axiom proof_of_tick_return_wit_13 : tick_return_wit_13.
Axiom proof_of_tick_return_wit_14 : tick_return_wit_14.
Axiom proof_of_tick_return_wit_15 : tick_return_wit_15.
Axiom proof_of_tick_return_wit_16 : tick_return_wit_16.
Axiom proof_of_tick_partial_solve_wit_1 : tick_partial_solve_wit_1.
Axiom proof_of_tick_partial_solve_wit_2 : tick_partial_solve_wit_2.
Axiom proof_of_tick_partial_solve_wit_3 : tick_partial_solve_wit_3.
Axiom proof_of_tick_partial_solve_wit_4 : tick_partial_solve_wit_4.
Axiom proof_of_tick_partial_solve_wit_5 : tick_partial_solve_wit_5.
Axiom proof_of_tick_partial_solve_wit_6 : tick_partial_solve_wit_6.
Axiom proof_of_tick_partial_solve_wit_7 : tick_partial_solve_wit_7.
Axiom proof_of_tick_partial_solve_wit_8 : tick_partial_solve_wit_8.
Axiom proof_of_tick_partial_solve_wit_9 : tick_partial_solve_wit_9.
Axiom proof_of_tick_partial_solve_wit_10 : tick_partial_solve_wit_10.
Axiom proof_of_tick_partial_solve_wit_11 : tick_partial_solve_wit_11.
Axiom proof_of_tick_partial_solve_wit_12 : tick_partial_solve_wit_12.
Axiom proof_of_tick_partial_solve_wit_13 : tick_partial_solve_wit_13.
Axiom proof_of_tick_partial_solve_wit_14 : tick_partial_solve_wit_14.
Axiom proof_of_tick_partial_solve_wit_15 : tick_partial_solve_wit_15.
Axiom proof_of_tick_partial_solve_wit_16 : tick_partial_solve_wit_16.

End VC_Correct.
