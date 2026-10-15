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

(*----- Function push_induction -----*)

Definition push_induction_return_wit_1 := 
(
forall (p_pre: Z) (front_pre: Z) (l: (@list Z)) (y: Z) (v: Z) (a: Z) (tl: (@list Z)) (y_2: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (front_pre <> 0)) (PreH3 : (l = (cons (a) (tl)))) (PreH4 : (front_pre <> p_pre)) (PreH5 : (p_pre <> 0)) (PreH6 : (front_pre <> y)) (PreH7 : (y <> 0)) ,
  (CNQueueAux y_2 y (app (tl) ((cons (v) ((@nil Z))))) )
  **  ((&((front_pre)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> y_2)
  **  ((&((front_pre)  # "int_queueCell" ->ₛ "first")) # Int  |-> a)
|--
  (CNQueueAux front_pre y (app (l) ((cons (v) ((@nil Z))))) )
) \/
(
forall (p_pre: Z) (front_pre: Z) (l: (@list Z)) (y: Z) (v: Z) (a: Z) (tl: (@list Z)) (y_2: Z) (PreH1 : (a <= INT_MAX)) (PreH2 : (a >= INT_MIN)) (PreH3 : (y_2 <> 0)) (PreH4 : (front_pre <> 0)) (PreH5 : (l = (cons (a) (tl)))) (PreH6 : (front_pre <> p_pre)) (PreH7 : (p_pre <> 0)) (PreH8 : (front_pre <> y)) (PreH9 : (y <> 0)) ,
  (CNQueueAux y_2 y (app (tl) ((cons (v) ((@nil Z))))) )
  **  ((&((front_pre)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> y_2)
  **  ((&((front_pre)  # "int_queueCell" ->ₛ "first")) # Int  |-> a)
|--
  (CNQueueAux front_pre y (app (l) ((cons (v) ((@nil Z))))) )
).

Definition push_induction_return_wit_1_split_goal_spatial := 
forall (p_pre: Z) (front_pre: Z) (l: (@list Z)) (y: Z) (v: Z) (a: Z) (tl: (@list Z)) (y_2: Z) (PreH1 : (a <= INT_MAX)) (PreH2 : (a >= INT_MIN)) (PreH3 : (y_2 <> 0)) (PreH4 : (front_pre <> 0)) (PreH5 : (l = (cons (a) (tl)))) (PreH6 : (front_pre <> p_pre)) (PreH7 : (p_pre <> 0)) (PreH8 : (front_pre <> y)) (PreH9 : (y <> 0)) ,
  (CNQueueAux y_2 y (app (tl) ((cons (v) ((@nil Z))))) )
  **  ((&((front_pre)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> y_2)
  **  ((&((front_pre)  # "int_queueCell" ->ₛ "first")) # Int  |-> a)
|--
  (CNQueueAux front_pre y (app (l) ((cons (v) ((@nil Z))))) )
.

Definition push_induction_return_wit_2 := 
(
forall (p_pre: Z) (front_pre: Z) (l: (@list Z)) (y: Z) (v: Z) (PreH1 : (front_pre = p_pre)) (PreH2 : (p_pre <> 0)) (PreH3 : (front_pre <> y)) (PreH4 : (y <> 0)) ,
  (CNQueueAux front_pre p_pre l )
  **  ((&((p_pre)  # "int_queueCell" ->ₛ "first")) # Int  |-> v)
  **  ((&((p_pre)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> y)
|--
  (CNQueueAux front_pre y (app (l) ((cons (v) ((@nil Z))))) )
) \/
(
forall (p_pre: Z) (front_pre: Z) (l: (@list Z)) (y: Z) (v: Z) (PreH1 : (v <= INT_MAX)) (PreH2 : (v >= INT_MIN)) (PreH3 : (l = (@nil Z))) (PreH4 : (front_pre = p_pre)) (PreH5 : (p_pre <> 0)) (PreH6 : (front_pre <> y)) (PreH7 : (y <> 0)) ,
  ((&((p_pre)  # "int_queueCell" ->ₛ "first")) # Int  |-> v)
  **  ((&((p_pre)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> y)
|--
  (CNQueueAux front_pre y (app (l) ((cons (v) ((@nil Z))))) )
).

Definition push_induction_return_wit_2_split_goal_spatial := 
forall (p_pre: Z) (front_pre: Z) (l: (@list Z)) (y: Z) (v: Z) (PreH1 : (v <= INT_MAX)) (PreH2 : (v >= INT_MIN)) (PreH3 : (l = (@nil Z))) (PreH4 : (front_pre = p_pre)) (PreH5 : (p_pre <> 0)) (PreH6 : (front_pre <> y)) (PreH7 : (y <> 0)) ,
  ((&((p_pre)  # "int_queueCell" ->ₛ "first")) # Int  |-> v)
  **  ((&((p_pre)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> y)
|--
  (CNQueueAux front_pre y (app (l) ((cons (v) ((@nil Z))))) )
.

Definition push_induction_partial_solve_wit_1 := 
forall (p_pre: Z) (front_pre: Z) (l: (@list Z)) (y: Z) (v: Z) (PreH1 : (front_pre <> p_pre)) (PreH2 : (p_pre <> 0)) (PreH3 : (front_pre <> y)) (PreH4 : (y <> 0)) ,
  (CNQueueAux front_pre p_pre l )
  **  ((&((p_pre)  # "int_queueCell" ->ₛ "first")) # Int  |-> v)
  **  ((&((p_pre)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> y)
|--
  EX (a: Z)  (tl: (@list Z))  (y_2: Z) ,
  “ (y_2 <> 0) ” 
  &&  “ (front_pre <> 0) ” 
  &&  “ (l = (cons (a) (tl))) ” 
  &&  “ (front_pre <> p_pre) ” 
  &&  “ (p_pre <> 0) ” 
  &&  “ (front_pre <> y) ” 
  &&  “ (y <> 0) ”
  &&  ((&((front_pre)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> y_2)
  **  (CNQueueAux y_2 p_pre tl )
  **  ((&((front_pre)  # "int_queueCell" ->ₛ "first")) # Int  |-> a)
  **  ((&((p_pre)  # "int_queueCell" ->ₛ "first")) # Int  |-> v)
  **  ((&((p_pre)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> y)
.

Definition push_induction_partial_solve_wit_2_pure := 
(
forall (p_pre: Z) (front_pre: Z) (l: (@list Z)) (y: Z) (v: Z) (a: Z) (tl: (@list Z)) (y_2: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (front_pre <> 0)) (PreH3 : (l = (cons (a) (tl)))) (PreH4 : (front_pre <> p_pre)) (PreH5 : (p_pre <> 0)) (PreH6 : (front_pre <> y)) (PreH7 : (y <> 0)) ,
  ((&((front_pre)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> y_2)
  **  (CNQueueAux y_2 p_pre tl )
  **  ((&((front_pre)  # "int_queueCell" ->ₛ "first")) # Int  |-> a)
  **  ((( &( "front" ) )) # Ptr  |-> front_pre)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((&((p_pre)  # "int_queueCell" ->ₛ "first")) # Int  |-> v)
  **  ((&((p_pre)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> y)
|--
  “ (p_pre <> 0) ” 
  &&  “ (y <> 0) ” 
  &&  “ (y_2 <> y) ”
) \/
(
forall (p_pre: Z) (front_pre: Z) (l: (@list Z)) (y: Z) (v: Z) (a: Z) (tl: (@list Z)) (y_2: Z) (PreH1 : (v <= INT_MAX)) (PreH2 : (a <= INT_MAX)) (PreH3 : (v >= INT_MIN)) (PreH4 : (a >= INT_MIN)) (PreH5 : (y_2 <> 0)) (PreH6 : (front_pre <> 0)) (PreH7 : (l = (cons (a) (tl)))) (PreH8 : (front_pre <> p_pre)) (PreH9 : (p_pre <> 0)) (PreH10 : (front_pre <> y)) (PreH11 : (y <> 0)) ,
  ((&((front_pre)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> y_2)
  **  (CNQueueAux y_2 p_pre tl )
  **  ((&((front_pre)  # "int_queueCell" ->ₛ "first")) # Int  |-> a)
  **  ((( &( "front" ) )) # Ptr  |-> front_pre)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((&((p_pre)  # "int_queueCell" ->ₛ "first")) # Int  |-> v)
  **  ((&((p_pre)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> y)
|--
  “ (y_2 <> y) ”
).

Definition push_induction_partial_solve_wit_2_pure_split_goal_1 := 
forall (p_pre: Z) (front_pre: Z) (l: (@list Z)) (y: Z) (v: Z) (a: Z) (tl: (@list Z)) (y_2: Z) (PreH1 : (v <= INT_MAX)) (PreH2 : (a <= INT_MAX)) (PreH3 : (v >= INT_MIN)) (PreH4 : (a >= INT_MIN)) (PreH5 : (y_2 <> 0)) (PreH6 : (front_pre <> 0)) (PreH7 : (l = (cons (a) (tl)))) (PreH8 : (front_pre <> p_pre)) (PreH9 : (p_pre <> 0)) (PreH10 : (front_pre <> y)) (PreH11 : (y <> 0)) ,
  ((&((front_pre)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> y_2)
  **  (CNQueueAux y_2 p_pre tl )
  **  ((&((front_pre)  # "int_queueCell" ->ₛ "first")) # Int  |-> a)
  **  ((( &( "front" ) )) # Ptr  |-> front_pre)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((&((p_pre)  # "int_queueCell" ->ₛ "first")) # Int  |-> v)
  **  ((&((p_pre)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> y)
|--
  “ (y_2 <> y) ”
.

Definition push_induction_partial_solve_wit_2_aux := 
forall (p_pre: Z) (front_pre: Z) (l: (@list Z)) (y: Z) (v: Z) (a: Z) (tl: (@list Z)) (y_2: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (front_pre <> 0)) (PreH3 : (l = (cons (a) (tl)))) (PreH4 : (front_pre <> p_pre)) (PreH5 : (p_pre <> 0)) (PreH6 : (front_pre <> y)) (PreH7 : (y <> 0)) ,
  ((&((front_pre)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> y_2)
  **  (CNQueueAux y_2 p_pre tl )
  **  ((&((front_pre)  # "int_queueCell" ->ₛ "first")) # Int  |-> a)
  **  ((&((p_pre)  # "int_queueCell" ->ₛ "first")) # Int  |-> v)
  **  ((&((p_pre)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> y)
|--
  “ (p_pre <> 0) ” 
  &&  “ (y <> 0) ” 
  &&  “ (y_2 <> y) ” 
  &&  “ (y_2 <> 0) ” 
  &&  “ (front_pre <> 0) ” 
  &&  “ (l = (cons (a) (tl))) ” 
  &&  “ (front_pre <> p_pre) ” 
  &&  “ (p_pre <> 0) ” 
  &&  “ (front_pre <> y) ” 
  &&  “ (y <> 0) ”
  &&  (CNQueueAux y_2 p_pre tl )
  **  ((&((p_pre)  # "int_queueCell" ->ₛ "first")) # Int  |-> v)
  **  ((&((p_pre)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((front_pre)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> y_2)
  **  ((&((front_pre)  # "int_queueCell" ->ₛ "first")) # Int  |-> a)
.

Definition push_induction_partial_solve_wit_2 := push_induction_partial_solve_wit_2_pure -> push_induction_partial_solve_wit_2_aux.

Module Type VC_Correct.

Axiom proof_of_push_induction_return_wit_1 : push_induction_return_wit_1.
Axiom proof_of_push_induction_return_wit_2 : push_induction_return_wit_2.
Axiom proof_of_push_induction_partial_solve_wit_1 : push_induction_partial_solve_wit_1.
Axiom proof_of_push_induction_partial_solve_wit_2_pure : push_induction_partial_solve_wit_2_pure.
Axiom proof_of_push_induction_partial_solve_wit_2 : push_induction_partial_solve_wit_2.

End VC_Correct.
