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

(*----- Function IntList_rev_aux -----*)

Definition IntList_rev_aux_safety_wit_1 := 
  ((( &( "xs_spec_469" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_466" ) )) # Ptr  |-> 0)
  **  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
  **  (sll 0 (@nil Z) )
|--
  TT && emp 
.

Definition IntList_rev_aux_safety_wit_2 := 
forall (PreH1 : False) ,
  ((( &( "xs_spec_469" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_466" ) )) # Ptr  |-> 0)
  **  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
  **  (sll 0 (@nil Z) )
|--
  “ False ”
.

Definition IntList_rev_aux_return_wit_1 := 
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (PreH1 : (ys_pre = 0)) (PreH2 : (xs_pre = 8192)) (PreH3 : (ys_pre = 0)) (PreH4 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH5 : (b___tespec_entry = (@nil Z))) ,
  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )
|--
  (sll xs_pre (app ((rev (b___tespec_entry))) (a___tespec_entry)) )
.

Definition IntList_rev_aux_precondition_wit_1 :=
exists (ys_pre: Z) ,
exists (xs_pre: Z) ,
exists (b___tespec_entry: (@list Z)) ,
exists (a___tespec_entry: (@list Z)) ,
~ ((  “ (xs_pre = 8192) ” 
  &&  “ (ys_pre = 0) ” 
  &&  “ (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ” 
  &&  “ (b___tespec_entry = (@nil Z)) ”
  &&  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_rev_aux_safety_wit_1 : IntList_rev_aux_safety_wit_1.
Axiom proof_of_IntList_rev_aux_safety_wit_2 : IntList_rev_aux_safety_wit_2.
Axiom proof_of_IntList_rev_aux_return_wit_1 : IntList_rev_aux_return_wit_1.
Axiom proof_of_IntList_rev_aux_precondition_wit_1 : IntList_rev_aux_precondition_wit_1.

End VC_Correct.
