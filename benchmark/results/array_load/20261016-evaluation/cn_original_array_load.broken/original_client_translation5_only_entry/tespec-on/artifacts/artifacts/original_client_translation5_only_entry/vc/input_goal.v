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

(*----- Function verify_main -----*)

Definition verify_main_safety_wit_1 := 
  ((( &( "third_spec_497" ) )) # Ptr  |-> 4104)
  **  ((( &( "two_spec_469" ) )) # Int  |-> 2)
  **  ((( &( "second_spec_454" ) )) # Ptr  |-> 4100)
  **  ((( &( "one_spec_430" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_419" ) )) # Ptr  |-> 4096)
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition verify_main_safety_wit_2 := 
  ((( &( "third_spec_497" ) )) # Ptr  |->_)
  **  ((( &( "two_spec_469" ) )) # Int  |-> 2)
  **  ((( &( "second_spec_454" ) )) # Ptr  |-> 4100)
  **  ((( &( "one_spec_430" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_419" ) )) # Ptr  |-> 4096)
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition verify_main_safety_wit_3 := 
  ((( &( "two_spec_469" ) )) # Int  |->_)
  **  ((( &( "second_spec_454" ) )) # Ptr  |-> 4100)
  **  ((( &( "one_spec_430" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_419" ) )) # Ptr  |-> 4096)
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition verify_main_safety_wit_4 := 
  ((( &( "two_spec_469" ) )) # Int  |->_)
  **  ((( &( "second_spec_454" ) )) # Ptr  |-> 4100)
  **  ((( &( "one_spec_430" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_419" ) )) # Ptr  |-> 4096)
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition verify_main_safety_wit_5 := 
  ((( &( "second_spec_454" ) )) # Ptr  |->_)
  **  ((( &( "one_spec_430" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_419" ) )) # Ptr  |-> 4096)
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition verify_main_safety_wit_6 := 
  ((( &( "one_spec_430" ) )) # Int  |->_)
  **  ((( &( "first_spec_419" ) )) # Ptr  |-> 4096)
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition verify_main_safety_wit_7 := 
  ((( &( "one_spec_430" ) )) # Int  |->_)
  **  ((( &( "first_spec_419" ) )) # Ptr  |-> 4096)
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition verify_main_safety_wit_8 := 
  ((( &( "zero_spec_399" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition verify_main_safety_wit_9 := 
  ((( &( "zero_spec_399" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition verify_main_entail_wit_1 := 
(
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
) \/
(
  TT && emp 
|--
  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
).

Definition verify_main_entail_wit_1_split_goal_spatial := 
  TT && emp 
|--
  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
.

Definition verify_main_entail_wit_2 := 
(
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  EX (two: Z) ,
  “ (two = 2) ”
  &&  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  ((( &( "two_spec_469" ) )) # Int  |-> 2)
) \/
(
  TT && emp 
|--
  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  ((( &( "two_spec_469" ) )) # Int  |-> 2)
).

Definition verify_main_entail_wit_2_split_goal_spatial := 
  TT && emp 
|--
  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  ((( &( "two_spec_469" ) )) # Int  |-> 2)
.

Definition verify_main_entail_wit_3 := 
forall (a_pre: Z) (PreH1 : (a_pre = 4096)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  EX (retval: Z) ,
  “ (retval = 2) ” 
  &&  “ (retval = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (a_pre = 4096) ”
  &&  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_entail_wit_4 := 
(
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
) \/
(
  TT && emp 
|--
  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
).

Definition verify_main_entail_wit_4_split_goal_spatial := 
  TT && emp 
|--
  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
.

Definition verify_main_entail_wit_5 := 
(
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  EX (one: Z) ,
  “ (one = 1) ”
  &&  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  ((( &( "one_spec_430" ) )) # Int  |-> 1)
) \/
(
  TT && emp 
|--
  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  ((( &( "one_spec_430" ) )) # Int  |-> 1)
).

Definition verify_main_entail_wit_5_split_goal_spatial := 
  TT && emp 
|--
  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  ((( &( "one_spec_430" ) )) # Int  |-> 1)
.

Definition verify_main_entail_wit_6 := 
forall (a_pre: Z) (PreH1 : (a_pre = 4096)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  EX (retval: Z) ,
  “ (retval = 1) ” 
  &&  “ (retval = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (a_pre = 4096) ”
  &&  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_entail_wit_7 := 
(
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
) \/
(
  TT && emp 
|--
  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
).

Definition verify_main_entail_wit_7_split_goal_spatial := 
  TT && emp 
|--
  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
.

Definition verify_main_entail_wit_8 := 
(
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  EX (zero: Z) ,
  “ (zero = 0) ”
  &&  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
) \/
(
  TT && emp 
|--
  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
).

Definition verify_main_entail_wit_8_split_goal_spatial := 
  TT && emp 
|--
  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
.

Definition verify_main_entail_wit_9 := 
forall (a_pre: Z) (PreH1 : (a_pre = 4096)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  EX (retval: Z) ,
  “ (retval = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (a_pre = 4096) ”
  &&  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_return_wit_1 := 
forall (a_pre: Z) (PreH1 : (a_pre = 4096)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 = 0) ”
  &&  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_1_pure := 
forall (a_pre: Z) (PreH1 : (a_pre = 4096)) ,
  ((( &( "two_spec_469" ) )) # Int  |->_)
  **  ((( &( "second_spec_454" ) )) # Ptr  |-> (a_pre + (1 * sizeof(INT))))
  **  ((( &( "one_spec_430" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_419" ) )) # Ptr  |-> a_pre)
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> a_pre)
  **  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ”
.

Definition verify_main_partial_solve_wit_1_aux := 
forall (a_pre: Z) (PreH1 : (a_pre = 4096)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ” 
  &&  “ (a_pre = 4096) ”
  &&  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_1 := verify_main_partial_solve_wit_1_pure -> verify_main_partial_solve_wit_1_aux.

Definition verify_main_partial_solve_wit_2_pure := 
forall (a_pre: Z) (PreH1 : (a_pre = 4096)) ,
  ((( &( "one_spec_430" ) )) # Int  |->_)
  **  ((( &( "first_spec_419" ) )) # Ptr  |-> a_pre)
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> a_pre)
  **  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ”
.

Definition verify_main_partial_solve_wit_2_aux := 
forall (a_pre: Z) (PreH1 : (a_pre = 4096)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ” 
  &&  “ (a_pre = 4096) ”
  &&  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_2 := verify_main_partial_solve_wit_2_pure -> verify_main_partial_solve_wit_2_aux.

Definition verify_main_partial_solve_wit_3_pure := 
forall (a_pre: Z) (PreH1 : (a_pre = 4096)) ,
  ((( &( "zero_spec_399" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> a_pre)
  **  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ”
.

Definition verify_main_partial_solve_wit_3_aux := 
forall (a_pre: Z) (PreH1 : (a_pre = 4096)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ” 
  &&  “ (a_pre = 4096) ”
  &&  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_3 := verify_main_partial_solve_wit_3_pure -> verify_main_partial_solve_wit_3_aux.

Definition verify_main_precondition_wit_1 :=
exists (a_pre: Z) ,
~ ((  “ (a_pre = 4096) ”
  &&  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )) |-- “ False ”).

Module Type VC_Correct.

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
Axiom proof_of_verify_main_entail_wit_7 : verify_main_entail_wit_7.
Axiom proof_of_verify_main_entail_wit_8 : verify_main_entail_wit_8.
Axiom proof_of_verify_main_entail_wit_9 : verify_main_entail_wit_9.
Axiom proof_of_verify_main_return_wit_1 : verify_main_return_wit_1.
Axiom proof_of_verify_main_partial_solve_wit_1_pure : verify_main_partial_solve_wit_1_pure.
Axiom proof_of_verify_main_partial_solve_wit_1 : verify_main_partial_solve_wit_1.
Axiom proof_of_verify_main_partial_solve_wit_2_pure : verify_main_partial_solve_wit_2_pure.
Axiom proof_of_verify_main_partial_solve_wit_2 : verify_main_partial_solve_wit_2.
Axiom proof_of_verify_main_partial_solve_wit_3_pure : verify_main_partial_solve_wit_3_pure.
Axiom proof_of_verify_main_partial_solve_wit_3 : verify_main_partial_solve_wit_3.
Axiom proof_of_verify_main_precondition_wit_1 : verify_main_precondition_wit_1.

End VC_Correct.
