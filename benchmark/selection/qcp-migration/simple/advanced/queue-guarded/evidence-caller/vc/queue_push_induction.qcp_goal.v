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

(*----- Function IntQueue_push_induction -----*)

Definition IntQueue_push_induction_safety_wit_1 := 
forall (q_pre: Z) (x_pre: Z) (l: (@list Z)) (x0: Z) (f: Z) (b: Z) (last: Z) (pre: (@list Z)) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (x_pre = x0)) (PreH3 : (f <> 0)) (PreH4 : (b <> 0)) (PreH5 : (l = (app (pre) ((cons (last) ((@nil Z))))))) ,
  ((&((retval)  # "int_queueCell" ->ₛ "first")) # Int  |-> x_pre)
  **  ((&((retval)  # "int_queueCell" ->ₛ "next")) # Ptr  |->_)
  **  ((( &( "c" ) )) # Ptr  |-> retval)
  **  ((( &( "x" ) )) # Int  |-> x_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> f)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> b)
  **  (CNQueueAux f b pre )
  **  ((&((b)  # "int_queueCell" ->ₛ "first")) # Int  |-> last)
  **  ((&((b)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntQueue_push_induction_safety_wit_2 := 
forall (q_pre: Z) (x_pre: Z) (l: (@list Z)) (x0: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (x_pre = x0)) (PreH3 : (l = (@nil Z))) ,
  ((&((retval)  # "int_queueCell" ->ₛ "first")) # Int  |-> x_pre)
  **  ((&((retval)  # "int_queueCell" ->ₛ "next")) # Ptr  |->_)
  **  ((( &( "c" ) )) # Ptr  |-> retval)
  **  ((( &( "x" ) )) # Int  |-> x_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> 0)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntQueue_push_induction_safety_wit_3 := 
forall (q_pre: Z) (x_pre: Z) (l: (@list Z)) (x0: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (x_pre = x0)) (PreH3 : (l = (@nil Z))) ,
  ((&((retval)  # "int_queueCell" ->ₛ "first")) # Int  |-> x_pre)
  **  ((&((retval)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> 0)
  **  ((( &( "c" ) )) # Ptr  |-> retval)
  **  ((( &( "x" ) )) # Int  |-> x_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> 0)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntQueue_push_induction_safety_wit_4 := 
forall (q_pre: Z) (x_pre: Z) (l: (@list Z)) (x0: Z) (f: Z) (b: Z) (last: Z) (pre: (@list Z)) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (x_pre = x0)) (PreH3 : (f <> 0)) (PreH4 : (b <> 0)) (PreH5 : (l = (app (pre) ((cons (last) ((@nil Z))))))) ,
  ((&((retval)  # "int_queueCell" ->ₛ "first")) # Int  |-> x_pre)
  **  ((&((retval)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> 0)
  **  ((( &( "c" ) )) # Ptr  |-> retval)
  **  ((( &( "x" ) )) # Int  |-> x_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> f)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> b)
  **  (CNQueueAux f b pre )
  **  ((&((b)  # "int_queueCell" ->ₛ "first")) # Int  |-> last)
  **  ((&((b)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntQueue_push_induction_safety_wit_5 := 
forall (q_pre: Z) (x_pre: Z) (l: (@list Z)) (x0: Z) (f: Z) (b: Z) (last: Z) (pre: (@list Z)) (retval: Z) (PreH1 : (b = 0)) (PreH2 : (retval <> 0)) (PreH3 : (x_pre = x0)) (PreH4 : (f <> 0)) (PreH5 : (b <> 0)) (PreH6 : (l = (app (pre) ((cons (last) ((@nil Z))))))) ,
  ((&((retval)  # "int_queueCell" ->ₛ "first")) # Int  |-> x_pre)
  **  ((&((retval)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> 0)
  **  ((( &( "c" ) )) # Ptr  |-> retval)
  **  ((( &( "x" ) )) # Int  |-> x_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> f)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> b)
  **  (CNQueueAux f b pre )
  **  ((&((b)  # "int_queueCell" ->ₛ "first")) # Int  |-> last)
  **  ((&((b)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> 0)
|--
  “ False ”
.

Definition IntQueue_push_induction_return_wit_1 := 
forall (q_pre: Z) (x_pre: Z) (l: (@list Z)) (x0: Z) (f_2: Z) (b_2: Z) (last_2: Z) (pre_2: (@list Z)) (retval: Z) (PreH1 : (b_2 <> 0)) (PreH2 : (retval <> 0)) (PreH3 : (x_pre = x0)) (PreH4 : (f_2 <> 0)) (PreH5 : (b_2 <> 0)) (PreH6 : (l = (app (pre_2) ((cons (last_2) ((@nil Z))))))) ,
  (CNQueueAux f_2 retval (app (pre_2) ((cons (last_2) ((@nil Z))))) )
  **  ((&((retval)  # "int_queueCell" ->ₛ "first")) # Int  |-> x_pre)
  **  ((&((retval)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> 0)
  **  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> f_2)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> retval)
|--
  (“ ((app (l) ((cons (x0) ((@nil Z))))) = (@nil Z)) ”
  &&  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> 0)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> 0))
  ||
  (EX (pre: (@list Z))  (last: Z)  (b: Z)  (f: Z) ,
  “ (f <> 0) ” 
  &&  “ (b <> 0) ” 
  &&  “ ((app (l) ((cons (x0) ((@nil Z))))) = (app (pre) ((cons (last) ((@nil Z)))))) ”
  &&  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> f)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> b)
  **  (CNQueueAux f b pre )
  **  ((&((b)  # "int_queueCell" ->ₛ "first")) # Int  |-> last)
  **  ((&((b)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> 0))
.

Definition IntQueue_push_induction_return_wit_2 := 
forall (q_pre: Z) (x_pre: Z) (l: (@list Z)) (x0: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (x_pre = x0)) (PreH3 : (l = (@nil Z))) ,
  ((&((retval)  # "int_queueCell" ->ₛ "first")) # Int  |-> x_pre)
  **  ((&((retval)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> 0)
  **  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> retval)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> retval)
|--
  (“ ((app (l) ((cons (x0) ((@nil Z))))) = (@nil Z)) ”
  &&  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> 0)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> 0))
  ||
  (EX (pre: (@list Z))  (last: Z)  (b: Z)  (f: Z) ,
  “ (f <> 0) ” 
  &&  “ (b <> 0) ” 
  &&  “ ((app (l) ((cons (x0) ((@nil Z))))) = (app (pre) ((cons (last) ((@nil Z)))))) ”
  &&  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> f)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> b)
  **  (CNQueueAux f b pre )
  **  ((&((b)  # "int_queueCell" ->ₛ "first")) # Int  |-> last)
  **  ((&((b)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> 0))
.

Definition IntQueue_push_induction_partial_solve_wit_1 := 
forall (q_pre: Z) (x_pre: Z) (l: (@list Z)) (x0: Z) (f: Z) (b: Z) (last: Z) (pre: (@list Z)) (PreH1 : (x_pre = x0)) (PreH2 : (f <> 0)) (PreH3 : (b <> 0)) (PreH4 : (l = (app (pre) ((cons (last) ((@nil Z))))))) ,
  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> f)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> b)
  **  (CNQueueAux f b pre )
  **  ((&((b)  # "int_queueCell" ->ₛ "first")) # Int  |-> last)
  **  ((&((b)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> 0)
|--
  “ (x_pre = x0) ” 
  &&  “ (f <> 0) ” 
  &&  “ (b <> 0) ” 
  &&  “ (l = (app (pre) ((cons (last) ((@nil Z)))))) ”
  &&  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> f)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> b)
  **  (CNQueueAux f b pre )
  **  ((&((b)  # "int_queueCell" ->ₛ "first")) # Int  |-> last)
  **  ((&((b)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> 0)
.

Definition IntQueue_push_induction_partial_solve_wit_2 := 
forall (q_pre: Z) (x_pre: Z) (l: (@list Z)) (x0: Z) (PreH1 : (x_pre = x0)) (PreH2 : (l = (@nil Z))) ,
  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> 0)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> 0)
|--
  “ (x_pre = x0) ” 
  &&  “ (l = (@nil Z)) ”
  &&  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> 0)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> 0)
.

Definition IntQueue_push_induction_partial_solve_wit_3_pure := 
(
forall (q_pre: Z) (x_pre: Z) (l: (@list Z)) (x0: Z) (f: Z) (b: Z) (last: Z) (pre: (@list Z)) (retval: Z) (PreH1 : (b <> 0)) (PreH2 : (retval <> 0)) (PreH3 : (x_pre = x0)) (PreH4 : (f <> 0)) (PreH5 : (b <> 0)) (PreH6 : (l = (app (pre) ((cons (last) ((@nil Z))))))) ,
  ((( &( "oldback" ) )) # Ptr  |-> b)
  **  ((&((retval)  # "int_queueCell" ->ₛ "first")) # Int  |-> x_pre)
  **  ((&((retval)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> 0)
  **  ((( &( "c" ) )) # Ptr  |-> retval)
  **  ((( &( "x" ) )) # Int  |-> x_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> f)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> retval)
  **  (CNQueueAux f b pre )
  **  ((&((b)  # "int_queueCell" ->ₛ "first")) # Int  |-> last)
  **  ((&((b)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> retval)
|--
  “ (b <> 0) ” 
  &&  “ (retval <> 0) ” 
  &&  “ (f <> retval) ”
) \/
(
forall (q_pre: Z) (x_pre: Z) (l: (@list Z)) (x0: Z) (f: Z) (b: Z) (last: Z) (pre: (@list Z)) (retval: Z) (PreH1 : (last <= INT_MAX)) (PreH2 : (x_pre <= INT_MAX)) (PreH3 : (last >= INT_MIN)) (PreH4 : (x_pre >= INT_MIN)) (PreH5 : (b <> 0)) (PreH6 : (retval <> 0)) (PreH7 : (x_pre = x0)) (PreH8 : (f <> 0)) (PreH9 : (b <> 0)) (PreH10 : (l = (app (pre) ((cons (last) ((@nil Z))))))) ,
  ((( &( "oldback" ) )) # Ptr  |-> b)
  **  ((&((retval)  # "int_queueCell" ->ₛ "first")) # Int  |-> x_pre)
  **  ((&((retval)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> 0)
  **  ((( &( "c" ) )) # Ptr  |-> retval)
  **  ((( &( "x" ) )) # Int  |-> x_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> f)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> retval)
  **  (CNQueueAux f b pre )
  **  ((&((b)  # "int_queueCell" ->ₛ "first")) # Int  |-> last)
  **  ((&((b)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> retval)
|--
  “ (f <> retval) ”
).

Definition IntQueue_push_induction_partial_solve_wit_3_pure_split_goal_1 := 
forall (q_pre: Z) (x_pre: Z) (l: (@list Z)) (x0: Z) (f: Z) (b: Z) (last: Z) (pre: (@list Z)) (retval: Z) (PreH1 : (last <= INT_MAX)) (PreH2 : (x_pre <= INT_MAX)) (PreH3 : (last >= INT_MIN)) (PreH4 : (x_pre >= INT_MIN)) (PreH5 : (b <> 0)) (PreH6 : (retval <> 0)) (PreH7 : (x_pre = x0)) (PreH8 : (f <> 0)) (PreH9 : (b <> 0)) (PreH10 : (l = (app (pre) ((cons (last) ((@nil Z))))))) ,
  ((( &( "oldback" ) )) # Ptr  |-> b)
  **  ((&((retval)  # "int_queueCell" ->ₛ "first")) # Int  |-> x_pre)
  **  ((&((retval)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> 0)
  **  ((( &( "c" ) )) # Ptr  |-> retval)
  **  ((( &( "x" ) )) # Int  |-> x_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> f)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> retval)
  **  (CNQueueAux f b pre )
  **  ((&((b)  # "int_queueCell" ->ₛ "first")) # Int  |-> last)
  **  ((&((b)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> retval)
|--
  “ (f <> retval) ”
.

Definition IntQueue_push_induction_partial_solve_wit_3_aux := 
forall (q_pre: Z) (x_pre: Z) (l: (@list Z)) (x0: Z) (f: Z) (b: Z) (last: Z) (pre: (@list Z)) (retval: Z) (PreH1 : (b <> 0)) (PreH2 : (retval <> 0)) (PreH3 : (x_pre = x0)) (PreH4 : (f <> 0)) (PreH5 : (b <> 0)) (PreH6 : (l = (app (pre) ((cons (last) ((@nil Z))))))) ,
  ((&((retval)  # "int_queueCell" ->ₛ "first")) # Int  |-> x_pre)
  **  ((&((retval)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> 0)
  **  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> f)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> retval)
  **  (CNQueueAux f b pre )
  **  ((&((b)  # "int_queueCell" ->ₛ "first")) # Int  |-> last)
  **  ((&((b)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> retval)
|--
  “ (b <> 0) ” 
  &&  “ (retval <> 0) ” 
  &&  “ (f <> retval) ” 
  &&  “ (b <> 0) ” 
  &&  “ (retval <> 0) ” 
  &&  “ (x_pre = x0) ” 
  &&  “ (f <> 0) ” 
  &&  “ (b <> 0) ” 
  &&  “ (l = (app (pre) ((cons (last) ((@nil Z)))))) ”
  &&  (CNQueueAux f b pre )
  **  ((&((b)  # "int_queueCell" ->ₛ "first")) # Int  |-> last)
  **  ((&((b)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> retval)
  **  ((&((retval)  # "int_queueCell" ->ₛ "first")) # Int  |-> x_pre)
  **  ((&((retval)  # "int_queueCell" ->ₛ "next")) # Ptr  |-> 0)
  **  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> f)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> retval)
.

Definition IntQueue_push_induction_partial_solve_wit_3 := IntQueue_push_induction_partial_solve_wit_3_pure -> IntQueue_push_induction_partial_solve_wit_3_aux.

Module Type VC_Correct.

Axiom proof_of_push_induction_return_wit_1 : push_induction_return_wit_1.
Axiom proof_of_push_induction_return_wit_2 : push_induction_return_wit_2.
Axiom proof_of_push_induction_partial_solve_wit_1 : push_induction_partial_solve_wit_1.
Axiom proof_of_push_induction_partial_solve_wit_2_pure : push_induction_partial_solve_wit_2_pure.
Axiom proof_of_push_induction_partial_solve_wit_2 : push_induction_partial_solve_wit_2.
Axiom proof_of_IntQueue_push_induction_safety_wit_1 : IntQueue_push_induction_safety_wit_1.
Axiom proof_of_IntQueue_push_induction_safety_wit_2 : IntQueue_push_induction_safety_wit_2.
Axiom proof_of_IntQueue_push_induction_safety_wit_3 : IntQueue_push_induction_safety_wit_3.
Axiom proof_of_IntQueue_push_induction_safety_wit_4 : IntQueue_push_induction_safety_wit_4.
Axiom proof_of_IntQueue_push_induction_safety_wit_5 : IntQueue_push_induction_safety_wit_5.
Axiom proof_of_IntQueue_push_induction_return_wit_1 : IntQueue_push_induction_return_wit_1.
Axiom proof_of_IntQueue_push_induction_return_wit_2 : IntQueue_push_induction_return_wit_2.
Axiom proof_of_IntQueue_push_induction_partial_solve_wit_1 : IntQueue_push_induction_partial_solve_wit_1.
Axiom proof_of_IntQueue_push_induction_partial_solve_wit_2 : IntQueue_push_induction_partial_solve_wit_2.
Axiom proof_of_IntQueue_push_induction_partial_solve_wit_3_pure : IntQueue_push_induction_partial_solve_wit_3_pure.
Axiom proof_of_IntQueue_push_induction_partial_solve_wit_3 : IntQueue_push_induction_partial_solve_wit_3.

End VC_Correct.
