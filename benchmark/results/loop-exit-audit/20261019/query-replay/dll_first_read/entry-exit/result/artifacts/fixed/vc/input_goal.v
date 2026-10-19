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
Require Import SimpleC.EE.QCP_demos_human.dll_shape_lib.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function sample -----*)

Definition sample_safety_wit_1 := 
forall (PreH1 : False) ,
  ((( &( "p_spec_422" ) )) # Ptr  |-> 4096)
  **  ((( &( "l_spec_413" ) )) # Ptr  |-> 4096)
  **  (dlistrep_shape 4096 0 )
|--
  “ False ”
.

Definition sample_return_wit_1 := 
(
forall (l_pre: Z) (x: Z) (y: Z) (PreH1 : (l_pre = 4096)) (PreH2 : (l_pre <> 0)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (l_pre + 0)) # Ptr  |-> y)
  **  (dlistrep_shape y l_pre )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (l_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (l_pre + 8)) # Int  |-> x)
|--
  (dlistrep_shape l_pre 0 )
) \/
(
forall (l_pre: Z) (PreH1 : (l_pre = 4096)) (PreH2 : (l_pre <> 0)) ,
  TT && emp 
|--
  TT && emp 
).

Definition sample_partial_solve_wit_1 := 
forall (l_pre: Z) (PreH1 : (l_pre = 4096)) (PreH2 : (l_pre <> 0)) ,
  (dlistrep_shape l_pre 0 )
|--
  EX (x: Z)  (y: Z) ,
  “ (l_pre = 4096) ” 
  &&  “ (l_pre <> 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (l_pre + 0)) # Ptr  |-> y)
  **  (dlistrep_shape y l_pre )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (l_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (l_pre + 8)) # Int  |-> x)
.

Definition sample_precondition_wit_1 :=
exists (l_pre: Z) ,
~ ((  “ (l_pre = 4096) ”
  &&  (dlistrep_shape l_pre 0 )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_sample_safety_wit_1 : sample_safety_wit_1.
Axiom proof_of_sample_return_wit_1 : sample_return_wit_1.
Axiom proof_of_sample_partial_solve_wit_1 : sample_partial_solve_wit_1.
Axiom proof_of_sample_precondition_wit_1 : sample_precondition_wit_1.

End VC_Correct.
