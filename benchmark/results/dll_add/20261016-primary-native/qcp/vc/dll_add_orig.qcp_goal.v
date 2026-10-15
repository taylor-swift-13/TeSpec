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
Local Open Scope Z_scope.

(*----- Function add -----*)

Definition add_safety_wit_1 := 
forall (n_pre: Z) (element_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (e: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (element_pre = e)) (PreH3 : (n_pre <> 0)) ,
  ((&((retval)  # "node" ->ₛ "data")) # Int  |-> element_pre)
  **  ((&((retval)  # "node" ->ₛ "prev")) # Ptr  |->_)
  **  ((&((retval)  # "node" ->ₛ "next")) # Ptr  |->_)
  **  ((( &( "new_node" ) )) # Ptr  |-> retval)
  **  ((( &( "element" ) )) # Int  |-> element_pre)
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

Definition add_safety_wit_2 := 
forall (n_pre: Z) (element_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (e: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (element_pre = e)) (PreH3 : (n_pre = 0)) (PreH4 : (ll = (@nil Z))) (PreH5 : (lr = (@nil Z))) ,
  ((&((retval)  # "node" ->ₛ "data")) # Int  |-> element_pre)
  **  ((&((retval)  # "node" ->ₛ "prev")) # Ptr  |->_)
  **  ((&((retval)  # "node" ->ₛ "next")) # Ptr  |->_)
  **  ((( &( "new_node" ) )) # Ptr  |-> retval)
  **  ((( &( "element" ) )) # Int  |-> element_pre)
  **  ((( &( "n" ) )) # Ptr  |-> n_pre)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition add_safety_wit_3 := 
forall (n_pre: Z) (element_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (e: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (element_pre = e)) (PreH3 : (n_pre <> 0)) ,
  ((&((retval)  # "node" ->ₛ "data")) # Int  |-> element_pre)
  **  ((&((retval)  # "node" ->ₛ "prev")) # Ptr  |-> 0)
  **  ((&((retval)  # "node" ->ₛ "next")) # Ptr  |->_)
  **  ((( &( "new_node" ) )) # Ptr  |-> retval)
  **  ((( &( "element" ) )) # Int  |-> element_pre)
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

Definition add_safety_wit_4 := 
forall (n_pre: Z) (element_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (e: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (element_pre = e)) (PreH3 : (n_pre = 0)) (PreH4 : (ll = (@nil Z))) (PreH5 : (lr = (@nil Z))) ,
  ((&((retval)  # "node" ->ₛ "data")) # Int  |-> element_pre)
  **  ((&((retval)  # "node" ->ₛ "prev")) # Ptr  |-> 0)
  **  ((&((retval)  # "node" ->ₛ "next")) # Ptr  |->_)
  **  ((( &( "new_node" ) )) # Ptr  |-> retval)
  **  ((( &( "element" ) )) # Int  |-> element_pre)
  **  ((( &( "n" ) )) # Ptr  |-> n_pre)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition add_safety_wit_5 := 
forall (n_pre: Z) (element_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (e: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (element_pre = e)) (PreH3 : (n_pre <> 0)) ,
  ((&((retval)  # "node" ->ₛ "data")) # Int  |-> element_pre)
  **  ((&((retval)  # "node" ->ₛ "prev")) # Ptr  |-> 0)
  **  ((&((retval)  # "node" ->ₛ "next")) # Ptr  |-> 0)
  **  ((( &( "new_node" ) )) # Ptr  |-> retval)
  **  ((( &( "element" ) )) # Int  |-> element_pre)
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

Definition add_safety_wit_6 := 
forall (n_pre: Z) (element_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (e: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (element_pre = e)) (PreH3 : (n_pre = 0)) (PreH4 : (ll = (@nil Z))) (PreH5 : (lr = (@nil Z))) ,
  ((&((retval)  # "node" ->ₛ "data")) # Int  |-> element_pre)
  **  ((&((retval)  # "node" ->ₛ "prev")) # Ptr  |-> 0)
  **  ((&((retval)  # "node" ->ₛ "next")) # Ptr  |-> 0)
  **  ((( &( "new_node" ) )) # Ptr  |-> retval)
  **  ((( &( "element" ) )) # Int  |-> element_pre)
  **  ((( &( "n" ) )) # Ptr  |-> n_pre)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition add_safety_wit_7 := 
forall (n_pre: Z) (element_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (e: Z) (retval: Z) (PreH1 : (n_pre = 0)) (PreH2 : (retval <> 0)) (PreH3 : (element_pre = e)) (PreH4 : (n_pre <> 0)) ,
  ((&((retval)  # "node" ->ₛ "data")) # Int  |-> element_pre)
  **  ((&((retval)  # "node" ->ₛ "prev")) # Ptr  |-> 0)
  **  ((&((retval)  # "node" ->ₛ "next")) # Ptr  |-> 0)
  **  ((( &( "new_node" ) )) # Ptr  |-> retval)
  **  ((( &( "element" ) )) # Int  |-> element_pre)
  **  ((( &( "n" ) )) # Ptr  |-> n_pre)
  **  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft p n_pre ll )
  **  (DLLRight q n_pre lr )
|--
  “ False ”
.

Definition add_safety_wit_8 := 
forall (n_pre: Z) (element_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (e: Z) (retval: Z) (PreH1 : (n_pre <> 0)) (PreH2 : (retval <> 0)) (PreH3 : (element_pre = e)) (PreH4 : (n_pre = 0)) (PreH5 : (ll = (@nil Z))) (PreH6 : (lr = (@nil Z))) ,
  ((&((retval)  # "node" ->ₛ "data")) # Int  |-> element_pre)
  **  ((&((retval)  # "node" ->ₛ "prev")) # Ptr  |-> 0)
  **  ((&((retval)  # "node" ->ₛ "next")) # Ptr  |-> 0)
  **  ((( &( "new_node" ) )) # Ptr  |-> retval)
  **  ((( &( "element" ) )) # Int  |-> element_pre)
  **  ((( &( "n" ) )) # Ptr  |-> n_pre)
|--
  “ False ”
.

Definition add_safety_wit_9 := 
forall (n_pre: Z) (element_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (e: Z) (retval: Z) (PreH1 : (n_pre = 0)) (PreH2 : (retval <> 0)) (PreH3 : (element_pre = e)) (PreH4 : (n_pre = 0)) (PreH5 : (ll = (@nil Z))) (PreH6 : (lr = (@nil Z))) ,
  ((&((retval)  # "node" ->ₛ "data")) # Int  |-> element_pre)
  **  ((&((retval)  # "node" ->ₛ "prev")) # Ptr  |-> 0)
  **  ((&((retval)  # "node" ->ₛ "next")) # Ptr  |-> 0)
  **  ((( &( "new_node" ) )) # Ptr  |-> retval)
  **  ((( &( "element" ) )) # Int  |-> element_pre)
  **  ((( &( "n" ) )) # Ptr  |-> n_pre)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition add_safety_wit_10 := 
forall (n_pre: Z) (element_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (e: Z) (retval: Z) (PreH1 : (n_pre = 0)) (PreH2 : (retval <> 0)) (PreH3 : (element_pre = e)) (PreH4 : (n_pre = 0)) (PreH5 : (ll = (@nil Z))) (PreH6 : (lr = (@nil Z))) ,
  ((&((retval)  # "node" ->ₛ "data")) # Int  |-> element_pre)
  **  ((&((retval)  # "node" ->ₛ "prev")) # Ptr  |-> 0)
  **  ((&((retval)  # "node" ->ₛ "next")) # Ptr  |-> 0)
  **  ((( &( "new_node" ) )) # Ptr  |-> retval)
  **  ((( &( "element" ) )) # Int  |-> element_pre)
  **  ((( &( "n" ) )) # Ptr  |-> n_pre)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition add_safety_wit_11 := 
forall (n_pre: Z) (element_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (e: Z) (retval: Z) (PreH1 : (n_pre <> 0)) (PreH2 : (retval <> 0)) (PreH3 : (element_pre = e)) (PreH4 : (n_pre <> 0)) ,
  ((&((retval)  # "node" ->ₛ "data")) # Int  |-> element_pre)
  **  ((&((retval)  # "node" ->ₛ "prev")) # Ptr  |-> n_pre)
  **  ((&((retval)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  ((( &( "new_node" ) )) # Ptr  |-> retval)
  **  ((( &( "element" ) )) # Int  |-> element_pre)
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

Definition add_return_wit_1 := 
(
forall (n_pre: Z) (element_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (e: Z) (retval: Z) (a: Z) (tl: (@list Z)) (q_2: Z) (PreH1 : (lr = (cons (a) (tl)))) (PreH2 : (q <> 0)) (PreH3 : (n_pre <> 0)) (PreH4 : (retval <> 0)) (PreH5 : (element_pre = e)) (PreH6 : (n_pre <> 0)) ,
  ((&((q)  # "node" ->ₛ "prev")) # Ptr  |-> retval)
  **  (DLLRight q_2 q tl )
  **  ((&((q)  # "node" ->ₛ "next")) # Ptr  |-> q_2)
  **  ((&((q)  # "node" ->ₛ "data")) # Int  |-> a)
  **  ((&((retval)  # "node" ->ₛ "data")) # Int  |-> element_pre)
  **  ((&((retval)  # "node" ->ₛ "prev")) # Ptr  |-> n_pre)
  **  ((&((retval)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> retval)
  **  (DLLLeft p n_pre ll )
|--
  “ (n_pre <> 0) ”
  &&  (Dll retval (cons (h) (ll)) e lr )
) \/
(
forall (n_pre: Z) (element_pre: Z) (lr: (@list Z)) (q: Z) (e: Z) (retval: Z) (a: Z) (tl: (@list Z)) (q_2: Z) (PreH1 : (a <= INT_MAX)) (PreH2 : (a >= INT_MIN)) (PreH3 : (lr = (cons (a) (tl)))) (PreH4 : (q <> 0)) (PreH5 : (n_pre <> 0)) (PreH6 : (retval <> 0)) (PreH7 : (element_pre = e)) (PreH8 : (n_pre <> 0)) ,
  ((&((q)  # "node" ->ₛ "prev")) # Ptr  |-> retval)
  **  (DLLRight q_2 q tl )
  **  ((&((q)  # "node" ->ₛ "next")) # Ptr  |-> q_2)
  **  ((&((q)  # "node" ->ₛ "data")) # Int  |-> a)
|--
  (DLLRight q retval lr )
).

Definition add_return_wit_1_split_goal_spatial := 
forall (n_pre: Z) (element_pre: Z) (lr: (@list Z)) (q: Z) (e: Z) (retval: Z) (a: Z) (tl: (@list Z)) (q_2: Z) (PreH1 : (a <= INT_MAX)) (PreH2 : (a >= INT_MIN)) (PreH3 : (lr = (cons (a) (tl)))) (PreH4 : (q <> 0)) (PreH5 : (n_pre <> 0)) (PreH6 : (retval <> 0)) (PreH7 : (element_pre = e)) (PreH8 : (n_pre <> 0)) ,
  ((&((q)  # "node" ->ₛ "prev")) # Ptr  |-> retval)
  **  (DLLRight q_2 q tl )
  **  ((&((q)  # "node" ->ₛ "next")) # Ptr  |-> q_2)
  **  ((&((q)  # "node" ->ₛ "data")) # Int  |-> a)
|--
  (DLLRight q retval lr )
.

Definition add_return_wit_2 := 
forall (n_pre: Z) (element_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (e: Z) (retval: Z) (PreH1 : (q = 0)) (PreH2 : (n_pre <> 0)) (PreH3 : (retval <> 0)) (PreH4 : (element_pre = e)) (PreH5 : (n_pre <> 0)) ,
  ((&((retval)  # "node" ->ₛ "data")) # Int  |-> element_pre)
  **  ((&((retval)  # "node" ->ₛ "prev")) # Ptr  |-> n_pre)
  **  ((&((retval)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> retval)
  **  (DLLLeft p n_pre ll )
  **  (DLLRight q n_pre lr )
|--
  “ (n_pre <> 0) ”
  &&  (Dll retval (cons (h) (ll)) e lr )
.

Definition add_return_wit_3 := 
forall (n_pre: Z) (element_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (e: Z) (retval: Z) (PreH1 : (n_pre = 0)) (PreH2 : (retval <> 0)) (PreH3 : (element_pre = e)) (PreH4 : (n_pre = 0)) (PreH5 : (ll = (@nil Z))) (PreH6 : (lr = (@nil Z))) ,
  ((&((retval)  # "node" ->ₛ "data")) # Int  |-> element_pre)
  **  ((&((retval)  # "node" ->ₛ "prev")) # Ptr  |-> 0)
  **  ((&((retval)  # "node" ->ₛ "next")) # Ptr  |-> 0)
|--
  “ (n_pre = 0) ”
  &&  (Dll retval (@nil Z) e (@nil Z) )
.

Definition add_partial_solve_wit_1 := 
forall (n_pre: Z) (element_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (e: Z) (PreH1 : (element_pre = e)) (PreH2 : (n_pre <> 0)) ,
  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft p n_pre ll )
  **  (DLLRight q n_pre lr )
|--
  “ (element_pre = e) ” 
  &&  “ (n_pre <> 0) ”
  &&  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft p n_pre ll )
  **  (DLLRight q n_pre lr )
.

Definition add_partial_solve_wit_2 := 
forall (n_pre: Z) (element_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (e: Z) (PreH1 : (element_pre = e)) (PreH2 : (n_pre = 0)) (PreH3 : (ll = (@nil Z))) (PreH4 : (lr = (@nil Z))) ,
  TT && emp 
|--
  “ (element_pre = e) ” 
  &&  “ (n_pre = 0) ” 
  &&  “ (ll = (@nil Z)) ” 
  &&  “ (lr = (@nil Z)) ”
  &&  emp
.

Definition add_partial_solve_wit_3 := 
forall (n_pre: Z) (element_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (e: Z) (retval: Z) (PreH1 : (q <> 0)) (PreH2 : (n_pre <> 0)) (PreH3 : (retval <> 0)) (PreH4 : (element_pre = e)) (PreH5 : (n_pre <> 0)) ,
  ((&((retval)  # "node" ->ₛ "data")) # Int  |-> element_pre)
  **  ((&((retval)  # "node" ->ₛ "prev")) # Ptr  |-> n_pre)
  **  ((&((retval)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft p n_pre ll )
  **  (DLLRight q n_pre lr )
|--
  EX (a: Z)  (tl: (@list Z))  (q_2: Z) ,
  “ (lr = (cons (a) (tl))) ” 
  &&  “ (q <> 0) ” 
  &&  “ (n_pre <> 0) ” 
  &&  “ (retval <> 0) ” 
  &&  “ (element_pre = e) ” 
  &&  “ (n_pre <> 0) ”
  &&  ((&((q)  # "node" ->ₛ "prev")) # Ptr  |->_)
  **  (DLLRight q_2 q tl )
  **  ((&((q)  # "node" ->ₛ "next")) # Ptr  |-> q_2)
  **  ((&((q)  # "node" ->ₛ "data")) # Int  |-> a)
  **  ((&((retval)  # "node" ->ₛ "data")) # Int  |-> element_pre)
  **  ((&((retval)  # "node" ->ₛ "prev")) # Ptr  |-> n_pre)
  **  ((&((retval)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  (DLLLeft p n_pre ll )
.

Module Type VC_Correct.

Axiom proof_of_add_safety_wit_1 : add_safety_wit_1.
Axiom proof_of_add_safety_wit_2 : add_safety_wit_2.
Axiom proof_of_add_safety_wit_3 : add_safety_wit_3.
Axiom proof_of_add_safety_wit_4 : add_safety_wit_4.
Axiom proof_of_add_safety_wit_5 : add_safety_wit_5.
Axiom proof_of_add_safety_wit_6 : add_safety_wit_6.
Axiom proof_of_add_safety_wit_7 : add_safety_wit_7.
Axiom proof_of_add_safety_wit_8 : add_safety_wit_8.
Axiom proof_of_add_safety_wit_9 : add_safety_wit_9.
Axiom proof_of_add_safety_wit_10 : add_safety_wit_10.
Axiom proof_of_add_safety_wit_11 : add_safety_wit_11.
Axiom proof_of_add_return_wit_1 : add_return_wit_1.
Axiom proof_of_add_return_wit_2 : add_return_wit_2.
Axiom proof_of_add_return_wit_3 : add_return_wit_3.
Axiom proof_of_add_partial_solve_wit_1 : add_partial_solve_wit_1.
Axiom proof_of_add_partial_solve_wit_2 : add_partial_solve_wit_2.
Axiom proof_of_add_partial_solve_wit_3 : add_partial_solve_wit_3.

End VC_Correct.
