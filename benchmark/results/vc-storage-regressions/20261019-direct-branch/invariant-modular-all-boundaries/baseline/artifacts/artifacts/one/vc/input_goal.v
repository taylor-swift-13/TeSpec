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
forall (i: Z) (n: Z) (PreH1 : (n = 4)) (PreH2 : (( &( "n_spec_371" ) ) = 4096)) (PreH3 : (( &( "i_spec_380" ) ) = 8192)) (PreH4 : (i = 3)) ,
  ((8192) # Int  |-> 3)
  **  ((4096) # Int  |-> 4)
|--
  “ ((i + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (i + 1 )) ”
.

Definition sample_safety_wit_2 := 
  ((( &( "i_spec_380" ) )) # Int  |->_)
  **  ((( &( "n_spec_371" ) )) # Int  |-> 4)
|--
  TT && emp 
.

Definition sample_entail_wit_1 := 
forall (n_pre: Z) (i: Z) (n: Z) (PreH1 : (i < n)) (PreH2 : (0 <= i)) (PreH3 : (i <= n)) (PreH4 : (n = n_pre)) (PreH5 : (n_pre = 4)) (PreH6 : (0 <= n_pre)) (PreH7 : (n_pre <= 4096)) (PreH8 : (( &( "n_spec_371" ) ) = 4096)) (PreH9 : (( &( "i_spec_380" ) ) = 8192)) (PreH10 : (i = 3)) ,
  TT && emp 
|--
  “ (0 <= (i + 1 )) ” 
  &&  “ ((i + 1 ) <= n) ” 
  &&  “ (n = n_pre) ” 
  &&  “ (n_pre = 4) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= 4096) ”
  &&  emp
.

Definition sample_entail_wit_2 := 
forall (n_pre: Z) (PreH1 : (n_pre = 4)) (PreH2 : (0 <= n_pre)) (PreH3 : (n_pre <= 4096)) ,
  TT && emp 
|--
  “ (0 <= 0) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre = n_pre) ” 
  &&  “ (n_pre = 4) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= 4096) ”
  &&  emp
.

Definition sample_return_wit_1 := 
forall (n_pre: Z) (i: Z) (n: Z) (PreH1 : (i >= n)) (PreH2 : (0 <= i)) (PreH3 : (i <= n)) (PreH4 : (n = n_pre)) (PreH5 : (n_pre = 4)) (PreH6 : (0 <= n_pre)) (PreH7 : (n_pre <= 4096)) (PreH8 : (( &( "n_spec_371" ) ) = 4096)) (PreH9 : (( &( "i_spec_380" ) ) = 8192)) ,
  TT && emp 
|--
  “ (i = n_pre) ”
  &&  emp
.

Definition sample_precondition_wit_1 :=
exists (n_pre: Z) ,
~ ((  “ (n_pre = 4) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= 4096) ”
  &&  emp) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_sample_safety_wit_1 : sample_safety_wit_1.
Axiom proof_of_sample_safety_wit_2 : sample_safety_wit_2.
Axiom proof_of_sample_entail_wit_1 : sample_entail_wit_1.
Axiom proof_of_sample_entail_wit_2 : sample_entail_wit_2.
Axiom proof_of_sample_return_wit_1 : sample_return_wit_1.
Axiom proof_of_sample_precondition_wit_1 : sample_precondition_wit_1.

End VC_Correct.
