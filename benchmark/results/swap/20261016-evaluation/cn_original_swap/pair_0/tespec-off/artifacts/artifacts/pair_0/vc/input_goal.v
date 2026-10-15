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

(*----- Function swap -----*)

Definition swap_return_wit_1 := 
forall (q_pre: Z) (p_pre: Z) (w___tespec_entry: Z) (v___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (q_pre = 8192)) (PreH3 : (v___tespec_entry = 0)) (PreH4 : (w___tespec_entry = 0)) ,
  ((p_pre) # UInt  |-> w___tespec_entry)
  **  ((q_pre) # UInt  |-> v___tespec_entry)
|--
  ((p_pre) # UInt  |-> w___tespec_entry)
  **  ((q_pre) # UInt  |-> v___tespec_entry)
.

Definition swap_precondition_wit_1 :=
exists (q_pre: Z) ,
exists (p_pre: Z) ,
exists (w___tespec_entry: Z) ,
exists (v___tespec_entry: Z) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (q_pre = 8192) ” 
  &&  “ (v___tespec_entry = 0) ” 
  &&  “ (w___tespec_entry = 0) ”
  &&  ((p_pre) # UInt  |-> v___tespec_entry)
  **  ((q_pre) # UInt  |-> w___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_swap_return_wit_1 : swap_return_wit_1.
Axiom proof_of_swap_precondition_wit_1 : swap_precondition_wit_1.

End VC_Correct.
