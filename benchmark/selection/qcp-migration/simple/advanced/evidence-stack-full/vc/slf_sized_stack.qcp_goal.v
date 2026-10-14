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

(*----- Function create -----*)

Definition create_safety_wit_1 := 
forall (retval: Z) (PreH1 : (retval <> 0)) ,
  ((&((retval)  # "sized_stack" ->ₛ "size")) # UInt  |->_)
  **  ((&((retval)  # "sized_stack" ->ₛ "data")) # Ptr  |->_)
  **  ((( &( "p" ) )) # Ptr  |-> retval)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition create_safety_wit_2 := 
forall (retval: Z) (PreH1 : (retval <> 0)) ,
  ((&((retval)  # "sized_stack" ->ₛ "size")) # UInt  |-> 0)
  **  ((&((retval)  # "sized_stack" ->ₛ "data")) # Ptr  |->_)
  **  ((( &( "p" ) )) # Ptr  |-> retval)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition create_return_wit_1 := 
forall (retval: Z) (PreH1 : (retval <> 0)) ,
  ((&((retval)  # "sized_stack" ->ₛ "size")) # UInt  |-> 0)
  **  ((&((retval)  # "sized_stack" ->ₛ "data")) # Ptr  |-> 0)
|--
  EX (retval_data: Z)  (retval_size: Z) ,
  “ (retval_size = 0) ” 
  &&  “ (retval_data = 0) ”
  &&  ((&((retval)  # "sized_stack" ->ₛ "size")) # UInt  |-> retval_size)
  **  ((&((retval)  # "sized_stack" ->ₛ "data")) # Ptr  |-> retval_data)
.

Definition create_partial_solve_wit_1 := 
  TT && emp 
|--
  TT && emp 
.

(*----- Function sizeOf -----*)

Definition sizeOf_return_wit_1 := 
forall (p_pre: Z) (l: (@list Z)) (d: Z) (p_pre_size: Z) (PreH1 : (p_pre_size = ((Zlength (l)) % ( 4294967296 ) ))) ,
  ((&((p_pre)  # "sized_stack" ->ₛ "size")) # UInt  |-> p_pre_size)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "data")) # Ptr  |-> d)
  **  (sll d l )
|--
  EX (p_pre_size_2: Z) ,
  “ (p_pre_size = ((Zlength (l)) % ( 4294967296 ) )) ” 
  &&  “ (p_pre_size_2 = ((Zlength (l)) % ( 4294967296 ) )) ”
  &&  ((&((p_pre)  # "sized_stack" ->ₛ "size")) # UInt  |-> p_pre_size_2)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "data")) # Ptr  |-> d)
  **  (sll d l )
.

(*----- Function push -----*)

Definition push_return_wit_1 := 
(
forall (x_pre: Z) (p_pre: Z) (l: (@list Z)) (x0: Z) (p_pre_size_2: Z) (retval: Z) (PreH1 : (x_pre = x0)) (PreH2 : (p_pre_size_2 = ((Zlength (l)) % ( 4294967296 ) ))) ,
  (sll retval (cons (x_pre) (l)) )
  **  ((&((p_pre)  # "sized_stack" ->ₛ "size")) # UInt  |-> (unsigned_last_nbits ((p_pre_size_2 + 1 )) (32)))
  **  ((&((p_pre)  # "sized_stack" ->ₛ "data")) # Ptr  |-> retval)
|--
  EX (d2: Z)  (p_pre_size: Z) ,
  “ (p_pre_size = (((Zlength (l)) + 1 ) % ( 4294967296 ) )) ”
  &&  ((&((p_pre)  # "sized_stack" ->ₛ "size")) # UInt  |-> p_pre_size)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "data")) # Ptr  |-> d2)
  **  (sll d2 (cons (x0) (l)) )
) \/
(
forall (x_pre: Z) (l: (@list Z)) (x0: Z) (p_pre_size_2: Z) (PreH1 : (x_pre = x0)) (PreH2 : (p_pre_size_2 = ((Zlength (l)) % ( 4294967296 ) ))) ,
  TT && emp 
|--
  “ ((unsigned_last_nbits ((p_pre_size_2 + 1 )) (32)) = (((Zlength (l)) + 1 ) % ( 4294967296 ) )) ” 
  &&  “ ((unsigned_last_nbits ((p_pre_size_2 + 1 )) (32)) = (((Zlength (l)) + 1 ) % ( 4294967296 ) )) ”
  &&  emp
).

Definition push_return_wit_1_split_goal_1 := 
forall (x_pre: Z) (l: (@list Z)) (x0: Z) (p_pre_size_2: Z) (PreH1 : (x_pre = x0)) (PreH2 : (p_pre_size_2 = ((Zlength (l)) % ( 4294967296 ) ))) ,
  ((unsigned_last_nbits ((p_pre_size_2 + 1 )) (32)) = (((Zlength (l)) + 1 ) % ( 4294967296 ) ))
.

Definition push_return_wit_1_split_goal_2 := 
forall (x_pre: Z) (l: (@list Z)) (x0: Z) (p_pre_size_2: Z) (PreH1 : (x_pre = x0)) (PreH2 : (p_pre_size_2 = ((Zlength (l)) % ( 4294967296 ) ))) ,
  ((unsigned_last_nbits ((p_pre_size_2 + 1 )) (32)) = (((Zlength (l)) + 1 ) % ( 4294967296 ) ))
.

Definition push_partial_solve_wit_1_pure := 
forall (x_pre: Z) (p_pre: Z) (l: (@list Z)) (x0: Z) (d: Z) (p_pre_size: Z) (PreH1 : (x_pre = x0)) (PreH2 : (p_pre_size = ((Zlength (l)) % ( 4294967296 ) ))) ,
  ((( &( "data" ) )) # Ptr  |->_)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((( &( "x" ) )) # Int  |-> x_pre)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "size")) # UInt  |-> p_pre_size)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "data")) # Ptr  |-> d)
  **  (sll d l )
|--
  “ (x_pre = x_pre) ”
.

Definition push_partial_solve_wit_1_aux := 
forall (x_pre: Z) (p_pre: Z) (l: (@list Z)) (x0: Z) (d: Z) (p_pre_size: Z) (PreH1 : (x_pre = x0)) (PreH2 : (p_pre_size = ((Zlength (l)) % ( 4294967296 ) ))) ,
  ((&((p_pre)  # "sized_stack" ->ₛ "size")) # UInt  |-> p_pre_size)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "data")) # Ptr  |-> d)
  **  (sll d l )
|--
  “ (x_pre = x_pre) ” 
  &&  “ (x_pre = x0) ” 
  &&  “ (p_pre_size = ((Zlength (l)) % ( 4294967296 ) )) ”
  &&  (sll d l )
  **  ((&((p_pre)  # "sized_stack" ->ₛ "size")) # UInt  |-> p_pre_size)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "data")) # Ptr  |-> d)
.

Definition push_partial_solve_wit_1 := push_partial_solve_wit_1_pure -> push_partial_solve_wit_1_aux.

(*----- Function top -----*)

Definition top_safety_wit_1 := 
forall (p_pre: Z) (l: (@list Z)) (h: Z) (d: Z) (p_pre_size: Z) (PreH1 : ((((Zlength (l)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH2 : (p_pre_size = (((Zlength (l)) + 1 ) % ( 4294967296 ) ))) ,
  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "size")) # UInt  |-> p_pre_size)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "data")) # Ptr  |-> d)
  **  (sll d (cons (h) (l)) )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition top_safety_wit_2 := 
forall (p_pre: Z) (l: (@list Z)) (h: Z) (d: Z) (p_pre_size: Z) (PreH1 : (d = 0)) (PreH2 : ((((Zlength (l)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH3 : (p_pre_size = (((Zlength (l)) + 1 ) % ( 4294967296 ) ))) ,
  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "size")) # UInt  |-> p_pre_size)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "data")) # Ptr  |-> d)
  **  (sll d (cons (h) (l)) )
|--
  “ (42 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 42) ”
.

Definition top_return_wit_1 := 
(
forall (p_pre: Z) (l: (@list Z)) (h: Z) (d: Z) (p_pre_size_2: Z) (PreH1 : (d = 0)) (PreH2 : ((((Zlength (l)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH3 : (p_pre_size_2 = (((Zlength (l)) + 1 ) % ( 4294967296 ) ))) ,
  ((&((p_pre)  # "sized_stack" ->ₛ "size")) # UInt  |-> p_pre_size_2)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "data")) # Ptr  |-> d)
  **  (sll d (cons (h) (l)) )
|--
  EX (p_pre_size: Z) ,
  “ (42 = h) ” 
  &&  “ (p_pre_size = (((Zlength (l)) + 1 ) % ( 4294967296 ) )) ”
  &&  ((&((p_pre)  # "sized_stack" ->ₛ "size")) # UInt  |-> p_pre_size)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "data")) # Ptr  |-> d)
  **  (sll d (cons (h) (l)) )
) \/
(
forall (l: (@list Z)) (h: Z) (d: Z) (p_pre_size_2: Z) (PreH1 : (d = 0)) (PreH2 : ((((Zlength (l)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH3 : (p_pre_size_2 = (((Zlength (l)) + 1 ) % ( 4294967296 ) ))) ,
  TT && emp 
|--
  “ (42 = h) ”
  &&  emp
).

Definition top_return_wit_1_split_goal_1 := 
forall (l: (@list Z)) (h: Z) (d: Z) (p_pre_size_2: Z) (PreH1 : (d = 0)) (PreH2 : ((((Zlength (l)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH3 : (p_pre_size_2 = (((Zlength (l)) + 1 ) % ( 4294967296 ) ))) ,
  (42 = h)
.

Definition top_return_wit_2 := 
forall (p_pre: Z) (l: (@list Z)) (h: Z) (d: Z) (p_pre_size_2: Z) (y: Z) (PreH1 : (d <> 0)) (PreH2 : ((((Zlength (l)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH3 : (p_pre_size_2 = (((Zlength (l)) + 1 ) % ( 4294967296 ) ))) ,
  ((&((d)  # "list" ->ₛ "data")) # Int  |-> h)
  **  (sll y l )
  **  ((&((d)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "size")) # UInt  |-> p_pre_size_2)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "data")) # Ptr  |-> d)
|--
  EX (p_pre_size: Z) ,
  “ (h = h) ” 
  &&  “ (p_pre_size = (((Zlength (l)) + 1 ) % ( 4294967296 ) )) ”
  &&  ((&((p_pre)  # "sized_stack" ->ₛ "size")) # UInt  |-> p_pre_size)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "data")) # Ptr  |-> d)
  **  (sll d (cons (h) (l)) )
.

Definition top_partial_solve_wit_1 := 
forall (p_pre: Z) (l: (@list Z)) (h: Z) (d: Z) (p_pre_size: Z) (PreH1 : (d <> 0)) (PreH2 : ((((Zlength (l)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH3 : (p_pre_size = (((Zlength (l)) + 1 ) % ( 4294967296 ) ))) ,
  ((&((p_pre)  # "sized_stack" ->ₛ "size")) # UInt  |-> p_pre_size)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "data")) # Ptr  |-> d)
  **  (sll d (cons (h) (l)) )
|--
  EX (y: Z) ,
  “ (d <> 0) ” 
  &&  “ ((((Zlength (l)) + 1 ) % ( 4294967296 ) ) > 0) ” 
  &&  “ (p_pre_size = (((Zlength (l)) + 1 ) % ( 4294967296 ) )) ”
  &&  ((&((d)  # "list" ->ₛ "data")) # Int  |-> h)
  **  (sll y l )
  **  ((&((d)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "size")) # UInt  |-> p_pre_size)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "data")) # Ptr  |-> d)
.

(*----- Function pop -----*)

Definition pop_safety_wit_1 := 
forall (p_pre: Z) (l: (@list Z)) (h: Z) (d: Z) (p_pre_size: Z) (PreH1 : ((((Zlength (l)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH2 : (p_pre_size = (((Zlength (l)) + 1 ) % ( 4294967296 ) ))) ,
  ((( &( "data" ) )) # Ptr  |-> d)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "size")) # UInt  |-> p_pre_size)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "data")) # Ptr  |-> d)
  **  (sll d (cons (h) (l)) )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition pop_safety_wit_2 := 
forall (p_pre: Z) (l: (@list Z)) (h: Z) (d: Z) (p_pre_size: Z) (PreH1 : (d = 0)) (PreH2 : ((((Zlength (l)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH3 : (p_pre_size = (((Zlength (l)) + 1 ) % ( 4294967296 ) ))) ,
  ((( &( "data" ) )) # Ptr  |-> d)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "size")) # UInt  |-> p_pre_size)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "data")) # Ptr  |-> d)
  **  (sll d (cons (h) (l)) )
|--
  “ (42 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 42) ”
.

Definition pop_return_wit_1 := 
(
forall (p_pre: Z) (l: (@list Z)) (h: Z) (d: Z) (p_pre_size_2: Z) (PreH1 : (d = 0)) (PreH2 : ((((Zlength (l)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH3 : (p_pre_size_2 = (((Zlength (l)) + 1 ) % ( 4294967296 ) ))) ,
  ((&((p_pre)  # "sized_stack" ->ₛ "size")) # UInt  |-> p_pre_size_2)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "data")) # Ptr  |-> d)
  **  (sll d (cons (h) (l)) )
|--
  EX (d2: Z)  (p_pre_size: Z) ,
  “ (p_pre_size = ((Zlength (l)) % ( 4294967296 ) )) ”
  &&  ((&((p_pre)  # "sized_stack" ->ₛ "size")) # UInt  |-> p_pre_size)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "data")) # Ptr  |-> d2)
  **  (sll d2 l )
) \/
(
forall (l: (@list Z)) (h: Z) (d: Z) (p_pre_size_2: Z) (y: Z) (PreH1 : (h <= INT_MAX)) (PreH2 : (h >= INT_MIN)) (PreH3 : (d = 0)) (PreH4 : ((((Zlength (l)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH5 : (p_pre_size_2 = (((Zlength (l)) + 1 ) % ( 4294967296 ) ))) ,
  (sll y l )
  **  ((&((d)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((d)  # "list" ->ₛ "data")) # Int  |-> h)
|--
  “ (p_pre_size_2 = ((Zlength (l)) % ( 4294967296 ) )) ” 
  &&  “ (p_pre_size_2 = ((Zlength (l)) % ( 4294967296 ) )) ” 
  &&  “ (l = (@nil Z)) ”
  &&  emp
).

Definition pop_return_wit_1_split_goal_1 := 
forall (l: (@list Z)) (h: Z) (d: Z) (p_pre_size_2: Z) (y: Z) (PreH1 : (h <= INT_MAX)) (PreH2 : (h >= INT_MIN)) (PreH3 : (d = 0)) (PreH4 : ((((Zlength (l)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH5 : (p_pre_size_2 = (((Zlength (l)) + 1 ) % ( 4294967296 ) ))) ,
  (sll y l )
  **  ((&((d)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((d)  # "list" ->ₛ "data")) # Int  |-> h)
|--
  “ (p_pre_size_2 = ((Zlength (l)) % ( 4294967296 ) )) ”
.

Definition pop_return_wit_1_split_goal_2 := 
forall (l: (@list Z)) (h: Z) (d: Z) (p_pre_size_2: Z) (y: Z) (PreH1 : (h <= INT_MAX)) (PreH2 : (h >= INT_MIN)) (PreH3 : (d = 0)) (PreH4 : ((((Zlength (l)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH5 : (p_pre_size_2 = (((Zlength (l)) + 1 ) % ( 4294967296 ) ))) ,
  (sll y l )
  **  ((&((d)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((d)  # "list" ->ₛ "data")) # Int  |-> h)
|--
  “ (p_pre_size_2 = ((Zlength (l)) % ( 4294967296 ) )) ”
.

Definition pop_return_wit_1_split_goal_3 := 
forall (l: (@list Z)) (h: Z) (d: Z) (p_pre_size_2: Z) (y: Z) (PreH1 : (h <= INT_MAX)) (PreH2 : (h >= INT_MIN)) (PreH3 : (d = 0)) (PreH4 : ((((Zlength (l)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH5 : (p_pre_size_2 = (((Zlength (l)) + 1 ) % ( 4294967296 ) ))) ,
  (sll y l )
  **  ((&((d)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((d)  # "list" ->ₛ "data")) # Int  |-> h)
|--
  “ (l = (@nil Z)) ”
.

Definition pop_return_wit_1_split_goal_spatial := 
forall (l: (@list Z)) (h: Z) (d: Z) (p_pre_size_2: Z) (y: Z) (PreH1 : (h <= INT_MAX)) (PreH2 : (h >= INT_MIN)) (PreH3 : (d = 0)) (PreH4 : ((((Zlength (l)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH5 : (p_pre_size_2 = (((Zlength (l)) + 1 ) % ( 4294967296 ) ))) ,
  (sll y l )
  **  ((&((d)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((d)  # "list" ->ₛ "data")) # Int  |-> h)
|--
  TT && emp 
.

Definition pop_return_wit_2 := 
(
forall (p_pre: Z) (l: (@list Z)) (d: Z) (p_pre_size_2: Z) (y: Z) (PreH1 : (d <> 0)) (PreH2 : ((((Zlength (l)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH3 : (p_pre_size_2 = (((Zlength (l)) + 1 ) % ( 4294967296 ) ))) ,
  (sll y l )
  **  ((&((p_pre)  # "sized_stack" ->ₛ "size")) # UInt  |-> (p_pre_size_2 - 1 ))
  **  ((&((p_pre)  # "sized_stack" ->ₛ "data")) # Ptr  |-> y)
|--
  EX (d2: Z)  (p_pre_size: Z) ,
  “ (p_pre_size = ((Zlength (l)) % ( 4294967296 ) )) ”
  &&  ((&((p_pre)  # "sized_stack" ->ₛ "size")) # UInt  |-> p_pre_size)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "data")) # Ptr  |-> d2)
  **  (sll d2 l )
) \/
(
forall (l: (@list Z)) (d: Z) (p_pre_size_2: Z) (PreH1 : (d <> 0)) (PreH2 : ((((Zlength (l)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH3 : (p_pre_size_2 = (((Zlength (l)) + 1 ) % ( 4294967296 ) ))) ,
  TT && emp 
|--
  “ ((p_pre_size_2 - 1 ) = ((Zlength (l)) % ( 4294967296 ) )) ” 
  &&  “ ((p_pre_size_2 - 1 ) = ((Zlength (l)) % ( 4294967296 ) )) ”
  &&  emp
).

Definition pop_return_wit_2_split_goal_1 := 
forall (l: (@list Z)) (d: Z) (p_pre_size_2: Z) (PreH1 : (d <> 0)) (PreH2 : ((((Zlength (l)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH3 : (p_pre_size_2 = (((Zlength (l)) + 1 ) % ( 4294967296 ) ))) ,
  ((p_pre_size_2 - 1 ) = ((Zlength (l)) % ( 4294967296 ) ))
.

Definition pop_return_wit_2_split_goal_2 := 
forall (l: (@list Z)) (d: Z) (p_pre_size_2: Z) (PreH1 : (d <> 0)) (PreH2 : ((((Zlength (l)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH3 : (p_pre_size_2 = (((Zlength (l)) + 1 ) % ( 4294967296 ) ))) ,
  ((p_pre_size_2 - 1 ) = ((Zlength (l)) % ( 4294967296 ) ))
.

Definition pop_partial_solve_wit_1 := 
forall (p_pre: Z) (l: (@list Z)) (h: Z) (d: Z) (p_pre_size: Z) (PreH1 : (d <> 0)) (PreH2 : ((((Zlength (l)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH3 : (p_pre_size = (((Zlength (l)) + 1 ) % ( 4294967296 ) ))) ,
  ((&((p_pre)  # "sized_stack" ->ₛ "size")) # UInt  |-> p_pre_size)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "data")) # Ptr  |-> d)
  **  (sll d (cons (h) (l)) )
|--
  EX (y: Z) ,
  “ (d <> 0) ” 
  &&  “ ((((Zlength (l)) + 1 ) % ( 4294967296 ) ) > 0) ” 
  &&  “ (p_pre_size = (((Zlength (l)) + 1 ) % ( 4294967296 ) )) ”
  &&  ((&((d)  # "list" ->ₛ "data")) # Int  |-> h)
  **  (sll y l )
  **  ((&((d)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "size")) # UInt  |-> p_pre_size)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "data")) # Ptr  |-> d)
.

Definition pop_partial_solve_wit_2 := 
forall (p_pre: Z) (l: (@list Z)) (h: Z) (d: Z) (p_pre_size: Z) (y: Z) (PreH1 : (d <> 0)) (PreH2 : ((((Zlength (l)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH3 : (p_pre_size = (((Zlength (l)) + 1 ) % ( 4294967296 ) ))) ,
  ((&((d)  # "list" ->ₛ "data")) # Int  |-> h)
  **  (sll y l )
  **  ((&((d)  # "list" ->ₛ "next")) # Ptr  |-> y)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "size")) # UInt  |-> p_pre_size)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "data")) # Ptr  |-> d)
|--
  “ (d <> 0) ” 
  &&  “ ((((Zlength (l)) + 1 ) % ( 4294967296 ) ) > 0) ” 
  &&  “ (p_pre_size = (((Zlength (l)) + 1 ) % ( 4294967296 ) )) ”
  &&  ((&((d)  # "list" ->ₛ "data")) # Int  |->_)
  **  ((&((d)  # "list" ->ₛ "next")) # Ptr  |->_)
  **  (sll y l )
  **  ((&((p_pre)  # "sized_stack" ->ₛ "size")) # UInt  |-> p_pre_size)
  **  ((&((p_pre)  # "sized_stack" ->ₛ "data")) # Ptr  |-> d)
.

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

Module Type VC_Correct.

Axiom proof_of_IntList_cons_return_wit_1 : IntList_cons_return_wit_1.
Axiom proof_of_IntList_cons_partial_solve_wit_1 : IntList_cons_partial_solve_wit_1.
Axiom proof_of_create_safety_wit_1 : create_safety_wit_1.
Axiom proof_of_create_safety_wit_2 : create_safety_wit_2.
Axiom proof_of_create_return_wit_1 : create_return_wit_1.
Axiom proof_of_create_partial_solve_wit_1 : create_partial_solve_wit_1.
Axiom proof_of_sizeOf_return_wit_1 : sizeOf_return_wit_1.
Axiom proof_of_push_return_wit_1 : push_return_wit_1.
Axiom proof_of_push_partial_solve_wit_1_pure : push_partial_solve_wit_1_pure.
Axiom proof_of_push_partial_solve_wit_1 : push_partial_solve_wit_1.
Axiom proof_of_top_safety_wit_1 : top_safety_wit_1.
Axiom proof_of_top_safety_wit_2 : top_safety_wit_2.
Axiom proof_of_top_return_wit_1 : top_return_wit_1.
Axiom proof_of_top_return_wit_2 : top_return_wit_2.
Axiom proof_of_top_partial_solve_wit_1 : top_partial_solve_wit_1.
Axiom proof_of_pop_safety_wit_1 : pop_safety_wit_1.
Axiom proof_of_pop_safety_wit_2 : pop_safety_wit_2.
Axiom proof_of_pop_return_wit_1 : pop_return_wit_1.
Axiom proof_of_pop_return_wit_2 : pop_return_wit_2.
Axiom proof_of_pop_partial_solve_wit_1 : pop_partial_solve_wit_1.
Axiom proof_of_pop_partial_solve_wit_2 : pop_partial_solve_wit_2.
Axiom proof_of_IntList_nil_safety_wit_1 : IntList_nil_safety_wit_1.
Axiom proof_of_IntList_nil_return_wit_1 : IntList_nil_return_wit_1.
Axiom proof_of_IntList_length_safety_wit_1 : IntList_length_safety_wit_1.
Axiom proof_of_IntList_length_safety_wit_2 : IntList_length_safety_wit_2.
Axiom proof_of_IntList_length_safety_wit_3 : IntList_length_safety_wit_3.
Axiom proof_of_IntList_length_return_wit_1 : IntList_length_return_wit_1.
Axiom proof_of_IntList_length_return_wit_2 : IntList_length_return_wit_2.
Axiom proof_of_IntList_length_partial_solve_wit_1 : IntList_length_partial_solve_wit_1.
Axiom proof_of_IntList_length_partial_solve_wit_2 : IntList_length_partial_solve_wit_2.

End VC_Correct.
