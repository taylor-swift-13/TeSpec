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
Local Open Scope Z_scope.

(*----- Function sample -----*)

Definition sample_safety_wit_1 := 
forall (p_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y = 0)) (PreH2 : (y_2 = 0)) (PreH3 : (p_pre <> 0)) ,
  (((p_pre + 4 )) # Ptr  |-> 0)
  **  ((4) # Ptr  |-> 0)
  **  ((0) # Int  |-> 2)
  **  ((p_pre) # Int  |-> 1)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> p_pre)
|--
  “ ((1 + 0 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 + 0 )) ”
.

Definition sample_safety_wit_2 := 
forall (p_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (p_pre <> 0)) ,
  (((p_pre + 4 )) # Ptr  |-> y)
  **  (((y + 4 )) # Ptr  |-> 0)
  **  ((y) # Int  |-> 2)
  **  ((p_pre) # Int  |-> 1)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> p_pre)
|--
  “ ((1 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 + 1 )) ”
.

Definition sample_safety_wit_3 := 
forall (p_pre: Z) (PreH1 : (p_pre <> 0)) ,
  ((( &( "p_spec_410" ) )) # Ptr  |-> p_pre)
  **  (sll p_pre (cons (1) ((cons (2) ((@nil Z))))) )
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition sample_safety_wit_4 := 
forall (p_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (p_pre <> 0)) ,
  ((( &( "p_spec_436" ) )) # Ptr  |-> y)
  **  (((p_pre + 4 )) # Ptr  |-> y)
  **  (((y + 4 )) # Ptr  |-> 0)
  **  ((y) # Int  |-> 2)
  **  ((p_pre) # Int  |-> 1)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> p_pre)
|--
  “ ((1 + 0 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 + 0 )) ”
.

Definition sample_safety_wit_5 := 
forall (p_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (p_pre <> 0)) ,
  ((( &( "p_spec_436" ) )) # Ptr  |-> y)
  **  (((p_pre + 4 )) # Ptr  |-> y)
  **  (((y + 4 )) # Ptr  |-> 0)
  **  ((y) # Int  |-> 2)
  **  ((p_pre) # Int  |-> 1)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> p_pre)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition sample_safety_wit_6 := 
forall (p_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (p_pre <> 0)) ,
  ((( &( "p_spec_437" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_436" ) )) # Ptr  |-> y)
  **  (((p_pre + 4 )) # Ptr  |-> y)
  **  (((y + 4 )) # Ptr  |-> 0)
  **  ((y) # Int  |-> 2)
  **  ((p_pre) # Int  |-> 1)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> p_pre)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition sample_safety_wit_7 := 
forall (p_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (p_pre <> 0)) ,
  ((( &( "p_spec_437" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_436" ) )) # Ptr  |-> y)
  **  (((p_pre + 4 )) # Ptr  |-> y)
  **  (((y + 4 )) # Ptr  |-> 0)
  **  ((y) # Int  |-> 2)
  **  ((p_pre) # Int  |-> 1)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> p_pre)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition sample_safety_wit_8 := 
forall (p_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y = 0)) (PreH2 : (y_2 = 0)) (PreH3 : (p_pre <> 0)) ,
  ((( &( "p_spec_436" ) )) # Ptr  |-> 0)
  **  (((p_pre + 4 )) # Ptr  |-> 0)
  **  ((4) # Ptr  |-> 0)
  **  ((0) # Int  |-> 2)
  **  ((p_pre) # Int  |-> 1)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> p_pre)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition sample_safety_wit_9 := 
forall (p_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (p_pre <> 0)) ,
  ((( &( "p_spec_436" ) )) # Ptr  |-> y)
  **  (((p_pre + 4 )) # Ptr  |-> y)
  **  (((y + 4 )) # Ptr  |-> 0)
  **  ((y) # Int  |-> 2)
  **  ((p_pre) # Int  |-> 1)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> p_pre)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition sample_safety_wit_10 := 
forall (p_pre: Z) (PreH1 : (p_pre = 0)) ,
  ((( &( "p_spec_410" ) )) # Ptr  |-> 0)
  **  (sll 0 (cons (1) ((cons (2) ((@nil Z))))) )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition sample_safety_wit_11 := 
forall (p_pre: Z) ,
  ((( &( "p_spec_410" ) )) # Ptr  |-> p_pre)
  **  (sll p_pre (cons (1) ((cons (2) ((@nil Z))))) )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition sample_return_wit_1 := 
forall (p_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (p_pre <> 0)) ,
  (((p_pre + 4 )) # Ptr  |-> y)
  **  (((y + 4 )) # Ptr  |-> 0)
  **  ((y) # Int  |-> 2)
  **  ((p_pre) # Int  |-> 1)
|--
  “ (2 = 2) ”
  &&  (sll p_pre (cons (1) ((cons (2) ((@nil Z))))) )
.

Definition sample_return_wit_2 := 
(
forall (p_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y = 0)) (PreH2 : (y_2 = 0)) (PreH3 : (p_pre <> 0)) ,
  (((p_pre + 4 )) # Ptr  |-> 0)
  **  ((4) # Ptr  |-> 0)
  **  ((0) # Int  |-> 2)
  **  ((p_pre) # Int  |-> 1)
|--
  “ (1 = 2) ”
  &&  (sll p_pre (cons (1) ((cons (2) ((@nil Z))))) )
) \/
(
forall (p_pre: Z) (y: Z) (y_2: Z) (PreH1 : (2 <= INT_MAX)) (PreH2 : (2 >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (p_pre <> 0)) ,
  ((4) # Ptr  |-> 0)
  **  ((0) # Int  |-> 2)
|--
  “ ((cons (2) ((@nil Z))) = (@nil Z)) ” 
  &&  “ (p_pre <> 0) ” 
  &&  “ (1 = 2) ”
  &&  emp
).

Definition sample_return_wit_2_split_goal_1 := 
forall (p_pre: Z) (y: Z) (y_2: Z) (PreH1 : (2 <= INT_MAX)) (PreH2 : (2 >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (p_pre <> 0)) ,
  ((4) # Ptr  |-> 0)
  **  ((0) # Int  |-> 2)
|--
  “ ((cons (2) ((@nil Z))) = (@nil Z)) ”
.

Definition sample_return_wit_2_split_goal_2 := 
forall (p_pre: Z) (y: Z) (y_2: Z) (PreH1 : (2 <= INT_MAX)) (PreH2 : (2 >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (p_pre <> 0)) ,
  ((4) # Ptr  |-> 0)
  **  ((0) # Int  |-> 2)
|--
  “ (p_pre <> 0) ”
.

Definition sample_return_wit_2_split_goal_3 := 
forall (p_pre: Z) (y: Z) (y_2: Z) (PreH1 : (2 <= INT_MAX)) (PreH2 : (2 >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (p_pre <> 0)) ,
  ((4) # Ptr  |-> 0)
  **  ((0) # Int  |-> 2)
|--
  “ (1 = 2) ”
.

Definition sample_return_wit_2_split_goal_spatial := 
forall (p_pre: Z) (y: Z) (y_2: Z) (PreH1 : (2 <= INT_MAX)) (PreH2 : (2 >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (p_pre <> 0)) ,
  ((4) # Ptr  |-> 0)
  **  ((0) # Int  |-> 2)
|--
  TT && emp 
.

Definition sample_return_wit_3 := 
(
forall (p_pre: Z) (PreH1 : (p_pre = 0)) ,
  (sll 0 (cons (1) ((cons (2) ((@nil Z))))) )
|--
  “ (0 = 2) ”
  &&  (sll p_pre (cons (1) ((cons (2) ((@nil Z))))) )
) \/
(
forall (p_pre: Z) (y: Z) (y_2: Z) (PreH1 : (1 <= INT_MAX)) (PreH2 : (2 <= INT_MAX)) (PreH3 : (1 >= INT_MIN)) (PreH4 : (2 >= INT_MIN)) (PreH5 : (y_2 = 0)) (PreH6 : (p_pre = 0)) ,
  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 2)
  **  ((4) # Ptr  |-> y)
  **  ((0) # Int  |-> 1)
|--
  “ ((cons (1) ((cons (2) ((@nil Z))))) = (@nil Z)) ” 
  &&  “ (0 = 2) ”
  &&  emp
).

Definition sample_return_wit_3_split_goal_1 := 
forall (p_pre: Z) (y: Z) (y_2: Z) (PreH1 : (1 <= INT_MAX)) (PreH2 : (2 <= INT_MAX)) (PreH3 : (1 >= INT_MIN)) (PreH4 : (2 >= INT_MIN)) (PreH5 : (y_2 = 0)) (PreH6 : (p_pre = 0)) ,
  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 2)
  **  ((4) # Ptr  |-> y)
  **  ((0) # Int  |-> 1)
|--
  “ ((cons (1) ((cons (2) ((@nil Z))))) = (@nil Z)) ”
.

Definition sample_return_wit_3_split_goal_2 := 
forall (p_pre: Z) (y: Z) (y_2: Z) (PreH1 : (1 <= INT_MAX)) (PreH2 : (2 <= INT_MAX)) (PreH3 : (1 >= INT_MIN)) (PreH4 : (2 >= INT_MIN)) (PreH5 : (y_2 = 0)) (PreH6 : (p_pre = 0)) ,
  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 2)
  **  ((4) # Ptr  |-> y)
  **  ((0) # Int  |-> 1)
|--
  “ (0 = 2) ”
.

Definition sample_return_wit_3_split_goal_spatial := 
forall (p_pre: Z) (y: Z) (y_2: Z) (PreH1 : (1 <= INT_MAX)) (PreH2 : (2 <= INT_MAX)) (PreH3 : (1 >= INT_MIN)) (PreH4 : (2 >= INT_MIN)) (PreH5 : (y_2 = 0)) (PreH6 : (p_pre = 0)) ,
  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 2)
  **  ((4) # Ptr  |-> y)
  **  ((0) # Int  |-> 1)
|--
  TT && emp 
.

Definition sample_partial_solve_wit_1 := 
forall (p_pre: Z) (PreH1 : (p_pre <> 0)) ,
  (sll p_pre (cons (1) ((cons (2) ((@nil Z))))) )
|--
  EX (y: Z)  (y_2: Z) ,
  “ (y_2 = 0) ” 
  &&  “ (p_pre <> 0) ”
  &&  (((p_pre + 4 )) # Ptr  |-> y)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 2)
  **  ((p_pre) # Int  |-> 1)
.

Definition sample_precondition_wit_1 :=
exists (p_pre: Z) ,
~ ((  “ ((cons (1) ((cons (2) ((@nil Z))))) = (cons (1) ((cons (2) ((@nil Z)))))) ” 
  &&  “ ((Zlength ((cons (1) ((cons (2) ((@nil Z))))))) <= 100) ”
  &&  (sll p_pre (cons (1) ((cons (2) ((@nil Z))))) )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_sample_safety_wit_1 : sample_safety_wit_1.
Axiom proof_of_sample_safety_wit_2 : sample_safety_wit_2.
Axiom proof_of_sample_safety_wit_3 : sample_safety_wit_3.
Axiom proof_of_sample_safety_wit_4 : sample_safety_wit_4.
Axiom proof_of_sample_safety_wit_5 : sample_safety_wit_5.
Axiom proof_of_sample_safety_wit_6 : sample_safety_wit_6.
Axiom proof_of_sample_safety_wit_7 : sample_safety_wit_7.
Axiom proof_of_sample_safety_wit_8 : sample_safety_wit_8.
Axiom proof_of_sample_safety_wit_9 : sample_safety_wit_9.
Axiom proof_of_sample_safety_wit_10 : sample_safety_wit_10.
Axiom proof_of_sample_safety_wit_11 : sample_safety_wit_11.
Axiom proof_of_sample_return_wit_1 : sample_return_wit_1.
Axiom proof_of_sample_return_wit_2 : sample_return_wit_2.
Axiom proof_of_sample_return_wit_3 : sample_return_wit_3.
Axiom proof_of_sample_partial_solve_wit_1 : sample_partial_solve_wit_1.
Axiom proof_of_sample_precondition_wit_1 : sample_precondition_wit_1.

End VC_Correct.
