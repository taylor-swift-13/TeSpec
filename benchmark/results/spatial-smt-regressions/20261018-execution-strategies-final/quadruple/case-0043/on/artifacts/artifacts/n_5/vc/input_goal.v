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

(*----- Function quadruple -----*)

Definition quadruple_return_wit_1 := 
forall (n_pre: Z) (PreH1 : (n_pre = 3221225472)) (PreH2 : (0 <= n_pre)) (PreH3 : (n_pre <= UINT_MAX)) ,
  TT && emp 
|--
  “ ((unsigned_last_nbits (((unsigned_last_nbits ((n_pre + n_pre )) (32)) + (unsigned_last_nbits ((n_pre + n_pre )) (32)) )) (32)) = ((4 * n_pre ) % ( 4294967296 ) )) ”
  &&  emp
.

Definition quadruple_precondition_wit_1 :=
exists (n_pre: Z) ,
~ ((  “ (n_pre = 3221225472) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ”
  &&  emp) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_quadruple_return_wit_1 : quadruple_return_wit_1.
Axiom proof_of_quadruple_precondition_wit_1 : quadruple_precondition_wit_1.

End VC_Correct.
