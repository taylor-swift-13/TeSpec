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

(*----- Function xizi_double_link_empty -----*)

Definition xizi_double_link_empty_return_wit_1 := 
(
forall (linklist_pre: Z) (nodes: (@list Z)) (first: Z) (last: Z) (PreH1 : (first <> linklist_pre)) (PreH2 : (linklist_pre <> 0)) ,
  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  (xizi_dllseg first linklist_pre linklist_pre last nodes )
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
|--
  “ (0 = 0) ” 
  &&  “ (nodes <> (@nil Z)) ”
  &&  (xizi_dll linklist_pre nodes )
) \/
(
forall (linklist_pre: Z) (nodes: (@list Z)) (first: Z) (last: Z) (next: Z) (l0: (@list Z)) (PreH1 : (nodes = (cons (first) (l0)))) (PreH2 : (first <> linklist_pre)) (PreH3 : (linklist_pre <> 0)) ,
  (xizi_dllseg next first linklist_pre last l0 )
  **  ((&((first)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_pre)
  **  ((&((first)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> next)
|--
  “ (nodes <> (@nil Z)) ”
  &&  (xizi_dllseg first linklist_pre linklist_pre last nodes )
).

Definition xizi_double_link_empty_return_wit_1_split_goal_1 := 
forall (linklist_pre: Z) (nodes: (@list Z)) (first: Z) (last: Z) (next: Z) (l0: (@list Z)) (PreH1 : (nodes = (cons (first) (l0)))) (PreH2 : (first <> linklist_pre)) (PreH3 : (linklist_pre <> 0)) ,
  (xizi_dllseg next first linklist_pre last l0 )
  **  ((&((first)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_pre)
  **  ((&((first)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> next)
|--
  “ (nodes <> (@nil Z)) ”
.

Definition xizi_double_link_empty_return_wit_1_split_goal_spatial := 
forall (linklist_pre: Z) (nodes: (@list Z)) (first: Z) (last: Z) (next: Z) (l0: (@list Z)) (PreH1 : (nodes = (cons (first) (l0)))) (PreH2 : (first <> linklist_pre)) (PreH3 : (linklist_pre <> 0)) ,
  (xizi_dllseg next first linklist_pre last l0 )
  **  ((&((first)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> linklist_pre)
  **  ((&((first)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> next)
|--
  (xizi_dllseg first linklist_pre linklist_pre last nodes )
.

Definition xizi_double_link_empty_return_wit_2 := 
(
forall (linklist_pre: Z) (nodes: (@list Z)) (first: Z) (last: Z) (PreH1 : (first = linklist_pre)) (PreH2 : (linklist_pre <> 0)) ,
  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  (xizi_dllseg first linklist_pre linklist_pre last nodes )
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
|--
  “ (1 = 1) ” 
  &&  “ (nodes = (@nil Z)) ”
  &&  (xizi_dll linklist_pre nodes )
) \/
(
forall (linklist_pre: Z) (nodes: (@list Z)) (first: Z) (last: Z) (PreH1 : (first = linklist_pre)) (PreH2 : (linklist_pre <> 0)) ,
  (xizi_dllseg first linklist_pre linklist_pre last nodes )
|--
  “ (nodes = (@nil Z)) ”
  &&  (xizi_dllseg first linklist_pre linklist_pre last nodes )
).

Definition xizi_double_link_empty_return_wit_2_split_goal_1 := 
forall (linklist_pre: Z) (nodes: (@list Z)) (first: Z) (last: Z) (PreH1 : (first = linklist_pre)) (PreH2 : (linklist_pre <> 0)) ,
  (xizi_dllseg first linklist_pre linklist_pre last nodes )
|--
  “ (nodes = (@nil Z)) ”
.

Definition xizi_double_link_empty_return_wit_2_split_goal_spatial := 
forall (linklist_pre: Z) (nodes: (@list Z)) (first: Z) (last: Z) (PreH1 : (first = linklist_pre)) (PreH2 : (linklist_pre <> 0)) ,
  (xizi_dllseg first linklist_pre linklist_pre last nodes )
|--
  (xizi_dllseg first linklist_pre linklist_pre last nodes )
.

Definition xizi_double_link_empty_partial_solve_wit_1 := 
forall (linklist_pre: Z) (nodes: (@list Z)) (PreH1 : (linklist_pre <> 0)) ,
  (xizi_dll linklist_pre nodes )
|--
  EX (last: Z)  (first: Z) ,
  “ (linklist_pre <> 0) ”
  &&  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  (xizi_dllseg first linklist_pre linklist_pre last nodes )
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
.

Module Type VC_Correct.

Include xizi_double_link_Strategy_Correct.

Axiom proof_of_xizi_double_link_empty_return_wit_1 : xizi_double_link_empty_return_wit_1.
Axiom proof_of_xizi_double_link_empty_return_wit_2 : xizi_double_link_empty_return_wit_2.
Axiom proof_of_xizi_double_link_empty_partial_solve_wit_1 : xizi_double_link_empty_partial_solve_wit_1.

End VC_Correct.
