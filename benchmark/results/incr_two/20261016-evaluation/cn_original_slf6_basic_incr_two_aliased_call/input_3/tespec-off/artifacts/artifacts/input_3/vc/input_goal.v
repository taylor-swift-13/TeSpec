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

(*----- Function aliased_call -----*)

Definition aliased_call_safety_wit_1 := 
  ((( &( "m_spec_419" ) )) # UInt  |->_)
  **  ((( &( "n_spec_416" ) )) # UInt  |-> 4294967294)
  **  ((( &( "p_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "q_spec_401" ) )) # Ptr  |-> 4096)
  **  ((( &( "p_spec_400" ) )) # Ptr  |-> 4096)
  **  ((( &( "p_spec_390" ) )) # Ptr  |-> 4096)
  **  ((4096) # UInt  |-> 4294967294)
|--
  TT && emp 
.

Definition aliased_call_safety_wit_2 := 
  ((( &( "m_spec_410" ) )) # UInt  |->_)
  **  ((( &( "n_spec_407" ) )) # UInt  |-> 4294967293)
  **  ((( &( "p_spec_404" ) )) # Ptr  |-> 4096)
  **  ((( &( "q_spec_401" ) )) # Ptr  |-> 4096)
  **  ((( &( "p_spec_400" ) )) # Ptr  |-> 4096)
  **  ((( &( "p_spec_390" ) )) # Ptr  |-> 4096)
  **  ((4096) # UInt  |-> 4294967293)
|--
  TT && emp 
.

Definition aliased_call_entail_wit_1 := 
forall (p_pre: Z) (v___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (v___tespec_entry = 4294967293)) (PreH3 : (0 <= v___tespec_entry)) (PreH4 : (v___tespec_entry <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> ((v___tespec_entry + 1 ) + 1 ))
|--
  “ (p_pre = 4096) ” 
  &&  “ (v___tespec_entry = 4294967293) ” 
  &&  “ (0 <= v___tespec_entry) ” 
  &&  “ (v___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> (((v___tespec_entry + 1 ) + 1 ) % ( 4294967296 ) ))
.

Definition aliased_call_entail_wit_2 := 
forall (p_pre: Z) (v___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (v___tespec_entry = 4294967293)) (PreH3 : (0 <= v___tespec_entry)) (PreH4 : (v___tespec_entry <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> (v___tespec_entry + 1 ))
|--
  “ (p_pre = 4096) ” 
  &&  “ (v___tespec_entry = 4294967293) ” 
  &&  “ (0 <= v___tespec_entry) ” 
  &&  “ (v___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> ((v___tespec_entry + 1 ) % ( 4294967296 ) ))
.

Definition aliased_call_entail_wit_3 := 
forall (p_pre: Z) (v___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (v___tespec_entry = 4294967293)) (PreH3 : (0 <= v___tespec_entry)) (PreH4 : (v___tespec_entry <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> ((v___tespec_entry + 1 ) + 1 ))
|--
  “ (p_pre = p_pre) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (v___tespec_entry = 4294967293) ” 
  &&  “ (0 <= v___tespec_entry) ” 
  &&  “ (v___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> ((v___tespec_entry + 2 ) % ( 4294967296 ) ))
.

Definition aliased_call_return_wit_1 := 
forall (p_pre: Z) (v___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (v___tespec_entry = 4294967293)) (PreH3 : (0 <= v___tespec_entry)) (PreH4 : (v___tespec_entry <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> ((v___tespec_entry + 1 ) + 1 ))
|--
  ((p_pre) # UInt  |-> ((v___tespec_entry + 2 ) % ( 4294967296 ) ))
.

Definition aliased_call_partial_solve_wit_1_pure := 
forall (p_pre: Z) (v___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (v___tespec_entry = 4294967293)) (PreH3 : (0 <= v___tespec_entry)) (PreH4 : (v___tespec_entry <= UINT_MAX)) ,
  ((( &( "p_spec_390" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # UInt  |-> v___tespec_entry)
|--
  “ (0 <= v___tespec_entry) ” 
  &&  “ (v___tespec_entry <= UINT_MAX) ” 
  &&  “ (p_pre = p_pre) ”
.

Definition aliased_call_partial_solve_wit_1_aux := 
forall (p_pre: Z) (v___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (v___tespec_entry = 4294967293)) (PreH3 : (0 <= v___tespec_entry)) (PreH4 : (v___tespec_entry <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> v___tespec_entry)
|--
  “ (0 <= v___tespec_entry) ” 
  &&  “ (v___tespec_entry <= UINT_MAX) ” 
  &&  “ (p_pre = p_pre) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (v___tespec_entry = 4294967293) ” 
  &&  “ (0 <= v___tespec_entry) ” 
  &&  “ (v___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> v___tespec_entry)
.

Definition aliased_call_partial_solve_wit_1 := aliased_call_partial_solve_wit_1_pure -> aliased_call_partial_solve_wit_1_aux.

Definition aliased_call_partial_solve_wit_2_pure := 
forall (p_pre: Z) (v___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (v___tespec_entry = 4294967293)) (PreH3 : (0 <= v___tespec_entry)) (PreH4 : (v___tespec_entry <= UINT_MAX)) ,
  ((( &( "q_spec_401" ) )) # Ptr  |-> p_pre)
  **  ((( &( "p_spec_400" ) )) # Ptr  |-> p_pre)
  **  ((( &( "p_spec_390" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # UInt  |-> (v___tespec_entry + 1 ))
|--
  “ (0 <= (v___tespec_entry + 1 )) ” 
  &&  “ ((v___tespec_entry + 1 ) <= UINT_MAX) ”
.

Definition aliased_call_partial_solve_wit_2_aux := 
forall (p_pre: Z) (v___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (v___tespec_entry = 4294967293)) (PreH3 : (0 <= v___tespec_entry)) (PreH4 : (v___tespec_entry <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> (v___tespec_entry + 1 ))
|--
  “ (0 <= (v___tespec_entry + 1 )) ” 
  &&  “ ((v___tespec_entry + 1 ) <= UINT_MAX) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (v___tespec_entry = 4294967293) ” 
  &&  “ (0 <= v___tespec_entry) ” 
  &&  “ (v___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> (v___tespec_entry + 1 ))
.

Definition aliased_call_partial_solve_wit_2 := aliased_call_partial_solve_wit_2_pure -> aliased_call_partial_solve_wit_2_aux.

Definition aliased_call_partial_solve_wit_3_pure := 
forall (p_pre: Z) (v___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (v___tespec_entry = 4294967293)) (PreH3 : (0 <= v___tespec_entry)) (PreH4 : (v___tespec_entry <= UINT_MAX)) ,
  ((( &( "q_spec_401" ) )) # Ptr  |-> p_pre)
  **  ((( &( "p_spec_400" ) )) # Ptr  |-> p_pre)
  **  ((( &( "p_spec_390" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # UInt  |-> v___tespec_entry)
|--
  “ (0 <= v___tespec_entry) ” 
  &&  “ (v___tespec_entry <= UINT_MAX) ”
.

Definition aliased_call_partial_solve_wit_3_aux := 
forall (p_pre: Z) (v___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (v___tespec_entry = 4294967293)) (PreH3 : (0 <= v___tespec_entry)) (PreH4 : (v___tespec_entry <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> v___tespec_entry)
|--
  “ (0 <= v___tespec_entry) ” 
  &&  “ (v___tespec_entry <= UINT_MAX) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (v___tespec_entry = 4294967293) ” 
  &&  “ (0 <= v___tespec_entry) ” 
  &&  “ (v___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> v___tespec_entry)
.

Definition aliased_call_partial_solve_wit_3 := aliased_call_partial_solve_wit_3_pure -> aliased_call_partial_solve_wit_3_aux.

Definition aliased_call_precondition_wit_1 :=
exists (p_pre: Z) ,
exists (v___tespec_entry: Z) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (v___tespec_entry = 4294967293) ” 
  &&  “ (0 <= v___tespec_entry) ” 
  &&  “ (v___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> v___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_aliased_call_safety_wit_1 : aliased_call_safety_wit_1.
Axiom proof_of_aliased_call_safety_wit_2 : aliased_call_safety_wit_2.
Axiom proof_of_aliased_call_entail_wit_1 : aliased_call_entail_wit_1.
Axiom proof_of_aliased_call_entail_wit_2 : aliased_call_entail_wit_2.
Axiom proof_of_aliased_call_entail_wit_3 : aliased_call_entail_wit_3.
Axiom proof_of_aliased_call_return_wit_1 : aliased_call_return_wit_1.
Axiom proof_of_aliased_call_partial_solve_wit_1_pure : aliased_call_partial_solve_wit_1_pure.
Axiom proof_of_aliased_call_partial_solve_wit_1 : aliased_call_partial_solve_wit_1.
Axiom proof_of_aliased_call_partial_solve_wit_2_pure : aliased_call_partial_solve_wit_2_pure.
Axiom proof_of_aliased_call_partial_solve_wit_2 : aliased_call_partial_solve_wit_2.
Axiom proof_of_aliased_call_partial_solve_wit_3_pure : aliased_call_partial_solve_wit_3_pure.
Axiom proof_of_aliased_call_partial_solve_wit_3 : aliased_call_partial_solve_wit_3.
Axiom proof_of_aliased_call_precondition_wit_1 : aliased_call_precondition_wit_1.

End VC_Correct.
