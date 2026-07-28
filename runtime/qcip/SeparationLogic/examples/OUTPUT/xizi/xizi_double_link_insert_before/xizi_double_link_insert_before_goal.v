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
Local Open Scope sac.
From QCIPLib.xizi.xizi_double_link_common Require Import xizi_double_link_strategy_goal.
From QCIPLib.xizi.xizi_double_link_common Require Import xizi_double_link_strategy_proof.

(*----- Function xizi_double_link_insert_before -----*)

Definition xizi_double_link_insert_before_entail_wit_1 := 
forall (linklist_node_pre: Z) (linklist_pre: Z) (suffix: (@list Z)) (prefix: (@list Z)) (head: Z) (PreH1 : (head <> 0)) (PreH2 : (linklist_pre <> 0)) (PreH3 : (linklist_node_pre <> 0)) ,
  (xizi_dll head (app (prefix) ((cons (linklist_pre) (suffix)))) )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |->_)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |->_)
|--
  (EX (last: Z)  (next: Z)  (before_prev: Z)  (prev: Z) ,
  “ (head <> 0) ” 
  &&  “ (linklist_pre = linklist_pre) ” 
  &&  “ (linklist_pre <> 0) ” 
  &&  “ (linklist_pre <> head) ” 
  &&  “ (linklist_node_pre <> 0) ” 
  &&  “ (linklist_node_pre <> head) ” 
  &&  “ (linklist_node_pre <> linklist_pre) ” 
  &&  “ (prefix = (@nil Z)) ” 
  &&  “ (prev = head) ” 
  &&  “ (prev <> 0) ” 
  &&  “ (before_prev = last) ”
  &&  ((&((prev)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> linklist_pre)
  **  ((&((prev)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> before_prev)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> next)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> prev)
  **  (xizi_dllseg next linklist_pre head last suffix )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |->_)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |->_))
  ||
  (EX (first: Z)  (prefix0: (@list Z))  (last: Z)  (next: Z)  (before_prev: Z)  (prev: Z) ,
  “ (head <> 0) ” 
  &&  “ (linklist_pre <> 0) ” 
  &&  “ (linklist_pre <> head) ” 
  &&  “ (linklist_node_pre <> 0) ” 
  &&  “ (linklist_node_pre <> head) ” 
  &&  “ (linklist_node_pre <> linklist_pre) ” 
  &&  “ (prefix = (app (prefix0) ((cons (prev) ((@nil Z)))))) ” 
  &&  “ (prev <> 0) ” 
  &&  “ (prev <> head) ” 
  &&  “ (prev <> linklist_node_pre) ”
  &&  ((&((prev)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> linklist_pre)
  **  ((&((prev)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> before_prev)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> next)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> prev)
  **  (xizi_dllseg next linklist_pre head last suffix )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |->_)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |->_)
  **  ((&((head)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  ((&((head)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
  **  (xizi_dllseg first head prev before_prev prefix0 ))
.

Definition xizi_double_link_insert_before_return_wit_1 := 
(
forall (linklist_node_pre: Z) (linklist_pre: Z) (suffix: (@list Z)) (prefix: (@list Z)) (head: Z) (first: Z) (last: Z) (prev: Z) (before_prev: Z) (next: Z) (prefix0: (@list Z)) (PreH1 : (head <> 0)) (PreH2 : (linklist_pre <> 0)) (PreH3 : (linklist_pre <> head)) (PreH4 : (linklist_node_pre <> 0)) (PreH5 : (linklist_node_pre <> head)) (PreH6 : (linklist_node_pre <> linklist_pre)) (PreH7 : (prefix = (app (prefix0) ((cons (prev) ((@nil Z))))))) (PreH8 : (prev <> 0)) (PreH9 : (prev <> head)) (PreH10 : (prev <> linklist_node_pre)) ,
  ((&((prev)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> linklist_node_pre)
  **  ((&((prev)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> before_prev)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> next)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_node_pre)
  **  (xizi_dllseg next linklist_pre head last suffix )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> linklist_pre)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> prev)
  **  ((&((head)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  ((&((head)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
  **  (xizi_dllseg first head prev before_prev prefix0 )
|--
  (xizi_dll head (app (prefix) ((cons (linklist_node_pre) ((cons (linklist_pre) (suffix)))))) )
) \/
(
forall (linklist_node_pre: Z) (linklist_pre: Z) (suffix: (@list Z)) (prefix: (@list Z)) (head: Z) (first: Z) (last: Z) (prev: Z) (before_prev: Z) (next: Z) (prefix0: (@list Z)) (PreH1 : (head <> 0)) (PreH2 : (linklist_pre <> 0)) (PreH3 : (linklist_pre <> head)) (PreH4 : (linklist_node_pre <> 0)) (PreH5 : (linklist_node_pre <> head)) (PreH6 : (linklist_node_pre <> linklist_pre)) (PreH7 : (prefix = (app (prefix0) ((cons (prev) ((@nil Z))))))) (PreH8 : (prev <> 0)) (PreH9 : (prev <> head)) (PreH10 : (prev <> linklist_node_pre)) ,
  ((&((prev)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> linklist_node_pre)
  **  ((&((prev)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> before_prev)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> next)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_node_pre)
  **  (xizi_dllseg next linklist_pre head last suffix )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> linklist_pre)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> prev)
  **  (xizi_dllseg first head prev before_prev prefix0 )
|--
  (xizi_dllseg first head head last (app (prefix) ((cons (linklist_node_pre) ((cons (linklist_pre) (suffix)))))) )
).

Definition xizi_double_link_insert_before_return_wit_1_split_goal_spatial := 
forall (linklist_node_pre: Z) (linklist_pre: Z) (suffix: (@list Z)) (prefix: (@list Z)) (head: Z) (first: Z) (last: Z) (prev: Z) (before_prev: Z) (next: Z) (prefix0: (@list Z)) (PreH1 : (head <> 0)) (PreH2 : (linklist_pre <> 0)) (PreH3 : (linklist_pre <> head)) (PreH4 : (linklist_node_pre <> 0)) (PreH5 : (linklist_node_pre <> head)) (PreH6 : (linklist_node_pre <> linklist_pre)) (PreH7 : (prefix = (app (prefix0) ((cons (prev) ((@nil Z))))))) (PreH8 : (prev <> 0)) (PreH9 : (prev <> head)) (PreH10 : (prev <> linklist_node_pre)) ,
  ((&((prev)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> linklist_node_pre)
  **  ((&((prev)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> before_prev)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> next)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_node_pre)
  **  (xizi_dllseg next linklist_pre head last suffix )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> linklist_pre)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> prev)
  **  (xizi_dllseg first head prev before_prev prefix0 )
|--
  (xizi_dllseg first head head last (app (prefix) ((cons (linklist_node_pre) ((cons (linklist_pre) (suffix)))))) )
.

Definition xizi_double_link_insert_before_return_wit_2 := 
(
forall (linklist_node_pre: Z) (linklist_pre: Z) (suffix: (@list Z)) (prefix: (@list Z)) (head: Z) (first: Z) (last: Z) (prev: Z) (before_prev: Z) (next: Z) (PreH1 : (head <> 0)) (PreH2 : (first = linklist_pre)) (PreH3 : (first <> 0)) (PreH4 : (first <> head)) (PreH5 : (linklist_node_pre <> 0)) (PreH6 : (linklist_node_pre <> head)) (PreH7 : (linklist_node_pre <> first)) (PreH8 : (prefix = (@nil Z))) (PreH9 : (prev = head)) (PreH10 : (prev <> 0)) (PreH11 : (before_prev = last)) ,
  ((&((prev)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> linklist_node_pre)
  **  ((&((prev)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> before_prev)
  **  ((&((first)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> next)
  **  ((&((first)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_node_pre)
  **  (xizi_dllseg next first head last suffix )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> prev)
|--
  (xizi_dll head (app (prefix) ((cons (linklist_node_pre) ((cons (linklist_pre) (suffix)))))) )
) \/
(
forall (linklist_node_pre: Z) (linklist_pre: Z) (suffix: (@list Z)) (prefix: (@list Z)) (head: Z) (first: Z) (last: Z) (prev: Z) (before_prev: Z) (next: Z) (PreH1 : (head <> 0)) (PreH2 : (first = linklist_pre)) (PreH3 : (first <> 0)) (PreH4 : (first <> head)) (PreH5 : (linklist_node_pre <> 0)) (PreH6 : (linklist_node_pre <> head)) (PreH7 : (linklist_node_pre <> first)) (PreH8 : (prefix = (@nil Z))) (PreH9 : (prev = head)) (PreH10 : (prev <> 0)) (PreH11 : (before_prev = last)) ,
  ((&((prev)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> linklist_node_pre)
  **  ((&((prev)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> before_prev)
  **  ((&((first)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> next)
  **  ((&((first)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_node_pre)
  **  (xizi_dllseg next first head last suffix )
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> prev)
|--
  EX (last_2: Z)  (first_2: Z) ,
  (xizi_dllseg first_2 head head last_2 (app (prefix) ((cons (linklist_node_pre) ((cons (linklist_pre) (suffix)))))) )
  **  ((&((head)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last_2)
  **  ((&((head)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first_2)
).

Module Type VC_Correct.

Include xizi_double_link_Strategy_Correct.

Axiom proof_of_xizi_double_link_insert_before_entail_wit_1 : xizi_double_link_insert_before_entail_wit_1.
Axiom proof_of_xizi_double_link_insert_before_return_wit_1 : xizi_double_link_insert_before_return_wit_1.
Axiom proof_of_xizi_double_link_insert_before_return_wit_2 : xizi_double_link_insert_before_return_wit_2.

End VC_Correct.
