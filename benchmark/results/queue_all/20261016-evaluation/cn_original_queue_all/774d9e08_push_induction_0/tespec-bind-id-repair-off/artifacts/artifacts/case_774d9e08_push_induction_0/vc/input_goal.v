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
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function push_induction -----*)

Definition push_induction_safety_wit_1 := 
forall (PreH1 : False) ,
  ((( &( "front_spec_466" ) )) # Ptr  |-> 12288)
  **  ((( &( "p_spec_463" ) )) # Ptr  |-> 12288)
  **  (sllseg 12288 12288 (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (12288 + 0)) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (12288 + 4)) # Ptr  |-> 16384)
|--
  “ False ”
.

Definition push_induction_return_wit_1 := 
(
forall (p_pre: Z) (front_pre: Z) (l___tespec_entry: (@list Z)) (n___tespec_entry: Z) (x___tespec_entry: Z) (PreH1 : (front_pre = p_pre)) (PreH2 : (front_pre = 12288)) (PreH3 : (p_pre = 12288)) (PreH4 : (l___tespec_entry = (@nil Z))) (PreH5 : (n___tespec_entry = 16384)) (PreH6 : (x___tespec_entry = 7)) (PreH7 : (p_pre <> 0)) ,
  (sllseg front_pre p_pre l___tespec_entry )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> x___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> n___tespec_entry)
|--
  (sllseg front_pre n___tespec_entry (app (l___tespec_entry) ((cons (x___tespec_entry) ((@nil Z))))) )
) \/
(
forall (p_pre: Z) (front_pre: Z) (l___tespec_entry: (@list Z)) (n___tespec_entry: Z) (x___tespec_entry: Z) (PreH1 : (x___tespec_entry <= INT_MAX)) (PreH2 : (x___tespec_entry >= INT_MIN)) (PreH3 : (front_pre = p_pre)) (PreH4 : (front_pre = 12288)) (PreH5 : (p_pre = 12288)) (PreH6 : (l___tespec_entry = (@nil Z))) (PreH7 : (n___tespec_entry = 16384)) (PreH8 : (x___tespec_entry = 7)) (PreH9 : (p_pre <> 0)) ,
  (sllseg front_pre p_pre l___tespec_entry )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> x___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> n___tespec_entry)
|--
  (sllseg front_pre n___tespec_entry (app (l___tespec_entry) ((cons (x___tespec_entry) ((@nil Z))))) )
).

Definition push_induction_return_wit_1_split_goal_spatial := 
forall (p_pre: Z) (front_pre: Z) (l___tespec_entry: (@list Z)) (n___tespec_entry: Z) (x___tespec_entry: Z) (PreH1 : (x___tespec_entry <= INT_MAX)) (PreH2 : (x___tespec_entry >= INT_MIN)) (PreH3 : (front_pre = p_pre)) (PreH4 : (front_pre = 12288)) (PreH5 : (p_pre = 12288)) (PreH6 : (l___tespec_entry = (@nil Z))) (PreH7 : (n___tespec_entry = 16384)) (PreH8 : (x___tespec_entry = 7)) (PreH9 : (p_pre <> 0)) ,
  (sllseg front_pre p_pre l___tespec_entry )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> x___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> n___tespec_entry)
|--
  (sllseg front_pre n___tespec_entry (app (l___tespec_entry) ((cons (x___tespec_entry) ((@nil Z))))) )
.

Definition push_induction_precondition_wit_1 :=
exists (p_pre: Z) ,
exists (front_pre: Z) ,
exists (l___tespec_entry: (@list Z)) ,
exists (n___tespec_entry: Z) ,
exists (x___tespec_entry: Z) ,
~ ((  “ (front_pre = 12288) ” 
  &&  “ (p_pre = 12288) ” 
  &&  “ (l___tespec_entry = (@nil Z)) ” 
  &&  “ (n___tespec_entry = 16384) ” 
  &&  “ (x___tespec_entry = 7) ” 
  &&  “ (p_pre <> 0) ”
  &&  (sllseg front_pre p_pre l___tespec_entry )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> x___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> n___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_push_induction_safety_wit_1 : push_induction_safety_wit_1.
Axiom proof_of_push_induction_return_wit_1 : push_induction_return_wit_1.
Axiom proof_of_push_induction_precondition_wit_1 : push_induction_precondition_wit_1.

End VC_Correct.
