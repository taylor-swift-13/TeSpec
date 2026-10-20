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

(*----- Function incr -----*)

Definition incr_safety_wit_1 := 
  ((( &( "m_spec_383" ) )) # UInt  |->_)
  **  ((( &( "n_spec_380" ) )) # UInt  |-> UINT_MAX)
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  ((4096) # UInt  |-> UINT_MAX)
|--
  TT && emp 
.

Definition incr_return_wit_1 := 
forall (p_pre: Z) (v___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (v___tespec_entry = UINT_MAX)) (PreH3 : (0 <= v___tespec_entry)) (PreH4 : (v___tespec_entry <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> (unsigned_last_nbits ((v___tespec_entry + 1 )) (32)))
|--
  ((p_pre) # UInt  |-> ((v___tespec_entry + 1 ) % ( 4294967296 ) ))
.

Definition incr_precondition_wit_1 :=
exists (p_pre: Z) ,
exists (v___tespec_entry: Z) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (v___tespec_entry = UINT_MAX) ” 
  &&  “ (0 <= v___tespec_entry) ” 
  &&  “ (v___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> v___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_incr_safety_wit_1 : incr_safety_wit_1.
Axiom proof_of_incr_return_wit_1 : incr_return_wit_1.
Axiom proof_of_incr_precondition_wit_1 : incr_precondition_wit_1.

End VC_Correct.
