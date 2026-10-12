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
Require Import SquareRelation.
Local Open Scope sac.

(*----- Function square_cell -----*)

Definition square_cell_safety_wit_1 := 
forall (p_pre: Z) ,
  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 13)
|--
  “ ((13 * 13 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (13 * 13 )) ”
.

Definition square_cell_return_wit_1 := 
(
forall (p_pre: Z) ,
  ((p_pre) # Int  |-> 169)
|--
  “ (is_square 169 ) ”
  &&  ((p_pre) # Int  |-> 169)
) \/
(
  TT && emp 
|--
  “ (is_square 169 ) ”
  &&  emp
).

Definition square_cell_return_wit_1_split_goal_1 := 
  (is_square 169 )
.

Definition square_cell_precondition_wit_1 :=
exists (p_pre: Z) ,
~ ((  “ (13 = 13) ” 
  &&  “ (0 <= 13) ” 
  &&  “ (13 <= 100) ”
  &&  ((p_pre) # Int  |-> 13)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_square_cell_safety_wit_1 : square_cell_safety_wit_1.
Axiom proof_of_square_cell_return_wit_1 : square_cell_return_wit_1.
Axiom proof_of_square_cell_precondition_wit_1 : square_cell_precondition_wit_1.

End VC_Correct.
