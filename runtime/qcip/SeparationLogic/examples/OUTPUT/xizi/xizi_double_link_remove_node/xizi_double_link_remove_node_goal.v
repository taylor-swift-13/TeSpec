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
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_remove_node Require Import xizi_double_link_remove_node_lib.
Local Open Scope sac.
From QCIPLib.xizi.xizi_double_link_common Require Import xizi_double_link_strategy_goal.
From QCIPLib.xizi.xizi_double_link_common Require Import xizi_double_link_strategy_proof.

(*----- Function xizi_double_link_remove_node -----*)

Definition xizi_double_link_remove_node_entail_wit_1 := 
(
forall (linklist_node_pre: Z) (suffix: (@list Z)) (prefix: (@list Z)) (head: Z) ,
  (xizi_dll head (app (prefix) ((cons (linklist_node_pre) (suffix)))) )
|--
  EX (node_next: Z)  (node_prev: Z) ,
  “ (linklist_node_pre <> 0) ”
  &&  (xizi_dllseg_shift head node_prev prefix )
  **  ((&((node_prev)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> linklist_node_pre)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> node_next)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> node_prev)
  **  ((&((node_next)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_node_pre)
  **  (xizi_dllseg_shift_rev node_next head suffix )
) \/
(
forall (linklist_node_pre: Z) (suffix: (@list Z)) (prefix: (@list Z)) (head: Z) (first: Z) (last: Z) ,
  (xizi_dllseg first head head last (app (prefix) ((cons (linklist_node_pre) (suffix)))) )
  **  ((&((head)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
  **  ((&((head)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
|--
  EX (node_next: Z)  (node_prev: Z) ,
  “ (linklist_node_pre <> 0) ”
  &&  (xizi_dllseg_shift head node_prev prefix )
  **  ((&((node_prev)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> linklist_node_pre)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> node_next)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> node_prev)
  **  ((&((node_next)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_node_pre)
  **  (xizi_dllseg_shift_rev node_next head suffix )
).

Definition xizi_double_link_remove_node_return_wit_1 := 
(
forall (linklist_node_pre: Z) (suffix: (@list Z)) (prefix: (@list Z)) (head: Z) (node_next: Z) (node_prev: Z) (PreH1 : (linklist_node_pre <> 0)) ,
  (xizi_dllseg_shift head node_prev prefix )
  **  ((&((node_prev)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> node_next)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> linklist_node_pre)
  **  ((&((linklist_node_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_node_pre)
  **  ((&((node_next)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> node_prev)
  **  (xizi_dllseg_shift_rev node_next head suffix )
|--
  (xizi_dll head (app (prefix) (suffix)) )
  **  (xizi_dll linklist_node_pre (@nil Z) )
) \/
(
forall (linklist_node_pre: Z) (suffix: (@list Z)) (prefix: (@list Z)) (head: Z) (node_next: Z) (node_prev: Z) (PreH1 : (linklist_node_pre <> 0)) ,
  (xizi_dllseg_shift head node_prev prefix )
  **  ((&((node_prev)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> node_next)
  **  ((&((node_next)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> node_prev)
  **  (xizi_dllseg_shift_rev node_next head suffix )
|--
  EX (last: Z)  (first: Z) ,
  (xizi_dllseg first head head last (app (prefix) (suffix)) )
  **  ((&((head)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
  **  ((&((head)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
).

Module Type VC_Correct.

Include xizi_double_link_Strategy_Correct.

Axiom proof_of_xizi_double_link_remove_node_entail_wit_1 : xizi_double_link_remove_node_entail_wit_1.
Axiom proof_of_xizi_double_link_remove_node_return_wit_1 : xizi_double_link_remove_node_return_wit_1.

End VC_Correct.
