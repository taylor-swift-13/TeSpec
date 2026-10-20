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

(*----- Function transfer -----*)

Definition transfer_safety_wit_1 := 
  ((( &( "s_spec_389" ) )) # UInt  |-> 4294967292)
  **  ((( &( "m_spec_386" ) )) # UInt  |-> 4294967294)
  **  ((( &( "n_spec_383" ) )) # UInt  |-> 4294967294)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "q_spec_371" ) )) # Ptr  |-> 4096)
  **  ((4096) # UInt  |-> 4294967292)
|--
  TT && emp 
.

Definition transfer_return_wit_1 := 
forall (q_pre: Z) (p_pre: Z) (v___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (q_pre = 4096)) (PreH3 : (v___tespec_entry = 4294967294)) (PreH4 : (0 <= v___tespec_entry)) (PreH5 : (v___tespec_entry <= UINT_MAX)) (PreH6 : (p_pre = q_pre)) ,
  ((p_pre) # UInt  |-> 0)
|--
  ((p_pre) # UInt  |-> 0)
.

Definition transfer_precondition_wit_1 :=
exists (q_pre: Z) ,
exists (p_pre: Z) ,
exists (v___tespec_entry: Z) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (q_pre = 4096) ” 
  &&  “ (v___tespec_entry = 4294967294) ” 
  &&  “ (0 <= v___tespec_entry) ” 
  &&  “ (v___tespec_entry <= UINT_MAX) ” 
  &&  “ (p_pre = q_pre) ”
  &&  ((p_pre) # UInt  |-> v___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_transfer_safety_wit_1 : transfer_safety_wit_1.
Axiom proof_of_transfer_return_wit_1 : transfer_return_wit_1.
Axiom proof_of_transfer_precondition_wit_1 : transfer_precondition_wit_1.

End VC_Correct.
