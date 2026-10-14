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

(*----- Function append -----*)

Definition append_safety_wit_1 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_7 <> 0)) (PreH2 : (y_6 <> 0)) (PreH3 : (y_5 <> 0)) (PreH4 : (y_4 <> 0)) (PreH5 : (y_3 <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (y_8 = 0)) (PreH9 : (y_7 <> 0)) (PreH10 : (y_6 <> 0)) (PreH11 : (y_5 <> 0)) (PreH12 : (y_4 <> 0)) (PreH13 : (y_3 <> 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (INT_MIN))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (INT_MIN))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> (INT_MIN))
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> (INT_MIN))
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> (INT_MIN))
  **  ((4096) # Int  |-> (INT_MIN))
  **  ((( &( "u_spec_429" ) )) # Ptr  |-> 0)
  **  ((( &( "t_spec_426" ) )) # Ptr  |-> y_7)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition append_safety_wit_2 := 
  ((( &( "u_spec_429" ) )) # Ptr  |->_)
  **  ((( &( "t_spec_426" ) )) # Ptr  |->_)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 0)
  **  (sll32 4096 (cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((@nil Z))))))))))))))))) )
  **  (sll32 0 (@nil Z) )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition append_safety_wit_3 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_8 = 0)) (PreH2 : (y_7 <> 0)) (PreH3 : (y_6 <> 0)) (PreH4 : (y_5 <> 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (INT_MIN))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (INT_MIN))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> (INT_MIN))
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> (INT_MIN))
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> (INT_MIN))
  **  ((4096) # Int  |-> (INT_MIN))
  **  ((( &( "u_spec_429" ) )) # Ptr  |-> y)
  **  ((( &( "t_spec_426" ) )) # Ptr  |-> 4096)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition append_safety_wit_4 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y = 0)) (PreH2 : (y_8 = 0)) (PreH3 : (y_7 <> 0)) (PreH4 : (y_6 <> 0)) (PreH5 : (y_5 <> 0)) (PreH6 : (y_4 <> 0)) (PreH7 : (y_3 <> 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (INT_MIN))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (INT_MIN))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> (INT_MIN))
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> (INT_MIN))
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> (INT_MIN))
  **  ((4096) # Int  |-> (INT_MIN))
  **  ((( &( "u_spec_429" ) )) # Ptr  |-> y)
  **  ((( &( "t_spec_426" ) )) # Ptr  |-> 4096)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 0)
|--
  “ False ”
.

Definition append_safety_wit_5 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y <> 0)) (PreH2 : (y_8 = 0)) (PreH3 : (y_7 <> 0)) (PreH4 : (y_6 <> 0)) (PreH5 : (y_5 <> 0)) (PreH6 : (y_4 <> 0)) (PreH7 : (y_3 <> 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (INT_MIN))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (INT_MIN))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> (INT_MIN))
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> (INT_MIN))
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> (INT_MIN))
  **  ((4096) # Int  |-> (INT_MIN))
  **  ((( &( "u_spec_429" ) )) # Ptr  |-> y_2)
  **  ((( &( "t_spec_426" ) )) # Ptr  |-> y)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition append_safety_wit_6 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_8 = 0)) (PreH4 : (y_7 <> 0)) (PreH5 : (y_6 <> 0)) (PreH6 : (y_5 <> 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (INT_MIN))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (INT_MIN))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> (INT_MIN))
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> (INT_MIN))
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> (INT_MIN))
  **  ((4096) # Int  |-> (INT_MIN))
  **  ((( &( "u_spec_429" ) )) # Ptr  |-> y_2)
  **  ((( &( "t_spec_426" ) )) # Ptr  |-> y)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 0)
|--
  “ False ”
.

Definition append_safety_wit_7 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_8 = 0)) (PreH4 : (y_7 <> 0)) (PreH5 : (y_6 <> 0)) (PreH6 : (y_5 <> 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (INT_MIN))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (INT_MIN))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> (INT_MIN))
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> (INT_MIN))
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> (INT_MIN))
  **  ((4096) # Int  |-> (INT_MIN))
  **  ((( &( "u_spec_429" ) )) # Ptr  |-> y_3)
  **  ((( &( "t_spec_426" ) )) # Ptr  |-> y_2)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition append_safety_wit_8 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_8 = 0)) (PreH5 : (y_7 <> 0)) (PreH6 : (y_6 <> 0)) (PreH7 : (y_5 <> 0)) (PreH8 : (y_4 <> 0)) (PreH9 : (y_3 <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (INT_MIN))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (INT_MIN))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> (INT_MIN))
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> (INT_MIN))
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> (INT_MIN))
  **  ((4096) # Int  |-> (INT_MIN))
  **  ((( &( "u_spec_429" ) )) # Ptr  |-> y_3)
  **  ((( &( "t_spec_426" ) )) # Ptr  |-> y_2)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 0)
|--
  “ False ”
.

Definition append_safety_wit_9 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_3 <> 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_8 = 0)) (PreH5 : (y_7 <> 0)) (PreH6 : (y_6 <> 0)) (PreH7 : (y_5 <> 0)) (PreH8 : (y_4 <> 0)) (PreH9 : (y_3 <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (INT_MIN))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (INT_MIN))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> (INT_MIN))
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> (INT_MIN))
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> (INT_MIN))
  **  ((4096) # Int  |-> (INT_MIN))
  **  ((( &( "u_spec_429" ) )) # Ptr  |-> y_4)
  **  ((( &( "t_spec_426" ) )) # Ptr  |-> y_3)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition append_safety_wit_10 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_4 = 0)) (PreH2 : (y_3 <> 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_8 = 0)) (PreH6 : (y_7 <> 0)) (PreH7 : (y_6 <> 0)) (PreH8 : (y_5 <> 0)) (PreH9 : (y_4 <> 0)) (PreH10 : (y_3 <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (INT_MIN))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (INT_MIN))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> (INT_MIN))
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> (INT_MIN))
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> (INT_MIN))
  **  ((4096) # Int  |-> (INT_MIN))
  **  ((( &( "u_spec_429" ) )) # Ptr  |-> y_4)
  **  ((( &( "t_spec_426" ) )) # Ptr  |-> y_3)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 0)
|--
  “ False ”
.

Definition append_safety_wit_11 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_4 <> 0)) (PreH2 : (y_3 <> 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_8 = 0)) (PreH6 : (y_7 <> 0)) (PreH7 : (y_6 <> 0)) (PreH8 : (y_5 <> 0)) (PreH9 : (y_4 <> 0)) (PreH10 : (y_3 <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (INT_MIN))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (INT_MIN))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> (INT_MIN))
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> (INT_MIN))
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> (INT_MIN))
  **  ((4096) # Int  |-> (INT_MIN))
  **  ((( &( "u_spec_429" ) )) # Ptr  |-> y_5)
  **  ((( &( "t_spec_426" ) )) # Ptr  |-> y_4)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition append_safety_wit_12 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_5 = 0)) (PreH2 : (y_4 <> 0)) (PreH3 : (y_3 <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_8 = 0)) (PreH7 : (y_7 <> 0)) (PreH8 : (y_6 <> 0)) (PreH9 : (y_5 <> 0)) (PreH10 : (y_4 <> 0)) (PreH11 : (y_3 <> 0)) (PreH12 : (y_2 <> 0)) (PreH13 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (INT_MIN))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (INT_MIN))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> (INT_MIN))
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> (INT_MIN))
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> (INT_MIN))
  **  ((4096) # Int  |-> (INT_MIN))
  **  ((( &( "u_spec_429" ) )) # Ptr  |-> y_5)
  **  ((( &( "t_spec_426" ) )) # Ptr  |-> y_4)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 0)
|--
  “ False ”
.

Definition append_safety_wit_13 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_5 <> 0)) (PreH2 : (y_4 <> 0)) (PreH3 : (y_3 <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_8 = 0)) (PreH7 : (y_7 <> 0)) (PreH8 : (y_6 <> 0)) (PreH9 : (y_5 <> 0)) (PreH10 : (y_4 <> 0)) (PreH11 : (y_3 <> 0)) (PreH12 : (y_2 <> 0)) (PreH13 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (INT_MIN))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (INT_MIN))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> (INT_MIN))
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> (INT_MIN))
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> (INT_MIN))
  **  ((4096) # Int  |-> (INT_MIN))
  **  ((( &( "u_spec_429" ) )) # Ptr  |-> y_6)
  **  ((( &( "t_spec_426" ) )) # Ptr  |-> y_5)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition append_safety_wit_14 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_6 = 0)) (PreH2 : (y_5 <> 0)) (PreH3 : (y_4 <> 0)) (PreH4 : (y_3 <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_8 = 0)) (PreH8 : (y_7 <> 0)) (PreH9 : (y_6 <> 0)) (PreH10 : (y_5 <> 0)) (PreH11 : (y_4 <> 0)) (PreH12 : (y_3 <> 0)) (PreH13 : (y_2 <> 0)) (PreH14 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (INT_MIN))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (INT_MIN))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> (INT_MIN))
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> (INT_MIN))
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> (INT_MIN))
  **  ((4096) # Int  |-> (INT_MIN))
  **  ((( &( "u_spec_429" ) )) # Ptr  |-> y_6)
  **  ((( &( "t_spec_426" ) )) # Ptr  |-> y_5)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 0)
|--
  “ False ”
.

Definition append_safety_wit_15 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_6 <> 0)) (PreH2 : (y_5 <> 0)) (PreH3 : (y_4 <> 0)) (PreH4 : (y_3 <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_8 = 0)) (PreH8 : (y_7 <> 0)) (PreH9 : (y_6 <> 0)) (PreH10 : (y_5 <> 0)) (PreH11 : (y_4 <> 0)) (PreH12 : (y_3 <> 0)) (PreH13 : (y_2 <> 0)) (PreH14 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (INT_MIN))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (INT_MIN))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> (INT_MIN))
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> (INT_MIN))
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> (INT_MIN))
  **  ((4096) # Int  |-> (INT_MIN))
  **  ((( &( "u_spec_429" ) )) # Ptr  |-> y_7)
  **  ((( &( "t_spec_426" ) )) # Ptr  |-> y_6)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition append_safety_wit_16 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_7 = 0)) (PreH2 : (y_6 <> 0)) (PreH3 : (y_5 <> 0)) (PreH4 : (y_4 <> 0)) (PreH5 : (y_3 <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (y_8 = 0)) (PreH9 : (y_7 <> 0)) (PreH10 : (y_6 <> 0)) (PreH11 : (y_5 <> 0)) (PreH12 : (y_4 <> 0)) (PreH13 : (y_3 <> 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (INT_MIN))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (INT_MIN))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> (INT_MIN))
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> (INT_MIN))
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> (INT_MIN))
  **  ((4096) # Int  |-> (INT_MIN))
  **  ((( &( "u_spec_429" ) )) # Ptr  |-> y_7)
  **  ((( &( "t_spec_426" ) )) # Ptr  |-> y_6)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 0)
|--
  “ False ”
.

Definition append_safety_wit_17 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_7 <> 0)) (PreH2 : (y_6 <> 0)) (PreH3 : (y_5 <> 0)) (PreH4 : (y_4 <> 0)) (PreH5 : (y_3 <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (y_8 = 0)) (PreH9 : (y_7 <> 0)) (PreH10 : (y_6 <> 0)) (PreH11 : (y_5 <> 0)) (PreH12 : (y_4 <> 0)) (PreH13 : (y_3 <> 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (INT_MIN))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (INT_MIN))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> (INT_MIN))
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> (INT_MIN))
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> (INT_MIN))
  **  ((4096) # Int  |-> (INT_MIN))
  **  ((( &( "u_spec_429" ) )) # Ptr  |-> 0)
  **  ((( &( "t_spec_426" ) )) # Ptr  |-> y_7)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition append_return_wit_1 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_7 <> 0)) (PreH2 : (y_6 <> 0)) (PreH3 : (y_5 <> 0)) (PreH4 : (y_4 <> 0)) (PreH5 : (y_3 <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (y_8 = 0)) (PreH9 : (y_7 <> 0)) (PreH10 : (y_6 <> 0)) (PreH11 : (y_5 <> 0)) (PreH12 : (y_4 <> 0)) (PreH13 : (y_3 <> 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (INT_MIN))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (INT_MIN))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> (INT_MIN))
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> (INT_MIN))
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> (INT_MIN))
  **  ((4096) # Int  |-> (INT_MIN))
|--
  (sll32 4096 (cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((@nil Z))))))))))))))))) )
