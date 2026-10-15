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
forall (y: Z) (PreH1 : (y = 0)) ,
  ((( &( "ys_spec_656" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_655" ) )) # Ptr  |-> 16384)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> 1)
  **  ((( &( "tmp_spec_642" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_469" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_466" ) )) # Ptr  |-> 16384)
|--
  TT && emp 
.

Definition IntList_rev_aux_safety_wit_2 := 
forall (PreH1 : False) ,
  ((( &( "ys_spec_656" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_655" ) )) # Ptr  |-> 16384)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> 1)
  **  ((( &( "tmp_spec_642" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_469" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_466" ) )) # Ptr  |-> 16384)
|--
  “ False ”
.

Definition IntList_rev_aux_safety_wit_3 := 
  ((( &( "xs_spec_469" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_466" ) )) # Ptr  |-> 16384)
  **  (sll 0 (@nil Z) )
  **  (sll 16384 (cons (1) ((@nil Z))) )
|--
  TT && emp 
.

Definition IntList_rev_aux_safety_wit_4 := 
forall (PreH1 : False) ,
  ((( &( "xs_spec_469" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_466" ) )) # Ptr  |-> 16384)
  **  (sll 0 (@nil Z) )
  **  (sll 16384 (cons (1) ((@nil Z))) )
|--
  “ False ”
.

Definition IntList_rev_aux_entail_wit_1 := 
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (y: Z) (PreH1 : (y = 0)) (PreH2 : (y = 0)) (PreH3 : (xs_pre = 0)) (PreH4 : (ys_pre <> 0)) (PreH5 : (xs_pre = 0)) (PreH6 : (ys_pre = 16384)) (PreH7 : (a___tespec_entry = (@nil Z))) (PreH8 : (b___tespec_entry = (cons (1) ((@nil Z))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 1)
|--
  EX (retval: Z) ,
  “ (retval = ys_pre) ” 
  &&  “ (y = 0) ” 
  &&  “ (xs_pre = 0) ” 
  &&  “ (ys_pre <> 0) ” 
  &&  “ (xs_pre = 0) ” 
  &&  “ (ys_pre = 16384) ” 
  &&  “ (a___tespec_entry = (@nil Z)) ” 
  &&  “ (b___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll retval (app ((rev ((@nil Z)))) ((cons (1) ((@nil Z))))) )
.

Definition IntList_rev_aux_return_wit_1 := 
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (y: Z) (PreH1 : (y = 0)) (PreH2 : (y = 0)) (PreH3 : (xs_pre = 0)) (PreH4 : (ys_pre <> 0)) (PreH5 : (xs_pre = 0)) (PreH6 : (ys_pre = 16384)) (PreH7 : (a___tespec_entry = (@nil Z))) (PreH8 : (b___tespec_entry = (cons (1) ((@nil Z))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 1)
|--
  (sll ys_pre (app ((rev (b___tespec_entry))) (a___tespec_entry)) )
.

Definition IntList_rev_aux_partial_solve_wit_1 := 
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (y: Z) (PreH1 : (y = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (ys_pre <> 0)) (PreH4 : (xs_pre = 0)) (PreH5 : (ys_pre = 16384)) (PreH6 : (a___tespec_entry = (@nil Z))) (PreH7 : (b___tespec_entry = (cons (1) ((@nil Z))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 1)
|--
  “ (y = 0) ” 
  &&  “ (xs_pre = 0) ” 
  &&  “ (ys_pre <> 0) ” 
  &&  “ (xs_pre = 0) ” 
  &&  “ (ys_pre = 16384) ” 
  &&  “ (a___tespec_entry = (@nil Z)) ” 
  &&  “ (b___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll ys_pre (cons (1) ((@nil Z))) )
  **  (sll y (@nil Z) )
.

Definition IntList_rev_aux_partial_solve_wit_2 := 
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (PreH1 : (ys_pre <> 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (ys_pre = 16384)) (PreH4 : (a___tespec_entry = (@nil Z))) (PreH5 : (b___tespec_entry = (cons (1) ((@nil Z))))) ,
  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )
|--
  EX (y: Z) ,
  “ (y = 0) ” 
  &&  “ (xs_pre = 0) ” 
  &&  “ (ys_pre <> 0) ” 
  &&  “ (xs_pre = 0) ” 
  &&  “ (ys_pre = 16384) ” 
  &&  “ (a___tespec_entry = (@nil Z)) ” 
  &&  “ (b___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 1)
.

Definition IntList_rev_aux_precondition_wit_1 :=
exists (ys_pre: Z) ,
exists (xs_pre: Z) ,
exists (b___tespec_entry: (@list Z)) ,
exists (a___tespec_entry: (@list Z)) ,
~ ((  “ (xs_pre = 0) ” 
  &&  “ (ys_pre = 16384) ” 
  &&  “ (a___tespec_entry = (@nil Z)) ” 
  &&  “ (b___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_rev_aux_safety_wit_1 : IntList_rev_aux_safety_wit_1.
Axiom proof_of_IntList_rev_aux_safety_wit_2 : IntList_rev_aux_safety_wit_2.
Axiom proof_of_IntList_rev_aux_safety_wit_3 : IntList_rev_aux_safety_wit_3.
Axiom proof_of_IntList_rev_aux_safety_wit_4 : IntList_rev_aux_safety_wit_4.
Axiom proof_of_IntList_rev_aux_entail_wit_1 : IntList_rev_aux_entail_wit_1.
Axiom proof_of_IntList_rev_aux_return_wit_1 : IntList_rev_aux_return_wit_1.
Axiom proof_of_IntList_rev_aux_partial_solve_wit_1 : IntList_rev_aux_partial_solve_wit_1.
Axiom proof_of_IntList_rev_aux_partial_solve_wit_2 : IntList_rev_aux_partial_solve_wit_2.
Axiom proof_of_IntList_rev_aux_precondition_wit_1 : IntList_rev_aux_precondition_wit_1.

End VC_Correct.
