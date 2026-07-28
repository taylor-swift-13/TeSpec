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
From QCIPLib.xizi.xizi_double_link_common Require Import xizi_double_link_lib.
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_next_rec_last
      Require Import xizi_double_link_next_rec_last_lib.
Local Open Scope sac.
From QCIPLib.xizi.xizi_double_link_common Require Import xizi_double_link_strategy_goal.
From QCIPLib.xizi.xizi_double_link_common Require Import xizi_double_link_strategy_proof.

(*----- Function xizi_double_link_next_rec_last -----*)

Definition xizi_double_link_next_rec_last_safety_wit_1 := 
forall (linklist_node_pre: Z) (linklist_pre: Z) (nodes_after: (@list Z)) (nodes_before: (@list Z)) (first: Z) (last: Z) (node_prev: Z) (node_next: Z) (PreH1 : (node_next = linklist_pre)) (PreH2 : (linklist_node_pre <> 0)) ,
  ((( &( "linklist" ) )) # Ptr  |-> linklist_pre)
  **  ((( &( "linklist_node" ) )) # Ptr  |-> linklist_node_pre)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
  **  (xizi_dllseg first linklist_pre linklist_node_pre node_prev nodes_before )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> node_next)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> node_prev)
  **  (xizi_dllseg node_next linklist_node_pre linklist_pre last nodes_after )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition xizi_double_link_next_rec_last_entail_wit_1 := 
(
forall (linklist_node_pre: Z) (linklist_pre: Z) (nodes_after: (@list Z)) (nodes_before: (@list Z)) (PreH1 : (linklist_pre <> 0)) (PreH2 : (linklist_node_pre <> 0)) ,
  (xizi_dll linklist_pre (app (nodes_before) ((cons (linklist_node_pre) (nodes_after)))) )
|--
  EX (node_next: Z)  (node_prev: Z)  (last: Z)  (first: Z) ,
  “ (linklist_node_pre <> 0) ”
  &&  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
  **  (xizi_dllseg first linklist_pre linklist_node_pre node_prev nodes_before )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> node_next)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> node_prev)
  **  (xizi_dllseg node_next linklist_node_pre linklist_pre last nodes_after )
) \/
(
forall (linklist_node_pre: Z) (linklist_pre: Z) (nodes_after: (@list Z)) (nodes_before: (@list Z)) (first_2: Z) (last_2: Z) (PreH1 : (linklist_pre <> 0)) (PreH2 : (linklist_node_pre <> 0)) ,
  (xizi_dllseg first_2 linklist_pre linklist_pre last_2 (app (nodes_before) ((cons (linklist_node_pre) (nodes_after)))) )
|--
  EX (node_next: Z)  (node_prev: Z) ,
  “ (linklist_node_pre <> 0) ”
  &&  (xizi_dllseg first_2 linklist_pre linklist_node_pre node_prev nodes_before )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> node_next)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> node_prev)
  **  (xizi_dllseg node_next linklist_node_pre linklist_pre last_2 nodes_after )
).

Definition xizi_double_link_next_rec_last_return_wit_1 := 
(
forall (linklist_node_pre: Z) (linklist_pre: Z) (nodes_after: (@list Z)) (nodes_before: (@list Z)) (first: Z) (last: Z) (node_prev: Z) (node_next: Z) (PreH1 : (node_next = linklist_pre)) (PreH2 : (linklist_node_pre <> 0)) ,
  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
  **  (xizi_dllseg first linklist_pre linklist_node_pre node_prev nodes_before )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> node_next)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> node_prev)
  **  (xizi_dllseg node_next linklist_node_pre linklist_pre last nodes_after )
|--
  “ (0 = (xizi_double_link_next_rec_last_value (nodes_after))) ”
  &&  (xizi_dll linklist_pre (app (nodes_before) ((cons (linklist_node_pre) (nodes_after)))) )
) \/
(
forall (linklist_node_pre: Z) (linklist_pre: Z) (nodes_after: (@list Z)) (nodes_before: (@list Z)) (first: Z) (last: Z) (node_prev: Z) (node_next: Z) (PreH1 : (node_next = linklist_pre)) (PreH2 : (linklist_node_pre <> 0)) ,
  (xizi_dllseg first linklist_pre linklist_node_pre node_prev nodes_before )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> node_next)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> node_prev)
  **  (xizi_dllseg node_next linklist_node_pre linklist_pre last nodes_after )
|--
  “ (0 = (xizi_double_link_next_rec_last_value (nodes_after))) ”
  &&  (xizi_dllseg first linklist_pre linklist_pre last (app (nodes_before) ((cons (linklist_node_pre) (nodes_after)))) )
).

Definition xizi_double_link_next_rec_last_return_wit_1_split_goal_1 := 
forall (linklist_node_pre: Z) (linklist_pre: Z) (nodes_after: (@list Z)) (nodes_before: (@list Z)) (first: Z) (last: Z) (node_prev: Z) (node_next: Z) (PreH1 : (node_next = linklist_pre)) (PreH2 : (linklist_node_pre <> 0)) ,
  (xizi_dllseg first linklist_pre linklist_node_pre node_prev nodes_before )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> node_next)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> node_prev)
  **  (xizi_dllseg node_next linklist_node_pre linklist_pre last nodes_after )
