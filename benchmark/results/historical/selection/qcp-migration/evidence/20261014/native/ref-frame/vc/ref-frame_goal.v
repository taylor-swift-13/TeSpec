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

(*----- Function refUnsignedInt -----*)

Definition refUnsignedInt_return_wit_1 := 
forall (v_pre: Z) (v0: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (v_pre = v0)) ,
  ((retval) # UInt  |-> v_pre)
|--
  ((retval) # UInt  |-> v0)
.

Definition refUnsignedInt_partial_solve_wit_1 := 
forall (v_pre: Z) (v0: Z) (PreH1 : (v_pre = v0)) ,
  TT && emp 
|--
  “ (v_pre = v0) ”
  &&  emp
.

(*----- Function triple_ref_with_frame -----*)

Definition triple_ref_with_frame_return_wit_1 := 
forall (v_pre: Z) (p__pre: Z) (v0: Z) (old: Z) (retval: Z) (PreH1 : (v_pre = v0)) ,
  ((retval) # UInt  |-> v_pre)
  **  ((p__pre) # UInt  |-> old)
|--
  ((p__pre) # UInt  |-> old)
  **  ((retval) # UInt  |-> v0)
.

Definition triple_ref_with_frame_partial_solve_wit_1_pure := 
forall (v_pre: Z) (p__pre: Z) (v0: Z) (old: Z) (PreH1 : (v_pre = v0)) ,
  ((( &( "p_" ) )) # Ptr  |-> p__pre)
  **  ((( &( "v" ) )) # UInt  |-> v_pre)
  **  ((p__pre) # UInt  |-> old)
|--
  “ (v_pre = v_pre) ”
.

Definition triple_ref_with_frame_partial_solve_wit_1_aux := 
forall (v_pre: Z) (p__pre: Z) (v0: Z) (old: Z) (PreH1 : (v_pre = v0)) ,
  ((p__pre) # UInt  |-> old)
|--
  “ (v_pre = v_pre) ” 
  &&  “ (v_pre = v0) ”
  &&  ((p__pre) # UInt  |-> old)
.

Definition triple_ref_with_frame_partial_solve_wit_1 := triple_ref_with_frame_partial_solve_wit_1_pure -> triple_ref_with_frame_partial_solve_wit_1_aux.

Module Type VC_Correct.

Axiom proof_of_refUnsignedInt_return_wit_1 : refUnsignedInt_return_wit_1.
Axiom proof_of_refUnsignedInt_partial_solve_wit_1 : refUnsignedInt_partial_solve_wit_1.
Axiom proof_of_triple_ref_with_frame_return_wit_1 : triple_ref_with_frame_return_wit_1.
Axiom proof_of_triple_ref_with_frame_partial_solve_wit_1_pure : triple_ref_with_frame_partial_solve_wit_1_pure.
Axiom proof_of_triple_ref_with_frame_partial_solve_wit_1 : triple_ref_with_frame_partial_solve_wit_1.

End VC_Correct.
