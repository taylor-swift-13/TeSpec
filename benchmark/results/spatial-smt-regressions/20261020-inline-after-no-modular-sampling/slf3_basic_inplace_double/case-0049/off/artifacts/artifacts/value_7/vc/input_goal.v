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

(*----- Function inplace_double -----*)

Definition inplace_double_safety_wit_1 := 
  ((( &( "m_spec_383" ) )) # Int  |->_)
  **  ((( &( "n_spec_380" ) )) # Int  |-> 1073741823)
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  ((4096) # Int  |-> 1073741823)
|--
  TT && emp 
.

Definition inplace_double_return_wit_1 := 
(
forall (p_pre: Z) (old___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (old___tespec_entry = 1073741823)) (PreH3 : ((-1073741824) <= old___tespec_entry)) (PreH4 : (old___tespec_entry <= 1073741823)) ,
  ((p_pre) # Int  |-> (old___tespec_entry + old___tespec_entry ))
|--
  ((p_pre) # Int  |-> old___tespec_entry)
) \/
(
forall (p_pre: Z) (old___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (old___tespec_entry = 1073741823)) (PreH3 : ((-1073741824) <= old___tespec_entry)) (PreH4 : (old___tespec_entry <= 1073741823)) ,
  TT && emp 
|--
  “ ((old___tespec_entry + old___tespec_entry ) = old___tespec_entry) ”
  &&  emp
).

Definition inplace_double_return_wit_1_split_goal_1 := 
forall (p_pre: Z) (old___tespec_entry: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (old___tespec_entry = 1073741823)) (PreH3 : ((-1073741824) <= old___tespec_entry)) (PreH4 : (old___tespec_entry <= 1073741823)) ,
  ((old___tespec_entry + old___tespec_entry ) = old___tespec_entry)
.

Definition inplace_double_precondition_wit_1 :=
exists (p_pre: Z) ,
exists (old___tespec_entry: Z) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (old___tespec_entry = 1073741823) ” 
  &&  “ ((-1073741824) <= old___tespec_entry) ” 
  &&  “ (old___tespec_entry <= 1073741823) ”
  &&  ((p_pre) # Int  |-> old___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_inplace_double_safety_wit_1 : inplace_double_safety_wit_1.
Axiom proof_of_inplace_double_return_wit_1 : inplace_double_return_wit_1.
Axiom proof_of_inplace_double_precondition_wit_1 : inplace_double_precondition_wit_1.

End VC_Correct.