|--
  “ (0 = (xizi_double_link_next_rec_last_value (nodes_after))) ”
.

Definition xizi_double_link_next_rec_last_return_wit_1_split_goal_spatial := 
forall (linklist_node_pre: Z) (linklist_pre: Z) (nodes_after: (@list Z)) (nodes_before: (@list Z)) (first: Z) (last: Z) (node_prev: Z) (node_next: Z) (PreH1 : (node_next = linklist_pre)) (PreH2 : (linklist_node_pre <> 0)) ,
  (xizi_dllseg first linklist_pre linklist_node_pre node_prev nodes_before )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> node_next)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> node_prev)
  **  (xizi_dllseg node_next linklist_node_pre linklist_pre last nodes_after )
|--
  (xizi_dllseg first linklist_pre linklist_pre last (app (nodes_before) ((cons (linklist_node_pre) (nodes_after)))) )
.

Definition xizi_double_link_next_rec_last_return_wit_2 := 
(
forall (linklist_node_pre: Z) (linklist_pre: Z) (nodes_after: (@list Z)) (nodes_before: (@list Z)) (first: Z) (last: Z) (node_prev: Z) (node_next: Z) (PreH1 : (node_next <> linklist_pre)) (PreH2 : (linklist_node_pre <> 0)) ,
  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
  **  (xizi_dllseg first linklist_pre linklist_node_pre node_prev nodes_before )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> node_next)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> node_prev)
  **  (xizi_dllseg node_next linklist_node_pre linklist_pre last nodes_after )
|--
  “ (node_next = (xizi_double_link_next_rec_last_value (nodes_after))) ”
  &&  (xizi_dll linklist_pre (app (nodes_before) ((cons (linklist_node_pre) (nodes_after)))) )
) \/
(
forall (linklist_node_pre: Z) (linklist_pre: Z) (nodes_after: (@list Z)) (nodes_before: (@list Z)) (first: Z) (last: Z) (node_prev: Z) (node_next: Z) (next: Z) (l0: (@list Z)) (PreH1 : (nodes_after = (cons (node_next) (l0)))) (PreH2 : (node_next <> linklist_pre)) (PreH3 : (linklist_node_pre <> 0)) ,
  (xizi_dllseg next node_next linklist_pre last l0 )
  **  ((&((node_next)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_node_pre)
  **  ((&((node_next)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> next)
  **  (xizi_dllseg first linklist_pre linklist_node_pre node_prev nodes_before )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> node_next)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> node_prev)
|--
  “ (node_next = (xizi_double_link_next_rec_last_value (nodes_after))) ”
  &&  (xizi_dllseg first linklist_pre linklist_pre last (app (nodes_before) ((cons (linklist_node_pre) (nodes_after)))) )
).

Definition xizi_double_link_next_rec_last_return_wit_2_split_goal_1 := 
forall (linklist_node_pre: Z) (linklist_pre: Z) (nodes_after: (@list Z)) (nodes_before: (@list Z)) (first: Z) (last: Z) (node_prev: Z) (node_next: Z) (next: Z) (l0: (@list Z)) (PreH1 : (nodes_after = (cons (node_next) (l0)))) (PreH2 : (node_next <> linklist_pre)) (PreH3 : (linklist_node_pre <> 0)) ,
  (xizi_dllseg next node_next linklist_pre last l0 )
  **  ((&((node_next)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_node_pre)
  **  ((&((node_next)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> next)
  **  (xizi_dllseg first linklist_pre linklist_node_pre node_prev nodes_before )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> node_next)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> node_prev)
|--
  “ (node_next = (xizi_double_link_next_rec_last_value (nodes_after))) ”
.

Definition xizi_double_link_next_rec_last_return_wit_2_split_goal_spatial := 
forall (linklist_node_pre: Z) (linklist_pre: Z) (nodes_after: (@list Z)) (nodes_before: (@list Z)) (first: Z) (last: Z) (node_prev: Z) (node_next: Z) (next: Z) (l0: (@list Z)) (PreH1 : (nodes_after = (cons (node_next) (l0)))) (PreH2 : (node_next <> linklist_pre)) (PreH3 : (linklist_node_pre <> 0)) ,
  (xizi_dllseg next node_next linklist_pre last l0 )
  **  ((&((node_next)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_node_pre)
  **  ((&((node_next)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> next)
  **  (xizi_dllseg first linklist_pre linklist_node_pre node_prev nodes_before )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> node_next)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> node_prev)
|--
  (xizi_dllseg first linklist_pre linklist_pre last (app (nodes_before) ((cons (linklist_node_pre) (nodes_after)))) )
.

Module Type VC_Correct.

Include xizi_double_link_Strategy_Correct.

Axiom proof_of_xizi_double_link_next_rec_last_safety_wit_1 : xizi_double_link_next_rec_last_safety_wit_1.
Axiom proof_of_xizi_double_link_next_rec_last_entail_wit_1 : xizi_double_link_next_rec_last_entail_wit_1.
Axiom proof_of_xizi_double_link_next_rec_last_return_wit_1 : xizi_double_link_next_rec_last_return_wit_1.
Axiom proof_of_xizi_double_link_next_rec_last_return_wit_2 : xizi_double_link_next_rec_last_return_wit_2.

End VC_Correct.
