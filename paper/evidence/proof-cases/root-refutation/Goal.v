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
Require Import LeastRoot.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function root_cell -----*)

Definition root_cell_safety_wit_1 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_391" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_388" ) )) # Int  |-> 13)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 13)
|--
  “ ((3 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (3 + 1 )) ”
.

Definition root_cell_safety_wit_2 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_391" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_388" ) )) # Int  |-> 13)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 13)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition root_cell_safety_wit_3 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_391" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_388" ) )) # Int  |-> 13)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 13)
|--
  “ ((2 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (2 + 1 )) ”
.

Definition root_cell_safety_wit_4 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_391" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_388" ) )) # Int  |-> 13)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 13)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition root_cell_safety_wit_5 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_391" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_388" ) )) # Int  |-> 13)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 13)
|--
  “ ((1 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 + 1 )) ”
.

Definition root_cell_safety_wit_6 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_391" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_388" ) )) # Int  |-> 13)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 13)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition root_cell_safety_wit_7 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_391" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_388" ) )) # Int  |-> 13)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 13)
|--
  “ ((0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (0 + 1 )) ”
.

Definition root_cell_safety_wit_8 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_391" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_388" ) )) # Int  |-> 13)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 13)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition root_cell_safety_wit_9 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_391" ) )) # Int  |->_)
  **  ((( &( "n_spec_388" ) )) # Int  |-> 13)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 13)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition root_cell_safety_wit_10 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_391" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_388" ) )) # Int  |-> 13)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 13)
|--
  “ ((0 * 0 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (0 * 0 )) ”
.

Definition root_cell_safety_wit_11 := 
forall (p_pre: Z) (PreH1 : ((0 * 0 ) >= 13)) ,
  ((( &( "r_spec_391" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_388" ) )) # Int  |-> 13)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 13)
|--
  “ False ”
.

Definition root_cell_safety_wit_12 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_391" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_388" ) )) # Int  |-> 13)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 13)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition root_cell_safety_wit_13 := 
forall (p_pre: Z) (PreH1 : ((1 * 1 ) >= 13)) ,
  ((( &( "r_spec_391" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_388" ) )) # Int  |-> 13)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 13)
|--
  “ False ”
.

Definition root_cell_safety_wit_14 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_391" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_388" ) )) # Int  |-> 13)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 13)
|--
  “ ((2 * 2 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (2 * 2 )) ”
.

Definition root_cell_safety_wit_15 := 
forall (p_pre: Z) (PreH1 : ((2 * 2 ) >= 13)) ,
  ((( &( "r_spec_391" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_388" ) )) # Int  |-> 13)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 13)
|--
  “ False ”
.

Definition root_cell_safety_wit_16 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_391" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_388" ) )) # Int  |-> 13)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 13)
|--
  “ ((3 * 3 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (3 * 3 )) ”
.

Definition root_cell_safety_wit_17 := 
forall (p_pre: Z) (PreH1 : ((3 * 3 ) >= 13)) ,
  ((( &( "r_spec_391" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_388" ) )) # Int  |-> 13)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 13)
|--
  “ False ”
.

Definition root_cell_safety_wit_18 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_391" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_388" ) )) # Int  |-> 13)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 13)
|--
  “ ((4 * 4 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (4 * 4 )) ”
.

Definition root_cell_safety_wit_19 := 
forall (p_pre: Z) (PreH1 : ((4 * 4 ) < 13)) ,
  ((( &( "r_spec_391" ) )) # Int  |-> 4)
  **  ((( &( "n_spec_388" ) )) # Int  |-> 13)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 13)
|--
  “ False ”
.

Definition root_cell_entail_wit_1 := 
(
forall (p_pre: Z) ,
  ((p_pre) # Int  |-> 13)
|--
  “ (least_root 13 3 ) ”
  &&  ((p_pre) # Int  |-> 13)
) \/
(
  TT && emp 
|--
  “ (least_root 13 3 ) ”
  &&  emp
).

Definition root_cell_entail_wit_1_split_goal_1 := 
  (least_root 13 3 )
.

Definition root_cell_entail_wit_2 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_391" ) )) # Int  |-> 4)
  **  ((p_pre) # Int  |-> 13)
|--
  (EX (r: Z) ,
  “ (r = 0) ”
  &&  ((( &( "r_spec_391" ) )) # Int  |-> 0)
  **  ((p_pre) # Int  |-> 13))
  ||
  (((( &( "r_spec_391" ) )) # Int  |-> 4)
  **  ((p_pre) # Int  |-> 13))
.

Definition root_cell_entail_wit_3 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_391" ) )) # Int  |-> 3)
  **  ((p_pre) # Int  |-> 13)
|--
  (EX (r: Z) ,
  “ (r = 0) ”
  &&  ((( &( "r_spec_391" ) )) # Int  |-> 0)
  **  ((p_pre) # Int  |-> 13))
  ||
  (((( &( "r_spec_391" ) )) # Int  |-> 3)
  **  ((p_pre) # Int  |-> 13))
.

Definition root_cell_entail_wit_4 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_391" ) )) # Int  |-> 2)
  **  ((p_pre) # Int  |-> 13)
|--
  (EX (r: Z) ,
  “ (r = 0) ”
  &&  ((( &( "r_spec_391" ) )) # Int  |-> 0)
  **  ((p_pre) # Int  |-> 13))
  ||
  (((( &( "r_spec_391" ) )) # Int  |-> 2)
  **  ((p_pre) # Int  |-> 13))
.

Definition root_cell_entail_wit_5 := 
forall (p_pre: Z) ,
  ((( &( "r_spec_391" ) )) # Int  |-> 1)
  **  ((p_pre) # Int  |-> 13)
|--
  (EX (r: Z) ,
  “ (r = 0) ”
  &&  ((( &( "r_spec_391" ) )) # Int  |-> 0)
  **  ((p_pre) # Int  |-> 13))
  ||
  (((( &( "r_spec_391" ) )) # Int  |-> 1)
  **  ((p_pre) # Int  |-> 13))
.

Definition root_cell_entail_wit_6 := 
forall (p_pre: Z) ,
  ((p_pre) # Int  |-> 13)
|--
  (((p_pre) # Int  |-> 13))
  ||
  (((p_pre) # Int  |-> 13))
.

Definition root_cell_return_wit_1 := 
(
forall (p_pre: Z) ,
  ((p_pre) # Int  |-> 4)
|--
  “ (least_root 13 4 ) ”
  &&  ((p_pre) # Int  |-> 4)
) \/
(
  TT && emp 
|--
  “ (least_root 13 4 ) ”
  &&  emp
).

Definition root_cell_return_wit_1_split_goal_1 := 
  (least_root 13 4 )
.

Definition root_cell_precondition_wit_1 :=
exists (p_pre: Z) ,
~ ((  “ (13 = 13) ” 
  &&  “ (0 <= 13) ” 
  &&  “ (13 <= 100) ”
  &&  ((p_pre) # Int  |-> 13)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_root_cell_safety_wit_1 : root_cell_safety_wit_1.
Axiom proof_of_root_cell_safety_wit_2 : root_cell_safety_wit_2.
Axiom proof_of_root_cell_safety_wit_3 : root_cell_safety_wit_3.
Axiom proof_of_root_cell_safety_wit_4 : root_cell_safety_wit_4.
Axiom proof_of_root_cell_safety_wit_5 : root_cell_safety_wit_5.
Axiom proof_of_root_cell_safety_wit_6 : root_cell_safety_wit_6.
Axiom proof_of_root_cell_safety_wit_7 : root_cell_safety_wit_7.
Axiom proof_of_root_cell_safety_wit_8 : root_cell_safety_wit_8.
Axiom proof_of_root_cell_safety_wit_9 : root_cell_safety_wit_9.
Axiom proof_of_root_cell_safety_wit_10 : root_cell_safety_wit_10.
Axiom proof_of_root_cell_safety_wit_11 : root_cell_safety_wit_11.
Axiom proof_of_root_cell_safety_wit_12 : root_cell_safety_wit_12.
Axiom proof_of_root_cell_safety_wit_13 : root_cell_safety_wit_13.
Axiom proof_of_root_cell_safety_wit_14 : root_cell_safety_wit_14.
Axiom proof_of_root_cell_safety_wit_15 : root_cell_safety_wit_15.
Axiom proof_of_root_cell_safety_wit_16 : root_cell_safety_wit_16.
Axiom proof_of_root_cell_safety_wit_17 : root_cell_safety_wit_17.
Axiom proof_of_root_cell_safety_wit_18 : root_cell_safety_wit_18.
Axiom proof_of_root_cell_safety_wit_19 : root_cell_safety_wit_19.
Axiom proof_of_root_cell_entail_wit_1 : root_cell_entail_wit_1.
Axiom proof_of_root_cell_entail_wit_2 : root_cell_entail_wit_2.
Axiom proof_of_root_cell_entail_wit_3 : root_cell_entail_wit_3.
Axiom proof_of_root_cell_entail_wit_4 : root_cell_entail_wit_4.
Axiom proof_of_root_cell_entail_wit_5 : root_cell_entail_wit_5.
Axiom proof_of_root_cell_entail_wit_6 : root_cell_entail_wit_6.
Axiom proof_of_root_cell_return_wit_1 : root_cell_return_wit_1.
Axiom proof_of_root_cell_precondition_wit_1 : root_cell_precondition_wit_1.

End VC_Correct.
