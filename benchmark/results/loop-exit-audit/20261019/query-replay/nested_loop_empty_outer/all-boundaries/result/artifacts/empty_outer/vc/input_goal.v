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

(*----- Function nested_loop -----*)

Definition nested_loop_safety_wit_1 := 
  ((( &( "j_spec_393" ) )) # Int  |->_)
  **  ((( &( "i_spec_390" ) )) # Int  |->_)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 0)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_2 := 
  ((( &( "count_spec_387" ) )) # Int  |->_)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 0)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 5)
|--
  TT && emp 
.

Definition nested_loop_safety_wit_3 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_393" ) )) # Int  |->_)
  **  ((( &( "i_spec_390" ) )) # Int  |-> 0)
  **  ((( &( "count_spec_387" ) )) # Int  |-> 0)
  **  ((( &( "n_spec_374" ) )) # Int  |-> 0)
  **  ((( &( "m_spec_371" ) )) # Int  |-> 5)
|--
  “ False ”
.

Definition nested_loop_return_wit_1 := 
forall (m_pre: Z) (n_pre: Z) (M___tespec_entry: Z) (N___tespec_entry: Z) (PreH1 : (0 >= n_pre)) (PreH2 : (n_pre = 0)) (PreH3 : (m_pre = 5)) (PreH4 : (M___tespec_entry = 5)) (PreH5 : (N___tespec_entry = 0)) (PreH6 : (n_pre = N___tespec_entry)) (PreH7 : (m_pre = M___tespec_entry)) (PreH8 : (0 <= N___tespec_entry)) (PreH9 : (N___tespec_entry <= 100)) (PreH10 : (0 <= M___tespec_entry)) (PreH11 : (M___tespec_entry <= 100)) ,
  TT && emp 
|--
  “ (0 = (N___tespec_entry * M___tespec_entry )) ”
  &&  emp
.

Definition nested_loop_precondition_wit_1 :=
exists (m_pre: Z) ,
exists (n_pre: Z) ,
exists (M___tespec_entry: Z) ,
exists (N___tespec_entry: Z) ,
~ ((  “ (n_pre = 0) ” 
  &&  “ (m_pre = 5) ” 
  &&  “ (M___tespec_entry = 5) ” 
  &&  “ (N___tespec_entry = 0) ” 
  &&  “ (n_pre = N___tespec_entry) ” 
  &&  “ (m_pre = M___tespec_entry) ” 
  &&  “ (0 <= N___tespec_entry) ” 
  &&  “ (N___tespec_entry <= 100) ” 
  &&  “ (0 <= M___tespec_entry) ” 
  &&  “ (M___tespec_entry <= 100) ”
  &&  emp) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_nested_loop_safety_wit_1 : nested_loop_safety_wit_1.
Axiom proof_of_nested_loop_safety_wit_2 : nested_loop_safety_wit_2.
Axiom proof_of_nested_loop_safety_wit_3 : nested_loop_safety_wit_3.
Axiom proof_of_nested_loop_return_wit_1 : nested_loop_return_wit_1.
Axiom proof_of_nested_loop_precondition_wit_1 : nested_loop_precondition_wit_1.

End VC_Correct.
