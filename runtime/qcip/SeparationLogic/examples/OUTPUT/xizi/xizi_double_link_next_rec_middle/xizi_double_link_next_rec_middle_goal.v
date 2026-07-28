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
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_next_rec_middle Require Import xizi_double_link_next_rec_middle_lib.
Local Open Scope sac.
From QCIPLib.xizi.xizi_double_link_common Require Import xizi_double_link_strategy_goal.
From QCIPLib.xizi.xizi_double_link_common Require Import xizi_double_link_strategy_proof.

(*----- Function xizi_double_link_next_rec_middle -----*)

Definition xizi_double_link_next_rec_middle_safety_wit_1 := 
forall (linklist_node_pre: Z) (linklist_pre: Z) (nodes_after: (@list Z)) (nodes_before: (@list Z)) (node: Z) (head: Z) (first: Z) (last: Z) (node_next: Z) (node_prev: Z) (PreH1 : (node_next = linklist_pre)) (PreH2 : (linklist_pre = head)) (PreH3 : (linklist_node_pre = node)) (PreH4 : (linklist_node_pre <> 0)) ,
  ((( &( "linklist" ) )) # Ptr  |-> linklist_pre)
  **  ((( &( "linklist_node" ) )) # Ptr  |-> linklist_node_pre)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
  **  (xizi_dllseg first head node node_prev nodes_before )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> node_next)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> node_prev)
  **  (xizi_dllseg node_next node head last nodes_after )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition xizi_double_link_next_rec_middle_entail_wit_1 := 
(
forall (linklist_node_pre: Z) (linklist_pre: Z) (nodes_after: (@list Z)) (nodes_before: (@list Z)) (node: Z) (head: Z) (PreH1 : (linklist_pre = head)) (PreH2 : (linklist_node_pre = node)) (PreH3 : (linklist_node_pre <> 0)) ,
  (xizi_dll head (app (nodes_before) ((cons (node) (nodes_after)))) )
|--
  EX (node_next: Z)  (node_prev: Z)  (last: Z)  (first: Z) ,
  “ (linklist_pre = head) ” 
  &&  “ (linklist_node_pre = node) ” 
  &&  “ (linklist_node_pre <> 0) ”
  &&  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
  **  (xizi_dllseg first head node node_prev nodes_before )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> node_next)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> node_prev)
  **  (xizi_dllseg node_next node head last nodes_after )
) \/
(
forall (linklist_node_pre: Z) (linklist_pre: Z) (nodes_after: (@list Z)) (nodes_before: (@list Z)) (node: Z) (head: Z) (first_2: Z) (last_2: Z) (PreH1 : (linklist_pre = head)) (PreH2 : (linklist_node_pre = node)) (PreH3 : (linklist_node_pre <> 0)) ,
  (xizi_dllseg first_2 head head last_2 (app (nodes_before) ((cons (node) (nodes_after)))) )
  **  ((&((head)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last_2)
  **  ((&((head)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first_2)
|--
  EX (node_next: Z)  (node_prev: Z)  (last: Z)  (first: Z) ,
  “ (linklist_pre = head) ” 
  &&  “ (linklist_node_pre = node) ” 
  &&  “ (linklist_node_pre <> 0) ”
  &&  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
  **  (xizi_dllseg first head node node_prev nodes_before )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> node_next)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> node_prev)
  **  (xizi_dllseg node_next node head last nodes_after )
).

Definition xizi_double_link_next_rec_middle_return_wit_1 := 
(
forall (linklist_node_pre: Z) (linklist_pre: Z) (nodes_after: (@list Z)) (nodes_before: (@list Z)) (node: Z) (head: Z) (first: Z) (last: Z) (node_next: Z) (node_prev: Z) (PreH1 : (node_next = linklist_pre)) (PreH2 : (linklist_pre = head)) (PreH3 : (linklist_node_pre = node)) (PreH4 : (linklist_node_pre <> 0)) ,
  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
  **  (xizi_dllseg first head node node_prev nodes_before )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> node_next)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> node_prev)
  **  (xizi_dllseg node_next node head last nodes_after )
|--
  “ (0 = (xizi_double_link_next_value (nodes_after))) ”
  &&  (xizi_dll head (app (nodes_before) ((cons (node) (nodes_after)))) )
) \/
(
forall (linklist_node_pre: Z) (linklist_pre: Z) (nodes_after: (@list Z)) (nodes_before: (@list Z)) (node: Z) (head: Z) (first: Z) (last: Z) (node_next: Z) (node_prev: Z) (PreH1 : (node_next = linklist_pre)) (PreH2 : (linklist_pre = head)) (PreH3 : (linklist_node_pre = node)) (PreH4 : (linklist_node_pre <> 0)) ,
  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
  **  (xizi_dllseg first head node node_prev nodes_before )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> node_next)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> node_prev)
  **  (xizi_dllseg node_next node head last nodes_after )
