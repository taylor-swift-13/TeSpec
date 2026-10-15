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

(*----- Function init_array -----*)

Definition init_array_safety_wit_1 := 
  ((( &( "j_spec_385" ) )) # UInt  |-> 1)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 2)
  **  (CharArray.full 4096 2 (cons (0) ((cons (40) ((@nil Z))))) )
|--
  TT && emp 
.

Definition init_array_safety_wit_2 := 
  ((( &( "j_spec_385" ) )) # UInt  |-> 0)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 2)
  **  (CharArray.full 4096 2 (cons (127) ((cons (40) ((@nil Z))))) )
|--
  TT && emp 
.

Definition init_array_safety_wit_3 := 
  ((( &( "j_spec_385" ) )) # UInt  |->_)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 2)
  **  (CharArray.full 4096 2 (cons (127) ((cons (40) ((@nil Z))))) )
|--
  TT && emp 
.

Definition init_array_safety_wit_4 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_385" ) )) # UInt  |-> 0)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 2)
  **  (CharArray.full 4096 2 (cons (127) ((cons (40) ((@nil Z))))) )
|--
  “ False ”
.

Definition init_array_safety_wit_5 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_385" ) )) # UInt  |-> 1)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 2)
  **  (CharArray.full 4096 2 (cons (0) ((cons (40) ((@nil Z))))) )
|--
  “ False ”
.

Definition init_array_safety_wit_6 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_385" ) )) # UInt  |-> 2)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 2)
  **  (CharArray.full 4096 2 (cons (0) ((cons (0) ((@nil Z))))) )
|--
  “ False ”
.

Definition init_array_entail_wit_1 := 
  (CharArray.full 4096 2 (cons (0) ((cons (0) ((@nil Z))))) )
|--
  EX (li: (@list Z)) ,
  (CharArray.full 4096 2 li )
.

Definition init_array_entail_wit_2 := 
  (CharArray.full 4096 2 (cons (0) ((cons (40) ((@nil Z))))) )
|--
  EX (li: (@list Z)) ,
  (CharArray.full 4096 2 li )
.

Definition init_array_entail_wit_3 := 
  (CharArray.full 4096 2 (cons (127) ((cons (40) ((@nil Z))))) )
|--
  EX (li: (@list Z)) ,
  (CharArray.full 4096 2 li )
.

Definition init_array_return_wit_1 := 
forall (n_pre: Z) (p_pre: Z) (l___tespec_entry: (@list Z)) (PreH1 : (((0 + 1 ) + 1 ) >= n_pre)) (PreH2 : ((0 + 1 ) < n_pre)) (PreH3 : (0 < n_pre)) (PreH4 : (p_pre = 4096)) (PreH5 : (n_pre = 2)) (PreH6 : (l___tespec_entry = (cons (127) ((cons (40) ((@nil Z))))))) (PreH7 : (0 <= n_pre)) (PreH8 : (n_pre <= UINT_MAX)) ,
  (CharArray.full p_pre n_pre (replace_Znth (1) (0) ((replace_Znth (0) (0) (l___tespec_entry)))) )
|--
  EX (l2: (@list Z)) ,
  (CharArray.full p_pre n_pre l2 )
.

Definition init_array_precondition_wit_1 :=
exists (n_pre: Z) ,
exists (p_pre: Z) ,
exists (l___tespec_entry: (@list Z)) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (n_pre = 2) ” 
  &&  “ (l___tespec_entry = (cons (127) ((cons (40) ((@nil Z)))))) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ”
  &&  (CharArray.full p_pre n_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_init_array_safety_wit_1 : init_array_safety_wit_1.
Axiom proof_of_init_array_safety_wit_2 : init_array_safety_wit_2.
Axiom proof_of_init_array_safety_wit_3 : init_array_safety_wit_3.
Axiom proof_of_init_array_safety_wit_4 : init_array_safety_wit_4.
Axiom proof_of_init_array_safety_wit_5 : init_array_safety_wit_5.
Axiom proof_of_init_array_safety_wit_6 : init_array_safety_wit_6.
Axiom proof_of_init_array_entail_wit_1 : init_array_entail_wit_1.
Axiom proof_of_init_array_entail_wit_2 : init_array_entail_wit_2.
Axiom proof_of_init_array_entail_wit_3 : init_array_entail_wit_3.
Axiom proof_of_init_array_return_wit_1 : init_array_return_wit_1.
Axiom proof_of_init_array_precondition_wit_1 : init_array_precondition_wit_1.

End VC_Correct.
