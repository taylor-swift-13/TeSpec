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
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_rev_loop -----*)

Definition IntList_rev_loop_safety_wit_1 := 
  ((( &( "last_spec_639" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_566" ) )) # Ptr  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_2 := 
  ((( &( "cur_spec_642" ) )) # Ptr  |-> 0)
  **  ((( &( "last_spec_639" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_566" ) )) # Ptr  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_3 := 
  ((( &( "cur_spec_642" ) )) # Ptr  |-> 0)
  **  ((( &( "last_spec_639" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_566" ) )) # Ptr  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_4 := 
forall (PreH1 : False) ,
  ((( &( "cur_spec_642" ) )) # Ptr  |-> 0)
  **  ((( &( "last_spec_639" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_566" ) )) # Ptr  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  “ False ”
.

Definition IntList_rev_loop_entail_wit_1 := 
  (sll 0 (@nil Z) )
|--
  EX (l2: (@list Z))  (l1: (@list Z)) ,
  “ ((app ((rev (l2))) (l1)) = (@nil Z)) ”
  &&  (sll 0 l1 )
  **  (sll 0 l2 )
.

Definition IntList_rev_loop_return_wit_1 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (PreH1 : (xs_pre = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (l___tespec_entry = (@nil Z))) ,
  (sll xs_pre l___tespec_entry )
|--
  (sll 0 (rev (l___tespec_entry)) )
.

Definition IntList_rev_loop_precondition_wit_1 :=
exists (xs_pre: Z) ,
exists (l___tespec_entry: (@list Z)) ,
~ ((  “ (xs_pre = 0) ” 
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_rev_loop_safety_wit_1 : IntList_rev_loop_safety_wit_1.
Axiom proof_of_IntList_rev_loop_safety_wit_2 : IntList_rev_loop_safety_wit_2.
Axiom proof_of_IntList_rev_loop_safety_wit_3 : IntList_rev_loop_safety_wit_3.
Axiom proof_of_IntList_rev_loop_safety_wit_4 : IntList_rev_loop_safety_wit_4.
Axiom proof_of_IntList_rev_loop_entail_wit_1 : IntList_rev_loop_entail_wit_1.
Axiom proof_of_IntList_rev_loop_return_wit_1 : IntList_rev_loop_return_wit_1.
Axiom proof_of_IntList_rev_loop_precondition_wit_1 : IntList_rev_loop_precondition_wit_1.

End VC_Correct.
