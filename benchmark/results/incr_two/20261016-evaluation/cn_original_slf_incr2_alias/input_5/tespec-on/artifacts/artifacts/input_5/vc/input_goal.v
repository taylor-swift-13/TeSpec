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

(*----- Function call_both -----*)

Definition call_both_safety_wit_1 := 
  ((( &( "m_spec_428" ) )) # UInt  |-> 3)
  **  ((( &( "n_spec_425" ) )) # UInt  |-> 3)
  **  ((( &( "q_spec_422" ) )) # Ptr  |-> 4096)
  **  ((( &( "p_spec_421" ) )) # Ptr  |-> 4096)
  **  ((( &( "p_spec_397" ) )) # Ptr  |-> 4096)
  **  ((( &( "q_spec_394" ) )) # Ptr  |-> 8192)
  **  ((4096) # UInt  |-> 3)
  **  ((8192) # UInt  |-> 0)
|--
  TT && emp 
.

Definition call_both_safety_wit_2 := 
  ((( &( "m_spec_428" ) )) # UInt  |->_)
  **  ((( &( "n_spec_425" ) )) # UInt  |-> 2)
  **  ((( &( "q_spec_422" ) )) # Ptr  |-> 4096)
  **  ((( &( "p_spec_421" ) )) # Ptr  |-> 4096)
  **  ((( &( "p_spec_397" ) )) # Ptr  |-> 4096)
  **  ((( &( "q_spec_394" ) )) # Ptr  |-> 8192)
  **  ((4096) # UInt  |-> 2)
  **  ((8192) # UInt  |-> 0)
|--
  TT && emp 
.

Definition call_both_safety_wit_3 := 
  ((( &( "m_spec_417" ) )) # UInt  |-> 2)
  **  ((( &( "n_spec_414" ) )) # UInt  |-> UINT_MAX)
  **  ((( &( "q_spec_411" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
  **  ((( &( "p_spec_397" ) )) # Ptr  |-> 4096)
  **  ((( &( "q_spec_394" ) )) # Ptr  |-> 8192)
  **  ((4096) # UInt  |-> 2)
  **  ((8192) # UInt  |-> UINT_MAX)
|--
  TT && emp 
.

Definition call_both_safety_wit_4 := 
  ((( &( "m_spec_417" ) )) # UInt  |->_)
  **  ((( &( "n_spec_414" ) )) # UInt  |-> 1)
  **  ((( &( "q_spec_411" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
  **  ((( &( "p_spec_397" ) )) # Ptr  |-> 4096)
  **  ((( &( "q_spec_394" ) )) # Ptr  |-> 8192)
  **  ((4096) # UInt  |-> 1)
  **  ((8192) # UInt  |-> UINT_MAX)
|--
  TT && emp 
.

Definition call_both_entail_wit_1 := 
forall (q_pre: Z) (p_pre: Z) (w___tespec_entry: Z) (v___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (q_pre = 8192)) (PreH3 : (v___tespec_entry = 1)) (PreH4 : (w___tespec_entry = UINT_MAX)) (PreH5 : (0 <= v___tespec_entry)) (PreH6 : (v___tespec_entry <= UINT_MAX)) (PreH7 : (0 <= w___tespec_entry)) (PreH8 : (w___tespec_entry <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> (((v___tespec_entry + 1 ) + 1 ) + 1 ))
  **  ((q_pre) # UInt  |-> (unsigned_last_nbits ((w___tespec_entry + 1 )) (32)))
|--
  “ (p_pre = p_pre) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (q_pre = 8192) ” 
  &&  “ (v___tespec_entry = 1) ” 
  &&  “ (w___tespec_entry = UINT_MAX) ” 
  &&  “ (0 <= v___tespec_entry) ” 
  &&  “ (v___tespec_entry <= UINT_MAX) ” 
  &&  “ (0 <= w___tespec_entry) ” 
  &&  “ (w___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> (((v___tespec_entry + 1 ) + 2 ) % ( 4294967296 ) ))
  **  ((q_pre) # UInt  |-> (unsigned_last_nbits ((w___tespec_entry + 1 )) (32)))
.

Definition call_both_entail_wit_2 := 
forall (q_pre: Z) (p_pre: Z) (w___tespec_entry: Z) (v___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (q_pre = 8192)) (PreH3 : (v___tespec_entry = 1)) (PreH4 : (w___tespec_entry = UINT_MAX)) (PreH5 : (0 <= v___tespec_entry)) (PreH6 : (v___tespec_entry <= UINT_MAX)) (PreH7 : (0 <= w___tespec_entry)) (PreH8 : (w___tespec_entry <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> (v___tespec_entry + 1 ))
  **  ((q_pre) # UInt  |-> (unsigned_last_nbits ((w___tespec_entry + 1 )) (32)))
|--
  “ (p_pre = 4096) ” 
  &&  “ (q_pre = 8192) ” 
  &&  “ (v___tespec_entry = 1) ” 
  &&  “ (w___tespec_entry = UINT_MAX) ” 
  &&  “ (0 <= v___tespec_entry) ” 
  &&  “ (v___tespec_entry <= UINT_MAX) ” 
  &&  “ (0 <= w___tespec_entry) ” 
  &&  “ (w___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> ((v___tespec_entry + 1 ) % ( 4294967296 ) ))
  **  ((q_pre) # UInt  |-> ((w___tespec_entry + 1 ) % ( 4294967296 ) ))
.

Definition call_both_return_wit_1 := 
forall (q_pre: Z) (p_pre: Z) (w___tespec_entry: Z) (v___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (q_pre = 8192)) (PreH3 : (v___tespec_entry = 1)) (PreH4 : (w___tespec_entry = UINT_MAX)) (PreH5 : (0 <= v___tespec_entry)) (PreH6 : (v___tespec_entry <= UINT_MAX)) (PreH7 : (0 <= w___tespec_entry)) (PreH8 : (w___tespec_entry <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> (((v___tespec_entry + 1 ) + 1 ) + 1 ))
  **  ((q_pre) # UInt  |-> (unsigned_last_nbits ((w___tespec_entry + 1 )) (32)))
|--
  ((p_pre) # UInt  |-> ((v___tespec_entry + 3 ) % ( 4294967296 ) ))
  **  ((q_pre) # UInt  |-> ((w___tespec_entry + 1 ) % ( 4294967296 ) ))
.

Definition call_both_partial_solve_wit_1_pure := 
forall (q_pre: Z) (p_pre: Z) (w___tespec_entry: Z) (v___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (q_pre = 8192)) (PreH3 : (v___tespec_entry = 1)) (PreH4 : (w___tespec_entry = UINT_MAX)) (PreH5 : (0 <= v___tespec_entry)) (PreH6 : (v___tespec_entry <= UINT_MAX)) (PreH7 : (0 <= w___tespec_entry)) (PreH8 : (w___tespec_entry <= UINT_MAX)) ,
  ((( &( "p_spec_397" ) )) # Ptr  |-> p_pre)
  **  ((( &( "q_spec_394" ) )) # Ptr  |-> q_pre)
  **  ((p_pre) # UInt  |-> (v___tespec_entry + 1 ))
  **  ((q_pre) # UInt  |-> (unsigned_last_nbits ((w___tespec_entry + 1 )) (32)))
|--
  “ (0 <= (v___tespec_entry + 1 )) ” 
  &&  “ ((v___tespec_entry + 1 ) <= UINT_MAX) ” 
  &&  “ (p_pre = p_pre) ”
.

Definition call_both_partial_solve_wit_1_aux := 
forall (q_pre: Z) (p_pre: Z) (w___tespec_entry: Z) (v___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (q_pre = 8192)) (PreH3 : (v___tespec_entry = 1)) (PreH4 : (w___tespec_entry = UINT_MAX)) (PreH5 : (0 <= v___tespec_entry)) (PreH6 : (v___tespec_entry <= UINT_MAX)) (PreH7 : (0 <= w___tespec_entry)) (PreH8 : (w___tespec_entry <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> (v___tespec_entry + 1 ))
  **  ((q_pre) # UInt  |-> (unsigned_last_nbits ((w___tespec_entry + 1 )) (32)))
|--
  “ (0 <= (v___tespec_entry + 1 )) ” 
  &&  “ ((v___tespec_entry + 1 ) <= UINT_MAX) ” 
  &&  “ (p_pre = p_pre) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (q_pre = 8192) ” 
  &&  “ (v___tespec_entry = 1) ” 
  &&  “ (w___tespec_entry = UINT_MAX) ” 
  &&  “ (0 <= v___tespec_entry) ” 
  &&  “ (v___tespec_entry <= UINT_MAX) ” 
  &&  “ (0 <= w___tespec_entry) ” 
  &&  “ (w___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> (v___tespec_entry + 1 ))
  **  ((q_pre) # UInt  |-> (unsigned_last_nbits ((w___tespec_entry + 1 )) (32)))
.

Definition call_both_partial_solve_wit_1 := call_both_partial_solve_wit_1_pure -> call_both_partial_solve_wit_1_aux.

Definition call_both_partial_solve_wit_2_pure := 
forall (q_pre: Z) (p_pre: Z) (w___tespec_entry: Z) (v___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (q_pre = 8192)) (PreH3 : (v___tespec_entry = 1)) (PreH4 : (w___tespec_entry = UINT_MAX)) (PreH5 : (0 <= v___tespec_entry)) (PreH6 : (v___tespec_entry <= UINT_MAX)) (PreH7 : (0 <= w___tespec_entry)) (PreH8 : (w___tespec_entry <= UINT_MAX)) ,
  ((( &( "p_spec_397" ) )) # Ptr  |-> p_pre)
  **  ((( &( "q_spec_394" ) )) # Ptr  |-> q_pre)
  **  ((p_pre) # UInt  |-> v___tespec_entry)
  **  ((q_pre) # UInt  |-> w___tespec_entry)
|--
  “ (0 <= v___tespec_entry) ” 
  &&  “ (v___tespec_entry <= UINT_MAX) ” 
  &&  “ (0 <= w___tespec_entry) ” 
  &&  “ (w___tespec_entry <= UINT_MAX) ”
.

Definition call_both_partial_solve_wit_2_aux := 
forall (q_pre: Z) (p_pre: Z) (w___tespec_entry: Z) (v___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (q_pre = 8192)) (PreH3 : (v___tespec_entry = 1)) (PreH4 : (w___tespec_entry = UINT_MAX)) (PreH5 : (0 <= v___tespec_entry)) (PreH6 : (v___tespec_entry <= UINT_MAX)) (PreH7 : (0 <= w___tespec_entry)) (PreH8 : (w___tespec_entry <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> v___tespec_entry)
  **  ((q_pre) # UInt  |-> w___tespec_entry)
|--
  “ (0 <= v___tespec_entry) ” 
  &&  “ (v___tespec_entry <= UINT_MAX) ” 
  &&  “ (0 <= w___tespec_entry) ” 
  &&  “ (w___tespec_entry <= UINT_MAX) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (q_pre = 8192) ” 
  &&  “ (v___tespec_entry = 1) ” 
  &&  “ (w___tespec_entry = UINT_MAX) ” 
  &&  “ (0 <= v___tespec_entry) ” 
  &&  “ (v___tespec_entry <= UINT_MAX) ” 
  &&  “ (0 <= w___tespec_entry) ” 
  &&  “ (w___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> v___tespec_entry)
  **  ((q_pre) # UInt  |-> w___tespec_entry)
.

Definition call_both_partial_solve_wit_2 := call_both_partial_solve_wit_2_pure -> call_both_partial_solve_wit_2_aux.

Definition call_both_precondition_wit_1 :=
exists (q_pre: Z) ,
exists (p_pre: Z) ,
exists (w___tespec_entry: Z) ,
exists (v___tespec_entry: Z) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (q_pre = 8192) ” 
  &&  “ (v___tespec_entry = 1) ” 
  &&  “ (w___tespec_entry = UINT_MAX) ” 
  &&  “ (0 <= v___tespec_entry) ” 
  &&  “ (v___tespec_entry <= UINT_MAX) ” 
  &&  “ (0 <= w___tespec_entry) ” 
  &&  “ (w___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> v___tespec_entry)
  **  ((q_pre) # UInt  |-> w___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_call_both_safety_wit_1 : call_both_safety_wit_1.
Axiom proof_of_call_both_safety_wit_2 : call_both_safety_wit_2.
Axiom proof_of_call_both_safety_wit_3 : call_both_safety_wit_3.
Axiom proof_of_call_both_safety_wit_4 : call_both_safety_wit_4.
Axiom proof_of_call_both_entail_wit_1 : call_both_entail_wit_1.
Axiom proof_of_call_both_entail_wit_2 : call_both_entail_wit_2.
Axiom proof_of_call_both_return_wit_1 : call_both_return_wit_1.
Axiom proof_of_call_both_partial_solve_wit_1_pure : call_both_partial_solve_wit_1_pure.
Axiom proof_of_call_both_partial_solve_wit_1 : call_both_partial_solve_wit_1.
Axiom proof_of_call_both_partial_solve_wit_2_pure : call_both_partial_solve_wit_2_pure.
Axiom proof_of_call_both_partial_solve_wit_2 : call_both_partial_solve_wit_2.
Axiom proof_of_call_both_precondition_wit_1 : call_both_precondition_wit_1.

End VC_Correct.
