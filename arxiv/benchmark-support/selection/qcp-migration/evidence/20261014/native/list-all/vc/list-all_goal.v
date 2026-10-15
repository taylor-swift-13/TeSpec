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

(*----- Function IntList_nil -----*)

Definition IntList_nil_safety_wit_1 := 
  TT && emp 
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntList_nil_return_wit_1 := 
  TT && emp 
|--
  (sll 0 (@nil Z) )
.

(*----- Function IntList_cons -----*)

Definition IntList_cons_return_wit_1 := 
forall (t_pre: Z) (h_pre: Z) (l: (@list Z)) (h0: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (h_pre = h0)) ,
  ((&((retval)  # "list" ->ₛ "data")) # Int  |-> h_pre)
  **  ((&((retval)  # "list" ->ₛ "next")) # Ptr  |-> t_pre)
  **  (sll t_pre l )
|--
  (sll retval (cons (h0) (l)) )
.

Definition IntList_cons_partial_solve_wit_1 := 
forall (t_pre: Z) (h_pre: Z) (l: (@list Z)) (h0: Z) (PreH1 : (h_pre = h0)) ,
  (sll t_pre l )
|--
  “ (h_pre = h0) ”
  &&  (sll t_pre l )
.

(*----- Function IntList_copy -----*)

Definition IntList_copy_safety_wit_1 := 
forall (xs_pre: Z) (l: (@list Z)) ,
  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
  **  (sll xs_pre l )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntList_copy_return_wit_1 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (retval: Z) (PreH1 : (l = (cons (x) (l0)))) (PreH2 : (xs_pre <> 0)) ,
  (sll retval (cons (x) (l0)) )
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
|--
  (sll xs_pre l )
  **  (sll retval l )
.

Definition IntList_copy_return_wit_2 := 
(
forall (xs_pre: Z) (l: (@list Z)) (retval: Z) (PreH1 : (xs_pre = 0)) ,
  (sll retval (@nil Z) )
  **  (sll xs_pre l )
|--
  (sll xs_pre l )
  **  (sll retval l )
) \/
(
forall (xs_pre: Z) (l: (@list Z)) (retval: Z) (PreH1 : (retval = 0)) (PreH2 : (xs_pre = 0)) ,
  (sll xs_pre l )
|--
  “ (l = (@nil Z)) ” 
  &&  “ (l = (@nil Z)) ”
  &&  emp
).

Definition IntList_copy_return_wit_2_split_goal_1 := 
forall (xs_pre: Z) (l: (@list Z)) (retval: Z) (PreH1 : (retval = 0)) (PreH2 : (xs_pre = 0)) ,
  (sll xs_pre l )
|--
  “ (l = (@nil Z)) ”
.

Definition IntList_copy_return_wit_2_split_goal_2 := 
forall (xs_pre: Z) (l: (@list Z)) (retval: Z) (PreH1 : (retval = 0)) (PreH2 : (xs_pre = 0)) ,
  (sll xs_pre l )
|--
  “ (l = (@nil Z)) ”
.

Definition IntList_copy_return_wit_2_split_goal_spatial := 
forall (xs_pre: Z) (l: (@list Z)) (retval: Z) (PreH1 : (retval = 0)) (PreH2 : (xs_pre = 0)) ,
  (sll xs_pre l )
|--
  TT && emp 
.

Definition IntList_copy_partial_solve_wit_1 := 
forall (xs_pre: Z) (l: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre l )
|--
  “ (xs_pre = 0) ”
  &&  (sll xs_pre l )
.

Definition IntList_copy_partial_solve_wit_2 := 
forall (xs_pre: Z) (l: (@list Z)) (PreH1 : (xs_pre <> 0)) ,
  (sll xs_pre l )
|--
  EX (x: Z)  (l0: (@list Z))  (y: Z) ,
  “ (l = (cons (x) (l0))) ” 
  &&  “ (xs_pre <> 0) ”
  &&  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
.

Definition IntList_copy_partial_solve_wit_3 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (l = (cons (x) (l0)))) (PreH2 : (xs_pre <> 0)) ,
  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
|--
  “ (l = (cons (x) (l0))) ” 
  &&  “ (xs_pre <> 0) ”
  &&  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
.

Definition IntList_copy_partial_solve_wit_4_pure := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (retval: Z) (PreH1 : (l = (cons (x) (l0)))) (PreH2 : (xs_pre <> 0)) ,
  (sll y l0 )
  **  (sll retval l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
  **  ((( &( "new_tail" ) )) # Ptr  |-> retval)
  **  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
|--
  “ (x = x) ”
.

Definition IntList_copy_partial_solve_wit_4_aux := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (retval: Z) (PreH1 : (l = (cons (x) (l0)))) (PreH2 : (xs_pre <> 0)) ,
  (sll y l0 )
  **  (sll retval l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
|--
  “ (x = x) ” 
  &&  “ (l = (cons (x) (l0))) ” 
  &&  “ (xs_pre <> 0) ”
  &&  (sll retval l0 )
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
.

Definition IntList_copy_partial_solve_wit_4 := IntList_copy_partial_solve_wit_4_pure -> IntList_copy_partial_solve_wit_4_aux.

(*----- Function IntList_free_list -----*)

Definition IntList_free_list_safety_wit_1 := 
forall (xs_pre: Z) (l: (@list Z)) ,
  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
  **  (sll xs_pre l )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntList_free_list_return_wit_1 := 
(
forall (xs_pre: Z) (l: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre l )
|--
  TT && emp 
) \/
(
forall (xs_pre: Z) (l: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre l )
|--
  TT && emp 
).

Definition IntList_free_list_return_wit_1_split_goal_spatial := 
forall (xs_pre: Z) (l: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre l )
|--
  TT && emp 
.

Definition IntList_free_list_return_wit_2 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (PreH1 : (l = (cons (x) (l0)))) (PreH2 : (xs_pre <> 0)) ,
  TT && emp 
|--
  TT && emp 
.

Definition IntList_free_list_partial_solve_wit_1 := 
forall (xs_pre: Z) (l: (@list Z)) (PreH1 : (xs_pre <> 0)) ,
  (sll xs_pre l )
|--
  EX (x: Z)  (l0: (@list Z))  (y: Z) ,
  “ (l = (cons (x) (l0))) ” 
  &&  “ (xs_pre <> 0) ”
  &&  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
.

Definition IntList_free_list_partial_solve_wit_2 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (l = (cons (x) (l0)))) (PreH2 : (xs_pre <> 0)) ,
  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
|--
  “ (l = (cons (x) (l0))) ” 
  &&  “ (xs_pre <> 0) ”
  &&  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
.

Definition IntList_free_list_partial_solve_wit_3 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (l = (cons (x) (l0)))) (PreH2 : (xs_pre <> 0)) ,
  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
|--
  “ (l = (cons (x) (l0))) ” 
  &&  “ (xs_pre <> 0) ”
  &&  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |->_)
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |->_)
.

(*----- Function IntList_length -----*)

Definition IntList_length_safety_wit_1 := 
forall (xs_pre: Z) (l: (@list Z)) ,
  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
  **  (sll xs_pre l )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntList_length_safety_wit_2 := 
forall (xs_pre: Z) (l: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
  **  (sll xs_pre l )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntList_length_safety_wit_3 := 
forall (xs_pre: Z) (l: (@list Z)) (PreH1 : (xs_pre <> 0)) ,
  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
  **  (sll xs_pre l )
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition IntList_length_return_wit_1 := 
(
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (retval: Z) (PreH1 : (retval = ((Zlength (l0)) % ( 4294967296 ) ))) (PreH2 : (l = (cons (x) (l0)))) (PreH3 : (xs_pre <> 0)) ,
  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
|--
  “ ((unsigned_last_nbits ((1 + retval )) (32)) = ((Zlength (l)) % ( 4294967296 ) )) ”
  &&  (sll xs_pre l )
) \/
(
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (retval: Z) (PreH1 : (retval = ((Zlength (l0)) % ( 4294967296 ) ))) (PreH2 : (l = (cons (x) (l0)))) (PreH3 : (xs_pre <> 0)) ,
  TT && emp 
|--
  “ ((unsigned_last_nbits ((1 + retval )) (32)) = ((Zlength (l)) % ( 4294967296 ) )) ”
  &&  emp
).

Definition IntList_length_return_wit_1_split_goal_1 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (retval: Z) (PreH1 : (retval = ((Zlength (l0)) % ( 4294967296 ) ))) (PreH2 : (l = (cons (x) (l0)))) (PreH3 : (xs_pre <> 0)) ,
  ((unsigned_last_nbits ((1 + retval )) (32)) = ((Zlength (l)) % ( 4294967296 ) ))
.

Definition IntList_length_return_wit_2 := 
(
forall (xs_pre: Z) (l: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre l )
|--
  “ (0 = ((Zlength (l)) % ( 4294967296 ) )) ”
  &&  (sll xs_pre l )
) \/
(
forall (xs_pre: Z) (l: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre l )
|--
  “ (0 = ((Zlength (l)) % ( 4294967296 ) )) ” 
  &&  “ (l = (@nil Z)) ”
  &&  emp
).

Definition IntList_length_return_wit_2_split_goal_1 := 
forall (xs_pre: Z) (l: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre l )
|--
  “ (0 = ((Zlength (l)) % ( 4294967296 ) )) ”
.

Definition IntList_length_return_wit_2_split_goal_2 := 
forall (xs_pre: Z) (l: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre l )
|--
  “ (l = (@nil Z)) ”
.

Definition IntList_length_return_wit_2_split_goal_spatial := 
forall (xs_pre: Z) (l: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre l )
|--
  TT && emp 
.

Definition IntList_length_partial_solve_wit_1 := 
forall (xs_pre: Z) (l: (@list Z)) (PreH1 : (xs_pre <> 0)) ,
  (sll xs_pre l )
|--
  EX (x: Z)  (l0: (@list Z))  (y: Z) ,
  “ (l = (cons (x) (l0))) ” 
  &&  “ (xs_pre <> 0) ”
  &&  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
.

Definition IntList_length_partial_solve_wit_2 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (l = (cons (x) (l0)))) (PreH2 : (xs_pre <> 0)) ,
  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
|--
  “ (l = (cons (x) (l0))) ” 
  &&  “ (xs_pre <> 0) ”
  &&  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
.

(*----- Function IntList_rev_aux -----*)

Definition IntList_rev_aux_safety_wit_1 := 
forall (ys_pre: Z) (xs_pre: Z) (b: (@list Z)) (a: (@list Z)) ,
  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys" ) )) # Ptr  |-> ys_pre)
  **  (sll xs_pre a )
  **  (sll ys_pre b )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntList_rev_aux_return_wit_1 := 
(
forall (ys_pre: Z) (b: (@list Z)) (a: (@list Z)) (x: Z) (l0: (@list Z)) (retval: Z) (PreH1 : (b = (cons (x) (l0)))) (PreH2 : (ys_pre <> 0)) ,
  (sll retval (app ((rev (l0))) ((cons (x) (a)))) )
|--
  (sll retval (app ((rev (b))) (a)) )
) \/
(
forall (ys_pre: Z) (b: (@list Z)) (a: (@list Z)) (x: Z) (l0: (@list Z)) (PreH1 : (b = (cons (x) (l0)))) (PreH2 : (ys_pre <> 0)) ,
  TT && emp 
|--
  “ ((app ((rev (l0))) ((cons (x) (a)))) = (app ((rev (b))) (a))) ”
  &&  emp
).

Definition IntList_rev_aux_return_wit_1_split_goal_1 := 
forall (ys_pre: Z) (b: (@list Z)) (a: (@list Z)) (x: Z) (l0: (@list Z)) (PreH1 : (b = (cons (x) (l0)))) (PreH2 : (ys_pre <> 0)) ,
  ((app ((rev (l0))) ((cons (x) (a)))) = (app ((rev (b))) (a)))
.

Definition IntList_rev_aux_return_wit_2 := 
(
forall (ys_pre: Z) (xs_pre: Z) (b: (@list Z)) (a: (@list Z)) (PreH1 : (ys_pre = 0)) ,
  (sll xs_pre a )
  **  (sll ys_pre b )
|--
  (sll xs_pre (app ((rev (b))) (a)) )
) \/
(
forall (ys_pre: Z) (b: (@list Z)) (a: (@list Z)) (PreH1 : (ys_pre = 0)) ,
  (sll ys_pre b )
|--
  “ (a = (app ((rev (b))) (a))) ”
  &&  emp
).

Definition IntList_rev_aux_return_wit_2_split_goal_1 := 
forall (ys_pre: Z) (b: (@list Z)) (a: (@list Z)) (PreH1 : (ys_pre = 0)) ,
  (sll ys_pre b )
|--
  “ (a = (app ((rev (b))) (a))) ”
.

Definition IntList_rev_aux_return_wit_2_split_goal_spatial := 
forall (ys_pre: Z) (b: (@list Z)) (PreH1 : (ys_pre = 0)) ,
  (sll ys_pre b )
|--
  TT && emp 
.

Definition IntList_rev_aux_partial_solve_wit_1 := 
forall (ys_pre: Z) (xs_pre: Z) (b: (@list Z)) (a: (@list Z)) (PreH1 : (ys_pre <> 0)) ,
  (sll xs_pre a )
  **  (sll ys_pre b )
|--
  EX (x: Z)  (l0: (@list Z))  (y: Z) ,
  “ (b = (cons (x) (l0))) ” 
  &&  “ (ys_pre <> 0) ”
  &&  ((&((ys_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll y l0 )
  **  ((&((ys_pre)  # "list" ->ₛ "data")) # Int  |-> x)
  **  (sll xs_pre a )
.

Definition IntList_rev_aux_partial_solve_wit_2 := 
forall (ys_pre: Z) (xs_pre: Z) (b: (@list Z)) (a: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (b = (cons (x) (l0)))) (PreH2 : (ys_pre <> 0)) ,
  ((&((ys_pre)  # "list" ->ₛ "next")) # Ptr  |-> xs_pre)
  **  (sll y l0 )
  **  ((&((ys_pre)  # "list" ->ₛ "data")) # Int  |-> x)
  **  (sll xs_pre a )
|--
  “ (b = (cons (x) (l0))) ” 
  &&  “ (ys_pre <> 0) ”
  &&  (sll ys_pre (cons (x) (a)) )
  **  (sll y l0 )
.

(*----- Function IntList_rev -----*)

Definition IntList_rev_safety_wit_1 := 
forall (xs_pre: Z) (l: (@list Z)) ,
  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
  **  (sll xs_pre l )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntList_rev_return_wit_1 := 
(
forall (l: (@list Z)) (retval: Z) ,
  (sll retval (app ((rev (l))) ((@nil Z))) )
|--
  (sll retval (rev (l)) )
) \/
(
forall (l: (@list Z)) ,
  TT && emp 
|--
  “ ((app ((rev (l))) ((@nil Z))) = (rev (l))) ”
  &&  emp
).

Definition IntList_rev_return_wit_1_split_goal_1 := 
forall (l: (@list Z)) ,
  ((app ((rev (l))) ((@nil Z))) = (rev (l)))
.

Definition IntList_rev_partial_solve_wit_1 := 
forall (xs_pre: Z) (l: (@list Z)) ,
  (sll xs_pre l )
|--
  (sll 0 (@nil Z) )
  **  (sll xs_pre l )
.

(*----- Function IntList_append -----*)

Definition IntList_append_safety_wit_1 := 
forall (ys_pre: Z) (xs_pre: Z) (b: (@list Z)) (a: (@list Z)) ,
  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys" ) )) # Ptr  |-> ys_pre)
  **  (sll xs_pre a )
  **  (sll ys_pre b )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntList_append_return_wit_1 := 
(
forall (xs_pre: Z) (b: (@list Z)) (a: (@list Z)) (x: Z) (l0: (@list Z)) (retval: Z) (PreH1 : (a = (cons (x) (l0)))) (PreH2 : (xs_pre <> 0)) ,
  (sll retval (app (l0) (b)) )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> retval)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
|--
  (sll xs_pre (app (a) (b)) )
) \/
(
forall (xs_pre: Z) (b: (@list Z)) (a: (@list Z)) (x: Z) (l0: (@list Z)) (PreH1 : (a = (cons (x) (l0)))) (PreH2 : (xs_pre <> 0)) ,
  TT && emp 
|--
  “ ((app (a) (b)) = (cons (x) ((app (l0) (b))))) ”
  &&  emp
).

Definition IntList_append_return_wit_1_split_goal_1 := 
forall (xs_pre: Z) (b: (@list Z)) (a: (@list Z)) (x: Z) (l0: (@list Z)) (PreH1 : (a = (cons (x) (l0)))) (PreH2 : (xs_pre <> 0)) ,
  ((app (a) (b)) = (cons (x) ((app (l0) (b)))))
.

Definition IntList_append_return_wit_2 := 
(
forall (ys_pre: Z) (xs_pre: Z) (b: (@list Z)) (a: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre a )
  **  (sll ys_pre b )
|--
  (sll ys_pre (app (a) (b)) )
) \/
(
forall (xs_pre: Z) (b: (@list Z)) (a: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre a )
|--
  “ (b = (app (a) (b))) ”
  &&  emp
).

Definition IntList_append_return_wit_2_split_goal_1 := 
forall (xs_pre: Z) (b: (@list Z)) (a: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre a )
|--
  “ (b = (app (a) (b))) ”
.

Definition IntList_append_return_wit_2_split_goal_spatial := 
forall (xs_pre: Z) (a: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre a )
|--
  TT && emp 
.

Definition IntList_append_partial_solve_wit_1 := 
forall (ys_pre: Z) (xs_pre: Z) (b: (@list Z)) (a: (@list Z)) (PreH1 : (xs_pre <> 0)) ,
  (sll xs_pre a )
  **  (sll ys_pre b )
|--
  EX (x: Z)  (l0: (@list Z))  (y: Z) ,
  “ (a = (cons (x) (l0))) ” 
  &&  “ (xs_pre <> 0) ”
  &&  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
  **  (sll ys_pre b )
.

Definition IntList_append_partial_solve_wit_2 := 
forall (ys_pre: Z) (xs_pre: Z) (b: (@list Z)) (a: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (a = (cons (x) (l0)))) (PreH2 : (xs_pre <> 0)) ,
  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
  **  (sll ys_pre b )
|--
  “ (a = (cons (x) (l0))) ” 
  &&  “ (xs_pre <> 0) ”
  &&  (sll y l0 )
  **  (sll ys_pre b )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
.

(*----- Function IntList_append2 -----*)

Definition IntList_append2_safety_wit_1 := 
forall (ys_pre: Z) (xs_pre: Z) (b: (@list Z)) (a: (@list Z)) ,
  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys" ) )) # Ptr  |-> ys_pre)
  **  (sll xs_pre a )
  **  (sll ys_pre b )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntList_append2_return_wit_1 := 
(
forall (ys_pre: Z) (xs_pre: Z) (b: (@list Z)) (a: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (retval: Z) (PreH1 : (a = (cons (x) (l0)))) (PreH2 : (xs_pre <> 0)) ,
  (sll retval (cons (x) ((app (l0) (b)))) )
  **  (sll y l0 )
  **  (sll ys_pre b )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
|--
  (sll xs_pre a )
  **  (sll ys_pre b )
  **  (sll retval (app (a) (b)) )
) \/
(
forall (xs_pre: Z) (b: (@list Z)) (a: (@list Z)) (x: Z) (l0: (@list Z)) (PreH1 : (a = (cons (x) (l0)))) (PreH2 : (xs_pre <> 0)) ,
  TT && emp 
|--
  “ ((cons (x) ((app (l0) (b)))) = (app (a) (b))) ”
  &&  emp
).

Definition IntList_append2_return_wit_1_split_goal_1 := 
forall (xs_pre: Z) (b: (@list Z)) (a: (@list Z)) (x: Z) (l0: (@list Z)) (PreH1 : (a = (cons (x) (l0)))) (PreH2 : (xs_pre <> 0)) ,
  ((cons (x) ((app (l0) (b)))) = (app (a) (b)))
.

Definition IntList_append2_return_wit_2 := 
(
forall (ys_pre: Z) (xs_pre: Z) (b: (@list Z)) (a: (@list Z)) (retval: Z) (PreH1 : (xs_pre = 0)) ,
  (sll ys_pre b )
  **  (sll retval b )
  **  (sll xs_pre a )
|--
  (sll xs_pre a )
  **  (sll ys_pre b )
  **  (sll retval (app (a) (b)) )
) \/
(
forall (xs_pre: Z) (b: (@list Z)) (a: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre a )
|--
  “ (a = (@nil Z)) ” 
  &&  “ (b = (app (a) (b))) ”
  &&  emp
).

Definition IntList_append2_return_wit_2_split_goal_1 := 
forall (xs_pre: Z) (a: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre a )
|--
  “ (a = (@nil Z)) ”
.

Definition IntList_append2_return_wit_2_split_goal_2 := 
forall (xs_pre: Z) (b: (@list Z)) (a: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre a )
|--
  “ (b = (app (a) (b))) ”
.

Definition IntList_append2_return_wit_2_split_goal_spatial := 
forall (xs_pre: Z) (a: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre a )
|--
  TT && emp 
.

Definition IntList_append2_partial_solve_wit_1 := 
forall (ys_pre: Z) (xs_pre: Z) (b: (@list Z)) (a: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre a )
  **  (sll ys_pre b )
|--
  “ (xs_pre = 0) ”
  &&  (sll ys_pre b )
  **  (sll xs_pre a )
.

Definition IntList_append2_partial_solve_wit_2 := 
forall (ys_pre: Z) (xs_pre: Z) (b: (@list Z)) (a: (@list Z)) (PreH1 : (xs_pre <> 0)) ,
  (sll xs_pre a )
  **  (sll ys_pre b )
|--
  EX (x: Z)  (l0: (@list Z))  (y: Z) ,
  “ (a = (cons (x) (l0))) ” 
  &&  “ (xs_pre <> 0) ”
  &&  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
  **  (sll ys_pre b )
.

Definition IntList_append2_partial_solve_wit_3 := 
forall (ys_pre: Z) (xs_pre: Z) (b: (@list Z)) (a: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (a = (cons (x) (l0)))) (PreH2 : (xs_pre <> 0)) ,
  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
  **  (sll ys_pre b )
|--
  “ (a = (cons (x) (l0))) ” 
  &&  “ (xs_pre <> 0) ”
  &&  (sll y l0 )
  **  (sll ys_pre b )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
.

Definition IntList_append2_partial_solve_wit_4_pure := 
forall (ys_pre: Z) (xs_pre: Z) (b: (@list Z)) (a: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (retval: Z) (PreH1 : (a = (cons (x) (l0)))) (PreH2 : (xs_pre <> 0)) ,
  (sll y l0 )
  **  (sll ys_pre b )
  **  (sll retval (app (l0) (b)) )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
  **  ((( &( "new_tail" ) )) # Ptr  |-> retval)
  **  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys" ) )) # Ptr  |-> ys_pre)
|--
  “ (x = x) ”
.

Definition IntList_append2_partial_solve_wit_4_aux := 
forall (ys_pre: Z) (xs_pre: Z) (b: (@list Z)) (a: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (retval: Z) (PreH1 : (a = (cons (x) (l0)))) (PreH2 : (xs_pre <> 0)) ,
  (sll y l0 )
  **  (sll ys_pre b )
  **  (sll retval (app (l0) (b)) )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
|--
  “ (x = x) ” 
  &&  “ (a = (cons (x) (l0))) ” 
  &&  “ (xs_pre <> 0) ”
  &&  (sll retval (app (l0) (b)) )
  **  (sll y l0 )
  **  (sll ys_pre b )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
.

Definition IntList_append2_partial_solve_wit_4 := IntList_append2_partial_solve_wit_4_pure -> IntList_append2_partial_solve_wit_4_aux.

Module Type VC_Correct.

Axiom proof_of_IntList_nil_safety_wit_1 : IntList_nil_safety_wit_1.
Axiom proof_of_IntList_nil_return_wit_1 : IntList_nil_return_wit_1.
Axiom proof_of_IntList_cons_return_wit_1 : IntList_cons_return_wit_1.
Axiom proof_of_IntList_cons_partial_solve_wit_1 : IntList_cons_partial_solve_wit_1.
Axiom proof_of_IntList_copy_safety_wit_1 : IntList_copy_safety_wit_1.
Axiom proof_of_IntList_copy_return_wit_1 : IntList_copy_return_wit_1.
Axiom proof_of_IntList_copy_return_wit_2 : IntList_copy_return_wit_2.
Axiom proof_of_IntList_copy_partial_solve_wit_1 : IntList_copy_partial_solve_wit_1.
Axiom proof_of_IntList_copy_partial_solve_wit_2 : IntList_copy_partial_solve_wit_2.
Axiom proof_of_IntList_copy_partial_solve_wit_3 : IntList_copy_partial_solve_wit_3.
Axiom proof_of_IntList_copy_partial_solve_wit_4_pure : IntList_copy_partial_solve_wit_4_pure.
Axiom proof_of_IntList_copy_partial_solve_wit_4 : IntList_copy_partial_solve_wit_4.
Axiom proof_of_IntList_free_list_safety_wit_1 : IntList_free_list_safety_wit_1.
Axiom proof_of_IntList_free_list_return_wit_1 : IntList_free_list_return_wit_1.
Axiom proof_of_IntList_free_list_return_wit_2 : IntList_free_list_return_wit_2.
Axiom proof_of_IntList_free_list_partial_solve_wit_1 : IntList_free_list_partial_solve_wit_1.
Axiom proof_of_IntList_free_list_partial_solve_wit_2 : IntList_free_list_partial_solve_wit_2.
Axiom proof_of_IntList_free_list_partial_solve_wit_3 : IntList_free_list_partial_solve_wit_3.
Axiom proof_of_IntList_length_safety_wit_1 : IntList_length_safety_wit_1.
Axiom proof_of_IntList_length_safety_wit_2 : IntList_length_safety_wit_2.
Axiom proof_of_IntList_length_safety_wit_3 : IntList_length_safety_wit_3.
Axiom proof_of_IntList_length_return_wit_1 : IntList_length_return_wit_1.
Axiom proof_of_IntList_length_return_wit_2 : IntList_length_return_wit_2.
Axiom proof_of_IntList_length_partial_solve_wit_1 : IntList_length_partial_solve_wit_1.
Axiom proof_of_IntList_length_partial_solve_wit_2 : IntList_length_partial_solve_wit_2.
Axiom proof_of_IntList_rev_aux_safety_wit_1 : IntList_rev_aux_safety_wit_1.
Axiom proof_of_IntList_rev_aux_return_wit_1 : IntList_rev_aux_return_wit_1.
Axiom proof_of_IntList_rev_aux_return_wit_2 : IntList_rev_aux_return_wit_2.
Axiom proof_of_IntList_rev_aux_partial_solve_wit_1 : IntList_rev_aux_partial_solve_wit_1.
Axiom proof_of_IntList_rev_aux_partial_solve_wit_2 : IntList_rev_aux_partial_solve_wit_2.
Axiom proof_of_IntList_rev_safety_wit_1 : IntList_rev_safety_wit_1.
Axiom proof_of_IntList_rev_return_wit_1 : IntList_rev_return_wit_1.
Axiom proof_of_IntList_rev_partial_solve_wit_1 : IntList_rev_partial_solve_wit_1.
Axiom proof_of_IntList_append_safety_wit_1 : IntList_append_safety_wit_1.
Axiom proof_of_IntList_append_return_wit_1 : IntList_append_return_wit_1.
Axiom proof_of_IntList_append_return_wit_2 : IntList_append_return_wit_2.
Axiom proof_of_IntList_append_partial_solve_wit_1 : IntList_append_partial_solve_wit_1.
Axiom proof_of_IntList_append_partial_solve_wit_2 : IntList_append_partial_solve_wit_2.
Axiom proof_of_IntList_append2_safety_wit_1 : IntList_append2_safety_wit_1.
Axiom proof_of_IntList_append2_return_wit_1 : IntList_append2_return_wit_1.
Axiom proof_of_IntList_append2_return_wit_2 : IntList_append2_return_wit_2.
Axiom proof_of_IntList_append2_partial_solve_wit_1 : IntList_append2_partial_solve_wit_1.
Axiom proof_of_IntList_append2_partial_solve_wit_2 : IntList_append2_partial_solve_wit_2.
Axiom proof_of_IntList_append2_partial_solve_wit_3 : IntList_append2_partial_solve_wit_3.
Axiom proof_of_IntList_append2_partial_solve_wit_4_pure : IntList_append2_partial_solve_wit_4_pure.
Axiom proof_of_IntList_append2_partial_solve_wit_4 : IntList_append2_partial_solve_wit_4.

End VC_Correct.
