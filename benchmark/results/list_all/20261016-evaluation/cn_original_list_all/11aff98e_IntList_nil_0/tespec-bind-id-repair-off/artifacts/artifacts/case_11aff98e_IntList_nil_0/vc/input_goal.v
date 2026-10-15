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
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_nil -----*)

Definition IntList_nil_safety_wit_1 := 
  TT && emp 
|--
  TT && emp 
.

Definition IntList_nil_return_wit_1 := 
  TT && emp 
|--
  (sll 0 (@nil Z) )
.

Definition IntList_nil_precondition_wit_1 :=
~ ((  TT && emp ) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_nil_safety_wit_1 : IntList_nil_safety_wit_1.
Axiom proof_of_IntList_nil_return_wit_1 : IntList_nil_return_wit_1.
Axiom proof_of_IntList_nil_precondition_wit_1 : IntList_nil_precondition_wit_1.

End VC_Correct.
