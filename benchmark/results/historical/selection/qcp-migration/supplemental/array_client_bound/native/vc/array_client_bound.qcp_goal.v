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
Local Open Scope sac.

(*----- Function read -----*)

Definition read_return_wit_1 := 
forall (i_pre: Z) (n_pre: Z) (p_pre: Z) (l: (@list Z)) (PreH1 : (0 <= i_pre)) (PreH2 : (i_pre < n_pre)) ,
  (IntArray.full p_pre n_pre l )
|--
  “ ((Znth i_pre l 0) = (Znth (i_pre) (l) (0))) ”
  &&  (IntArray.full p_pre n_pre l )
.

Definition read_partial_solve_wit_1 := 
forall (i_pre: Z) (n_pre: Z) (p_pre: Z) (l: (@list Z)) (PreH1 : (0 <= i_pre)) (PreH2 : (i_pre < n_pre)) ,
  (IntArray.full p_pre n_pre l )
|--
  “ (0 <= i_pre) ” 
  &&  “ (i_pre < n_pre) ”
  &&  (((p_pre + (i_pre * sizeof(INT)))) # Int  |-> (Znth i_pre l 0))
  **  (IntArray.missing_i p_pre i_pre 0 n_pre l )
.

(*----- Function verify_main -----*)

Definition verify_main_safety_wit_1 := 
forall (a_pre: Z) (a0: Z) (PreH1 : (a_pre = a0)) ,
  ((( &( "zero" ) )) # Int  |->_)
  **  ((( &( "a" ) )) # Ptr  |-> a_pre)
  **  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (3 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 3) ”
.

Definition verify_main_safety_wit_2 := 
forall (a_pre: Z) (a0: Z) (PreH1 : (a_pre = a0)) ,
  ((( &( "zero" ) )) # Int  |->_)
  **  ((( &( "a" ) )) # Ptr  |-> a_pre)
  **  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition verify_main_safety_wit_3 := 
forall (a0: Z) (zero: Z) (PreH1 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) ,
  ((( &( "one" ) )) # Int  |->_)
  **  ((( &( "a" ) )) # Ptr  |-> a0)
  **  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero" ) )) # Int  |-> zero)
  **  ((( &( "first" ) )) # Ptr  |-> a0)
|--
  “ (3 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 3) ”
.

Definition verify_main_safety_wit_4 := 
forall (a0: Z) (zero: Z) (PreH1 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) ,
  ((( &( "one" ) )) # Int  |->_)
  **  ((( &( "a" ) )) # Ptr  |-> a0)
  **  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero" ) )) # Int  |-> zero)
  **  ((( &( "first" ) )) # Ptr  |-> a0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition verify_main_safety_wit_5 := 
forall (a0: Z) (one: Z) (zero: Z) (PreH1 : (one = 1)) ,
  ((( &( "second" ) )) # Ptr  |->_)
  **  ((( &( "a" ) )) # Ptr  |-> a0)
  **  ((( &( "one" ) )) # Int  |-> one)
  **  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero" ) )) # Int  |-> zero)
  **  ((( &( "first" ) )) # Ptr  |-> a0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition verify_main_safety_wit_6 := 
forall (a0: Z) (zero: Z) (one: Z) (second: Z) (PreH1 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH2 : (second = (a0 + 4 ))) ,
  ((( &( "two" ) )) # Int  |->_)
  **  ((( &( "a" ) )) # Ptr  |-> a0)
  **  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero" ) )) # Int  |-> zero)
  **  ((( &( "first" ) )) # Ptr  |-> a0)
  **  ((( &( "one" ) )) # Int  |-> one)
  **  ((( &( "second" ) )) # Ptr  |-> second)
|--
  “ (3 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 3) ”
.

Definition verify_main_safety_wit_7 := 
forall (a0: Z) (zero: Z) (one: Z) (second: Z) (PreH1 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH2 : (second = (a0 + 4 ))) ,
  ((( &( "two" ) )) # Int  |->_)
  **  ((( &( "a" ) )) # Ptr  |-> a0)
  **  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero" ) )) # Int  |-> zero)
  **  ((( &( "first" ) )) # Ptr  |-> a0)
  **  ((( &( "one" ) )) # Int  |-> one)
  **  ((( &( "second" ) )) # Ptr  |-> second)
|--
  “ (2 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 2) ”
.

Definition verify_main_safety_wit_8 := 
forall (a0: Z) (two: Z) (zero: Z) (one: Z) (second: Z) (PreH1 : (two = 2)) (PreH2 : (second = (a0 + 4 ))) ,
  ((( &( "third" ) )) # Ptr  |->_)
  **  ((( &( "a" ) )) # Ptr  |-> a0)
  **  ((( &( "two" ) )) # Int  |-> two)
  **  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero" ) )) # Int  |-> zero)
  **  ((( &( "first" ) )) # Ptr  |-> a0)
  **  ((( &( "one" ) )) # Int  |-> one)
  **  ((( &( "second" ) )) # Ptr  |-> second)
|--
  “ (2 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 2) ”
.

Definition verify_main_safety_wit_9 := 
forall (a0: Z) (zero: Z) (one: Z) (second: Z) (two: Z) (third: Z) (PreH1 : ((Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 2)) (PreH2 : (second = (a0 + 4 ))) (PreH3 : (third = (a0 + 8 ))) ,
  ((( &( "a" ) )) # Ptr  |-> a0)
  **  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero" ) )) # Int  |-> zero)
  **  ((( &( "first" ) )) # Ptr  |-> a0)
  **  ((( &( "one" ) )) # Int  |-> one)
  **  ((( &( "second" ) )) # Ptr  |-> second)
  **  ((( &( "two" ) )) # Int  |-> two)
  **  ((( &( "third" ) )) # Ptr  |-> third)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition verify_main_entail_wit_1 := 
(
forall (a_pre: Z) (a0: Z) (retval: Z) (PreH1 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : (a_pre = a0)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "a" ) )) # Ptr  |-> a_pre)
|--
  “ (retval = 0) ”
  &&  ((( &( "a" ) )) # Ptr  |-> a0)
  **  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
) \/
(
forall (a_pre: Z) (a0: Z) (retval: Z) (PreH1 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : (a_pre = a0)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (retval = 0) ”
  &&  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
).

Definition verify_main_entail_wit_1_split_goal_1 := 
forall (a_pre: Z) (a0: Z) (retval: Z) (PreH1 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : (a_pre = a0)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (retval = 0) ”
.

Definition verify_main_entail_wit_1_split_goal_spatial := 
forall (a_pre: Z) (a0: Z) (retval: Z) (PreH1 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : (a_pre = a0)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_entail_wit_2 := 
(
forall (a0: Z) (zero: Z) (PreH1 : (zero = 0)) ,
  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ”
  &&  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
) \/
(
forall (zero: Z) (PreH1 : (zero = 0)) ,
  TT && emp 
|--
  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ”
  &&  emp
).

Definition verify_main_entail_wit_2_split_goal_1 := 
forall (zero: Z) (PreH1 : (zero = 0)) ,
  ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)
.

Definition verify_main_entail_wit_3 := 
(
forall (a0: Z) (retval: Z) (PreH1 : (retval = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) ,
  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (retval = 1) ”
  &&  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
) \/
(
forall (retval: Z) (PreH1 : (retval = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) ,
  TT && emp 
|--
  “ (retval = 1) ”
  &&  emp
).

Definition verify_main_entail_wit_3_split_goal_1 := 
forall (retval: Z) (PreH1 : (retval = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) ,
  (retval = 1)
.

Definition verify_main_entail_wit_4 := 
(
forall (a0: Z) (one: Z) (PreH1 : (one = 1)) ,
  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1) ” 
  &&  “ ((a0 + (1 * sizeof(INT))) = (a0 + 4 )) ”
  &&  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
) \/
(
forall (one: Z) (PreH1 : (one = 1)) ,
  TT && emp 
|--
  “ ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1) ”
  &&  emp
).

Definition verify_main_entail_wit_4_split_goal_1 := 
forall (one: Z) (PreH1 : (one = 1)) ,
  ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)
.

Definition verify_main_entail_wit_5 := 
(
forall (a0: Z) (second: Z) (retval: Z) (PreH1 : (retval = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH3 : (second = (a0 + 4 ))) ,
  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (retval = 2) ” 
  &&  “ (second = (a0 + 4 )) ”
  &&  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
) \/
(
forall (a0: Z) (second: Z) (retval: Z) (PreH1 : (retval = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH3 : (second = (a0 + 4 ))) ,
  TT && emp 
|--
  “ (retval = 2) ”
  &&  emp
).

Definition verify_main_entail_wit_5_split_goal_1 := 
forall (a0: Z) (second: Z) (retval: Z) (PreH1 : (retval = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH3 : (second = (a0 + 4 ))) ,
  (retval = 2)
.

Definition verify_main_entail_wit_6 := 
(
forall (a0: Z) (two: Z) (second: Z) (PreH1 : (two = 2)) (PreH2 : (second = (a0 + 4 ))) ,
  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ ((Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 2) ” 
  &&  “ (second = (a0 + 4 )) ” 
  &&  “ ((a0 + (2 * sizeof(INT))) = (a0 + 8 )) ”
  &&  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
) \/
(
forall (a0: Z) (two: Z) (second: Z) (PreH1 : (two = 2)) (PreH2 : (second = (a0 + 4 ))) ,
  TT && emp 
|--
  “ ((Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 2) ”
  &&  emp
).

Definition verify_main_entail_wit_6_split_goal_1 := 
forall (a0: Z) (two: Z) (second: Z) (PreH1 : (two = 2)) (PreH2 : (second = (a0 + 4 ))) ,
  ((Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 2)
.

Definition verify_main_return_wit_1 := 
forall (a0: Z) (second: Z) (third: Z) (PreH1 : ((Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 2)) (PreH2 : (second = (a0 + 4 ))) (PreH3 : (third = (a0 + 8 ))) ,
  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 = 0) ”
  &&  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_1_pure := 
forall (a_pre: Z) (a0: Z) (PreH1 : (a_pre = a0)) ,
  ((( &( "zero" ) )) # Int  |->_)
  **  ((( &( "a" ) )) # Ptr  |-> a_pre)
  **  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ”
.

Definition verify_main_partial_solve_wit_1_aux := 
forall (a_pre: Z) (a0: Z) (PreH1 : (a_pre = a0)) ,
  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ” 
  &&  “ (a_pre = a0) ”
  &&  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_1 := verify_main_partial_solve_wit_1_pure -> verify_main_partial_solve_wit_1_aux.

Definition verify_main_partial_solve_wit_2_pure := 
forall (a0: Z) (zero: Z) (PreH1 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) ,
  ((( &( "one" ) )) # Int  |->_)
  **  ((( &( "a" ) )) # Ptr  |-> a0)
  **  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero" ) )) # Int  |-> zero)
  **  ((( &( "first" ) )) # Ptr  |-> a0)
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ”
.

Definition verify_main_partial_solve_wit_2_aux := 
forall (a0: Z) (PreH1 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) ,
  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ” 
  &&  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ”
  &&  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_2 := verify_main_partial_solve_wit_2_pure -> verify_main_partial_solve_wit_2_aux.

Definition verify_main_partial_solve_wit_3_pure := 
forall (a0: Z) (zero: Z) (one: Z) (second: Z) (PreH1 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH2 : (second = (a0 + 4 ))) ,
  ((( &( "two" ) )) # Int  |->_)
  **  ((( &( "a" ) )) # Ptr  |-> a0)
  **  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero" ) )) # Int  |-> zero)
  **  ((( &( "first" ) )) # Ptr  |-> a0)
  **  ((( &( "one" ) )) # Int  |-> one)
  **  ((( &( "second" ) )) # Ptr  |-> second)
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ”
.

Definition verify_main_partial_solve_wit_3_aux := 
forall (a0: Z) (second: Z) (PreH1 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH2 : (second = (a0 + 4 ))) ,
  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ” 
  &&  “ ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1) ” 
  &&  “ (second = (a0 + 4 )) ”
  &&  (IntArray.full a0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_3 := verify_main_partial_solve_wit_3_pure -> verify_main_partial_solve_wit_3_aux.

Module Type VC_Correct.

Axiom proof_of_read_return_wit_1 : read_return_wit_1.
Axiom proof_of_read_partial_solve_wit_1 : read_partial_solve_wit_1.
Axiom proof_of_verify_main_safety_wit_1 : verify_main_safety_wit_1.
Axiom proof_of_verify_main_safety_wit_2 : verify_main_safety_wit_2.
Axiom proof_of_verify_main_safety_wit_3 : verify_main_safety_wit_3.
Axiom proof_of_verify_main_safety_wit_4 : verify_main_safety_wit_4.
Axiom proof_of_verify_main_safety_wit_5 : verify_main_safety_wit_5.
Axiom proof_of_verify_main_safety_wit_6 : verify_main_safety_wit_6.
Axiom proof_of_verify_main_safety_wit_7 : verify_main_safety_wit_7.
Axiom proof_of_verify_main_safety_wit_8 : verify_main_safety_wit_8.
Axiom proof_of_verify_main_safety_wit_9 : verify_main_safety_wit_9.
Axiom proof_of_verify_main_entail_wit_1 : verify_main_entail_wit_1.
Axiom proof_of_verify_main_entail_wit_2 : verify_main_entail_wit_2.
Axiom proof_of_verify_main_entail_wit_3 : verify_main_entail_wit_3.
Axiom proof_of_verify_main_entail_wit_4 : verify_main_entail_wit_4.
Axiom proof_of_verify_main_entail_wit_5 : verify_main_entail_wit_5.
Axiom proof_of_verify_main_entail_wit_6 : verify_main_entail_wit_6.
Axiom proof_of_verify_main_return_wit_1 : verify_main_return_wit_1.
Axiom proof_of_verify_main_partial_solve_wit_1_pure : verify_main_partial_solve_wit_1_pure.
Axiom proof_of_verify_main_partial_solve_wit_1 : verify_main_partial_solve_wit_1.
Axiom proof_of_verify_main_partial_solve_wit_2_pure : verify_main_partial_solve_wit_2_pure.
Axiom proof_of_verify_main_partial_solve_wit_2 : verify_main_partial_solve_wit_2.
Axiom proof_of_verify_main_partial_solve_wit_3_pure : verify_main_partial_solve_wit_3_pure.
Axiom proof_of_verify_main_partial_solve_wit_3 : verify_main_partial_solve_wit_3.

End VC_Correct.
