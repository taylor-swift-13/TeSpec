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
Require Import DLLSupplement.
Local Open Scope sac.

(*----- Function remove -----*)

Definition remove_safety_wit_1 := 
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (PreH1 : (n_pre <> 0)) ,
  ((( &( "temp" ) )) # Ptr  |->_)
  **  ((( &( "n" ) )) # Ptr  |-> n_pre)
  **  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft p n_pre ll )
  **  (DLLRight q n_pre lr )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition remove_safety_wit_2 := 
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (PreH1 : (n_pre <> 0)) ,
  ((( &( "temp" ) )) # Ptr  |-> 0)
  **  ((( &( "n" ) )) # Ptr  |-> n_pre)
  **  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft p n_pre ll )
  **  (DLLRight q n_pre lr )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition remove_safety_wit_3 := 
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (PreH1 : (p = 0)) (PreH2 : (n_pre <> 0)) ,
  ((( &( "temp" ) )) # Ptr  |-> 0)
  **  ((( &( "n" ) )) # Ptr  |-> n_pre)
  **  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft p n_pre ll )
  **  (DLLRight q n_pre lr )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition remove_safety_wit_4 := 
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (a: Z) (tl: (@list Z)) (q_2: Z) (PreH1 : (ll = (cons (a) (tl)))) (PreH2 : (p <> 0)) (PreH3 : (n_pre <> 0)) ,
  ((&((p)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft q_2 p tl )
  **  ((&((p)  # "node" ->ₛ "prev")) # Ptr  |-> q_2)
  **  ((&((p)  # "node" ->ₛ "data")) # Int  |-> a)
  **  ((( &( "temp" ) )) # Ptr  |-> p)
  **  ((( &( "n" ) )) # Ptr  |-> n_pre)
  **  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLRight q n_pre lr )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition remove_return_wit_1 := 
(
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (a: Z) (tl: (@list Z)) (q_2: Z) (a_2: Z) (tl_2: (@list Z)) (q_3: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (lr = (cons (a_2) (tl_2)))) (PreH3 : (q <> 0)) (PreH4 : (ll = (cons (a) (tl)))) (PreH5 : (p <> 0)) (PreH6 : (n_pre <> 0)) ,
  ((&((retval)  # "node_and_int" ->ₛ "node")) # Ptr  |-> q)
  **  ((&((retval)  # "node_and_int" ->ₛ "data")) # Int  |-> h)
  **  ((&((q)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  (DLLRight q_3 q tl_2 )
  **  ((&((q)  # "node" ->ₛ "next")) # Ptr  |-> q_3)
  **  ((&((q)  # "node" ->ₛ "data")) # Int  |-> a_2)
  **  ((&((p)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft q_2 p tl )
  **  ((&((p)  # "node" ->ₛ "prev")) # Ptr  |-> q_2)
  **  ((&((p)  # "node" ->ₛ "data")) # Int  |-> a)
|--
  EX (v: Z)  (t: Z) ,
  “ (q <> 0) ” 
  &&  “ (t = q) ”
  &&  ((&((retval)  # "node_and_int" ->ₛ "node")) # Ptr  |-> t)
  **  ((&((retval)  # "node_and_int" ->ₛ "data")) # Int  |-> h)
  **  (Dll t ll v (dll_tail (lr)) )
) \/
(
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (a: Z) (tl: (@list Z)) (q_2: Z) (a_2: Z) (tl_2: (@list Z)) (retval: Z) (PreH1 : (a <= INT_MAX)) (PreH2 : (a >= INT_MIN)) (PreH3 : (retval <> 0)) (PreH4 : (lr = (cons (a_2) (tl_2)))) (PreH5 : (q <> 0)) (PreH6 : (ll = (cons (a) (tl)))) (PreH7 : (p <> 0)) (PreH8 : (n_pre <> 0)) ,
  ((&((p)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft q_2 p tl )
  **  ((&((p)  # "node" ->ₛ "prev")) # Ptr  |-> q_2)
  **  ((&((p)  # "node" ->ₛ "data")) # Int  |-> a)
|--
  “ (tl_2 = (dll_tail (lr))) ”
  &&  (DLLLeft p q ll )
).

Definition remove_return_wit_1_split_goal_1 := 
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (a: Z) (tl: (@list Z)) (q_2: Z) (a_2: Z) (tl_2: (@list Z)) (retval: Z) (PreH1 : (a <= INT_MAX)) (PreH2 : (a >= INT_MIN)) (PreH3 : (retval <> 0)) (PreH4 : (lr = (cons (a_2) (tl_2)))) (PreH5 : (q <> 0)) (PreH6 : (ll = (cons (a) (tl)))) (PreH7 : (p <> 0)) (PreH8 : (n_pre <> 0)) ,
  ((&((p)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft q_2 p tl )
  **  ((&((p)  # "node" ->ₛ "prev")) # Ptr  |-> q_2)
  **  ((&((p)  # "node" ->ₛ "data")) # Int  |-> a)
|--
  “ (tl_2 = (dll_tail (lr))) ”
.

Definition remove_return_wit_1_split_goal_spatial := 
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (a: Z) (tl: (@list Z)) (q_2: Z) (a_2: Z) (tl_2: (@list Z)) (retval: Z) (PreH1 : (a <= INT_MAX)) (PreH2 : (a >= INT_MIN)) (PreH3 : (retval <> 0)) (PreH4 : (lr = (cons (a_2) (tl_2)))) (PreH5 : (q <> 0)) (PreH6 : (ll = (cons (a) (tl)))) (PreH7 : (p <> 0)) (PreH8 : (n_pre <> 0)) ,
  ((&((p)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft q_2 p tl )
  **  ((&((p)  # "node" ->ₛ "prev")) # Ptr  |-> q_2)
  **  ((&((p)  # "node" ->ₛ "data")) # Int  |-> a)
|--
  (DLLLeft p q ll )
.

Definition remove_return_wit_2 := 
(
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (a: Z) (tl: (@list Z)) (q_2: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (lr = (cons (a) (tl)))) (PreH3 : (ll = (@nil Z))) (PreH4 : (q <> 0)) (PreH5 : (p = 0)) (PreH6 : (n_pre <> 0)) ,
  ((&((retval)  # "node_and_int" ->ₛ "node")) # Ptr  |-> q)
  **  ((&((retval)  # "node_and_int" ->ₛ "data")) # Int  |-> h)
  **  ((&((q)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  (DLLRight q_2 q tl )
  **  ((&((q)  # "node" ->ₛ "next")) # Ptr  |-> q_2)
  **  ((&((q)  # "node" ->ₛ "data")) # Int  |-> a)
|--
  EX (v: Z)  (t: Z) ,
  “ (q <> 0) ” 
  &&  “ (t = q) ”
  &&  ((&((retval)  # "node_and_int" ->ₛ "node")) # Ptr  |-> t)
  **  ((&((retval)  # "node_and_int" ->ₛ "data")) # Int  |-> h)
  **  (Dll t ll v (dll_tail (lr)) )
) \/
(
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (a: Z) (tl: (@list Z)) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (lr = (cons (a) (tl)))) (PreH3 : (ll = (@nil Z))) (PreH4 : (q <> 0)) (PreH5 : (p = 0)) (PreH6 : (n_pre <> 0)) ,
  TT && emp 
|--
  “ (tl = (dll_tail (lr))) ”
  &&  emp
).

Definition remove_return_wit_2_split_goal_1 := 
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (a: Z) (tl: (@list Z)) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (lr = (cons (a) (tl)))) (PreH3 : (ll = (@nil Z))) (PreH4 : (q <> 0)) (PreH5 : (p = 0)) (PreH6 : (n_pre <> 0)) ,
  (tl = (dll_tail (lr)))
.

Definition remove_return_wit_3 := 
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (lr = (@nil Z))) (PreH3 : (ll = (@nil Z))) (PreH4 : (q = 0)) (PreH5 : (p = 0)) (PreH6 : (n_pre <> 0)) ,
  ((&((retval)  # "node_and_int" ->ₛ "node")) # Ptr  |-> 0)
  **  ((&((retval)  # "node_and_int" ->ₛ "data")) # Int  |-> h)
|--
  EX (t: Z) ,
  “ (p = 0) ” 
  &&  “ (q = 0) ” 
  &&  “ (t = 0) ”
  &&  ((&((retval)  # "node_and_int" ->ₛ "node")) # Ptr  |-> t)
  **  ((&((retval)  # "node_and_int" ->ₛ "data")) # Int  |-> h)
  **  (Dll t (@nil Z) 0 (@nil Z) )
.

Definition remove_return_wit_4 := 
(
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (a: Z) (tl: (@list Z)) (q_2: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (lr = (@nil Z))) (PreH3 : (q = 0)) (PreH4 : (ll = (cons (a) (tl)))) (PreH5 : (p <> 0)) (PreH6 : (n_pre <> 0)) ,
  ((&((retval)  # "node_and_int" ->ₛ "node")) # Ptr  |-> p)
  **  ((&((retval)  # "node_and_int" ->ₛ "data")) # Int  |-> h)
  **  ((&((p)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft q_2 p tl )
  **  ((&((p)  # "node" ->ₛ "prev")) # Ptr  |-> q_2)
  **  ((&((p)  # "node" ->ₛ "data")) # Int  |-> a)
|--
  EX (v: Z)  (t: Z) ,
  “ (q = 0) ” 
  &&  “ (p <> 0) ” 
  &&  “ (t = p) ”
  &&  ((&((retval)  # "node_and_int" ->ₛ "node")) # Ptr  |-> t)
  **  ((&((retval)  # "node_and_int" ->ₛ "data")) # Int  |-> h)
  **  (Dll t (dll_tail (ll)) v lr )
) \/
(
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (a: Z) (tl: (@list Z)) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (lr = (@nil Z))) (PreH3 : (q = 0)) (PreH4 : (ll = (cons (a) (tl)))) (PreH5 : (p <> 0)) (PreH6 : (n_pre <> 0)) ,
  TT && emp 
|--
  “ (tl = (dll_tail (ll))) ”
  &&  emp
).

Definition remove_return_wit_4_split_goal_1 := 
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (a: Z) (tl: (@list Z)) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (lr = (@nil Z))) (PreH3 : (q = 0)) (PreH4 : (ll = (cons (a) (tl)))) (PreH5 : (p <> 0)) (PreH6 : (n_pre <> 0)) ,
  (tl = (dll_tail (ll)))
.

Definition remove_partial_solve_wit_1 := 
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (PreH1 : (p <> 0)) (PreH2 : (n_pre <> 0)) ,
  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft p n_pre ll )
  **  (DLLRight q n_pre lr )
|--
  EX (a: Z)  (tl: (@list Z))  (q_2: Z) ,
  “ (ll = (cons (a) (tl))) ” 
  &&  “ (p <> 0) ” 
  &&  “ (n_pre <> 0) ”
  &&  ((&((p)  # "node" ->ₛ "next")) # Ptr  |->_)
  **  (DLLLeft q_2 p tl )
  **  ((&((p)  # "node" ->ₛ "prev")) # Ptr  |-> q_2)
  **  ((&((p)  # "node" ->ₛ "data")) # Int  |-> a)
  **  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLRight q n_pre lr )
.

Definition remove_partial_solve_wit_2 := 
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (a: Z) (tl: (@list Z)) (q_2: Z) (PreH1 : (q <> 0)) (PreH2 : (ll = (cons (a) (tl)))) (PreH3 : (p <> 0)) (PreH4 : (n_pre <> 0)) ,
  ((&((p)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft q_2 p tl )
  **  ((&((p)  # "node" ->ₛ "prev")) # Ptr  |-> q_2)
  **  ((&((p)  # "node" ->ₛ "data")) # Int  |-> a)
  **  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLRight q n_pre lr )
|--
  EX (a_2: Z)  (tl_2: (@list Z))  (q_3: Z) ,
  “ (lr = (cons (a_2) (tl_2))) ” 
  &&  “ (q <> 0) ” 
  &&  “ (ll = (cons (a) (tl))) ” 
  &&  “ (p <> 0) ” 
  &&  “ (n_pre <> 0) ”
  &&  ((&((q)  # "node" ->ₛ "prev")) # Ptr  |->_)
  **  (DLLRight q_3 q tl_2 )
  **  ((&((q)  # "node" ->ₛ "next")) # Ptr  |-> q_3)
  **  ((&((q)  # "node" ->ₛ "data")) # Int  |-> a_2)
  **  ((&((p)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft q_2 p tl )
  **  ((&((p)  # "node" ->ₛ "prev")) # Ptr  |-> q_2)
  **  ((&((p)  # "node" ->ₛ "data")) # Int  |-> a)
  **  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
.

Definition remove_partial_solve_wit_3 := 
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (PreH1 : (q <> 0)) (PreH2 : (p = 0)) (PreH3 : (n_pre <> 0)) ,
  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft p n_pre ll )
  **  (DLLRight q n_pre lr )
|--
  EX (a: Z)  (tl: (@list Z))  (q_2: Z) ,
  “ (lr = (cons (a) (tl))) ” 
  &&  “ (ll = (@nil Z)) ” 
  &&  “ (q <> 0) ” 
  &&  “ (p = 0) ” 
  &&  “ (n_pre <> 0) ”
  &&  ((&((q)  # "node" ->ₛ "prev")) # Ptr  |->_)
  **  (DLLRight q_2 q tl )
  **  ((&((q)  # "node" ->ₛ "next")) # Ptr  |-> q_2)
  **  ((&((q)  # "node" ->ₛ "data")) # Int  |-> a)
  **  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
.

Definition remove_partial_solve_wit_4 := 
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (a: Z) (tl: (@list Z)) (q_2: Z) (a_2: Z) (tl_2: (@list Z)) (q_3: Z) (PreH1 : (lr = (cons (a_2) (tl_2)))) (PreH2 : (q <> 0)) (PreH3 : (ll = (cons (a) (tl)))) (PreH4 : (p <> 0)) (PreH5 : (n_pre <> 0)) ,
  ((&((q)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  (DLLRight q_3 q tl_2 )
  **  ((&((q)  # "node" ->ₛ "next")) # Ptr  |-> q_3)
  **  ((&((q)  # "node" ->ₛ "data")) # Int  |-> a_2)
  **  ((&((p)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft q_2 p tl )
  **  ((&((p)  # "node" ->ₛ "prev")) # Ptr  |-> q_2)
  **  ((&((p)  # "node" ->ₛ "data")) # Int  |-> a)
  **  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
|--
  “ (lr = (cons (a_2) (tl_2))) ” 
  &&  “ (q <> 0) ” 
  &&  “ (ll = (cons (a) (tl))) ” 
  &&  “ (p <> 0) ” 
  &&  “ (n_pre <> 0) ”
  &&  ((&((q)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  (DLLRight q_3 q tl_2 )
  **  ((&((q)  # "node" ->ₛ "next")) # Ptr  |-> q_3)
  **  ((&((q)  # "node" ->ₛ "data")) # Int  |-> a_2)
  **  ((&((p)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft q_2 p tl )
  **  ((&((p)  # "node" ->ₛ "prev")) # Ptr  |-> q_2)
  **  ((&((p)  # "node" ->ₛ "data")) # Int  |-> a)
  **  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
.

Definition remove_partial_solve_wit_5 := 
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (a: Z) (tl: (@list Z)) (q_2: Z) (PreH1 : (lr = (cons (a) (tl)))) (PreH2 : (ll = (@nil Z))) (PreH3 : (q <> 0)) (PreH4 : (p = 0)) (PreH5 : (n_pre <> 0)) ,
  ((&((q)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  (DLLRight q_2 q tl )
  **  ((&((q)  # "node" ->ₛ "next")) # Ptr  |-> q_2)
  **  ((&((q)  # "node" ->ₛ "data")) # Int  |-> a)
  **  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
|--
  “ (lr = (cons (a) (tl))) ” 
  &&  “ (ll = (@nil Z)) ” 
  &&  “ (q <> 0) ” 
  &&  “ (p = 0) ” 
  &&  “ (n_pre <> 0) ”
  &&  ((&((q)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  (DLLRight q_2 q tl )
  **  ((&((q)  # "node" ->ₛ "next")) # Ptr  |-> q_2)
  **  ((&((q)  # "node" ->ₛ "data")) # Int  |-> a)
  **  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
.

Definition remove_partial_solve_wit_6 := 
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (PreH1 : (q = 0)) (PreH2 : (p = 0)) (PreH3 : (n_pre <> 0)) ,
  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft p n_pre ll )
  **  (DLLRight q n_pre lr )
|--
  “ (lr = (@nil Z)) ” 
  &&  “ (ll = (@nil Z)) ” 
  &&  “ (q = 0) ” 
  &&  “ (p = 0) ” 
  &&  “ (n_pre <> 0) ”
  &&  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
.

Definition remove_partial_solve_wit_7 := 
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (a: Z) (tl: (@list Z)) (q_2: Z) (PreH1 : (q = 0)) (PreH2 : (ll = (cons (a) (tl)))) (PreH3 : (p <> 0)) (PreH4 : (n_pre <> 0)) ,
  ((&((p)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft q_2 p tl )
  **  ((&((p)  # "node" ->ₛ "prev")) # Ptr  |-> q_2)
  **  ((&((p)  # "node" ->ₛ "data")) # Int  |-> a)
  **  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLRight q n_pre lr )
|--
  “ (lr = (@nil Z)) ” 
  &&  “ (q = 0) ” 
  &&  “ (ll = (cons (a) (tl))) ” 
  &&  “ (p <> 0) ” 
  &&  “ (n_pre <> 0) ”
  &&  ((&((p)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft q_2 p tl )
  **  ((&((p)  # "node" ->ₛ "prev")) # Ptr  |-> q_2)
  **  ((&((p)  # "node" ->ₛ "data")) # Int  |-> a)
  **  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
.

Definition remove_partial_solve_wit_8 := 
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (a: Z) (tl: (@list Z)) (q_2: Z) (a_2: Z) (tl_2: (@list Z)) (q_3: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (lr = (cons (a_2) (tl_2)))) (PreH3 : (q <> 0)) (PreH4 : (ll = (cons (a) (tl)))) (PreH5 : (p <> 0)) (PreH6 : (n_pre <> 0)) ,
  ((&((retval)  # "node_and_int" ->ₛ "node")) # Ptr  |-> q)
  **  ((&((retval)  # "node_and_int" ->ₛ "data")) # Int  |-> h)
  **  ((&((q)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  (DLLRight q_3 q tl_2 )
  **  ((&((q)  # "node" ->ₛ "next")) # Ptr  |-> q_3)
  **  ((&((q)  # "node" ->ₛ "data")) # Int  |-> a_2)
  **  ((&((p)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft q_2 p tl )
  **  ((&((p)  # "node" ->ₛ "prev")) # Ptr  |-> q_2)
  **  ((&((p)  # "node" ->ₛ "data")) # Int  |-> a)
  **  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
|--
  “ (retval <> 0) ” 
  &&  “ (lr = (cons (a_2) (tl_2))) ” 
  &&  “ (q <> 0) ” 
  &&  “ (ll = (cons (a) (tl))) ” 
  &&  “ (p <> 0) ” 
  &&  “ (n_pre <> 0) ”
  &&  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |->_)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |->_)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |->_)
  **  ((&((retval)  # "node_and_int" ->ₛ "node")) # Ptr  |-> q)
  **  ((&((retval)  # "node_and_int" ->ₛ "data")) # Int  |-> h)
  **  ((&((q)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  (DLLRight q_3 q tl_2 )
  **  ((&((q)  # "node" ->ₛ "next")) # Ptr  |-> q_3)
  **  ((&((q)  # "node" ->ₛ "data")) # Int  |-> a_2)
  **  ((&((p)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft q_2 p tl )
  **  ((&((p)  # "node" ->ₛ "prev")) # Ptr  |-> q_2)
  **  ((&((p)  # "node" ->ₛ "data")) # Int  |-> a)
.

Definition remove_partial_solve_wit_9 := 
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (a: Z) (tl: (@list Z)) (q_2: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (lr = (cons (a) (tl)))) (PreH3 : (ll = (@nil Z))) (PreH4 : (q <> 0)) (PreH5 : (p = 0)) (PreH6 : (n_pre <> 0)) ,
  ((&((retval)  # "node_and_int" ->ₛ "node")) # Ptr  |-> q)
  **  ((&((retval)  # "node_and_int" ->ₛ "data")) # Int  |-> h)
  **  ((&((q)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  (DLLRight q_2 q tl )
  **  ((&((q)  # "node" ->ₛ "next")) # Ptr  |-> q_2)
  **  ((&((q)  # "node" ->ₛ "data")) # Int  |-> a)
  **  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
|--
  “ (retval <> 0) ” 
  &&  “ (lr = (cons (a) (tl))) ” 
  &&  “ (ll = (@nil Z)) ” 
  &&  “ (q <> 0) ” 
  &&  “ (p = 0) ” 
  &&  “ (n_pre <> 0) ”
  &&  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |->_)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |->_)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |->_)
  **  ((&((retval)  # "node_and_int" ->ₛ "node")) # Ptr  |-> q)
  **  ((&((retval)  # "node_and_int" ->ₛ "data")) # Int  |-> h)
  **  ((&((q)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  (DLLRight q_2 q tl )
  **  ((&((q)  # "node" ->ₛ "next")) # Ptr  |-> q_2)
  **  ((&((q)  # "node" ->ₛ "data")) # Int  |-> a)
.

Definition remove_partial_solve_wit_10 := 
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (lr = (@nil Z))) (PreH3 : (ll = (@nil Z))) (PreH4 : (q = 0)) (PreH5 : (p = 0)) (PreH6 : (n_pre <> 0)) ,
  ((&((retval)  # "node_and_int" ->ₛ "node")) # Ptr  |-> 0)
  **  ((&((retval)  # "node_and_int" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
|--
  “ (retval <> 0) ” 
  &&  “ (lr = (@nil Z)) ” 
  &&  “ (ll = (@nil Z)) ” 
  &&  “ (q = 0) ” 
  &&  “ (p = 0) ” 
  &&  “ (n_pre <> 0) ”
  &&  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |->_)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |->_)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |->_)
  **  ((&((retval)  # "node_and_int" ->ₛ "node")) # Ptr  |-> 0)
  **  ((&((retval)  # "node_and_int" ->ₛ "data")) # Int  |-> h)
.

Definition remove_partial_solve_wit_11 := 
forall (n_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (a: Z) (tl: (@list Z)) (q_2: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (lr = (@nil Z))) (PreH3 : (q = 0)) (PreH4 : (ll = (cons (a) (tl)))) (PreH5 : (p <> 0)) (PreH6 : (n_pre <> 0)) ,
  ((&((retval)  # "node_and_int" ->ₛ "node")) # Ptr  |-> p)
  **  ((&((retval)  # "node_and_int" ->ₛ "data")) # Int  |-> h)
  **  ((&((p)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft q_2 p tl )
  **  ((&((p)  # "node" ->ₛ "prev")) # Ptr  |-> q_2)
  **  ((&((p)  # "node" ->ₛ "data")) # Int  |-> a)
  **  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
|--
  “ (retval <> 0) ” 
  &&  “ (lr = (@nil Z)) ” 
  &&  “ (q = 0) ” 
  &&  “ (ll = (cons (a) (tl))) ” 
  &&  “ (p <> 0) ” 
  &&  “ (n_pre <> 0) ”
  &&  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |->_)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |->_)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |->_)
  **  ((&((retval)  # "node_and_int" ->ₛ "node")) # Ptr  |-> p)
  **  ((&((retval)  # "node_and_int" ->ₛ "data")) # Int  |-> h)
  **  ((&((p)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft q_2 p tl )
  **  ((&((p)  # "node" ->ₛ "prev")) # Ptr  |-> q_2)
  **  ((&((p)  # "node" ->ₛ "data")) # Int  |-> a)
.

Module Type VC_Correct.

Axiom proof_of_remove_safety_wit_1 : remove_safety_wit_1.
Axiom proof_of_remove_safety_wit_2 : remove_safety_wit_2.
Axiom proof_of_remove_safety_wit_3 : remove_safety_wit_3.
Axiom proof_of_remove_safety_wit_4 : remove_safety_wit_4.
Axiom proof_of_remove_return_wit_1 : remove_return_wit_1.
Axiom proof_of_remove_return_wit_2 : remove_return_wit_2.
Axiom proof_of_remove_return_wit_3 : remove_return_wit_3.
Axiom proof_of_remove_return_wit_4 : remove_return_wit_4.
Axiom proof_of_remove_partial_solve_wit_1 : remove_partial_solve_wit_1.
Axiom proof_of_remove_partial_solve_wit_2 : remove_partial_solve_wit_2.
Axiom proof_of_remove_partial_solve_wit_3 : remove_partial_solve_wit_3.
Axiom proof_of_remove_partial_solve_wit_4 : remove_partial_solve_wit_4.
Axiom proof_of_remove_partial_solve_wit_5 : remove_partial_solve_wit_5.
Axiom proof_of_remove_partial_solve_wit_6 : remove_partial_solve_wit_6.
Axiom proof_of_remove_partial_solve_wit_7 : remove_partial_solve_wit_7.
Axiom proof_of_remove_partial_solve_wit_8 : remove_partial_solve_wit_8.
Axiom proof_of_remove_partial_solve_wit_9 : remove_partial_solve_wit_9.
Axiom proof_of_remove_partial_solve_wit_10 : remove_partial_solve_wit_10.
Axiom proof_of_remove_partial_solve_wit_11 : remove_partial_solve_wit_11.

End VC_Correct.
