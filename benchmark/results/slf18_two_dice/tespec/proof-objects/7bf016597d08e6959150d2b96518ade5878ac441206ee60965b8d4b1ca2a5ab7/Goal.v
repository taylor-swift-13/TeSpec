From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function two_dice -----*)

Definition two_dice_safety_wit_1 :=
forall (retval: Z) (retval_2: Z) (PreH1 : (0 <= retval_2)) (PreH2 : (retval_2 <= INT_MAX)) (PreH3 : (0 <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) (PreH7 : ((INT_MIN) <= retval_2)) (PreH8 : (retval_2 <= INT_MAX)),
  ((( &( "s_spec_390" ) )) # UInt  |-> (unsigned_last_nbits (((retval % ( 6 ) ) + (retval_2 % ( 6 ) ) )) (32)))
  **  ((( &( "n2_spec_388" ) )) # UInt  |-> (retval_2 % ( 6 ) ))
  **  ((( &( "n1_spec_386" ) )) # UInt  |-> (retval % ( 6 ) ))
|--
  TT && emp 
.

Definition two_dice_safety_wit_2 :=
forall (retval: Z) (PreH1 : (0 <= retval)) (PreH2 : (retval <= INT_MAX)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)),
  ((( &( "n2_spec_388" ) )) # UInt  |->_)
  **  ((( &( "n1_spec_386" ) )) # UInt  |-> (retval % ( 6 ) ))
|--
  TT && emp 
.

Definition two_dice_safety_wit_3 :=
forall (retval: Z) (retval_2: Z) (PreH1 : (0 <= retval_2)) (PreH2 : (retval_2 <= INT_MAX)) (PreH3 : (0 <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) (PreH7 : ((INT_MIN) <= retval_2)) (PreH8 : (retval_2 <= INT_MAX)),
  ((( &( "n_spec_402" ) )) # UInt  |-> 6)
  **  ((( &( "n2_spec_388" ) )) # UInt  |->_)
  **  ((( &( "n1_spec_386" ) )) # UInt  |-> (retval % ( 6 ) ))
|--
  TT && emp 
.

Definition two_dice_safety_wit_4 :=
  ((( &( "n1_spec_386" ) )) # UInt  |->_)
|--
  TT && emp 
.

Definition two_dice_safety_wit_5 :=
forall (retval: Z) (PreH1 : (0 <= retval)) (PreH2 : (retval <= INT_MAX)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)),
  ((( &( "n_spec_395" ) )) # UInt  |-> 6)
  **  ((( &( "n1_spec_386" ) )) # UInt  |->_)
|--
  TT && emp 
.

Definition two_dice_entail_wit_1 :=
(
forall (retval: Z) (retval_3: Z) (PreH1 : (0 <= retval_3)) (PreH2 : (retval_3 <= INT_MAX)) (PreH3 : (0 <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) (PreH7 : ((INT_MIN) <= retval_3)) (PreH8 : (retval_3 <= INT_MAX)),
  TT && emp 
|--
  EX (retval_2: Z),
  “ (retval_2 = (retval_3 % ( 6 ) )) ”
  &&  “ (0 <= retval_2) ”
  &&  “ (retval_2 < 6) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= INT_MAX) ”
  &&  “ ((INT_MIN) <= retval) ”
  &&  “ (retval <= INT_MAX) ”
  &&  emp
) \/
(
forall (retval: Z) (retval_3: Z) (PreH1 : (0 <= retval_3)) (PreH2 : (retval_3 <= INT_MAX)) (PreH3 : (0 <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) (PreH7 : ((INT_MIN) <= retval_3)) (PreH8 : (retval_3 <= INT_MAX)),
  TT && emp 
|--
  “ (0 <= (retval_3 % ( 6 ) )) ”
  &&  “ ((retval_3 % ( 6 ) ) < 6) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= INT_MAX) ”
  &&  “ ((INT_MIN) <= retval) ”
  &&  “ (retval <= INT_MAX) ”
  &&  emp
).

Definition two_dice_entail_wit_1_split_goal_1 :=
forall (retval: Z) (retval_3: Z) (PreH1 : (0 <= retval_3)) (PreH2 : (retval_3 <= INT_MAX)) (PreH3 : (0 <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) (PreH7 : ((INT_MIN) <= retval_3)) (PreH8 : (retval_3 <= INT_MAX)),
  (0 <= (retval_3 % ( 6 ) ))
.

Definition two_dice_entail_wit_1_split_goal_2 :=
forall (retval: Z) (retval_3: Z) (PreH1 : (0 <= retval_3)) (PreH2 : (retval_3 <= INT_MAX)) (PreH3 : (0 <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) (PreH7 : ((INT_MIN) <= retval_3)) (PreH8 : (retval_3 <= INT_MAX)),
  ((retval_3 % ( 6 ) ) < 6)
.

Definition two_dice_entail_wit_1_split_goal_3 :=
forall (retval: Z) (retval_3: Z) (PreH1 : (0 <= retval_3)) (PreH2 : (retval_3 <= INT_MAX)) (PreH3 : (0 <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) (PreH7 : ((INT_MIN) <= retval_3)) (PreH8 : (retval_3 <= INT_MAX)),
  (0 <= retval)
.

Definition two_dice_entail_wit_1_split_goal_4 :=
forall (retval: Z) (retval_3: Z) (PreH1 : (0 <= retval_3)) (PreH2 : (retval_3 <= INT_MAX)) (PreH3 : (0 <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) (PreH7 : ((INT_MIN) <= retval_3)) (PreH8 : (retval_3 <= INT_MAX)),
  (retval <= INT_MAX)
.

Definition two_dice_entail_wit_1_split_goal_5 :=
forall (retval: Z) (retval_3: Z) (PreH1 : (0 <= retval_3)) (PreH2 : (retval_3 <= INT_MAX)) (PreH3 : (0 <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) (PreH7 : ((INT_MIN) <= retval_3)) (PreH8 : (retval_3 <= INT_MAX)),
  ((INT_MIN) <= retval)
.

Definition two_dice_entail_wit_1_split_goal_6 :=
forall (retval: Z) (retval_3: Z) (PreH1 : (0 <= retval_3)) (PreH2 : (retval_3 <= INT_MAX)) (PreH3 : (0 <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) (PreH7 : ((INT_MIN) <= retval_3)) (PreH8 : (retval_3 <= INT_MAX)),
  (retval <= INT_MAX)
.

Definition two_dice_entail_wit_2 :=
(
forall (retval_2: Z) (PreH1 : (0 <= retval_2)) (PreH2 : (retval_2 <= INT_MAX)) (PreH3 : ((INT_MIN) <= retval_2)) (PreH4 : (retval_2 <= INT_MAX)),
  TT && emp 
|--
  EX (retval: Z),
  “ (retval = (retval_2 % ( 6 ) )) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval < 6) ”
  &&  emp
) \/
(
forall (retval_2: Z) (PreH1 : (0 <= retval_2)) (PreH2 : (retval_2 <= INT_MAX)) (PreH3 : ((INT_MIN) <= retval_2)) (PreH4 : (retval_2 <= INT_MAX)),
  TT && emp 
|--
  “ (0 <= (retval_2 % ( 6 ) )) ”
  &&  “ ((retval_2 % ( 6 ) ) < 6) ”
  &&  emp
).

Definition two_dice_entail_wit_2_split_goal_1 :=
forall (retval_2: Z) (PreH1 : (0 <= retval_2)) (PreH2 : (retval_2 <= INT_MAX)) (PreH3 : ((INT_MIN) <= retval_2)) (PreH4 : (retval_2 <= INT_MAX)),
  (0 <= (retval_2 % ( 6 ) ))
.

Definition two_dice_entail_wit_2_split_goal_2 :=
forall (retval_2: Z) (PreH1 : (0 <= retval_2)) (PreH2 : (retval_2 <= INT_MAX)) (PreH3 : ((INT_MIN) <= retval_2)) (PreH4 : (retval_2 <= INT_MAX)),
  ((retval_2 % ( 6 ) ) < 6)
.

Definition two_dice_return_wit_1 :=
(
forall (retval: Z) (retval_2: Z) (PreH1 : (0 <= retval_2)) (PreH2 : (retval_2 <= INT_MAX)) (PreH3 : (0 <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) (PreH7 : ((INT_MIN) <= retval_2)) (PreH8 : (retval_2 <= INT_MAX)),
  TT && emp 
|--
  “ (2 <= (unsigned_last_nbits (((unsigned_last_nbits (((retval % ( 6 ) ) + (retval_2 % ( 6 ) ) )) (32)) + 2 )) (32))) ”
  &&  “ ((unsigned_last_nbits (((unsigned_last_nbits (((retval % ( 6 ) ) + (retval_2 % ( 6 ) ) )) (32)) + 2 )) (32)) <= 12) ”
  &&  emp
) \/
(
forall (retval: Z) (retval_2: Z) (PreH1 : (0 <= retval_2)) (PreH2 : (retval_2 <= INT_MAX)) (PreH3 : (0 <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) (PreH7 : ((INT_MIN) <= retval_2)) (PreH8 : (retval_2 <= INT_MAX)),
  TT && emp 
|--
  “ (2 <= (unsigned_last_nbits (((unsigned_last_nbits (((retval % ( 6 ) ) + (retval_2 % ( 6 ) ) )) (32)) + 2 )) (32))) ”
  &&  “ ((unsigned_last_nbits (((unsigned_last_nbits (((retval % ( 6 ) ) + (retval_2 % ( 6 ) ) )) (32)) + 2 )) (32)) <= 12) ”
  &&  emp
).

Definition two_dice_return_wit_1_split_goal_1 :=
forall (retval: Z) (retval_2: Z) (PreH1 : (0 <= retval_2)) (PreH2 : (retval_2 <= INT_MAX)) (PreH3 : (0 <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) (PreH7 : ((INT_MIN) <= retval_2)) (PreH8 : (retval_2 <= INT_MAX)),
  (2 <= (unsigned_last_nbits (((unsigned_last_nbits (((retval % ( 6 ) ) + (retval_2 % ( 6 ) ) )) (32)) + 2 )) (32)))
.

Definition two_dice_return_wit_1_split_goal_2 :=
forall (retval: Z) (retval_2: Z) (PreH1 : (0 <= retval_2)) (PreH2 : (retval_2 <= INT_MAX)) (PreH3 : (0 <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) (PreH7 : ((INT_MIN) <= retval_2)) (PreH8 : (retval_2 <= INT_MAX)),
  ((unsigned_last_nbits (((unsigned_last_nbits (((retval % ( 6 ) ) + (retval_2 % ( 6 ) ) )) (32)) + 2 )) (32)) <= 12)
.

Definition two_dice_partial_solve_wit_1_pure :=
forall (retval: Z) (PreH1 : (0 <= retval)) (PreH2 : (retval <= INT_MAX)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)),
  ((( &( "n2_spec_388" ) )) # UInt  |->_)
  **  ((( &( "n1_spec_386" ) )) # UInt  |-> (retval % ( 6 ) ))
|--
  “ (6 = 6) ”
  &&  “ (6 > 0) ”
.

Definition two_dice_partial_solve_wit_1_aux :=
forall (retval: Z) (PreH1 : (0 <= retval)) (PreH2 : (retval <= INT_MAX)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)),
  TT && emp 
|--
  “ (6 = 6) ”
  &&  “ (6 > 0) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= INT_MAX) ”
  &&  “ ((INT_MIN) <= retval) ”
  &&  “ (retval <= INT_MAX) ”
  &&  emp
.

Definition two_dice_partial_solve_wit_1 := two_dice_partial_solve_wit_1_pure -> two_dice_partial_solve_wit_1_aux.

Definition two_dice_partial_solve_wit_2 :=
forall (retval: Z) (PreH1 : (0 <= retval)) (PreH2 : (retval <= INT_MAX)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)),
  TT && emp 
|--
  “ (0 <= retval) ”
  &&  “ (retval <= INT_MAX) ”
  &&  “ ((INT_MIN) <= retval) ”
  &&  “ (retval <= INT_MAX) ”
  &&  emp
.

Definition two_dice_partial_solve_wit_3_pure :=
  ((( &( "n1_spec_386" ) )) # UInt  |->_)
|--
  “ (6 = 6) ”
  &&  “ (6 > 0) ”
.

Definition two_dice_partial_solve_wit_3_aux :=
  TT && emp 
|--
  “ (6 = 6) ”
  &&  “ (6 > 0) ”
  &&  emp
.

Definition two_dice_partial_solve_wit_3 := two_dice_partial_solve_wit_3_pure -> two_dice_partial_solve_wit_3_aux.

Definition two_dice_partial_solve_wit_4 :=
  TT && emp 
|--
  TT && emp 
.

Definition two_dice_precondition_wit_1 :=
~ ((  TT && emp ) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_two_dice_safety_wit_1 : two_dice_safety_wit_1.
Axiom proof_of_two_dice_safety_wit_2 : two_dice_safety_wit_2.
Axiom proof_of_two_dice_safety_wit_3 : two_dice_safety_wit_3.
Axiom proof_of_two_dice_safety_wit_4 : two_dice_safety_wit_4.
Axiom proof_of_two_dice_safety_wit_5 : two_dice_safety_wit_5.
Axiom proof_of_two_dice_entail_wit_1 : two_dice_entail_wit_1.
Axiom proof_of_two_dice_entail_wit_2 : two_dice_entail_wit_2.
Axiom proof_of_two_dice_return_wit_1 : two_dice_return_wit_1.
Axiom proof_of_two_dice_partial_solve_wit_1_pure : two_dice_partial_solve_wit_1_pure.
Axiom proof_of_two_dice_partial_solve_wit_1 : two_dice_partial_solve_wit_1.
Axiom proof_of_two_dice_partial_solve_wit_2 : two_dice_partial_solve_wit_2.
Axiom proof_of_two_dice_partial_solve_wit_3_pure : two_dice_partial_solve_wit_3_pure.
Axiom proof_of_two_dice_partial_solve_wit_3 : two_dice_partial_solve_wit_3.
Axiom proof_of_two_dice_partial_solve_wit_4 : two_dice_partial_solve_wit_4.
Axiom proof_of_two_dice_precondition_wit_1 : two_dice_precondition_wit_1.

End VC_Correct.
