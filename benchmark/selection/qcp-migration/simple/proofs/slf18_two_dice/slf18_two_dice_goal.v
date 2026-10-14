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

(*----- Function val_rand -----*)

Definition val_rand_safety_wit_1 := 
forall (n_pre: Z) (n0: Z) (retval: Z) (PreH1 : (0 <= retval)) (PreH2 : (retval <= INT_MAX)) (PreH3 : (0 <= n0)) (PreH4 : (n0 <= UINT_MAX)) (PreH5 : (n_pre = n0)) (PreH6 : (n0 > 0)) ,
  ((( &( "n" ) )) # UInt  |-> n_pre)
|--
  “ (n_pre <> 0) ”
.

Definition val_rand_return_wit_1 := 
(
forall (n_pre: Z) (n0: Z) (retval: Z) (PreH1 : (0 <= retval)) (PreH2 : (retval <= INT_MAX)) (PreH3 : (0 <= n0)) (PreH4 : (n0 <= UINT_MAX)) (PreH5 : (n_pre = n0)) (PreH6 : (n0 > 0)) ,
  TT && emp 
|--
  “ (0 <= (retval % ( n_pre ) )) ” 
  &&  “ ((retval % ( n_pre ) ) < n0) ”
  &&  emp
) \/
(
forall (n_pre: Z) (n0: Z) (retval: Z) (PreH1 : (0 <= retval)) (PreH2 : (retval <= INT_MAX)) (PreH3 : (0 <= n0)) (PreH4 : (n0 <= UINT_MAX)) (PreH5 : (n_pre = n0)) (PreH6 : (n0 > 0)) ,
  TT && emp 
|--
  “ ((retval % ( n_pre ) ) < n_pre) ” 
  &&  “ (0 <= (retval % ( n_pre ) )) ”
  &&  emp
).

Definition val_rand_return_wit_1_split_goal_1 := 
forall (n_pre: Z) (n0: Z) (retval: Z) (PreH1 : (0 <= retval)) (PreH2 : (retval <= INT_MAX)) (PreH3 : (0 <= n0)) (PreH4 : (n0 <= UINT_MAX)) (PreH5 : (n_pre = n0)) (PreH6 : (n0 > 0)) ,
  ((retval % ( n_pre ) ) < n_pre)
.

Definition val_rand_return_wit_1_split_goal_2 := 
forall (n_pre: Z) (n0: Z) (retval: Z) (PreH1 : (0 <= retval)) (PreH2 : (retval <= INT_MAX)) (PreH3 : (0 <= n0)) (PreH4 : (n0 <= UINT_MAX)) (PreH5 : (n_pre = n0)) (PreH6 : (n0 > 0)) ,
  (0 <= (retval % ( n_pre ) ))
.

Definition val_rand_partial_solve_wit_1 := 
forall (n_pre: Z) (n0: Z) (PreH1 : (0 <= n0)) (PreH2 : (n0 <= UINT_MAX)) (PreH3 : (n_pre = n0)) (PreH4 : (n0 > 0)) ,
  TT && emp 
|--
  “ (0 <= n0) ” 
  &&  “ (n0 <= UINT_MAX) ” 
  &&  “ (n_pre = n0) ” 
  &&  “ (n0 > 0) ”
  &&  emp
.

(*----- Function two_dice -----*)

Definition two_dice_safety_wit_1 := 
  ((( &( "n1" ) )) # UInt  |->_)
|--
  “ (6 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 6) ”
.

Definition two_dice_safety_wit_2 := 
forall (retval: Z) (PreH1 : (0 <= retval)) (PreH2 : (retval < 6)) ,
  ((( &( "n2" ) )) # UInt  |->_)
  **  ((( &( "n1" ) )) # UInt  |-> retval)
|--
  “ (6 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 6) ”
.

Definition two_dice_safety_wit_3 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (0 <= retval_2)) (PreH2 : (retval_2 < 6)) (PreH3 : (0 <= retval)) (PreH4 : (retval < 6)) ,
  ((( &( "s" ) )) # UInt  |-> (retval + retval_2 ))
  **  ((( &( "n2" ) )) # UInt  |-> retval_2)
  **  ((( &( "n1" ) )) # UInt  |-> retval)
|--
  “ (2 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 2) ”
.

Definition two_dice_return_wit_1 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (0 <= retval_2)) (PreH2 : (retval_2 < 6)) (PreH3 : (0 <= retval)) (PreH4 : (retval < 6)) ,
  TT && emp 
|--
  “ (2 <= ((retval + retval_2 ) + 2 )) ” 
  &&  “ (((retval + retval_2 ) + 2 ) <= 12) ”
  &&  emp
.

Definition two_dice_partial_solve_wit_1_pure := 
  ((( &( "n1" ) )) # UInt  |->_)
|--
  “ (0 <= 6) ” 
  &&  “ (6 <= UINT_MAX) ” 
  &&  “ (6 = 6) ” 
  &&  “ (6 > 0) ”
.

Definition two_dice_partial_solve_wit_1_aux := 
  TT && emp 
|--
  “ (0 <= 6) ” 
  &&  “ (6 <= UINT_MAX) ” 
  &&  “ (6 = 6) ” 
  &&  “ (6 > 0) ”
  &&  emp
.

Definition two_dice_partial_solve_wit_1 := two_dice_partial_solve_wit_1_pure -> two_dice_partial_solve_wit_1_aux.

Definition two_dice_partial_solve_wit_2_pure := 
forall (retval: Z) (PreH1 : (0 <= retval)) (PreH2 : (retval < 6)) ,
  ((( &( "n2" ) )) # UInt  |->_)
  **  ((( &( "n1" ) )) # UInt  |-> retval)
|--
  “ (0 <= 6) ” 
  &&  “ (6 <= UINT_MAX) ” 
  &&  “ (6 = 6) ” 
  &&  “ (6 > 0) ”
.

Definition two_dice_partial_solve_wit_2_aux := 
forall (retval: Z) (PreH1 : (0 <= retval)) (PreH2 : (retval < 6)) ,
  TT && emp 
|--
  “ (0 <= 6) ” 
  &&  “ (6 <= UINT_MAX) ” 
  &&  “ (6 = 6) ” 
  &&  “ (6 > 0) ” 
  &&  “ (0 <= retval) ” 
  &&  “ (retval < 6) ”
  &&  emp
.

Definition two_dice_partial_solve_wit_2 := two_dice_partial_solve_wit_2_pure -> two_dice_partial_solve_wit_2_aux.

Module Type VC_Correct.

Axiom proof_of_val_rand_safety_wit_1 : val_rand_safety_wit_1.
Axiom proof_of_val_rand_return_wit_1 : val_rand_return_wit_1.
Axiom proof_of_val_rand_partial_solve_wit_1 : val_rand_partial_solve_wit_1.
Axiom proof_of_two_dice_safety_wit_1 : two_dice_safety_wit_1.
Axiom proof_of_two_dice_safety_wit_2 : two_dice_safety_wit_2.
Axiom proof_of_two_dice_safety_wit_3 : two_dice_safety_wit_3.
Axiom proof_of_two_dice_return_wit_1 : two_dice_return_wit_1.
Axiom proof_of_two_dice_partial_solve_wit_1_pure : two_dice_partial_solve_wit_1_pure.
Axiom proof_of_two_dice_partial_solve_wit_1 : two_dice_partial_solve_wit_1.
Axiom proof_of_two_dice_partial_solve_wit_2_pure : two_dice_partial_solve_wit_2_pure.
Axiom proof_of_two_dice_partial_solve_wit_2 : two_dice_partial_solve_wit_2.

End VC_Correct.
