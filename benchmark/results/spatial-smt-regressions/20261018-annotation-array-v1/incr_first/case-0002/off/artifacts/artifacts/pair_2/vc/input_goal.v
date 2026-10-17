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

(*----- Function incr_first -----*)

Definition incr_first_safety_wit_1 := 
  ((( &( "m_spec_410" ) )) # UInt  |->_)
  **  ((( &( "n_spec_407" ) )) # UInt  |-> 0)
  **  ((( &( "p_spec_404" ) )) # Ptr  |-> 4096)
  **  ((( &( "p_spec_382" ) )) # Ptr  |-> 4096)
  **  ((( &( "q_spec_379" ) )) # Ptr  |-> 8192)
  **  ((4096) # UInt  |-> 0)
  **  ((8192) # UInt  |-> 1)
|--
  TT && emp 
.

Definition incr_first_entail_wit_1 := 
forall (q_pre: Z) (p_pre: Z) (w___tespec_entry: Z) (v___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (q_pre = 8192)) (PreH3 : (v___tespec_entry = 0)) (PreH4 : (w___tespec_entry = 1)) (PreH5 : (0 <= v___tespec_entry)) (PreH6 : (v___tespec_entry <= UINT_MAX)) (PreH7 : (0 <= w___tespec_entry)) (PreH8 : (w___tespec_entry <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> (v___tespec_entry + 1 ))
  **  ((q_pre) # UInt  |-> w___tespec_entry)
|--
  “ (p_pre = 4096) ” 
  &&  “ (q_pre = 8192) ” 
  &&  “ (v___tespec_entry = 0) ” 
  &&  “ (w___tespec_entry = 1) ” 
  &&  “ (0 <= v___tespec_entry) ” 
  &&  “ (v___tespec_entry <= UINT_MAX) ” 
  &&  “ (0 <= w___tespec_entry) ” 
  &&  “ (w___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> ((v___tespec_entry + 1 ) % ( 4294967296 ) ))
  **  ((q_pre) # UInt  |-> w___tespec_entry)
.

Definition incr_first_return_wit_1 := 
forall (q_pre: Z) (p_pre: Z) (w___tespec_entry: Z) (v___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (q_pre = 8192)) (PreH3 : (v___tespec_entry = 0)) (PreH4 : (w___tespec_entry = 1)) (PreH5 : (0 <= v___tespec_entry)) (PreH6 : (v___tespec_entry <= UINT_MAX)) (PreH7 : (0 <= w___tespec_entry)) (PreH8 : (w___tespec_entry <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> (v___tespec_entry + 1 ))
  **  ((q_pre) # UInt  |-> w___tespec_entry)
|--
  ((p_pre) # UInt  |-> ((v___tespec_entry + 1 ) % ( 4294967296 ) ))
  **  ((q_pre) # UInt  |-> w___tespec_entry)
.

Definition incr_first_partial_solve_wit_1_pure := 
forall (q_pre: Z) (p_pre: Z) (w___tespec_entry: Z) (v___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (q_pre = 8192)) (PreH3 : (v___tespec_entry = 0)) (PreH4 : (w___tespec_entry = 1)) (PreH5 : (0 <= v___tespec_entry)) (PreH6 : (v___tespec_entry <= UINT_MAX)) (PreH7 : (0 <= w___tespec_entry)) (PreH8 : (w___tespec_entry <= UINT_MAX)) ,
  ((( &( "p_spec_382" ) )) # Ptr  |-> p_pre)
  **  ((( &( "q_spec_379" ) )) # Ptr  |-> q_pre)
  **  ((p_pre) # UInt  |-> v___tespec_entry)
  **  ((q_pre) # UInt  |-> w___tespec_entry)
|--
  “ (0 <= v___tespec_entry) ” 
  &&  “ (v___tespec_entry <= UINT_MAX) ”
.

Definition incr_first_partial_solve_wit_1_aux := 
forall (q_pre: Z) (p_pre: Z) (w___tespec_entry: Z) (v___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (q_pre = 8192)) (PreH3 : (v___tespec_entry = 0)) (PreH4 : (w___tespec_entry = 1)) (PreH5 : (0 <= v___tespec_entry)) (PreH6 : (v___tespec_entry <= UINT_MAX)) (PreH7 : (0 <= w___tespec_entry)) (PreH8 : (w___tespec_entry <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> v___tespec_entry)
  **  ((q_pre) # UInt  |-> w___tespec_entry)
|--
  “ (0 <= v___tespec_entry) ” 
  &&  “ (v___tespec_entry <= UINT_MAX) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (q_pre = 8192) ” 
  &&  “ (v___tespec_entry = 0) ” 
  &&  “ (w___tespec_entry = 1) ” 
  &&  “ (0 <= v___tespec_entry) ” 
  &&  “ (v___tespec_entry <= UINT_MAX) ” 
  &&  “ (0 <= w___tespec_entry) ” 
  &&  “ (w___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> v___tespec_entry)
  **  ((q_pre) # UInt  |-> w___tespec_entry)
.

Definition incr_first_partial_solve_wit_1 := incr_first_partial_solve_wit_1_pure -> incr_first_partial_solve_wit_1_aux.

Definition incr_first_precondition_wit_1 :=
exists (q_pre: Z) ,
exists (p_pre: Z) ,
exists (w___tespec_entry: Z) ,
exists (v___tespec_entry: Z) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (q_pre = 8192) ” 
  &&  “ (v___tespec_entry = 0) ” 
  &&  “ (w___tespec_entry = 1) ” 
  &&  “ (0 <= v___tespec_entry) ” 
  &&  “ (v___tespec_entry <= UINT_MAX) ” 
  &&  “ (0 <= w___tespec_entry) ” 
  &&  “ (w___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> v___tespec_entry)
  **  ((q_pre) # UInt  |-> w___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_incr_first_safety_wit_1 : incr_first_safety_wit_1.
Axiom proof_of_incr_first_entail_wit_1 : incr_first_entail_wit_1.
Axiom proof_of_incr_first_return_wit_1 : incr_first_return_wit_1.
Axiom proof_of_incr_first_partial_solve_wit_1_pure : incr_first_partial_solve_wit_1_pure.
Axiom proof_of_incr_first_partial_solve_wit_1 : incr_first_partial_solve_wit_1.
Axiom proof_of_incr_first_precondition_wit_1 : incr_first_precondition_wit_1.

End VC_Correct.