.

Definition append_partial_solve_wit_1 := 
  (sll32 4096 (cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((@nil Z))))))))))))))))) )
  **  (sll32 0 (@nil Z) )
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
  **  ((y_7) # Int  |-> (INT_MIN))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> (INT_MIN))
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> (INT_MIN))
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (INT_MIN))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> (INT_MIN))
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> (INT_MIN))
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> (INT_MIN))
  **  ((4096) # Int  |-> (INT_MIN))
.

Definition append_precondition_wit_1 :=
~ ((  “ (4096 = 4096) ” 
  &&  “ (0 = 0) ” 
  &&  “ ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((@nil Z))))))))))))))))) = (cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((@nil Z)))))))))))))))))) ” 
  &&  “ ((@nil Z) = (@nil Z)) ”
  &&  (sll32 4096 (cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((cons ((INT_MIN)) ((@nil Z))))))))))))))))) )
  **  (sll32 0 (@nil Z) )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_append_safety_wit_1 : append_safety_wit_1.
Axiom proof_of_append_safety_wit_2 : append_safety_wit_2.
Axiom proof_of_append_safety_wit_3 : append_safety_wit_3.
Axiom proof_of_append_safety_wit_4 : append_safety_wit_4.
Axiom proof_of_append_safety_wit_5 : append_safety_wit_5.
Axiom proof_of_append_safety_wit_6 : append_safety_wit_6.
Axiom proof_of_append_safety_wit_7 : append_safety_wit_7.
Axiom proof_of_append_safety_wit_8 : append_safety_wit_8.
Axiom proof_of_append_safety_wit_9 : append_safety_wit_9.
Axiom proof_of_append_safety_wit_10 : append_safety_wit_10.
Axiom proof_of_append_safety_wit_11 : append_safety_wit_11.
Axiom proof_of_append_safety_wit_12 : append_safety_wit_12.
Axiom proof_of_append_safety_wit_13 : append_safety_wit_13.
Axiom proof_of_append_safety_wit_14 : append_safety_wit_14.
Axiom proof_of_append_safety_wit_15 : append_safety_wit_15.
Axiom proof_of_append_safety_wit_16 : append_safety_wit_16.
Axiom proof_of_append_safety_wit_17 : append_safety_wit_17.
Axiom proof_of_append_return_wit_1 : append_return_wit_1.
Axiom proof_of_append_partial_solve_wit_1 : append_partial_solve_wit_1.
Axiom proof_of_append_precondition_wit_1 : append_precondition_wit_1.

End VC_Correct.
