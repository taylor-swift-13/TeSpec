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
Local Open Scope Z_scope.

(*----- Function main -----*)

Definition main_safety_wit_1 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (retval_3: Z) (two: Z) (PreH1 : (two = 2)) (PreH2 : (retval_3 = 2)) (PreH3 : (one = 1)) (PreH4 : (retval_2 = 1)) (PreH5 : (zero = 0)) (PreH6 : (retval = 0)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "third_spec_448" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (2 * 4)))
  **  ((( &( "two_spec_436" ) )) # Int  |-> 2)
  **  ((( &( "second_spec_429" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (1 * 4)))
  **  ((( &( "one_spec_417" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
|--
  TT && emp 
.

Definition main_safety_wit_2 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (retval_3: Z) (two: Z) (PreH1 : (two = 2)) (PreH2 : (retval_3 = 2)) (PreH3 : (one = 1)) (PreH4 : (retval_2 = 1)) (PreH5 : (zero = 0)) (PreH6 : (retval = 0)) ,
  ((( &( "third_spec_448" ) )) # Ptr  |->_)
  **  ((( &( "two_spec_436" ) )) # Int  |-> 2)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "second_spec_429" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (1 * 4)))
  **  ((( &( "one_spec_417" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
|--
  TT && emp 
.

Definition main_safety_wit_3 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (retval_3: Z) (two: Z) (PreH1 : (two = 2)) (PreH2 : (retval_3 = 2)) (PreH3 : (one = 1)) (PreH4 : (retval_2 = 1)) (PreH5 : (zero = 0)) (PreH6 : (retval = 0)) ,
  ((( &( "third_spec_448" ) )) # Ptr  |->_)
  **  ((( &( "two_spec_436" ) )) # Int  |-> 2)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "second_spec_429" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (1 * 4)))
  **  ((( &( "one_spec_417" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
|--
  TT && emp 
.

Definition main_safety_wit_4 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (PreH1 : (one = 1)) (PreH2 : (retval_2 = 1)) (PreH3 : (zero = 0)) (PreH4 : (retval = 0)) ,
  ((( &( "two_spec_436" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "second_spec_429" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (1 * 4)))
  **  ((( &( "one_spec_417" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
|--
  TT && emp 
.

Definition main_safety_wit_5 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (PreH1 : (one = 1)) (PreH2 : (retval_2 = 1)) (PreH3 : (zero = 0)) (PreH4 : (retval = 0)) ,
  ((( &( "two_spec_436" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "second_spec_429" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (1 * 4)))
  **  ((( &( "one_spec_417" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
|--
  TT && emp 
.

Definition main_safety_wit_6 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (PreH1 : (one = 1)) (PreH2 : (retval_2 = 1)) (PreH3 : (zero = 0)) (PreH4 : (retval = 0)) ,
  ((( &( "second_spec_429" ) )) # Ptr  |->_)
  **  ((( &( "one_spec_417" ) )) # Int  |-> 1)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
|--
  TT && emp 
.

Definition main_safety_wit_7 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (PreH1 : (one = 1)) (PreH2 : (retval_2 = 1)) (PreH3 : (zero = 0)) (PreH4 : (retval = 0)) ,
  ((( &( "second_spec_429" ) )) # Ptr  |->_)
  **  ((( &( "one_spec_417" ) )) # Int  |-> 1)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
|--
  TT && emp 
.

Definition main_safety_wit_8 := 
forall (retval: Z) (zero: Z) (PreH1 : (zero = 0)) (PreH2 : (retval = 0)) ,
  ((( &( "one_spec_417" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
|--
  TT && emp 
.

Definition main_safety_wit_9 := 
forall (retval: Z) (zero: Z) (PreH1 : (zero = 0)) (PreH2 : (retval = 0)) ,
  ((( &( "one_spec_417" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
|--
  TT && emp 
.

Definition main_safety_wit_10 := 
forall (retval: Z) (zero: Z) (PreH1 : (zero = 0)) (PreH2 : (retval = 0)) ,
  ((( &( "first_spec_410" ) )) # Ptr  |->_)
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_11 := 
  ((( &( "zero_spec_398" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_12 := 
  ((( &( "zero_spec_398" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_13 := 
  TT && emp 
|--
  TT && emp 
.

Definition main_safety_wit_14 := 
  TT && emp 
|--
  TT && emp 
.

Definition main_safety_wit_15 := 
  TT && emp 
|--
  TT && emp 
.

Definition main_entail_wit_1 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (retval_3: Z) (two: Z) (PreH1 : (two = 2)) (PreH2 : (retval_3 = 2)) (PreH3 : (one = 1)) (PreH4 : (retval_2 = 1)) (PreH5 : (zero = 0)) (PreH6 : (retval = 0)) ,
  ((( &( "third_spec_448" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (2 * sizeof(INT))))
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (two = 2) ” 
  &&  “ (retval_3 = 2) ” 
  &&  “ (one = 1) ” 
  &&  “ (retval_2 = 1) ” 
  &&  “ (zero = 0) ” 
  &&  “ (retval = 0) ”
  &&  ((( &( "third_spec_448" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (2 * 4)))
  **  (((( &( "a_spec_395" ) ) + (2 * 4))) # Int  |-> 2)
  **  (IntArray.missing_i ( &( "a_spec_395" ) ) 2 0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_2 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (retval_3: Z) (PreH1 : (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : (one = 1)) (PreH3 : (retval_2 = 1)) (PreH4 : (zero = 0)) (PreH5 : (retval = 0)) (PreH6 : ((INT_MIN) <= retval_3)) (PreH7 : (retval_3 <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "two_spec_436" ) )) # Int  |-> retval_3)
|--
  EX (two: Z) ,
  “ (two = 2) ” 
  &&  “ (retval_3 = 2) ” 
  &&  “ (one = 1) ” 
  &&  “ (retval_2 = 1) ” 
  &&  “ (zero = 0) ” 
  &&  “ (retval = 0) ”
  &&  ((( &( "two_spec_436" ) )) # Int  |-> 2)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_3 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (PreH1 : (one = 1)) (PreH2 : (retval_2 = 1)) (PreH3 : (zero = 0)) (PreH4 : (retval = 0)) ,
  ((( &( "second_spec_429" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (1 * sizeof(INT))))
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (one = 1) ” 
  &&  “ (retval_2 = 1) ” 
  &&  “ (zero = 0) ” 
  &&  “ (retval = 0) ”
  &&  ((( &( "second_spec_429" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (1 * 4)))
  **  (((( &( "a_spec_395" ) ) + (1 * 4))) # Int  |-> 1)
  **  (IntArray.missing_i ( &( "a_spec_395" ) ) 1 0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_4 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (PreH1 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : (zero = 0)) (PreH3 : (retval = 0)) (PreH4 : ((INT_MIN) <= retval_2)) (PreH5 : (retval_2 <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "one_spec_417" ) )) # Int  |-> retval_2)
|--
  EX (one: Z) ,
  “ (one = 1) ” 
  &&  “ (retval_2 = 1) ” 
  &&  “ (zero = 0) ” 
  &&  “ (retval = 0) ”
  &&  ((( &( "one_spec_417" ) )) # Int  |-> 1)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_5 := 
(
forall (retval: Z) (zero: Z) (PreH1 : (zero = 0)) (PreH2 : (retval = 0)) ,
  ((( &( "first_spec_410" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * sizeof(INT))))
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (zero = 0) ” 
  &&  “ (retval = 0) ”
  &&  ((( &( "first_spec_410" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * 4)))
  **  (((( &( "a_spec_395" ) ) + (0 * 4))) # Int  |-> 0)
  **  (IntArray.missing_i ( &( "a_spec_395" ) ) 0 0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
) \/
(
forall (retval: Z) (zero: Z) (PreH1 : (zero = 0)) (PreH2 : (retval = 0)) ,
  TT && emp 
|--
  TT && emp 
).

Definition main_entail_wit_6 := 
forall (retval: Z) (PreH1 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : ((INT_MIN) <= retval)) (PreH3 : (retval <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_398" ) )) # Int  |-> retval)
|--
  EX (zero: Z) ,
  “ (zero = 0) ” 
  &&  “ (retval = 0) ”
  &&  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_return_wit_1 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (retval_3: Z) (two: Z) (PreH1 : (two = 2)) (PreH2 : (retval_3 = 2)) (PreH3 : (one = 1)) (PreH4 : (retval_2 = 1)) (PreH5 : (zero = 0)) (PreH6 : (retval = 0)) ,
  TT && emp 
|--
  “ (0 = 0) ”
  &&  emp
.

Definition main_partial_solve_wit_1_pure := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (PreH1 : (one = 1)) (PreH2 : (retval_2 = 1)) (PreH3 : (zero = 0)) (PreH4 : (retval = 0)) ,
  ((( &( "two_spec_436" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (replace_Znth (1) (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z))))))))) )
  **  ((( &( "second_spec_429" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (1 * 4)))
  **  ((( &( "one_spec_417" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ”
.

Definition main_partial_solve_wit_1_aux := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (PreH1 : (one = 1)) (PreH2 : (retval_2 = 1)) (PreH3 : (zero = 0)) (PreH4 : (retval = 0)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (replace_Znth (1) (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z))))))))) )
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ” 
  &&  “ (one = 1) ” 
  &&  “ (retval_2 = 1) ” 
  &&  “ (zero = 0) ” 
  &&  “ (retval = 0) ”
  &&  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_partial_solve_wit_1 := main_partial_solve_wit_1_pure -> main_partial_solve_wit_1_aux.

Definition main_partial_solve_wit_2_pure := 
forall (retval: Z) (zero: Z) (PreH1 : (zero = 0)) (PreH2 : (retval = 0)) ,
  ((( &( "one_spec_417" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (replace_Znth (0) (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z))))))))) )
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ”
.

Definition main_partial_solve_wit_2_aux := 
forall (retval: Z) (zero: Z) (PreH1 : (zero = 0)) (PreH2 : (retval = 0)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (replace_Znth (0) (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z))))))))) )
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ” 
  &&  “ (zero = 0) ” 
  &&  “ (retval = 0) ”
  &&  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_partial_solve_wit_2 := main_partial_solve_wit_2_pure -> main_partial_solve_wit_2_aux.

Definition main_partial_solve_wit_3_pure := 
  ((( &( "zero_spec_398" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ”
.

Definition main_partial_solve_wit_3_aux := 
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ”
  &&  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_partial_solve_wit_3 := main_partial_solve_wit_3_pure -> main_partial_solve_wit_3_aux.

Definition main_precondition_wit_1 :=
~ ((  TT && emp ) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_main_safety_wit_1 : main_safety_wit_1.
Axiom proof_of_main_safety_wit_2 : main_safety_wit_2.
Axiom proof_of_main_safety_wit_3 : main_safety_wit_3.
Axiom proof_of_main_safety_wit_4 : main_safety_wit_4.
Axiom proof_of_main_safety_wit_5 : main_safety_wit_5.
Axiom proof_of_main_safety_wit_6 : main_safety_wit_6.
Axiom proof_of_main_safety_wit_7 : main_safety_wit_7.
Axiom proof_of_main_safety_wit_8 : main_safety_wit_8.
Axiom proof_of_main_safety_wit_9 : main_safety_wit_9.
Axiom proof_of_main_safety_wit_10 : main_safety_wit_10.
Axiom proof_of_main_safety_wit_11 : main_safety_wit_11.
Axiom proof_of_main_safety_wit_12 : main_safety_wit_12.
Axiom proof_of_main_safety_wit_13 : main_safety_wit_13.
Axiom proof_of_main_safety_wit_14 : main_safety_wit_14.
Axiom proof_of_main_safety_wit_15 : main_safety_wit_15.
Axiom proof_of_main_entail_wit_1 : main_entail_wit_1.
Axiom proof_of_main_entail_wit_2 : main_entail_wit_2.
Axiom proof_of_main_entail_wit_3 : main_entail_wit_3.
Axiom proof_of_main_entail_wit_4 : main_entail_wit_4.
Axiom proof_of_main_entail_wit_5 : main_entail_wit_5.
Axiom proof_of_main_entail_wit_6 : main_entail_wit_6.
Axiom proof_of_main_return_wit_1 : main_return_wit_1.
Axiom proof_of_main_partial_solve_wit_1_pure : main_partial_solve_wit_1_pure.
Axiom proof_of_main_partial_solve_wit_1 : main_partial_solve_wit_1.
Axiom proof_of_main_partial_solve_wit_2_pure : main_partial_solve_wit_2_pure.
Axiom proof_of_main_partial_solve_wit_2 : main_partial_solve_wit_2.
Axiom proof_of_main_partial_solve_wit_3_pure : main_partial_solve_wit_3_pure.
Axiom proof_of_main_partial_solve_wit_3 : main_partial_solve_wit_3.
Axiom proof_of_main_precondition_wit_1 : main_precondition_wit_1.

End VC_Correct.
