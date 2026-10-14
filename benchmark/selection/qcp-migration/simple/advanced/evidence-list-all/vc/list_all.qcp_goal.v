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
Require Import list_all.qcp_def.
Import naive_C_Rules.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Require Import FulminateMerge.
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

(*----- Function IntList_rev_loop -----*)

Definition IntList_rev_loop_safety_wit_1 := 
forall (xs_pre: Z) (l: (@list Z)) ,
  ((( &( "last" ) )) # Ptr  |->_)
  **  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
  **  (sll xs_pre l )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntList_rev_loop_safety_wit_2 := 
forall (xs_pre: Z) (l: (@list Z)) (cur: Z) (last: Z) (l2: (@list Z)) (l1: (@list Z)) (PreH1 : ((app ((rev (l2))) (l1)) = (rev (l)))) ,
  ((( &( "last" ) )) # Ptr  |-> last)
  **  (sll last l1 )
  **  ((( &( "cur" ) )) # Ptr  |-> cur)
  **  (sll cur l2 )
  **  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition IntList_rev_loop_safety_wit_3 := 
forall (xs_pre: Z) (l: (@list Z)) (cur: Z) (last: Z) (l2: (@list Z)) (l1: (@list Z)) (PreH1 : ((app ((rev (l2))) (l1)) = (rev (l)))) ,
  ((( &( "last" ) )) # Ptr  |-> last)
  **  (sll last l1 )
  **  ((( &( "cur" ) )) # Ptr  |-> cur)
  **  (sll cur l2 )
  **  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntList_rev_loop_entail_wit_1 := 
(
forall (xs_pre: Z) (l: (@list Z)) ,
  (sll xs_pre l )
|--
  EX (l2: (@list Z))  (l1: (@list Z)) ,
  “ ((app ((rev (l2))) (l1)) = (rev (l))) ”
  &&  (sll 0 l1 )
  **  (sll xs_pre l2 )
) \/
(
forall (l: (@list Z)) ,
  TT && emp 
|--
  “ ((app ((rev (l))) ((@nil Z))) = (rev (l))) ”
  &&  emp
).

Definition IntList_rev_loop_entail_wit_1_split_goal_1 := 
forall (l: (@list Z)) ,
  ((app ((rev (l))) ((@nil Z))) = (rev (l)))
.

Definition IntList_rev_loop_entail_wit_2 := 
(
forall (l: (@list Z)) (cur: Z) (last: Z) (l2_2: (@list Z)) (l1_2: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (l2_2 = (cons (x) (l0)))) (PreH2 : (cur <> 0)) (PreH3 : ((app ((rev (l2_2))) (l1_2)) = (rev (l)))) ,
  ((&((cur)  # "list" ->ₛ "next")) # Ptr  |-> last)
  **  (sll y l0 )
  **  ((&((cur)  # "list" ->ₛ "data")) # Int  |-> x)
  **  (sll last l1_2 )
|--
  EX (l2: (@list Z))  (l1: (@list Z)) ,
  “ ((app ((rev (l2))) (l1)) = (rev (l))) ”
  &&  (sll cur l1 )
  **  (sll y l2 )
) \/
(
forall (l: (@list Z)) (cur: Z) (l2_2: (@list Z)) (l1_2: (@list Z)) (x: Z) (l0: (@list Z)) (PreH1 : (l2_2 = (cons (x) (l0)))) (PreH2 : (cur <> 0)) (PreH3 : ((app ((rev (l2_2))) (l1_2)) = (rev (l)))) ,
  TT && emp 
|--
  “ ((app ((rev (l0))) ((cons (x) (l1_2)))) = (rev (l))) ”
  &&  emp
).

Definition IntList_rev_loop_entail_wit_2_split_goal_1 := 
forall (l: (@list Z)) (cur: Z) (l2_2: (@list Z)) (l1_2: (@list Z)) (x: Z) (l0: (@list Z)) (PreH1 : (l2_2 = (cons (x) (l0)))) (PreH2 : (cur <> 0)) (PreH3 : ((app ((rev (l2_2))) (l1_2)) = (rev (l)))) ,
  ((app ((rev (l0))) ((cons (x) (l1_2)))) = (rev (l)))
.

Definition IntList_rev_loop_return_wit_1 := 
(
forall (l: (@list Z)) (cur: Z) (last: Z) (l2: (@list Z)) (l1: (@list Z)) (PreH1 : (cur = 0)) (PreH2 : ((app ((rev (l2))) (l1)) = (rev (l)))) ,
  (sll last l1 )
  **  (sll cur l2 )
|--
  (sll last (rev (l)) )
) \/
(
forall (l: (@list Z)) (cur: Z) (l2: (@list Z)) (l1: (@list Z)) (PreH1 : (cur = 0)) (PreH2 : ((app ((rev (l2))) (l1)) = (rev (l)))) ,
  (sll cur l2 )
|--
  “ (l1 = (rev (l))) ”
  &&  emp
).

Definition IntList_rev_loop_return_wit_1_split_goal_1 := 
forall (l: (@list Z)) (cur: Z) (l2: (@list Z)) (l1: (@list Z)) (PreH1 : (cur = 0)) (PreH2 : ((app ((rev (l2))) (l1)) = (rev (l)))) ,
  (sll cur l2 )
|--
  “ (l1 = (rev (l))) ”
.

Definition IntList_rev_loop_return_wit_1_split_goal_spatial := 
forall (l: (@list Z)) (cur: Z) (l2: (@list Z)) (l1: (@list Z)) (PreH1 : (cur = 0)) (PreH2 : ((app ((rev (l2))) (l1)) = (rev (l)))) ,
  (sll cur l2 )
|--
  TT && emp 
.

Definition IntList_rev_loop_partial_solve_wit_1 := 
forall (l: (@list Z)) (cur: Z) (last: Z) (l2: (@list Z)) (l1: (@list Z)) (PreH1 : (cur <> 0)) (PreH2 : ((app ((rev (l2))) (l1)) = (rev (l)))) ,
  (sll last l1 )
  **  (sll cur l2 )
|--
  EX (x: Z)  (l0: (@list Z))  (y: Z) ,
  “ (l2 = (cons (x) (l0))) ” 
  &&  “ (cur <> 0) ” 
  &&  “ ((app ((rev (l2))) (l1)) = (rev (l))) ”
  &&  ((&((cur)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll y l0 )
  **  ((&((cur)  # "list" ->ₛ "data")) # Int  |-> x)
  **  (sll last l1 )
.

(*----- Function IntList_split -----*)

Definition IntList_split_safety_wit_1 := 
forall (xs_pre: Z) (l: (@list Z)) ,
  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
  **  (sll xs_pre l )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntList_split_safety_wit_2 := 
forall (xs_pre: Z) (l: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
  **  (sll xs_pre l )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntList_split_safety_wit_3 := 
forall (xs_pre: Z) (l: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
  **  (sll xs_pre l )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntList_split_safety_wit_4 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (l = (cons (x) (l0)))) (PreH2 : (xs_pre <> 0)) ,
  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
  **  ((( &( "cdr" ) )) # Ptr  |-> y)
  **  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntList_split_safety_wit_5 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (y = 0)) (PreH2 : (l = (cons (x) (l0)))) (PreH3 : (xs_pre <> 0)) ,
  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
  **  ((( &( "cdr" ) )) # Ptr  |-> y)
  **  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntList_split_return_wit_1 := 
(
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (x_2: Z) (l0_2: (@list Z)) (retval_snd_2: Z) (retval_fst_2: Z) (record_return: Z) (PreH1 : (l0 = (cons (x_2) (l0_2)))) (PreH2 : (y <> 0)) (PreH3 : (l = (cons (x) (l0)))) (PreH4 : (xs_pre <> 0)) ,
  ((&((record_return)  # "int_list_pair" ->ₛ "snd")) # Ptr  |-> y)
  **  ((&((record_return)  # "int_list_pair" ->ₛ "fst")) # Ptr  |-> xs_pre)
  **  (sll retval_fst_2 (cn_split_fst (l0_2)) )
  **  (sll retval_snd_2 (cn_split_snd (l0_2)) )
  **  ((&((y)  # "list" ->ₛ "next")) # Ptr  |-> retval_snd_2)
  **  ((&((y)  # "list" ->ₛ "data")) # Int  |-> x_2)
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> retval_fst_2)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
|--
  EX (retval_snd: Z)  (retval_fst: Z) ,
  ((&((record_return)  # "int_list_pair" ->ₛ "fst")) # Ptr  |-> retval_fst)
  **  (sll retval_fst (cn_split_fst (l)) )
  **  ((&((record_return)  # "int_list_pair" ->ₛ "snd")) # Ptr  |-> retval_snd)
  **  (sll retval_snd (cn_split_snd (l)) )
) \/
(
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (x_2: Z) (l0_2: (@list Z)) (PreH1 : (l0 = (cons (x_2) (l0_2)))) (PreH2 : (y <> 0)) (PreH3 : (l = (cons (x) (l0)))) (PreH4 : (xs_pre <> 0)) ,
  TT && emp 
|--
  “ ((cn_split_snd (l)) = (cons (x_2) ((cn_split_snd (l0_2))))) ” 
  &&  “ ((cn_split_fst (l)) = (cons (x) ((cn_split_fst (l0_2))))) ”
  &&  emp
).

Definition IntList_split_return_wit_1_split_goal_1 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (x_2: Z) (l0_2: (@list Z)) (PreH1 : (l0 = (cons (x_2) (l0_2)))) (PreH2 : (y <> 0)) (PreH3 : (l = (cons (x) (l0)))) (PreH4 : (xs_pre <> 0)) ,
  ((cn_split_snd (l)) = (cons (x_2) ((cn_split_snd (l0_2)))))
.

Definition IntList_split_return_wit_1_split_goal_2 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (x_2: Z) (l0_2: (@list Z)) (PreH1 : (l0 = (cons (x_2) (l0_2)))) (PreH2 : (y <> 0)) (PreH3 : (l = (cons (x) (l0)))) (PreH4 : (xs_pre <> 0)) ,
  ((cn_split_fst (l)) = (cons (x) ((cn_split_fst (l0_2)))))
.

Definition IntList_split_return_wit_2 := 
(
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (record_return: Z) (PreH1 : (y = 0)) (PreH2 : (l = (cons (x) (l0)))) (PreH3 : (xs_pre <> 0)) ,
  ((&((record_return)  # "int_list_pair" ->ₛ "snd")) # Ptr  |-> xs_pre)
  **  ((&((record_return)  # "int_list_pair" ->ₛ "fst")) # Ptr  |-> 0)
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
|--
  EX (retval_snd: Z)  (retval_fst: Z) ,
  ((&((record_return)  # "int_list_pair" ->ₛ "fst")) # Ptr  |-> retval_fst)
  **  (sll retval_fst (cn_split_fst (l)) )
  **  ((&((record_return)  # "int_list_pair" ->ₛ "snd")) # Ptr  |-> retval_snd)
  **  (sll retval_snd (cn_split_snd (l)) )
) \/
(
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (y = 0)) (PreH2 : (l = (cons (x) (l0)))) (PreH3 : (xs_pre <> 0)) ,
  (sll y l0 )
|--
  “ ((cn_split_fst (l)) = (@nil Z)) ” 
  &&  “ ((cn_split_snd (l)) = (cons (x) ((@nil Z)))) ”
  &&  emp
).

Definition IntList_split_return_wit_2_split_goal_1 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (y = 0)) (PreH2 : (l = (cons (x) (l0)))) (PreH3 : (xs_pre <> 0)) ,
  (sll y l0 )
|--
  “ ((cn_split_fst (l)) = (@nil Z)) ”
.

Definition IntList_split_return_wit_2_split_goal_2 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (y = 0)) (PreH2 : (l = (cons (x) (l0)))) (PreH3 : (xs_pre <> 0)) ,
  (sll y l0 )
|--
  “ ((cn_split_snd (l)) = (cons (x) ((@nil Z)))) ”
.

Definition IntList_split_return_wit_2_split_goal_spatial := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (y = 0)) (PreH2 : (l = (cons (x) (l0)))) (PreH3 : (xs_pre <> 0)) ,
  (sll y l0 )
|--
  TT && emp 
.

Definition IntList_split_return_wit_3 := 
(
forall (xs_pre: Z) (l: (@list Z)) (record_return: Z) (PreH1 : (xs_pre = 0)) ,
  ((&((record_return)  # "int_list_pair" ->ₛ "snd")) # Ptr  |-> 0)
  **  ((&((record_return)  # "int_list_pair" ->ₛ "fst")) # Ptr  |-> 0)
  **  (sll xs_pre l )
|--
  EX (retval_snd: Z)  (retval_fst: Z) ,
  ((&((record_return)  # "int_list_pair" ->ₛ "fst")) # Ptr  |-> retval_fst)
  **  (sll retval_fst (cn_split_fst (l)) )
  **  ((&((record_return)  # "int_list_pair" ->ₛ "snd")) # Ptr  |-> retval_snd)
  **  (sll retval_snd (cn_split_snd (l)) )
) \/
(
forall (xs_pre: Z) (l: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre l )
|--
  “ ((cn_split_fst (l)) = (@nil Z)) ” 
  &&  “ ((cn_split_snd (l)) = (@nil Z)) ”
  &&  emp
).

Definition IntList_split_return_wit_3_split_goal_1 := 
forall (xs_pre: Z) (l: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre l )
|--
  “ ((cn_split_fst (l)) = (@nil Z)) ”
.

Definition IntList_split_return_wit_3_split_goal_2 := 
forall (xs_pre: Z) (l: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre l )
|--
  “ ((cn_split_snd (l)) = (@nil Z)) ”
.

Definition IntList_split_return_wit_3_split_goal_spatial := 
forall (xs_pre: Z) (l: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre l )
|--
  TT && emp 
.

Definition IntList_split_partial_solve_wit_1 := 
forall (xs_pre: Z) (l: (@list Z)) (record_return: Z) (PreH1 : (xs_pre = 0)) ,
  (UndefStructPredint_list_pair record_return )
  **  (StructPredint_list_pair ( &( "r" ) ) (make_record_int_list_pair (0) (0)) )
  **  (sll xs_pre l )
|--
  “ (xs_pre = 0) ”
  &&  ((&((record_return)  # "int_list_pair" ->ₛ "snd")) # Ptr  |->_)
  **  ((&((( &( "r" ) ))  # "int_list_pair" ->ₛ "snd")) # Ptr  |-> 0)
  **  ((&((record_return)  # "int_list_pair" ->ₛ "fst")) # Ptr  |->_)
  **  ((&((( &( "r" ) ))  # "int_list_pair" ->ₛ "fst")) # Ptr  |-> 0)
  **  (sll xs_pre l )
.

Definition IntList_split_partial_solve_wit_2 := 
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

Definition IntList_split_partial_solve_wit_3 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (record_return: Z) (PreH1 : (y = 0)) (PreH2 : (l = (cons (x) (l0)))) (PreH3 : (xs_pre <> 0)) ,
  (UndefStructPredint_list_pair record_return )
  **  (StructPredint_list_pair ( &( "r" ) ) (make_record_int_list_pair (0) (xs_pre)) )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
|--
  “ (y = 0) ” 
  &&  “ (l = (cons (x) (l0))) ” 
  &&  “ (xs_pre <> 0) ”
  &&  ((&((record_return)  # "int_list_pair" ->ₛ "snd")) # Ptr  |->_)
  **  ((&((( &( "r" ) ))  # "int_list_pair" ->ₛ "snd")) # Ptr  |-> xs_pre)
  **  ((&((record_return)  # "int_list_pair" ->ₛ "fst")) # Ptr  |->_)
  **  ((&((( &( "r" ) ))  # "int_list_pair" ->ₛ "fst")) # Ptr  |-> 0)
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
.

Definition IntList_split_partial_solve_wit_4 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (y <> 0)) (PreH2 : (l = (cons (x) (l0)))) (PreH3 : (xs_pre <> 0)) ,
  (UndefStructPredint_list_pair ( &( "p" ) ) )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
|--
  EX (x_2: Z)  (l0_2: (@list Z))  (y_2: Z) ,
  “ (l0 = (cons (x_2) (l0_2))) ” 
  &&  “ (y <> 0) ” 
  &&  “ (l = (cons (x) (l0))) ” 
  &&  “ (xs_pre <> 0) ”
  &&  ((&((y)  # "list" ->ₛ "next")) # Ptr  |-> y_2)
  **  (sll y_2 l0_2 )
  **  ((&((y)  # "list" ->ₛ "data")) # Int  |-> x_2)
  **  (UndefStructPredint_list_pair ( &( "p" ) ) )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
.

Definition IntList_split_partial_solve_wit_5 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (x_2: Z) (l0_2: (@list Z)) (y_2: Z) (PreH1 : (l0 = (cons (x_2) (l0_2)))) (PreH2 : (y <> 0)) (PreH3 : (l = (cons (x) (l0)))) (PreH4 : (xs_pre <> 0)) ,
  ((&((y)  # "list" ->ₛ "next")) # Ptr  |-> y_2)
  **  (sll y_2 l0_2 )
  **  ((&((y)  # "list" ->ₛ "data")) # Int  |-> x_2)
  **  (UndefStructPredint_list_pair ( &( "p" ) ) )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
|--
  “ (l0 = (cons (x_2) (l0_2))) ” 
  &&  “ (y <> 0) ” 
  &&  “ (l = (cons (x) (l0))) ” 
  &&  “ (xs_pre <> 0) ”
  &&  (sll y_2 l0_2 )
  **  ((&((y)  # "list" ->ₛ "next")) # Ptr  |-> y_2)
  **  ((&((y)  # "list" ->ₛ "data")) # Int  |-> x_2)
  **  (UndefStructPredint_list_pair ( &( "p" ) ) )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
.

Definition IntList_split_partial_solve_wit_6 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (x_2: Z) (l0_2: (@list Z)) (y_2: Z) (retval_snd: Z) (retval_fst: Z) (retval: Z) (PreH1 : (l0 = (cons (x_2) (l0_2)))) (PreH2 : (y <> 0)) (PreH3 : (l = (cons (x) (l0)))) (PreH4 : (xs_pre <> 0)) ,
  ((&((retval)  # "int_list_pair" ->ₛ "fst")) # Ptr  |-> retval_fst)
  **  (sll retval_fst (cn_split_fst (l0_2)) )
  **  ((&((retval)  # "int_list_pair" ->ₛ "snd")) # Ptr  |-> retval_snd)
  **  (sll retval_snd (cn_split_snd (l0_2)) )
  **  ((&((y)  # "list" ->ₛ "next")) # Ptr  |-> y_2)
  **  ((&((y)  # "list" ->ₛ "data")) # Int  |-> x_2)
  **  (UndefStructPredint_list_pair ( &( "p" ) ) )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
|--
  “ (l0 = (cons (x_2) (l0_2))) ” 
  &&  “ (y <> 0) ” 
  &&  “ (l = (cons (x) (l0))) ” 
  &&  “ (xs_pre <> 0) ”
  &&  ((&((( &( "p" ) ))  # "int_list_pair" ->ₛ "snd")) # Ptr  |->_)
  **  ((&((retval)  # "int_list_pair" ->ₛ "snd")) # Ptr  |-> retval_snd)
  **  ((&((( &( "p" ) ))  # "int_list_pair" ->ₛ "fst")) # Ptr  |->_)
  **  ((&((retval)  # "int_list_pair" ->ₛ "fst")) # Ptr  |-> retval_fst)
  **  (sll retval_fst (cn_split_fst (l0_2)) )
  **  (sll retval_snd (cn_split_snd (l0_2)) )
  **  ((&((y)  # "list" ->ₛ "next")) # Ptr  |-> y_2)
  **  ((&((y)  # "list" ->ₛ "data")) # Int  |-> x_2)
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
.

Definition IntList_split_partial_solve_wit_7 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (x_2: Z) (l0_2: (@list Z)) (retval_snd: Z) (retval_fst: Z) (record_return: Z) (PreH1 : (l0 = (cons (x_2) (l0_2)))) (PreH2 : (y <> 0)) (PreH3 : (l = (cons (x) (l0)))) (PreH4 : (xs_pre <> 0)) ,
  (UndefStructPredint_list_pair record_return )
  **  (StructPredint_list_pair ( &( "r" ) ) (make_record_int_list_pair (xs_pre) (y)) )
  **  ((&((( &( "p" ) ))  # "int_list_pair" ->ₛ "snd")) # Ptr  |-> retval_snd)
  **  ((&((( &( "p" ) ))  # "int_list_pair" ->ₛ "fst")) # Ptr  |-> retval_fst)
  **  (sll retval_fst (cn_split_fst (l0_2)) )
  **  (sll retval_snd (cn_split_snd (l0_2)) )
  **  ((&((y)  # "list" ->ₛ "next")) # Ptr  |-> retval_snd)
  **  ((&((y)  # "list" ->ₛ "data")) # Int  |-> x_2)
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> retval_fst)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
|--
  “ (l0 = (cons (x_2) (l0_2))) ” 
  &&  “ (y <> 0) ” 
  &&  “ (l = (cons (x) (l0))) ” 
  &&  “ (xs_pre <> 0) ”
  &&  ((&((record_return)  # "int_list_pair" ->ₛ "snd")) # Ptr  |->_)
  **  ((&((( &( "r" ) ))  # "int_list_pair" ->ₛ "snd")) # Ptr  |-> y)
  **  ((&((record_return)  # "int_list_pair" ->ₛ "fst")) # Ptr  |->_)
  **  ((&((( &( "r" ) ))  # "int_list_pair" ->ₛ "fst")) # Ptr  |-> xs_pre)
  **  ((&((( &( "p" ) ))  # "int_list_pair" ->ₛ "snd")) # Ptr  |-> retval_snd)
  **  ((&((( &( "p" ) ))  # "int_list_pair" ->ₛ "fst")) # Ptr  |-> retval_fst)
  **  (sll retval_fst (cn_split_fst (l0_2)) )
  **  (sll retval_snd (cn_split_snd (l0_2)) )
  **  ((&((y)  # "list" ->ₛ "next")) # Ptr  |-> retval_snd)
  **  ((&((y)  # "list" ->ₛ "data")) # Int  |-> x_2)
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> retval_fst)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
.

(*----- Function IntList_merge -----*)

Definition IntList_merge_safety_wit_1 := 
forall (ys_pre: Z) (xs_pre: Z) (r: (@list Z)) (l: (@list Z)) ,
  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys" ) )) # Ptr  |-> ys_pre)
  **  (sll xs_pre l )
  **  (sll ys_pre r )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntList_merge_safety_wit_2 := 
forall (ys_pre: Z) (xs_pre: Z) (r: (@list Z)) (l: (@list Z)) (PreH1 : (xs_pre <> 0)) ,
  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys" ) )) # Ptr  |-> ys_pre)
  **  (sll xs_pre l )
  **  (sll ys_pre r )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntList_merge_return_wit_1 := 
(
forall (ys_pre: Z) (xs_pre: Z) (r: (@list Z)) (l: (@list Z)) (x: Z) (l0: (@list Z)) (x_2: Z) (l0_2: (@list Z)) (retval: Z) (PreH1 : (x >= x_2)) (PreH2 : (r = (cons (x_2) (l0_2)))) (PreH3 : (l = (cons (x) (l0)))) (PreH4 : (ys_pre <> 0)) (PreH5 : (xs_pre <> 0)) ,
  (sll retval (cn_merge ((cons (x) (l0))) (l0_2)) )
  **  ((&((ys_pre)  # "list" ->ₛ "data")) # Int  |-> x_2)
  **  ((&((ys_pre)  # "list" ->ₛ "next")) # Ptr  |-> retval)
|--
  (sll ys_pre (cn_merge (l) (r)) )
) \/
(
forall (ys_pre: Z) (xs_pre: Z) (r: (@list Z)) (l: (@list Z)) (x: Z) (l0: (@list Z)) (x_2: Z) (l0_2: (@list Z)) (PreH1 : (x >= x_2)) (PreH2 : (r = (cons (x_2) (l0_2)))) (PreH3 : (l = (cons (x) (l0)))) (PreH4 : (ys_pre <> 0)) (PreH5 : (xs_pre <> 0)) ,
  TT && emp 
|--
  “ ((cn_merge (l) (r)) = (cons (x_2) ((cn_merge (l) (l0_2))))) ”
  &&  emp
).

Definition IntList_merge_return_wit_1_split_goal_1 := 
forall (ys_pre: Z) (xs_pre: Z) (r: (@list Z)) (l: (@list Z)) (x: Z) (l0: (@list Z)) (x_2: Z) (l0_2: (@list Z)) (PreH1 : (x >= x_2)) (PreH2 : (r = (cons (x_2) (l0_2)))) (PreH3 : (l = (cons (x) (l0)))) (PreH4 : (ys_pre <> 0)) (PreH5 : (xs_pre <> 0)) ,
  ((cn_merge (l) (r)) = (cons (x_2) ((cn_merge (l) (l0_2)))))
.

Definition IntList_merge_return_wit_2 := 
(
forall (ys_pre: Z) (xs_pre: Z) (r: (@list Z)) (l: (@list Z)) (x: Z) (l0: (@list Z)) (x_2: Z) (l0_2: (@list Z)) (retval: Z) (PreH1 : (x < x_2)) (PreH2 : (r = (cons (x_2) (l0_2)))) (PreH3 : (l = (cons (x) (l0)))) (PreH4 : (ys_pre <> 0)) (PreH5 : (xs_pre <> 0)) ,
  (sll retval (cn_merge (l0) ((cons (x_2) (l0_2)))) )
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> retval)
|--
  (sll xs_pre (cn_merge (l) (r)) )
) \/
(
forall (ys_pre: Z) (xs_pre: Z) (r: (@list Z)) (l: (@list Z)) (x: Z) (l0: (@list Z)) (x_2: Z) (l0_2: (@list Z)) (PreH1 : (x < x_2)) (PreH2 : (r = (cons (x_2) (l0_2)))) (PreH3 : (l = (cons (x) (l0)))) (PreH4 : (ys_pre <> 0)) (PreH5 : (xs_pre <> 0)) ,
  TT && emp 
|--
  “ ((cn_merge (l) (r)) = (cons (x) ((cn_merge (l0) (r))))) ”
  &&  emp
).

Definition IntList_merge_return_wit_2_split_goal_1 := 
forall (ys_pre: Z) (xs_pre: Z) (r: (@list Z)) (l: (@list Z)) (x: Z) (l0: (@list Z)) (x_2: Z) (l0_2: (@list Z)) (PreH1 : (x < x_2)) (PreH2 : (r = (cons (x_2) (l0_2)))) (PreH3 : (l = (cons (x) (l0)))) (PreH4 : (ys_pre <> 0)) (PreH5 : (xs_pre <> 0)) ,
  ((cn_merge (l) (r)) = (cons (x) ((cn_merge (l0) (r)))))
.

Definition IntList_merge_return_wit_3 := 
(
forall (ys_pre: Z) (xs_pre: Z) (r: (@list Z)) (l: (@list Z)) (PreH1 : (ys_pre = 0)) (PreH2 : (xs_pre <> 0)) ,
  (sll xs_pre l )
  **  (sll ys_pre r )
|--
  (sll xs_pre (cn_merge (l) (r)) )
) \/
(
forall (ys_pre: Z) (xs_pre: Z) (r: (@list Z)) (l: (@list Z)) (PreH1 : (ys_pre = 0)) (PreH2 : (xs_pre <> 0)) ,
  (sll ys_pre r )
|--
  “ (l = (cn_merge (l) (r))) ”
  &&  emp
).

Definition IntList_merge_return_wit_3_split_goal_1 := 
forall (ys_pre: Z) (xs_pre: Z) (r: (@list Z)) (l: (@list Z)) (PreH1 : (ys_pre = 0)) (PreH2 : (xs_pre <> 0)) ,
  (sll ys_pre r )
|--
  “ (l = (cn_merge (l) (r))) ”
.

Definition IntList_merge_return_wit_3_split_goal_spatial := 
forall (ys_pre: Z) (xs_pre: Z) (r: (@list Z)) (PreH1 : (ys_pre = 0)) (PreH2 : (xs_pre <> 0)) ,
  (sll ys_pre r )
|--
  TT && emp 
.

Definition IntList_merge_return_wit_4 := 
(
forall (ys_pre: Z) (xs_pre: Z) (r: (@list Z)) (l: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre l )
  **  (sll ys_pre r )
|--
  (sll ys_pre (cn_merge (l) (r)) )
) \/
(
forall (xs_pre: Z) (r: (@list Z)) (l: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre l )
|--
  “ (r = (cn_merge (l) (r))) ”
  &&  emp
).

Definition IntList_merge_return_wit_4_split_goal_1 := 
forall (xs_pre: Z) (r: (@list Z)) (l: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre l )
|--
  “ (r = (cn_merge (l) (r))) ”
.

Definition IntList_merge_return_wit_4_split_goal_spatial := 
forall (xs_pre: Z) (l: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre l )
|--
  TT && emp 
.

Definition IntList_merge_partial_solve_wit_1 := 
forall (ys_pre: Z) (xs_pre: Z) (r: (@list Z)) (l: (@list Z)) (PreH1 : (ys_pre <> 0)) (PreH2 : (xs_pre <> 0)) ,
  (sll xs_pre l )
  **  (sll ys_pre r )
|--
  EX (x: Z)  (l0: (@list Z))  (y: Z) ,
  “ (l = (cons (x) (l0))) ” 
  &&  “ (ys_pre <> 0) ” 
  &&  “ (xs_pre <> 0) ”
  &&  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll ys_pre r )
.

Definition IntList_merge_partial_solve_wit_2 := 
forall (ys_pre: Z) (xs_pre: Z) (r: (@list Z)) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (l = (cons (x) (l0)))) (PreH2 : (ys_pre <> 0)) (PreH3 : (xs_pre <> 0)) ,
  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll ys_pre r )
|--
  EX (x_2: Z)  (l0_2: (@list Z))  (y_2: Z) ,
  “ (r = (cons (x_2) (l0_2))) ” 
  &&  “ (l = (cons (x) (l0))) ” 
  &&  “ (ys_pre <> 0) ” 
  &&  “ (xs_pre <> 0) ”
  &&  ((&((ys_pre)  # "list" ->ₛ "data")) # Int  |-> x_2)
  **  (sll y_2 l0_2 )
  **  ((&((ys_pre)  # "list" ->ₛ "next")) # Ptr  |-> y_2)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
.

Definition IntList_merge_partial_solve_wit_3 := 
forall (ys_pre: Z) (xs_pre: Z) (r: (@list Z)) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (x_2: Z) (l0_2: (@list Z)) (y_2: Z) (PreH1 : (x < x_2)) (PreH2 : (r = (cons (x_2) (l0_2)))) (PreH3 : (l = (cons (x) (l0)))) (PreH4 : (ys_pre <> 0)) (PreH5 : (xs_pre <> 0)) ,
  ((&((ys_pre)  # "list" ->ₛ "data")) # Int  |-> x_2)
  **  (sll y_2 l0_2 )
  **  ((&((ys_pre)  # "list" ->ₛ "next")) # Ptr  |-> y_2)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
|--
  “ (x < x_2) ” 
  &&  “ (r = (cons (x_2) (l0_2))) ” 
  &&  “ (l = (cons (x) (l0))) ” 
  &&  “ (ys_pre <> 0) ” 
  &&  “ (xs_pre <> 0) ”
  &&  (sll y l0 )
  **  (sll ys_pre (cons (x_2) (l0_2)) )
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
.

Definition IntList_merge_partial_solve_wit_4 := 
forall (ys_pre: Z) (xs_pre: Z) (r: (@list Z)) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y_2: Z) (x_2: Z) (l0_2: (@list Z)) (y: Z) (PreH1 : (x >= x_2)) (PreH2 : (r = (cons (x_2) (l0_2)))) (PreH3 : (l = (cons (x) (l0)))) (PreH4 : (ys_pre <> 0)) (PreH5 : (xs_pre <> 0)) ,
  ((&((ys_pre)  # "list" ->ₛ "data")) # Int  |-> x_2)
  **  (sll y l0_2 )
  **  ((&((ys_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
  **  (sll y_2 l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y_2)
|--
  “ (x >= x_2) ” 
  &&  “ (r = (cons (x_2) (l0_2))) ” 
  &&  “ (l = (cons (x) (l0))) ” 
  &&  “ (ys_pre <> 0) ” 
  &&  “ (xs_pre <> 0) ”
  &&  (sll xs_pre (cons (x) (l0)) )
  **  (sll y l0_2 )
  **  ((&((ys_pre)  # "list" ->ₛ "data")) # Int  |-> x_2)
  **  ((&((ys_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
.

(*----- Function IntList_mergesort -----*)

Definition IntList_mergesort_safety_wit_1 := 
forall (xs_pre: Z) (l: (@list Z)) ,
  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
  **  (sll xs_pre l )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntList_mergesort_safety_wit_2 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (l = (cons (x) (l0)))) (PreH2 : (xs_pre <> 0)) ,
  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
  **  ((( &( "tail" ) )) # Ptr  |-> y)
  **  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntList_mergesort_return_wit_1 := 
(
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (retval: Z) (PreH1 : (y <> 0)) (PreH2 : (l = (cons (x) (l0)))) (PreH3 : (xs_pre <> 0)) ,
  (sll retval (cn_merge ((cn_mergesort ((cn_split_fst ((cons (x) (l0))))))) ((cn_mergesort ((cn_split_snd ((cons (x) (l0)))))))) )
|--
  (sll retval (cn_mergesort (l)) )
) \/
(
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (y <> 0)) (PreH2 : (l = (cons (x) (l0)))) (PreH3 : (xs_pre <> 0)) ,
  TT && emp 
|--
  “ ((cn_merge ((cn_mergesort ((cn_split_fst (l))))) ((cn_mergesort ((cn_split_snd (l)))))) = (cn_mergesort (l))) ”
  &&  emp
).

Definition IntList_mergesort_return_wit_1_split_goal_1 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (y <> 0)) (PreH2 : (l = (cons (x) (l0)))) (PreH3 : (xs_pre <> 0)) ,
  ((cn_merge ((cn_mergesort ((cn_split_fst (l))))) ((cn_mergesort ((cn_split_snd (l)))))) = (cn_mergesort (l)))
.

Definition IntList_mergesort_return_wit_2 := 
(
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (y = 0)) (PreH2 : (l = (cons (x) (l0)))) (PreH3 : (xs_pre <> 0)) ,
  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
|--
  (sll xs_pre (cn_mergesort (l)) )
) \/
(
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (y = 0)) (PreH2 : (l = (cons (x) (l0)))) (PreH3 : (xs_pre <> 0)) ,
  (sll y l0 )
|--
  “ ((cn_mergesort (l)) = (cons (x) ((@nil Z)))) ”
  &&  emp
).

Definition IntList_mergesort_return_wit_2_split_goal_1 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (y = 0)) (PreH2 : (l = (cons (x) (l0)))) (PreH3 : (xs_pre <> 0)) ,
  (sll y l0 )
|--
  “ ((cn_mergesort (l)) = (cons (x) ((@nil Z)))) ”
.

Definition IntList_mergesort_return_wit_2_split_goal_spatial := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (y = 0)) (PreH2 : (l = (cons (x) (l0)))) (PreH3 : (xs_pre <> 0)) ,
  (sll y l0 )
|--
  TT && emp 
.

Definition IntList_mergesort_return_wit_3 := 
(
forall (xs_pre: Z) (l: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre l )
|--
  (sll xs_pre (cn_mergesort (l)) )
) \/
(
forall (xs_pre: Z) (l: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre l )
|--
  “ ((cn_mergesort (l)) = (@nil Z)) ”
  &&  emp
).

Definition IntList_mergesort_return_wit_3_split_goal_1 := 
forall (xs_pre: Z) (l: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre l )
|--
  “ ((cn_mergesort (l)) = (@nil Z)) ”
.

Definition IntList_mergesort_return_wit_3_split_goal_spatial := 
forall (xs_pre: Z) (l: (@list Z)) (PreH1 : (xs_pre = 0)) ,
  (sll xs_pre l )
|--
  TT && emp 
.

Definition IntList_mergesort_partial_solve_wit_1 := 
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

Definition IntList_mergesort_partial_solve_wit_2 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (y <> 0)) (PreH2 : (l = (cons (x) (l0)))) (PreH3 : (xs_pre <> 0)) ,
  (UndefStructPredint_list_pair ( &( "p" ) ) )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
|--
  “ (y <> 0) ” 
  &&  “ (l = (cons (x) (l0))) ” 
  &&  “ (xs_pre <> 0) ”
  &&  (sll xs_pre (cons (x) (l0)) )
  **  (UndefStructPredint_list_pair ( &( "p" ) ) )
.

Definition IntList_mergesort_partial_solve_wit_3 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (retval_snd: Z) (retval_fst: Z) (retval: Z) (PreH1 : (y <> 0)) (PreH2 : (l = (cons (x) (l0)))) (PreH3 : (xs_pre <> 0)) ,
  ((&((retval)  # "int_list_pair" ->ₛ "fst")) # Ptr  |-> retval_fst)
  **  (sll retval_fst (cn_split_fst ((cons (x) (l0)))) )
  **  ((&((retval)  # "int_list_pair" ->ₛ "snd")) # Ptr  |-> retval_snd)
  **  (sll retval_snd (cn_split_snd ((cons (x) (l0)))) )
  **  (UndefStructPredint_list_pair ( &( "p" ) ) )
|--
  “ (y <> 0) ” 
  &&  “ (l = (cons (x) (l0))) ” 
  &&  “ (xs_pre <> 0) ”
  &&  ((&((( &( "p" ) ))  # "int_list_pair" ->ₛ "snd")) # Ptr  |->_)
  **  ((&((retval)  # "int_list_pair" ->ₛ "snd")) # Ptr  |-> retval_snd)
  **  ((&((( &( "p" ) ))  # "int_list_pair" ->ₛ "fst")) # Ptr  |->_)
  **  ((&((retval)  # "int_list_pair" ->ₛ "fst")) # Ptr  |-> retval_fst)
  **  (sll retval_fst (cn_split_fst ((cons (x) (l0)))) )
  **  (sll retval_snd (cn_split_snd ((cons (x) (l0)))) )
.

Definition IntList_mergesort_partial_solve_wit_4 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (retval_snd: Z) (retval_fst: Z) (PreH1 : (y <> 0)) (PreH2 : (l = (cons (x) (l0)))) (PreH3 : (xs_pre <> 0)) ,
  ((&((( &( "p" ) ))  # "int_list_pair" ->ₛ "snd")) # Ptr  |-> retval_snd)
  **  ((&((( &( "p" ) ))  # "int_list_pair" ->ₛ "fst")) # Ptr  |-> retval_fst)
  **  (sll retval_fst (cn_split_fst ((cons (x) (l0)))) )
  **  (sll retval_snd (cn_split_snd ((cons (x) (l0)))) )
|--
  “ (y <> 0) ” 
  &&  “ (l = (cons (x) (l0))) ” 
  &&  “ (xs_pre <> 0) ”
  &&  (sll retval_fst (cn_split_fst ((cons (x) (l0)))) )
  **  ((&((( &( "p" ) ))  # "int_list_pair" ->ₛ "snd")) # Ptr  |-> retval_snd)
  **  ((&((( &( "p" ) ))  # "int_list_pair" ->ₛ "fst")) # Ptr  |-> retval_fst)
  **  (sll retval_snd (cn_split_snd ((cons (x) (l0)))) )
.

Definition IntList_mergesort_partial_solve_wit_5 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (retval_snd: Z) (retval: Z) (PreH1 : (y <> 0)) (PreH2 : (l = (cons (x) (l0)))) (PreH3 : (xs_pre <> 0)) ,
  (sll retval (cn_mergesort ((cn_split_fst ((cons (x) (l0)))))) )
  **  ((&((( &( "p" ) ))  # "int_list_pair" ->ₛ "snd")) # Ptr  |-> retval_snd)
  **  ((&((( &( "p" ) ))  # "int_list_pair" ->ₛ "fst")) # Ptr  |-> retval)
  **  (sll retval_snd (cn_split_snd ((cons (x) (l0)))) )
|--
  “ (y <> 0) ” 
  &&  “ (l = (cons (x) (l0))) ” 
  &&  “ (xs_pre <> 0) ”
  &&  (sll retval_snd (cn_split_snd ((cons (x) (l0)))) )
  **  (sll retval (cn_mergesort ((cn_split_fst ((cons (x) (l0)))))) )
  **  ((&((( &( "p" ) ))  # "int_list_pair" ->ₛ "snd")) # Ptr  |-> retval_snd)
  **  ((&((( &( "p" ) ))  # "int_list_pair" ->ₛ "fst")) # Ptr  |-> retval)
.

Definition IntList_mergesort_partial_solve_wit_6 := 
forall (xs_pre: Z) (l: (@list Z)) (x: Z) (l0: (@list Z)) (y: Z) (retval: Z) (retval_2: Z) (PreH1 : (y <> 0)) (PreH2 : (l = (cons (x) (l0)))) (PreH3 : (xs_pre <> 0)) ,
  (sll retval_2 (cn_mergesort ((cn_split_snd ((cons (x) (l0)))))) )
  **  (sll retval (cn_mergesort ((cn_split_fst ((cons (x) (l0)))))) )
  **  ((&((( &( "p" ) ))  # "int_list_pair" ->ₛ "snd")) # Ptr  |-> retval_2)
  **  ((&((( &( "p" ) ))  # "int_list_pair" ->ₛ "fst")) # Ptr  |-> retval)
|--
  “ (y <> 0) ” 
  &&  “ (l = (cons (x) (l0))) ” 
  &&  “ (xs_pre <> 0) ”
  &&  (sll retval (cn_mergesort ((cn_split_fst ((cons (x) (l0)))))) )
  **  (sll retval_2 (cn_mergesort ((cn_split_snd ((cons (x) (l0)))))) )
  **  ((&((( &( "p" ) ))  # "int_list_pair" ->ₛ "snd")) # Ptr  |-> retval_2)
  **  ((&((( &( "p" ) ))  # "int_list_pair" ->ₛ "fst")) # Ptr  |-> retval)
.

(*----- Function refUnsignedInt -----*)

Definition refUnsignedInt_return_wit_1 := 
forall (v_pre: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (0 <= v_pre)) (PreH3 : (v_pre <= UINT_MAX)) ,
  ((retval) # UInt  |-> v_pre)
|--
  ((retval) # UInt  |-> v_pre)
.

Definition refUnsignedInt_partial_solve_wit_1 := 
forall (v_pre: Z) (PreH1 : (0 <= v_pre)) (PreH2 : (v_pre <= UINT_MAX)) ,
  TT && emp 
|--
  “ (0 <= v_pre) ” 
  &&  “ (v_pre <= UINT_MAX) ”
  &&  emp
.

(*----- Function IntList_length_acc_aux -----*)

Definition IntList_length_acc_aux_safety_wit_1 := 
forall (p_pre: Z) (xs_pre: Z) (l: (@list Z)) (n: Z) (PreH1 : (0 <= n)) (PreH2 : (n <= UINT_MAX)) ,
  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # UInt  |-> n)
  **  (sll xs_pre l )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntList_length_acc_aux_safety_wit_2 := 
forall (p_pre: Z) (xs_pre: Z) (l: (@list Z)) (n: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (0 <= n)) (PreH3 : (n <= UINT_MAX)) ,
  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # UInt  |-> n)
  **  (sll xs_pre l )
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition IntList_length_acc_aux_return_wit_1 := 
(
forall (p_pre: Z) (xs_pre: Z) (l: (@list Z)) (n: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (0 <= n)) (PreH3 : (n <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> n)
  **  (sll xs_pre l )
|--
  ((p_pre) # UInt  |-> ((n + (Zlength (l)) ) % ( 4294967296 ) ))
  **  (sll xs_pre l )
) \/
(
forall (xs_pre: Z) (l: (@list Z)) (n: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (0 <= n)) (PreH3 : (n <= UINT_MAX)) ,
  (sll xs_pre l )
|--
  “ (n = ((n + (Zlength (l)) ) % ( 4294967296 ) )) ” 
  &&  “ (l = (@nil Z)) ”
  &&  emp
).

Definition IntList_length_acc_aux_return_wit_1_split_goal_1 := 
forall (xs_pre: Z) (l: (@list Z)) (n: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (0 <= n)) (PreH3 : (n <= UINT_MAX)) ,
  (sll xs_pre l )
|--
  “ (n = ((n + (Zlength (l)) ) % ( 4294967296 ) )) ”
.

Definition IntList_length_acc_aux_return_wit_1_split_goal_2 := 
forall (xs_pre: Z) (l: (@list Z)) (n: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (0 <= n)) (PreH3 : (n <= UINT_MAX)) ,
  (sll xs_pre l )
|--
  “ (l = (@nil Z)) ”
.

Definition IntList_length_acc_aux_return_wit_1_split_goal_spatial := 
forall (xs_pre: Z) (l: (@list Z)) (n: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (0 <= n)) (PreH3 : (n <= UINT_MAX)) ,
  (sll xs_pre l )
|--
  TT && emp 
.

Definition IntList_length_acc_aux_return_wit_2 := 
(
forall (p_pre: Z) (xs_pre: Z) (l: (@list Z)) (n: Z) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (l = (cons (x) (l0)))) (PreH2 : (xs_pre <> 0)) (PreH3 : (0 <= n)) (PreH4 : (n <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> (((unsigned_last_nbits ((n + 1 )) (32)) + (Zlength (l0)) ) % ( 4294967296 ) ))
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
|--
  ((p_pre) # UInt  |-> ((n + (Zlength (l)) ) % ( 4294967296 ) ))
  **  (sll xs_pre l )
) \/
(
forall (xs_pre: Z) (l: (@list Z)) (n: Z) (x: Z) (l0: (@list Z)) (PreH1 : (l = (cons (x) (l0)))) (PreH2 : (xs_pre <> 0)) (PreH3 : (0 <= n)) (PreH4 : (n <= UINT_MAX)) ,
  TT && emp 
|--
  “ ((((unsigned_last_nbits ((n + 1 )) (32)) + (Zlength (l0)) ) % ( 4294967296 ) ) = ((n + (Zlength (l)) ) % ( 4294967296 ) )) ”
  &&  emp
).

Definition IntList_length_acc_aux_return_wit_2_split_goal_1 := 
forall (xs_pre: Z) (l: (@list Z)) (n: Z) (x: Z) (l0: (@list Z)) (PreH1 : (l = (cons (x) (l0)))) (PreH2 : (xs_pre <> 0)) (PreH3 : (0 <= n)) (PreH4 : (n <= UINT_MAX)) ,
  ((((unsigned_last_nbits ((n + 1 )) (32)) + (Zlength (l0)) ) % ( 4294967296 ) ) = ((n + (Zlength (l)) ) % ( 4294967296 ) ))
.

Definition IntList_length_acc_aux_partial_solve_wit_1 := 
forall (p_pre: Z) (xs_pre: Z) (l: (@list Z)) (n: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (0 <= n)) (PreH3 : (n <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> (unsigned_last_nbits ((n + 1 )) (32)))
  **  (sll xs_pre l )
|--
  EX (x: Z)  (l0: (@list Z))  (y: Z) ,
  “ (l = (cons (x) (l0))) ” 
  &&  “ (xs_pre <> 0) ” 
  &&  “ (0 <= n) ” 
  &&  “ (n <= UINT_MAX) ”
  &&  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
  **  ((p_pre) # UInt  |-> (unsigned_last_nbits ((n + 1 )) (32)))
.

Definition IntList_length_acc_aux_partial_solve_wit_2_pure := 
forall (p_pre: Z) (xs_pre: Z) (l: (@list Z)) (n: Z) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (l = (cons (x) (l0)))) (PreH2 : (xs_pre <> 0)) (PreH3 : (0 <= n)) (PreH4 : (n <= UINT_MAX)) ,
  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
  **  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # UInt  |-> (unsigned_last_nbits ((n + 1 )) (32)))
|--
  “ ((unsigned_last_nbits ((n + 1 )) (32)) <= UINT_MAX) ” 
  &&  “ (0 <= (unsigned_last_nbits ((n + 1 )) (32))) ”
.

Definition IntList_length_acc_aux_partial_solve_wit_2_aux := 
forall (p_pre: Z) (xs_pre: Z) (l: (@list Z)) (n: Z) (x: Z) (l0: (@list Z)) (y: Z) (PreH1 : (l = (cons (x) (l0)))) (PreH2 : (xs_pre <> 0)) (PreH3 : (0 <= n)) (PreH4 : (n <= UINT_MAX)) ,
  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
  **  ((p_pre) # UInt  |-> (unsigned_last_nbits ((n + 1 )) (32)))
|--
  “ ((unsigned_last_nbits ((n + 1 )) (32)) <= UINT_MAX) ” 
  &&  “ (0 <= (unsigned_last_nbits ((n + 1 )) (32))) ” 
  &&  “ (l = (cons (x) (l0))) ” 
  &&  “ (xs_pre <> 0) ” 
  &&  “ (0 <= n) ” 
  &&  “ (n <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> (unsigned_last_nbits ((n + 1 )) (32)))
  **  (sll y l0 )
  **  ((&((xs_pre)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((xs_pre)  # "list" ->ₛ "data")) # Int  |-> x)
.

Definition IntList_length_acc_aux_partial_solve_wit_2 := IntList_length_acc_aux_partial_solve_wit_2_pure -> IntList_length_acc_aux_partial_solve_wit_2_aux.

(*----- Function IntList_length_acc -----*)

Definition IntList_length_acc_safety_wit_1 := 
forall (xs_pre: Z) (l: (@list Z)) ,
  ((( &( "p" ) )) # Ptr  |->_)
  **  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
  **  (sll xs_pre l )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition IntList_length_acc_return_wit_1 := 
(
forall (xs_pre: Z) (l: (@list Z)) ,
  (sll xs_pre l )
|--
  “ (((0 + (Zlength (l)) ) % ( 4294967296 ) ) = ((Zlength (l)) % ( 4294967296 ) )) ”
  &&  (sll xs_pre l )
) \/
(
forall (l: (@list Z)) ,
  TT && emp 
|--
  “ (((0 + (Zlength (l)) ) % ( 4294967296 ) ) = ((Zlength (l)) % ( 4294967296 ) )) ”
  &&  emp
).

Definition IntList_length_acc_return_wit_1_split_goal_1 := 
forall (l: (@list Z)) ,
  (((0 + (Zlength (l)) ) % ( 4294967296 ) ) = ((Zlength (l)) % ( 4294967296 ) ))
.

Definition IntList_length_acc_partial_solve_wit_1_pure := 
forall (xs_pre: Z) (l: (@list Z)) ,
  ((( &( "p" ) )) # Ptr  |->_)
  **  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
  **  (sll xs_pre l )
|--
  “ (0 <= 0) ” 
  &&  “ (0 <= UINT_MAX) ”
.

Definition IntList_length_acc_partial_solve_wit_1_aux := 
forall (xs_pre: Z) (l: (@list Z)) ,
  (sll xs_pre l )
|--
  “ (0 <= 0) ” 
  &&  “ (0 <= UINT_MAX) ”
  &&  (sll xs_pre l )
.

Definition IntList_length_acc_partial_solve_wit_1 := IntList_length_acc_partial_solve_wit_1_pure -> IntList_length_acc_partial_solve_wit_1_aux.

Definition IntList_length_acc_partial_solve_wit_2_pure := 
forall (xs_pre: Z) (l: (@list Z)) (retval: Z) ,
  ((retval) # UInt  |-> 0)
  **  ((( &( "p" ) )) # Ptr  |-> retval)
  **  ((( &( "xs" ) )) # Ptr  |-> xs_pre)
  **  (sll xs_pre l )
|--
  “ (0 <= 0) ” 
  &&  “ (0 <= UINT_MAX) ”
.

Definition IntList_length_acc_partial_solve_wit_2_aux := 
forall (xs_pre: Z) (l: (@list Z)) (retval: Z) ,
  ((retval) # UInt  |-> 0)
  **  (sll xs_pre l )
|--
  “ (0 <= 0) ” 
  &&  “ (0 <= UINT_MAX) ”
  &&  ((retval) # UInt  |-> 0)
  **  (sll xs_pre l )
.

Definition IntList_length_acc_partial_solve_wit_2 := IntList_length_acc_partial_solve_wit_2_pure -> IntList_length_acc_partial_solve_wit_2_aux.

Definition IntList_length_acc_partial_solve_wit_3 := 
forall (xs_pre: Z) (l: (@list Z)) (retval: Z) ,
  ((retval) # UInt  |-> ((0 + (Zlength (l)) ) % ( 4294967296 ) ))
  **  (sll xs_pre l )
|--
  ((retval) # UInt  |->_)
  **  (sll xs_pre l )
.

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
Axiom proof_of_IntList_rev_loop_safety_wit_1 : IntList_rev_loop_safety_wit_1.
Axiom proof_of_IntList_rev_loop_safety_wit_2 : IntList_rev_loop_safety_wit_2.
Axiom proof_of_IntList_rev_loop_safety_wit_3 : IntList_rev_loop_safety_wit_3.
Axiom proof_of_IntList_rev_loop_entail_wit_1 : IntList_rev_loop_entail_wit_1.
Axiom proof_of_IntList_rev_loop_entail_wit_2 : IntList_rev_loop_entail_wit_2.
Axiom proof_of_IntList_rev_loop_return_wit_1 : IntList_rev_loop_return_wit_1.
Axiom proof_of_IntList_rev_loop_partial_solve_wit_1 : IntList_rev_loop_partial_solve_wit_1.
Axiom proof_of_IntList_split_safety_wit_1 : IntList_split_safety_wit_1.
Axiom proof_of_IntList_split_safety_wit_2 : IntList_split_safety_wit_2.
Axiom proof_of_IntList_split_safety_wit_3 : IntList_split_safety_wit_3.
Axiom proof_of_IntList_split_safety_wit_4 : IntList_split_safety_wit_4.
Axiom proof_of_IntList_split_safety_wit_5 : IntList_split_safety_wit_5.
Axiom proof_of_IntList_split_return_wit_1 : IntList_split_return_wit_1.
Axiom proof_of_IntList_split_return_wit_2 : IntList_split_return_wit_2.
Axiom proof_of_IntList_split_return_wit_3 : IntList_split_return_wit_3.
Axiom proof_of_IntList_split_partial_solve_wit_1 : IntList_split_partial_solve_wit_1.
Axiom proof_of_IntList_split_partial_solve_wit_2 : IntList_split_partial_solve_wit_2.
Axiom proof_of_IntList_split_partial_solve_wit_3 : IntList_split_partial_solve_wit_3.
Axiom proof_of_IntList_split_partial_solve_wit_4 : IntList_split_partial_solve_wit_4.
Axiom proof_of_IntList_split_partial_solve_wit_5 : IntList_split_partial_solve_wit_5.
Axiom proof_of_IntList_split_partial_solve_wit_6 : IntList_split_partial_solve_wit_6.
Axiom proof_of_IntList_split_partial_solve_wit_7 : IntList_split_partial_solve_wit_7.
Axiom proof_of_IntList_merge_safety_wit_1 : IntList_merge_safety_wit_1.
Axiom proof_of_IntList_merge_safety_wit_2 : IntList_merge_safety_wit_2.
Axiom proof_of_IntList_merge_return_wit_1 : IntList_merge_return_wit_1.
Axiom proof_of_IntList_merge_return_wit_2 : IntList_merge_return_wit_2.
Axiom proof_of_IntList_merge_return_wit_3 : IntList_merge_return_wit_3.
Axiom proof_of_IntList_merge_return_wit_4 : IntList_merge_return_wit_4.
Axiom proof_of_IntList_merge_partial_solve_wit_1 : IntList_merge_partial_solve_wit_1.
Axiom proof_of_IntList_merge_partial_solve_wit_2 : IntList_merge_partial_solve_wit_2.
Axiom proof_of_IntList_merge_partial_solve_wit_3 : IntList_merge_partial_solve_wit_3.
Axiom proof_of_IntList_merge_partial_solve_wit_4 : IntList_merge_partial_solve_wit_4.
Axiom proof_of_IntList_mergesort_safety_wit_1 : IntList_mergesort_safety_wit_1.
Axiom proof_of_IntList_mergesort_safety_wit_2 : IntList_mergesort_safety_wit_2.
Axiom proof_of_IntList_mergesort_return_wit_1 : IntList_mergesort_return_wit_1.
Axiom proof_of_IntList_mergesort_return_wit_2 : IntList_mergesort_return_wit_2.
Axiom proof_of_IntList_mergesort_return_wit_3 : IntList_mergesort_return_wit_3.
Axiom proof_of_IntList_mergesort_partial_solve_wit_1 : IntList_mergesort_partial_solve_wit_1.
Axiom proof_of_IntList_mergesort_partial_solve_wit_2 : IntList_mergesort_partial_solve_wit_2.
Axiom proof_of_IntList_mergesort_partial_solve_wit_3 : IntList_mergesort_partial_solve_wit_3.
Axiom proof_of_IntList_mergesort_partial_solve_wit_4 : IntList_mergesort_partial_solve_wit_4.
Axiom proof_of_IntList_mergesort_partial_solve_wit_5 : IntList_mergesort_partial_solve_wit_5.
Axiom proof_of_IntList_mergesort_partial_solve_wit_6 : IntList_mergesort_partial_solve_wit_6.
Axiom proof_of_refUnsignedInt_return_wit_1 : refUnsignedInt_return_wit_1.
Axiom proof_of_refUnsignedInt_partial_solve_wit_1 : refUnsignedInt_partial_solve_wit_1.
Axiom proof_of_IntList_length_acc_aux_safety_wit_1 : IntList_length_acc_aux_safety_wit_1.
Axiom proof_of_IntList_length_acc_aux_safety_wit_2 : IntList_length_acc_aux_safety_wit_2.
Axiom proof_of_IntList_length_acc_aux_return_wit_1 : IntList_length_acc_aux_return_wit_1.
Axiom proof_of_IntList_length_acc_aux_return_wit_2 : IntList_length_acc_aux_return_wit_2.
Axiom proof_of_IntList_length_acc_aux_partial_solve_wit_1 : IntList_length_acc_aux_partial_solve_wit_1.
Axiom proof_of_IntList_length_acc_aux_partial_solve_wit_2_pure : IntList_length_acc_aux_partial_solve_wit_2_pure.
Axiom proof_of_IntList_length_acc_aux_partial_solve_wit_2 : IntList_length_acc_aux_partial_solve_wit_2.
Axiom proof_of_IntList_length_acc_safety_wit_1 : IntList_length_acc_safety_wit_1.
Axiom proof_of_IntList_length_acc_return_wit_1 : IntList_length_acc_return_wit_1.
Axiom proof_of_IntList_length_acc_partial_solve_wit_1_pure : IntList_length_acc_partial_solve_wit_1_pure.
Axiom proof_of_IntList_length_acc_partial_solve_wit_1 : IntList_length_acc_partial_solve_wit_1.
Axiom proof_of_IntList_length_acc_partial_solve_wit_2_pure : IntList_length_acc_partial_solve_wit_2_pure.
Axiom proof_of_IntList_length_acc_partial_solve_wit_2 : IntList_length_acc_partial_solve_wit_2.
Axiom proof_of_IntList_length_acc_partial_solve_wit_3 : IntList_length_acc_partial_solve_wit_3.

End VC_Correct.
