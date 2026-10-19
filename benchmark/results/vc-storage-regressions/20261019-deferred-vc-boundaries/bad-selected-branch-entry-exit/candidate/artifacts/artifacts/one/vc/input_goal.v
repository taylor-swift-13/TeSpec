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
  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_2 := 
  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_3 := 
  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  TT && emp 
.

Definition sample_safety_wit_4 := 
forall (PreH1 : False) ,
  ((( &( "n_spec_371" ) )) # Int  |-> 3)
|--
  “ False ”
.

Definition sample_return_wit_1 := 
(
forall (n_pre: Z) (PreH1 : (n_pre < 5)) (PreH2 : (n_pre = 3)) (PreH3 : (0 <= n_pre)) (PreH4 : (n_pre <= 4096)) ,
  TT && emp 
|--
  “ ((n_pre + 1 ) = n_pre) ”
  &&  emp
) \/
(
forall (n_pre: Z) (PreH1 : (n_pre < 5)) (PreH2 : (n_pre = 3)) (PreH3 : (0 <= n_pre)) (PreH4 : (n_pre <= 4096)) ,
  TT && emp 
|--
  “ ((n_pre + 1 ) = n_pre) ”
  &&  emp
).

Definition sample_return_wit_1_split_goal_1 := 
forall (n_pre: Z) (PreH1 : (n_pre < 5)) (PreH2 : (n_pre = 3)) (PreH3 : (0 <= n_pre)) (PreH4 : (n_pre <= 4096)) ,
  ((n_pre + 1 ) = n_pre)
.

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
Axiom proof_of_sample_return_wit_1 : sample_return_wit_1.
Axiom proof_of_sample_precondition_wit_1 : sample_precondition_wit_1.

End VC_Correct.
