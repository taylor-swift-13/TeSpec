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
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_insert_after Require Import xizi_double_link_insert_after_lib.
Local Open Scope sac.
From QCIPLib.xizi.xizi_double_link_common Require Import xizi_double_link_strategy_goal.
From QCIPLib.xizi.xizi_double_link_common Require Import xizi_double_link_strategy_proof.

(*----- Function xizi_double_link_insert_after -----*)

Definition xizi_double_link_insert_after_entail_wit_1 := 
forall (linklist_node_pre: Z) (linklist_pre: Z) (nodes_after: (@list Z)) (nodes_before: (@list Z)) (head: Z) (PreH1 : (linklist_pre <> 0)) (PreH2 : (linklist_node_pre <> 0)) ,
  (xizi_dll head (app (nodes_before) ((cons (linklist_pre) (nodes_after)))) )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |->_)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |->_)
|--
  (EX (old_prev: Z)  (first: Z) ,
  “ (nodes_after = (@nil Z)) ” 
  &&  “ (linklist_pre <> 0) ” 
  &&  “ (linklist_node_pre <> 0) ”
  &&  ((&((head)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  (xizi_dllseg first head linklist_pre old_prev nodes_before )
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> head)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> old_prev)
  **  ((&((head)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_pre)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |->_)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |->_))
  ||
  (EX (next_next: Z)  (old_prev_2: Z)  (last: Z)  (first_2: Z)  (old_next: Z)  (rest: (@list Z)) ,
  “ (nodes_after = (cons (old_next) (rest))) ” 
  &&  “ (linklist_pre <> 0) ” 
  &&  “ (linklist_node_pre <> 0) ” 
  &&  “ (old_next <> 0) ”
  &&  ((&((head)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first_2)
  **  ((&((head)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
  **  (xizi_dllseg first_2 head linklist_pre old_prev_2 nodes_before )
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> old_next)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> old_prev_2)
  **  ((&((old_next)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> next_next)
  **  ((&((old_next)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_pre)
  **  (xizi_dllseg next_next old_next head last rest )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |->_)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |->_))
.

Definition xizi_double_link_insert_after_return_wit_1 := 
(
forall (linklist_node_pre: Z) (linklist_pre: Z) (nodes_after: (@list Z)) (nodes_before: (@list Z)) (head: Z) (first: Z) (last: Z) (old_next: Z) (old_prev: Z) (next_next: Z) (rest: (@list Z)) (PreH1 : (nodes_after = (cons (old_next) (rest)))) (PreH2 : (linklist_pre <> 0)) (PreH3 : (linklist_node_pre <> 0)) (PreH4 : (old_next <> 0)) ,
  ((&((head)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  ((&((head)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
  **  (xizi_dllseg first head linklist_pre old_prev nodes_before )
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> linklist_node_pre)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> old_prev)
  **  ((&((old_next)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> next_next)
  **  ((&((old_next)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_node_pre)
  **  (xizi_dllseg next_next old_next head last rest )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> old_next)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_pre)
|--
  (xizi_dll head (xizi_double_link_insert_after_nodes (nodes_before) (linklist_pre) (linklist_node_pre) (nodes_after)) )
) \/
(
forall (linklist_node_pre: Z) (linklist_pre: Z) (nodes_after: (@list Z)) (nodes_before: (@list Z)) (head: Z) (first: Z) (last: Z) (old_next: Z) (old_prev: Z) (next_next: Z) (rest: (@list Z)) (PreH1 : (nodes_after = (cons (old_next) (rest)))) (PreH2 : (linklist_pre <> 0)) (PreH3 : (linklist_node_pre <> 0)) (PreH4 : (old_next <> 0)) ,
  (xizi_dllseg first head linklist_pre old_prev nodes_before )
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> linklist_node_pre)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> old_prev)
  **  ((&((old_next)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> next_next)
  **  ((&((old_next)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_node_pre)
  **  (xizi_dllseg next_next old_next head last rest )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> old_next)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_pre)
|--
  (xizi_dllseg first head head last (xizi_double_link_insert_after_nodes (nodes_before) (linklist_pre) (linklist_node_pre) (nodes_after)) )
).

Definition xizi_double_link_insert_after_return_wit_1_split_goal_spatial := 
forall (linklist_node_pre: Z) (linklist_pre: Z) (nodes_after: (@list Z)) (nodes_before: (@list Z)) (head: Z) (first: Z) (last: Z) (old_next: Z) (old_prev: Z) (next_next: Z) (rest: (@list Z)) (PreH1 : (nodes_after = (cons (old_next) (rest)))) (PreH2 : (linklist_pre <> 0)) (PreH3 : (linklist_node_pre <> 0)) (PreH4 : (old_next <> 0)) ,
  (xizi_dllseg first head linklist_pre old_prev nodes_before )
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> linklist_node_pre)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> old_prev)
  **  ((&((old_next)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> next_next)
  **  ((&((old_next)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_node_pre)
  **  (xizi_dllseg next_next old_next head last rest )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> old_next)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_pre)
|--
  (xizi_dllseg first head head last (xizi_double_link_insert_after_nodes (nodes_before) (linklist_pre) (linklist_node_pre) (nodes_after)) )
.

Definition xizi_double_link_insert_after_return_wit_2 := 
(
forall (linklist_node_pre: Z) (linklist_pre: Z) (nodes_after: (@list Z)) (nodes_before: (@list Z)) (head: Z) (first: Z) (old_prev: Z) (PreH1 : (nodes_after = (@nil Z))) (PreH2 : (linklist_pre <> 0)) (PreH3 : (linklist_node_pre <> 0)) ,
  ((&((head)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  (xizi_dllseg first head linklist_pre old_prev nodes_before )
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> linklist_node_pre)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> old_prev)
  **  ((&((head)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_node_pre)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> head)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_pre)
|--
  (xizi_dll head (xizi_double_link_insert_after_nodes (nodes_before) (linklist_pre) (linklist_node_pre) (nodes_after)) )
) \/
(
forall (linklist_node_pre: Z) (linklist_pre: Z) (nodes_after: (@list Z)) (nodes_before: (@list Z)) (head: Z) (first: Z) (old_prev: Z) (PreH1 : (nodes_after = (@nil Z))) (PreH2 : (linklist_pre <> 0)) (PreH3 : (linklist_node_pre <> 0)) ,
  (xizi_dllseg first head linklist_pre old_prev nodes_before )
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> linklist_node_pre)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> old_prev)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> head)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_pre)
|--
  (xizi_dllseg first head head linklist_node_pre (xizi_double_link_insert_after_nodes (nodes_before) (linklist_pre) (linklist_node_pre) (nodes_after)) )
).

Definition xizi_double_link_insert_after_return_wit_2_split_goal_spatial := 
forall (linklist_node_pre: Z) (linklist_pre: Z) (nodes_after: (@list Z)) (nodes_before: (@list Z)) (head: Z) (first: Z) (old_prev: Z) (PreH1 : (nodes_after = (@nil Z))) (PreH2 : (linklist_pre <> 0)) (PreH3 : (linklist_node_pre <> 0)) ,
  (xizi_dllseg first head linklist_pre old_prev nodes_before )
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> linklist_node_pre)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> old_prev)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> head)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_pre)
|--
  (xizi_dllseg first head head linklist_node_pre (xizi_double_link_insert_after_nodes (nodes_before) (linklist_pre) (linklist_node_pre) (nodes_after)) )
.

Module Type VC_Correct.

Include xizi_double_link_Strategy_Correct.

Axiom proof_of_xizi_double_link_insert_after_entail_wit_1 : xizi_double_link_insert_after_entail_wit_1.
Axiom proof_of_xizi_double_link_insert_after_return_wit_1 : xizi_double_link_insert_after_return_wit_1.
Axiom proof_of_xizi_double_link_insert_after_return_wit_2 : xizi_double_link_insert_after_return_wit_2.

End VC_Correct.
