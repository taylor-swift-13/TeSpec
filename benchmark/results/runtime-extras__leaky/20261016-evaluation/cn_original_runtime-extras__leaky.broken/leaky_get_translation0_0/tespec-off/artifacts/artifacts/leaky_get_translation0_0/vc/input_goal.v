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

(*----- Function leaky_get -----*)

Definition leaky_get_return_wit_1 := 
(
forall (p_pre: Z) (v___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (v___tespec_entry = 0)) ,
  ((p_pre) # UInt  |-> v___tespec_entry)
|--
  “ (v___tespec_entry = v___tespec_entry) ”
  &&  emp
) \/
(
forall (p_pre: Z) (v___tespec_entry: Z) (PreH1 : (v___tespec_entry <= UINT_MAX)) (PreH2 : (v___tespec_entry >= 0)) (PreH3 : (p_pre = 4096)) (PreH4 : (v___tespec_entry = 0)) ,
  ((p_pre) # UInt  |-> v___tespec_entry)
|--
  TT && emp 
).

Definition leaky_get_return_wit_1_split_goal_spatial := 
forall (p_pre: Z) (v___tespec_entry: Z) (PreH1 : (v___tespec_entry <= UINT_MAX)) (PreH2 : (v___tespec_entry >= 0)) (PreH3 : (p_pre = 4096)) (PreH4 : (v___tespec_entry = 0)) ,
  ((p_pre) # UInt  |-> v___tespec_entry)
|--
  TT && emp 
.

Definition leaky_get_precondition_wit_1 :=
exists (p_pre: Z) ,
exists (v___tespec_entry: Z) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (v___tespec_entry = 0) ”
  &&  ((p_pre) # UInt  |-> v___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_leaky_get_return_wit_1 : leaky_get_return_wit_1.
Axiom proof_of_leaky_get_precondition_wit_1 : leaky_get_precondition_wit_1.

End VC_Correct.