|--
  EX (last_2: Z)  (first_2: Z) ,
  “ (0 = (xizi_double_link_next_value (nodes_after))) ”
  &&  (xizi_dllseg first_2 head head last_2 (app (nodes_before) ((cons (node) (nodes_after)))) )
  **  ((&((head)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last_2)
  **  ((&((head)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first_2)
).

Definition xizi_double_link_next_rec_middle_return_wit_2 := 
(
forall (linklist_node_pre: Z) (linklist_pre: Z) (nodes_after: (@list Z)) (nodes_before: (@list Z)) (node: Z) (head: Z) (first: Z) (last: Z) (node_next: Z) (node_prev: Z) (PreH1 : (node_next <> linklist_pre)) (PreH2 : (linklist_pre = head)) (PreH3 : (linklist_node_pre = node)) (PreH4 : (linklist_node_pre <> 0)) ,
  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
  **  (xizi_dllseg first head node node_prev nodes_before )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> node_next)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> node_prev)
  **  (xizi_dllseg node_next node head last nodes_after )
|--
  “ (node_next = (xizi_double_link_next_value (nodes_after))) ”
  &&  (xizi_dll head (app (nodes_before) ((cons (node) (nodes_after)))) )
) \/
(
forall (linklist_node_pre: Z) (linklist_pre: Z) (nodes_after: (@list Z)) (nodes_before: (@list Z)) (node: Z) (head: Z) (first: Z) (last: Z) (node_next: Z) (node_prev: Z) (PreH1 : (node_next <> linklist_pre)) (PreH2 : (linklist_pre = head)) (PreH3 : (linklist_node_pre = node)) (PreH4 : (linklist_node_pre <> 0)) ,
  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
  **  (xizi_dllseg first head node node_prev nodes_before )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> node_next)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> node_prev)
  **  (xizi_dllseg node_next node head last nodes_after )
|--
  EX (last_2: Z)  (first_2: Z) ,
  “ (node_next = (xizi_double_link_next_value (nodes_after))) ”
  &&  (xizi_dllseg first_2 head head last_2 (app (nodes_before) ((cons (node) (nodes_after)))) )
  **  ((&((head)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last_2)
  **  ((&((head)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first_2)
).

Module Type VC_Correct.

Include xizi_double_link_Strategy_Correct.

Axiom proof_of_xizi_double_link_next_rec_middle_safety_wit_1 : xizi_double_link_next_rec_middle_safety_wit_1.
Axiom proof_of_xizi_double_link_next_rec_middle_entail_wit_1 : xizi_double_link_next_rec_middle_entail_wit_1.
Axiom proof_of_xizi_double_link_next_rec_middle_return_wit_1 : xizi_double_link_next_rec_middle_return_wit_1.
Axiom proof_of_xizi_double_link_next_rec_middle_return_wit_2 : xizi_double_link_next_rec_middle_return_wit_2.

End VC_Correct.
