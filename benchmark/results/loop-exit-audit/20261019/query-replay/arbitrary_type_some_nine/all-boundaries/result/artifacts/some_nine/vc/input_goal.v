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

(*----- Function arbitrary_type -----*)

Definition arbitrary_type_return_wit_1 := 
forall (n_pre: Z) (value___tespec_entry: (@option Z)) (PreH1 : (n_pre = 5)) (PreH2 : (value___tespec_entry = (Some (9)))) (PreH3 : (n_pre = 5)) (PreH4 : (value___tespec_entry = (Some (9)))) ,
  TT && emp 
|--
  “ (n_pre = n_pre) ” 
  &&  “ (value___tespec_entry = (Some (9))) ”
  &&  emp
.

Definition arbitrary_type_precondition_wit_1 :=
exists (n_pre: Z) ,
exists (value___tespec_entry: (@option Z)) ,
~ ((  “ (n_pre = 5) ” 
  &&  “ (value___tespec_entry = (Some (9))) ” 
  &&  “ (n_pre = 5) ” 
  &&  “ (value___tespec_entry = (Some (9))) ”
  &&  emp) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_arbitrary_type_return_wit_1 : arbitrary_type_return_wit_1.
Axiom proof_of_arbitrary_type_precondition_wit_1 : arbitrary_type_precondition_wit_1.

End VC_Correct.
