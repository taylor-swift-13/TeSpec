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

(*----- Function swap -----*)

Definition swap_return_wit_1 := 
forall (q_pre: Z) (p_pre: Z) (w: Z) (v: Z) ,
  ((p_pre) # UInt  |-> w)
  **  ((q_pre) # UInt  |-> v)
|--
  ((p_pre) # UInt  |-> w)
  **  ((q_pre) # UInt  |-> v)
.

(*----- Function transpose2 -----*)

Definition transpose2_return_wit_1 := 
forall (p_pre: Z) (y: Z) (x: Z) ,
  ((&((p_pre)  # "upoint" ->ₛ "x")) # UInt  |-> y)
  **  ((&((p_pre)  # "upoint" ->ₛ "y")) # UInt  |-> x)
|--
  ((&((p_pre)  # "upoint" ->ₛ "x")) # UInt  |-> y)
  **  ((&((p_pre)  # "upoint" ->ₛ "y")) # UInt  |-> x)
.

Definition transpose2_partial_solve_wit_1 := 
forall (p_pre: Z) (y: Z) (x: Z) ,
  ((&((p_pre)  # "upoint" ->ₛ "x")) # UInt  |-> x)
  **  ((&((p_pre)  # "upoint" ->ₛ "y")) # UInt  |-> y)
|--
  ((&((p_pre)  # "upoint" ->ₛ "x")) # UInt  |-> x)
  **  ((&((p_pre)  # "upoint" ->ₛ "y")) # UInt  |-> y)
.

Module Type VC_Correct.

Axiom proof_of_swap_return_wit_1 : swap_return_wit_1.
Axiom proof_of_transpose2_return_wit_1 : transpose2_return_wit_1.
Axiom proof_of_transpose2_partial_solve_wit_1 : transpose2_partial_solve_wit_1.

End VC_Correct.
