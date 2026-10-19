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

(*----- Function sample -----*)

Definition sample_safety_wit_1 := 
  ((( &( "j_spec_392" ) )) # Int  |-> 3)
  **  ((( &( "i_spec_389" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_380" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_2 := 
  ((( &( "j_spec_392" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_389" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_380" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_3 := 
  ((( &( "j_spec_392" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_389" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_380" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_4 := 
  ((( &( "j_spec_392" ) )) # Int  |->_)
  **  ((( &( "i_spec_389" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_380" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_5 := 
  ((( &( "i_spec_389" ) )) # Int  |->_)
  **  ((( &( "n_spec_380" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_6 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_392" ) )) # Int  |-> 0)
  **  ((( &( "i_spec_389" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_380" ) )) # Int  |-> 3)
|--
  “ False ”
.

Definition sample_safety_wit_7 := 
  ((( &( "p_spec_397" ) )) # Ptr  |-> ( &( "j_spec_392" ) ))
  **  ((( &( "j_spec_392" ) )) # Int  |-> 0)
  **  ((( &( "i_spec_389" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_380" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_8 := 
  ((( &( "p_spec_397" ) )) # Ptr  |-> ( &( "j_spec_392" ) ))
  **  ((( &( "j_spec_392" ) )) # Int  |-> 0)
  **  ((( &( "i_spec_389" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_380" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_9 := 
  ((( &( "j_spec_392" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_389" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_380" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_10 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_392" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_389" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_380" ) )) # Int  |-> 3)
|--
  “ False ”
.

Definition sample_safety_wit_11 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_392" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_389" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_380" ) )) # Int  |-> 3)
|--
  “ False ”
.

Definition sample_safety_wit_12 := 
  ((( &( "p_spec_402" ) )) # Ptr  |-> ( &( "j_spec_392" ) ))
  **  ((( &( "j_spec_392" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_389" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_380" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_13 := 
  ((( &( "p_spec_402" ) )) # Ptr  |-> ( &( "j_spec_392" ) ))
  **  ((( &( "j_spec_392" ) )) # Int  |-> 1)
  **  ((( &( "i_spec_389" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_380" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_14 := 
  ((( &( "j_spec_392" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_389" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_380" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_15 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_392" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_389" ) )) # Int  |-> 1)
  **  ((( &( "n_spec_380" ) )) # Int  |-> 3)
|--
  “ False ”
.

Definition sample_safety_wit_16 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_392" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_389" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_380" ) )) # Int  |-> 3)
|--
  “ False ”
.

Definition sample_safety_wit_17 := 
  ((( &( "p_spec_407" ) )) # Ptr  |-> ( &( "j_spec_392" ) ))
  **  ((( &( "j_spec_392" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_389" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_380" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_18 := 
  ((( &( "p_spec_407" ) )) # Ptr  |-> ( &( "j_spec_392" ) ))
  **  ((( &( "j_spec_392" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_389" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_380" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_19 := 
  ((( &( "j_spec_392" ) )) # Int  |-> 3)
  **  ((( &( "i_spec_389" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_380" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_20 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_392" ) )) # Int  |-> 3)
  **  ((( &( "i_spec_389" ) )) # Int  |-> 2)
  **  ((( &( "n_spec_380" ) )) # Int  |-> 3)
|--
  “ False ”
.

Definition sample_safety_wit_21 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_392" ) )) # Int  |-> 3)
  **  ((( &( "i_spec_389" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_380" ) )) # Int  |-> 3)
|--
  “ False ”
.

Definition sample_entail_wit_1 := 
forall (n_pre: Z) (PreH1 : (0 < n_pre)) (PreH2 : (n_pre = 3)) (PreH3 : (0 <= n_pre)) (PreH4 : (n_pre <= 4096)) ,
  TT && emp 
|--
  EX (retval: Z) ,
  “ (retval = (0 + 1 )) ” 
  &&  “ (retval = (0 + 1 )) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (n_pre = 3) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= 4096) ”
  &&  emp
.

Definition sample_entail_wit_2 := 
forall (n_pre: Z) (PreH1 : ((0 + 1 ) < n_pre)) (PreH2 : ((0 + 1 ) < 4)) (PreH3 : (0 < n_pre)) (PreH4 : (n_pre = 3)) (PreH5 : (0 <= n_pre)) (PreH6 : (n_pre <= 4096)) ,
  TT && emp 
|--
  EX (retval: Z) ,
  “ (retval = ((0 + 1 ) + 1 )) ” 
  &&  “ (retval = ((0 + 1 ) + 1 )) ” 
  &&  “ ((0 + 1 ) < n_pre) ” 
  &&  “ ((0 + 1 ) < 4) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (n_pre = 3) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= 4096) ”
  &&  emp
.

Definition sample_entail_wit_3 := 
forall (n_pre: Z) (PreH1 : (((0 + 1 ) + 1 ) < n_pre)) (PreH2 : (((0 + 1 ) + 1 ) < 4)) (PreH3 : ((0 + 1 ) < n_pre)) (PreH4 : ((0 + 1 ) < 4)) (PreH5 : (0 < n_pre)) (PreH6 : (n_pre = 3)) (PreH7 : (0 <= n_pre)) (PreH8 : (n_pre <= 4096)) ,
  TT && emp 
|--
  EX (retval: Z) ,
  “ (retval = (((0 + 1 ) + 1 ) + 1 )) ” 
  &&  “ (retval = (((0 + 1 ) + 1 ) + 1 )) ” 
  &&  “ (((0 + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((0 + 1 ) + 1 ) < 4) ” 
  &&  “ ((0 + 1 ) < n_pre) ” 
  &&  “ ((0 + 1 ) < 4) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (n_pre = 3) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= 4096) ”
  &&  emp
.

Definition sample_return_wit_1 := 
forall (n_pre: Z) (PreH1 : ((((0 + 1 ) + 1 ) + 1 ) >= n_pre)) (PreH2 : ((((0 + 1 ) + 1 ) + 1 ) < 4)) (PreH3 : (((0 + 1 ) + 1 ) < n_pre)) (PreH4 : (((0 + 1 ) + 1 ) < 4)) (PreH5 : ((0 + 1 ) < n_pre)) (PreH6 : ((0 + 1 ) < 4)) (PreH7 : (0 < n_pre)) (PreH8 : (n_pre = 3)) (PreH9 : (0 <= n_pre)) (PreH10 : (n_pre <= 4096)) ,
  TT && emp 
|--
  “ ((((0 + 1 ) + 1 ) + 1 ) = n_pre) ”
  &&  emp
.

Definition sample_partial_solve_wit_1_pure := 
forall (n_pre: Z) (PreH1 : (0 < n_pre)) (PreH2 : (n_pre = 3)) (PreH3 : (0 <= n_pre)) (PreH4 : (n_pre <= 4096)) ,
  ((( &( "j_spec_392" ) )) # Int  |-> 0)
  **  ((( &( "i_spec_389" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_380" ) )) # Int  |-> n_pre)
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 10) ”
.

Definition sample_partial_solve_wit_1_aux := 
forall (n_pre: Z) (PreH1 : (0 < n_pre)) (PreH2 : (n_pre = 3)) (PreH3 : (0 <= n_pre)) (PreH4 : (n_pre <= 4096)) ,
  TT && emp 
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 10) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (n_pre = 3) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= 4096) ”
  &&  emp
.

Definition sample_partial_solve_wit_1 := sample_partial_solve_wit_1_pure -> sample_partial_solve_wit_1_aux.

Definition sample_partial_solve_wit_2_pure := 
forall (n_pre: Z) (PreH1 : ((0 + 1 ) < n_pre)) (PreH2 : ((0 + 1 ) < 4)) (PreH3 : (0 < n_pre)) (PreH4 : (n_pre = 3)) (PreH5 : (0 <= n_pre)) (PreH6 : (n_pre <= 4096)) ,
  ((( &( "j_spec_392" ) )) # Int  |-> (0 + 1 ))
  **  ((( &( "i_spec_389" ) )) # Int  |-> (0 + 1 ))
  **  ((( &( "n_spec_380" ) )) # Int  |-> n_pre)
|--
  “ (0 <= (0 + 1 )) ” 
  &&  “ ((0 + 1 ) < 10) ”
.

Definition sample_partial_solve_wit_2_aux := 
forall (n_pre: Z) (PreH1 : ((0 + 1 ) < n_pre)) (PreH2 : ((0 + 1 ) < 4)) (PreH3 : (0 < n_pre)) (PreH4 : (n_pre = 3)) (PreH5 : (0 <= n_pre)) (PreH6 : (n_pre <= 4096)) ,
  TT && emp 
|--
  “ (0 <= (0 + 1 )) ” 
  &&  “ ((0 + 1 ) < 10) ” 
  &&  “ ((0 + 1 ) < n_pre) ” 
  &&  “ ((0 + 1 ) < 4) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (n_pre = 3) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= 4096) ”
  &&  emp
.

Definition sample_partial_solve_wit_2 := sample_partial_solve_wit_2_pure -> sample_partial_solve_wit_2_aux.

Definition sample_partial_solve_wit_3_pure := 
forall (n_pre: Z) (PreH1 : (((0 + 1 ) + 1 ) < n_pre)) (PreH2 : (((0 + 1 ) + 1 ) < 4)) (PreH3 : ((0 + 1 ) < n_pre)) (PreH4 : ((0 + 1 ) < 4)) (PreH5 : (0 < n_pre)) (PreH6 : (n_pre = 3)) (PreH7 : (0 <= n_pre)) (PreH8 : (n_pre <= 4096)) ,
  ((( &( "j_spec_392" ) )) # Int  |-> ((0 + 1 ) + 1 ))
  **  ((( &( "i_spec_389" ) )) # Int  |-> ((0 + 1 ) + 1 ))
  **  ((( &( "n_spec_380" ) )) # Int  |-> n_pre)
|--
  “ (0 <= ((0 + 1 ) + 1 )) ” 
  &&  “ (((0 + 1 ) + 1 ) < 10) ”
.

Definition sample_partial_solve_wit_3_aux := 
forall (n_pre: Z) (PreH1 : (((0 + 1 ) + 1 ) < n_pre)) (PreH2 : (((0 + 1 ) + 1 ) < 4)) (PreH3 : ((0 + 1 ) < n_pre)) (PreH4 : ((0 + 1 ) < 4)) (PreH5 : (0 < n_pre)) (PreH6 : (n_pre = 3)) (PreH7 : (0 <= n_pre)) (PreH8 : (n_pre <= 4096)) ,
  TT && emp 
|--
  “ (0 <= ((0 + 1 ) + 1 )) ” 
  &&  “ (((0 + 1 ) + 1 ) < 10) ” 
  &&  “ (((0 + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((0 + 1 ) + 1 ) < 4) ” 
  &&  “ ((0 + 1 ) < n_pre) ” 
  &&  “ ((0 + 1 ) < 4) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (n_pre = 3) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= 4096) ”
  &&  emp
.

Definition sample_partial_solve_wit_3 := sample_partial_solve_wit_3_pure -> sample_partial_solve_wit_3_aux.

Definition sample_precondition_wit_1 :=
exists (n_pre: Z) ,
~ ((  “ (n_pre = 3) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= 4096) ”
  &&  emp) |-- “ False ”).

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
Axiom proof_of_sample_safety_wit_12 : sample_safety_wit_12.
Axiom proof_of_sample_safety_wit_13 : sample_safety_wit_13.
Axiom proof_of_sample_safety_wit_14 : sample_safety_wit_14.
Axiom proof_of_sample_safety_wit_15 : sample_safety_wit_15.
Axiom proof_of_sample_safety_wit_16 : sample_safety_wit_16.
Axiom proof_of_sample_safety_wit_17 : sample_safety_wit_17.
Axiom proof_of_sample_safety_wit_18 : sample_safety_wit_18.
Axiom proof_of_sample_safety_wit_19 : sample_safety_wit_19.
Axiom proof_of_sample_safety_wit_20 : sample_safety_wit_20.
Axiom proof_of_sample_safety_wit_21 : sample_safety_wit_21.
Axiom proof_of_sample_entail_wit_1 : sample_entail_wit_1.
Axiom proof_of_sample_entail_wit_2 : sample_entail_wit_2.
Axiom proof_of_sample_entail_wit_3 : sample_entail_wit_3.
Axiom proof_of_sample_return_wit_1 : sample_return_wit_1.
Axiom proof_of_sample_partial_solve_wit_1_pure : sample_partial_solve_wit_1_pure.
Axiom proof_of_sample_partial_solve_wit_1 : sample_partial_solve_wit_1.
Axiom proof_of_sample_partial_solve_wit_2_pure : sample_partial_solve_wit_2_pure.
Axiom proof_of_sample_partial_solve_wit_2 : sample_partial_solve_wit_2.
Axiom proof_of_sample_partial_solve_wit_3_pure : sample_partial_solve_wit_3_pure.
Axiom proof_of_sample_partial_solve_wit_3 : sample_partial_solve_wit_3.
Axiom proof_of_sample_precondition_wit_1 : sample_precondition_wit_1.

End VC_Correct.
