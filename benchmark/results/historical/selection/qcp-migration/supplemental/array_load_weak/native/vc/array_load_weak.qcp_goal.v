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
  EX (l2: (@list Z)) ,
  (IntArray.full p_pre n_pre l2 )
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

Module Type VC_Correct.

Axiom proof_of_read_return_wit_1 : read_return_wit_1.
Axiom proof_of_read_partial_solve_wit_1 : read_partial_solve_wit_1.

End VC_Correct.
