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
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Local Open Scope sac.

(*----- Function IntQueue_empty -----*)

Definition IntQueue_empty_safety_wit_1 := 
forall (retval: Z) (PreH1 : (retval <> 0)) ,
  ((&((retval)  # "int_queue" ->ₛ "front")) # Ptr  |->_)
  **  ((&((retval)  # "int_queue" ->ₛ "back")) # Ptr  |->_)
  **  ((( &( "p" ) )) # Ptr  |-> retval)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntQueue_empty_safety_wit_2 := 
forall (retval: Z) (PreH1 : (retval <> 0)) ,
  ((&((retval)  # "int_queue" ->ₛ "front")) # Ptr  |-> 0)
  **  ((&((retval)  # "int_queue" ->ₛ "back")) # Ptr  |->_)
  **  ((( &( "p" ) )) # Ptr  |-> retval)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntQueue_empty_return_wit_1 := 
forall (retval: Z) (PreH1 : (retval <> 0)) ,
  ((&((retval)  # "int_queue" ->ₛ "front")) # Ptr  |-> 0)
  **  ((&((retval)  # "int_queue" ->ₛ "back")) # Ptr  |-> 0)
|--
  (((&((retval)  # "int_queue" ->ₛ "front")) # Ptr  |-> 0)
  **  ((&((retval)  # "int_queue" ->ₛ "back")) # Ptr  |-> 0))
  ||
  (EX (pre: (@list Z))  (last: Z)  (b: Z)  (f: Z) ,
  “ (f <> 0) ” 
  &&  “ (b <> 0) ” 
  &&  “ ((@nil Z) = (app (pre) ((cons (last) ((@nil Z)))))) ”
  &&  ((&((retval)  # "int_queue" ->ₛ "front")) # Ptr  |-> f)
  **  ((&((retval)  # "int_queue" ->ₛ "back")) # Ptr  |-> b)
  **  (sllseg f b pre )
  **  ((&((b)  # "list" ->ₛ "data")) # Int  |-> last)
  **  ((&((b)  # "list" ->ₛ "next")) # Ptr  |-> 0))
.

Definition IntQueue_empty_partial_solve_wit_1 := 
  TT && emp 
|--
  TT && emp 
.

(*----- Function IntQueue_pop -----*)

Definition IntQueue_pop_safety_wit_1 := 
forall (q_pre: Z) (l: (@list Z)) (x0: Z) (h: Z) (t: Z) (b: Z) (last: Z) (pre: (@list Z)) (PreH1 : (t = 0)) (PreH2 : (h <> 0)) (PreH3 : (t <> 0)) (PreH4 : (b <> 0)) (PreH5 : (l = (app (pre) ((cons (last) ((@nil Z))))))) ,
  ((( &( "x" ) )) # Int  |-> x0)
  **  ((( &( "h" ) )) # Ptr  |-> h)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> t)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> b)
  **  (sllseg t b pre )
  **  ((&((b)  # "list" ->ₛ "data")) # Int  |-> last)
  **  ((&((b)  # "list" ->ₛ "next")) # Ptr  |-> 0)
|--
  “ False ”
.

Definition IntQueue_pop_safety_wit_2 := 
forall (q_pre: Z) (l: (@list Z)) (x0: Z) (h: Z) (PreH1 : (l = (@nil Z))) (PreH2 : (h <> 0)) ,
  ((( &( "x" ) )) # Int  |-> x0)
  **  ((( &( "h" ) )) # Ptr  |-> h)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> 0)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> h)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntQueue_pop_return_wit_1 := 
forall (q_pre: Z) (l: (@list Z)) (x0: Z) (h: Z) (PreH1 : (l = (@nil Z))) (PreH2 : (h <> 0)) ,
  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> 0)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> 0)
|--
  (EX (pre: (@list Z))  (last: Z)  (b: Z)  (f: Z) ,
  “ (x0 = x0) ” 
  &&  “ (f <> 0) ” 
  &&  “ (b <> 0) ” 
  &&  “ (l = (app (pre) ((cons (last) ((@nil Z)))))) ”
  &&  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> f)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> b)
  **  (sllseg f b pre )
  **  ((&((b)  # "list" ->ₛ "data")) # Int  |-> last)
  **  ((&((b)  # "list" ->ₛ "next")) # Ptr  |-> 0))
  ||
  (“ (x0 = x0) ” 
  &&  “ (l = (@nil Z)) ”
  &&  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> 0)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> 0))
.

Definition IntQueue_pop_return_wit_2 := 
forall (q_pre: Z) (l: (@list Z)) (x0: Z) (h: Z) (t: Z) (b_2: Z) (last_2: Z) (pre_2: (@list Z)) (PreH1 : (t <> 0)) (PreH2 : (h <> 0)) (PreH3 : (t <> 0)) (PreH4 : (b_2 <> 0)) (PreH5 : (l = (app (pre_2) ((cons (last_2) ((@nil Z))))))) ,
  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> t)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> b_2)
  **  (sllseg t b_2 pre_2 )
  **  ((&((b_2)  # "list" ->ₛ "data")) # Int  |-> last_2)
  **  ((&((b_2)  # "list" ->ₛ "next")) # Ptr  |-> 0)
|--
  (EX (pre: (@list Z))  (last: Z)  (b: Z)  (f: Z) ,
  “ (x0 = x0) ” 
  &&  “ (f <> 0) ” 
  &&  “ (b <> 0) ” 
  &&  “ (l = (app (pre) ((cons (last) ((@nil Z)))))) ”
  &&  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> f)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> b)
  **  (sllseg f b pre )
  **  ((&((b)  # "list" ->ₛ "data")) # Int  |-> last)
  **  ((&((b)  # "list" ->ₛ "next")) # Ptr  |-> 0))
  ||
  (“ (x0 = x0) ” 
  &&  “ (l = (@nil Z)) ”
  &&  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> 0)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> 0))
.

Definition IntQueue_pop_partial_solve_wit_1 := 
forall (q_pre: Z) (l: (@list Z)) (x0: Z) (h: Z) (PreH1 : (l = (@nil Z))) (PreH2 : (h <> 0)) ,
  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> 0)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> h)
  **  ((&((h)  # "list" ->ₛ "data")) # Int  |-> x0)
  **  ((&((h)  # "list" ->ₛ "next")) # Ptr  |-> 0)
|--
  “ (l = (@nil Z)) ” 
  &&  “ (h <> 0) ”
  &&  ((&((h)  # "list" ->ₛ "data")) # Int  |->_)
  **  ((&((h)  # "list" ->ₛ "next")) # Ptr  |->_)
  **  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> 0)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> h)
.

Definition IntQueue_pop_partial_solve_wit_2 := 
forall (q_pre: Z) (l: (@list Z)) (x0: Z) (h: Z) (t: Z) (b: Z) (last: Z) (pre: (@list Z)) (PreH1 : (h <> 0)) (PreH2 : (t <> 0)) (PreH3 : (b <> 0)) (PreH4 : (l = (app (pre) ((cons (last) ((@nil Z))))))) ,
  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> t)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> b)
  **  ((&((h)  # "list" ->ₛ "data")) # Int  |-> x0)
  **  ((&((h)  # "list" ->ₛ "next")) # Ptr  |-> t)
  **  (sllseg t b pre )
  **  ((&((b)  # "list" ->ₛ "data")) # Int  |-> last)
  **  ((&((b)  # "list" ->ₛ "next")) # Ptr  |-> 0)
|--
  “ (h <> 0) ” 
  &&  “ (t <> 0) ” 
  &&  “ (b <> 0) ” 
  &&  “ (l = (app (pre) ((cons (last) ((@nil Z)))))) ”
  &&  ((&((h)  # "list" ->ₛ "data")) # Int  |->_)
  **  ((&((h)  # "list" ->ₛ "next")) # Ptr  |->_)
  **  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> t)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> b)
  **  (sllseg t b pre )
  **  ((&((b)  # "list" ->ₛ "data")) # Int  |-> last)
  **  ((&((b)  # "list" ->ₛ "next")) # Ptr  |-> 0)
.

(*----- Function IntQueue_push -----*)

Definition IntQueue_push_safety_wit_1 := 
forall (q_pre: Z) (x_pre: Z) (l: (@list Z)) (x0: Z) (f: Z) (b: Z) (last: Z) (pre: (@list Z)) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (x_pre = x0)) (PreH3 : (f <> 0)) (PreH4 : (b <> 0)) (PreH5 : (l = (app (pre) ((cons (last) ((@nil Z))))))) ,
  ((&((retval)  # "list" ->ₛ "data")) # Int  |-> x_pre)
  **  ((&((retval)  # "list" ->ₛ "next")) # Ptr  |->_)
  **  ((( &( "c" ) )) # Ptr  |-> retval)
  **  ((( &( "x" ) )) # Int  |-> x_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> f)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> b)
  **  (sllseg f b pre )
  **  ((&((b)  # "list" ->ₛ "data")) # Int  |-> last)
  **  ((&((b)  # "list" ->ₛ "next")) # Ptr  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntQueue_push_safety_wit_2 := 
forall (q_pre: Z) (x_pre: Z) (l: (@list Z)) (x0: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (x_pre = x0)) (PreH3 : (l = (@nil Z))) ,
  ((&((retval)  # "list" ->ₛ "data")) # Int  |-> x_pre)
  **  ((&((retval)  # "list" ->ₛ "next")) # Ptr  |->_)
  **  ((( &( "c" ) )) # Ptr  |-> retval)
  **  ((( &( "x" ) )) # Int  |-> x_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> 0)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntQueue_push_safety_wit_3 := 
forall (q_pre: Z) (x_pre: Z) (l: (@list Z)) (x0: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (x_pre = x0)) (PreH3 : (l = (@nil Z))) ,
  ((&((retval)  # "list" ->ₛ "data")) # Int  |-> x_pre)
  **  ((&((retval)  # "list" ->ₛ "next")) # Ptr  |-> 0)
  **  ((( &( "c" ) )) # Ptr  |-> retval)
  **  ((( &( "x" ) )) # Int  |-> x_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> 0)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntQueue_push_safety_wit_4 := 
forall (q_pre: Z) (x_pre: Z) (l: (@list Z)) (x0: Z) (f: Z) (b: Z) (last: Z) (pre: (@list Z)) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (x_pre = x0)) (PreH3 : (f <> 0)) (PreH4 : (b <> 0)) (PreH5 : (l = (app (pre) ((cons (last) ((@nil Z))))))) ,
  ((&((retval)  # "list" ->ₛ "data")) # Int  |-> x_pre)
  **  ((&((retval)  # "list" ->ₛ "next")) # Ptr  |-> 0)
  **  ((( &( "c" ) )) # Ptr  |-> retval)
  **  ((( &( "x" ) )) # Int  |-> x_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> f)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> b)
  **  (sllseg f b pre )
  **  ((&((b)  # "list" ->ₛ "data")) # Int  |-> last)
  **  ((&((b)  # "list" ->ₛ "next")) # Ptr  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntQueue_push_safety_wit_5 := 
forall (q_pre: Z) (x_pre: Z) (l: (@list Z)) (x0: Z) (f: Z) (b: Z) (last: Z) (pre: (@list Z)) (retval: Z) (PreH1 : (b = 0)) (PreH2 : (retval <> 0)) (PreH3 : (x_pre = x0)) (PreH4 : (f <> 0)) (PreH5 : (b <> 0)) (PreH6 : (l = (app (pre) ((cons (last) ((@nil Z))))))) ,
  ((&((retval)  # "list" ->ₛ "data")) # Int  |-> x_pre)
  **  ((&((retval)  # "list" ->ₛ "next")) # Ptr  |-> 0)
  **  ((( &( "c" ) )) # Ptr  |-> retval)
  **  ((( &( "x" ) )) # Int  |-> x_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> f)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> b)
  **  (sllseg f b pre )
  **  ((&((b)  # "list" ->ₛ "data")) # Int  |-> last)
  **  ((&((b)  # "list" ->ₛ "next")) # Ptr  |-> 0)
|--
  “ False ”
.

Definition IntQueue_push_return_wit_1 := 
forall (q_pre: Z) (x_pre: Z) (l: (@list Z)) (x0: Z) (f_2: Z) (b_2: Z) (last_2: Z) (pre_2: (@list Z)) (retval: Z) (PreH1 : (b_2 <> 0)) (PreH2 : (retval <> 0)) (PreH3 : (x_pre = x0)) (PreH4 : (f_2 <> 0)) (PreH5 : (b_2 <> 0)) (PreH6 : (l = (app (pre_2) ((cons (last_2) ((@nil Z))))))) ,
  (sllseg f_2 retval (app (pre_2) ((cons (last_2) ((@nil Z))))) )
  **  ((&((retval)  # "list" ->ₛ "data")) # Int  |-> x_pre)
  **  ((&((retval)  # "list" ->ₛ "next")) # Ptr  |-> 0)
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
  **  (sllseg f b pre )
  **  ((&((b)  # "list" ->ₛ "data")) # Int  |-> last)
  **  ((&((b)  # "list" ->ₛ "next")) # Ptr  |-> 0))
.

Definition IntQueue_push_return_wit_2 := 
forall (q_pre: Z) (x_pre: Z) (l: (@list Z)) (x0: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (x_pre = x0)) (PreH3 : (l = (@nil Z))) ,
  ((&((retval)  # "list" ->ₛ "data")) # Int  |-> x_pre)
  **  ((&((retval)  # "list" ->ₛ "next")) # Ptr  |-> 0)
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
  **  (sllseg f b pre )
  **  ((&((b)  # "list" ->ₛ "data")) # Int  |-> last)
  **  ((&((b)  # "list" ->ₛ "next")) # Ptr  |-> 0))
.

Definition IntQueue_push_partial_solve_wit_1 := 
forall (q_pre: Z) (x_pre: Z) (l: (@list Z)) (x0: Z) (f: Z) (b: Z) (last: Z) (pre: (@list Z)) (PreH1 : (x_pre = x0)) (PreH2 : (f <> 0)) (PreH3 : (b <> 0)) (PreH4 : (l = (app (pre) ((cons (last) ((@nil Z))))))) ,
  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> f)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> b)
  **  (sllseg f b pre )
  **  ((&((b)  # "list" ->ₛ "data")) # Int  |-> last)
  **  ((&((b)  # "list" ->ₛ "next")) # Ptr  |-> 0)
|--
  “ (x_pre = x0) ” 
  &&  “ (f <> 0) ” 
  &&  “ (b <> 0) ” 
  &&  “ (l = (app (pre) ((cons (last) ((@nil Z)))))) ”
  &&  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> f)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> b)
  **  (sllseg f b pre )
  **  ((&((b)  # "list" ->ₛ "data")) # Int  |-> last)
  **  ((&((b)  # "list" ->ₛ "next")) # Ptr  |-> 0)
.

Definition IntQueue_push_partial_solve_wit_2 := 
forall (q_pre: Z) (x_pre: Z) (l: (@list Z)) (x0: Z) (PreH1 : (x_pre = x0)) (PreH2 : (l = (@nil Z))) ,
  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> 0)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> 0)
|--
  “ (x_pre = x0) ” 
  &&  “ (l = (@nil Z)) ”
  &&  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> 0)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> 0)
.

Definition IntQueue_push_partial_solve_wit_3 := 
forall (q_pre: Z) (x_pre: Z) (l: (@list Z)) (x0: Z) (f: Z) (b: Z) (last: Z) (pre: (@list Z)) (retval: Z) (PreH1 : (b <> 0)) (PreH2 : (retval <> 0)) (PreH3 : (x_pre = x0)) (PreH4 : (f <> 0)) (PreH5 : (b <> 0)) (PreH6 : (l = (app (pre) ((cons (last) ((@nil Z))))))) ,
  ((&((retval)  # "list" ->ₛ "data")) # Int  |-> x_pre)
  **  ((&((retval)  # "list" ->ₛ "next")) # Ptr  |-> 0)
  **  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> f)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> retval)
  **  (sllseg f b pre )
  **  ((&((b)  # "list" ->ₛ "data")) # Int  |-> last)
  **  ((&((b)  # "list" ->ₛ "next")) # Ptr  |-> retval)
|--
  “ (b <> 0) ” 
  &&  “ (retval <> 0) ” 
  &&  “ (x_pre = x0) ” 
  &&  “ (f <> 0) ” 
  &&  “ (b <> 0) ” 
  &&  “ (l = (app (pre) ((cons (last) ((@nil Z)))))) ”
  &&  (sllseg f b pre )
  **  ((&((b)  # "list" ->ₛ "data")) # Int  |-> last)
  **  ((&((b)  # "list" ->ₛ "next")) # Ptr  |-> retval)
  **  ((&((retval)  # "list" ->ₛ "data")) # Int  |-> x_pre)
  **  ((&((retval)  # "list" ->ₛ "next")) # Ptr  |-> 0)
  **  ((&((q_pre)  # "int_queue" ->ₛ "front")) # Ptr  |-> f)
  **  ((&((q_pre)  # "int_queue" ->ₛ "back")) # Ptr  |-> retval)
.

Module Type VC_Correct.

Axiom proof_of_IntQueue_empty_safety_wit_1 : IntQueue_empty_safety_wit_1.
Axiom proof_of_IntQueue_empty_safety_wit_2 : IntQueue_empty_safety_wit_2.
Axiom proof_of_IntQueue_empty_return_wit_1 : IntQueue_empty_return_wit_1.
Axiom proof_of_IntQueue_empty_partial_solve_wit_1 : IntQueue_empty_partial_solve_wit_1.
Axiom proof_of_IntQueue_pop_safety_wit_1 : IntQueue_pop_safety_wit_1.
Axiom proof_of_IntQueue_pop_safety_wit_2 : IntQueue_pop_safety_wit_2.
Axiom proof_of_IntQueue_pop_return_wit_1 : IntQueue_pop_return_wit_1.
Axiom proof_of_IntQueue_pop_return_wit_2 : IntQueue_pop_return_wit_2.
Axiom proof_of_IntQueue_pop_partial_solve_wit_1 : IntQueue_pop_partial_solve_wit_1.
Axiom proof_of_IntQueue_pop_partial_solve_wit_2 : IntQueue_pop_partial_solve_wit_2.
Axiom proof_of_IntQueue_push_safety_wit_1 : IntQueue_push_safety_wit_1.
Axiom proof_of_IntQueue_push_safety_wit_2 : IntQueue_push_safety_wit_2.
Axiom proof_of_IntQueue_push_safety_wit_3 : IntQueue_push_safety_wit_3.
Axiom proof_of_IntQueue_push_safety_wit_4 : IntQueue_push_safety_wit_4.
Axiom proof_of_IntQueue_push_safety_wit_5 : IntQueue_push_safety_wit_5.
Axiom proof_of_IntQueue_push_return_wit_1 : IntQueue_push_return_wit_1.
Axiom proof_of_IntQueue_push_return_wit_2 : IntQueue_push_return_wit_2.
Axiom proof_of_IntQueue_push_partial_solve_wit_1 : IntQueue_push_partial_solve_wit_1.
Axiom proof_of_IntQueue_push_partial_solve_wit_2 : IntQueue_push_partial_solve_wit_2.
Axiom proof_of_IntQueue_push_partial_solve_wit_3 : IntQueue_push_partial_solve_wit_3.

End VC_Correct.
