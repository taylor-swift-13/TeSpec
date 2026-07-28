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
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_len Require Import xizi_double_link_len_lib.
Local Open Scope sac.
From QCIPLib.xizi.xizi_double_link_common Require Import xizi_double_link_strategy_goal.
From QCIPLib.xizi.xizi_double_link_common Require Import xizi_double_link_strategy_proof.

(*----- Function xizi_double_link_len -----*)

Definition xizi_double_link_len_safety_wit_1 := 
forall (linklist_pre: Z) (nodes: (@list Z)) (PreH1 : (linklist_pre <> 0)) (PreH2 : ((xizi_double_link_size (nodes)) <= 4294967295)) ,
  ((( &( "linklist_length" ) )) # UInt  |->_)
  **  ((( &( "linklist" ) )) # Ptr  |-> linklist_pre)
  **  (xizi_dll linklist_pre nodes )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition xizi_double_link_len_entail_wit_1 := 
(
forall (linklist_pre: Z) (nodes: (@list Z)) (PreH1 : (linklist_pre <> 0)) (PreH2 : ((xizi_double_link_size (nodes)) <= 4294967295)) ,
  (xizi_dll linklist_pre nodes )
|--
  EX (last: Z)  (first: Z)  (done: (@list Z))  (todo: (@list Z)) ,
  “ (nodes = (app (done) (todo))) ” 
  &&  “ (linklist_pre <> 0) ” 
  &&  “ (0 = (Zlength (done))) ” 
  &&  “ ((Zlength (nodes)) = ((Zlength (done)) + (Zlength (todo)) )) ” 
  &&  “ ((xizi_double_link_size (nodes)) <= 4294967295) ” 
  &&  “ (done = (@nil Z)) ” 
  &&  “ (linklist_pre = linklist_pre) ”
  &&  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
  **  (xizi_dllseg first linklist_pre linklist_pre last todo )
) \/
(
forall (linklist_pre: Z) (nodes: (@list Z)) (first_2: Z) (last_2: Z) (PreH1 : (linklist_pre <> 0)) (PreH2 : ((xizi_double_link_size (nodes)) <= 4294967295)) ,
  (xizi_dllseg first_2 linklist_pre linklist_pre last_2 nodes )
|--
  EX (todo: (@list Z)) ,
  “ (nodes = (app ((@nil Z)) (todo))) ” 
  &&  “ (linklist_pre <> 0) ” 
  &&  “ (0 = (Zlength ((@nil Z)))) ” 
  &&  “ ((Zlength (nodes)) = ((Zlength ((@nil Z))) + (Zlength (todo)) )) ” 
  &&  “ ((xizi_double_link_size (nodes)) <= 4294967295) ”
  &&  (xizi_dllseg first_2 linklist_pre linklist_pre last_2 todo )
).

Definition xizi_double_link_len_entail_wit_2_1 := 
(
forall (linklist_pre: Z) (nodes: (@list Z)) (next_2: Z) (prev_2: Z) (last_2: Z) (first_2: Z) (before_2: (@list Z)) (tmp_node: Z) (linklist_length: Z) (done_2: (@list Z)) (todo_2: (@list Z)) (PreH1 : (next_2 <> linklist_pre)) (PreH2 : (nodes = (app (done_2) (todo_2)))) (PreH3 : (linklist_pre <> 0)) (PreH4 : (linklist_length = (Zlength (done_2)))) (PreH5 : ((Zlength (nodes)) = ((Zlength (done_2)) + (Zlength (todo_2)) ))) (PreH6 : ((xizi_double_link_size (nodes)) <= 4294967295)) (PreH7 : (done_2 = (app (before_2) ((cons (tmp_node) ((@nil Z))))))) (PreH8 : (tmp_node <> 0)) (PreH9 : (tmp_node <> linklist_pre)) ,
  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first_2)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last_2)
  **  (xizi_dllseg first_2 linklist_pre tmp_node prev_2 before_2 )
  **  ((&((tmp_node)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> next_2)
  **  ((&((tmp_node)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> prev_2)
  **  (xizi_dllseg next_2 tmp_node linklist_pre last_2 todo_2 )
|--
  EX (next: Z)  (prev: Z)  (last: Z)  (first: Z)  (before: (@list Z))  (done: (@list Z))  (todo: (@list Z)) ,
  “ (nodes = (app (done) (todo))) ” 
  &&  “ (linklist_pre <> 0) ” 
  &&  “ ((unsigned_last_nbits ((linklist_length + 1 )) (32)) = (Zlength (done))) ” 
  &&  “ ((Zlength (nodes)) = ((Zlength (done)) + (Zlength (todo)) )) ” 
  &&  “ ((xizi_double_link_size (nodes)) <= 4294967295) ” 
  &&  “ (done = (app (before) ((cons (next_2) ((@nil Z)))))) ” 
  &&  “ (next_2 <> 0) ” 
  &&  “ (next_2 <> linklist_pre) ”
  &&  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
  **  (xizi_dllseg first linklist_pre next_2 prev before )
  **  ((&((next_2)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> next)
  **  ((&((next_2)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> prev)
  **  (xizi_dllseg next next_2 linklist_pre last todo )
) \/
(
forall (linklist_pre: Z) (nodes: (@list Z)) (next_2: Z) (prev_2: Z) (last_2: Z) (first_2: Z) (before_2: (@list Z)) (tmp_node: Z) (linklist_length: Z) (done_2: (@list Z)) (todo_2: (@list Z)) (next_3: Z) (l0: (@list Z)) (PreH1 : (todo_2 = (cons (next_2) (l0)))) (PreH2 : (next_2 <> linklist_pre)) (PreH3 : (nodes = (app (done_2) (todo_2)))) (PreH4 : (linklist_pre <> 0)) (PreH5 : (linklist_length = (Zlength (done_2)))) (PreH6 : ((Zlength (nodes)) = ((Zlength (done_2)) + (Zlength (todo_2)) ))) (PreH7 : ((xizi_double_link_size (nodes)) <= 4294967295)) (PreH8 : (done_2 = (app (before_2) ((cons (tmp_node) ((@nil Z))))))) (PreH9 : (tmp_node <> 0)) (PreH10 : (tmp_node <> linklist_pre)) ,
  (xizi_dllseg next_3 next_2 linklist_pre last_2 l0 )
  **  (xizi_dllseg first_2 linklist_pre tmp_node prev_2 before_2 )
  **  ((&((tmp_node)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> next_2)
  **  ((&((tmp_node)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> prev_2)
|--
  EX (before: (@list Z))  (todo: (@list Z)) ,
  “ (nodes = (app ((app (before) ((cons (next_2) ((@nil Z)))))) (todo))) ” 
  &&  “ (linklist_pre <> 0) ” 
  &&  “ ((unsigned_last_nbits ((linklist_length + 1 )) (32)) = (Zlength ((app (before) ((cons (next_2) ((@nil Z)))))))) ” 
  &&  “ ((Zlength (nodes)) = ((Zlength ((app (before) ((cons (next_2) ((@nil Z))))))) + (Zlength (todo)) )) ” 
  &&  “ ((xizi_double_link_size (nodes)) <= 4294967295) ” 
  &&  “ (next_2 <> 0) ” 
  &&  “ (next_2 <> linklist_pre) ”
  &&  (xizi_dllseg first_2 linklist_pre next_2 tmp_node before )
  **  (xizi_dllseg next_3 next_2 linklist_pre last_2 todo )
).

Definition xizi_double_link_len_entail_wit_2_2 := 
(
forall (linklist_pre: Z) (nodes: (@list Z)) (last_2: Z) (first_2: Z) (tmp_node: Z) (linklist_length: Z) (done_2: (@list Z)) (todo_2: (@list Z)) (PreH1 : (first_2 <> linklist_pre)) (PreH2 : (nodes = (app (done_2) (todo_2)))) (PreH3 : (linklist_pre <> 0)) (PreH4 : (linklist_length = (Zlength (done_2)))) (PreH5 : ((Zlength (nodes)) = ((Zlength (done_2)) + (Zlength (todo_2)) ))) (PreH6 : ((xizi_double_link_size (nodes)) <= 4294967295)) (PreH7 : (done_2 = (@nil Z))) (PreH8 : (tmp_node = linklist_pre)) ,
  ((&((tmp_node)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first_2)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last_2)
  **  (xizi_dllseg first_2 linklist_pre linklist_pre last_2 todo_2 )
|--
  EX (next: Z)  (prev: Z)  (last: Z)  (first: Z)  (before: (@list Z))  (done: (@list Z))  (todo: (@list Z)) ,
  “ (nodes = (app (done) (todo))) ” 
  &&  “ (linklist_pre <> 0) ” 
  &&  “ ((unsigned_last_nbits ((linklist_length + 1 )) (32)) = (Zlength (done))) ” 
  &&  “ ((Zlength (nodes)) = ((Zlength (done)) + (Zlength (todo)) )) ” 
  &&  “ ((xizi_double_link_size (nodes)) <= 4294967295) ” 
  &&  “ (done = (app (before) ((cons (first_2) ((@nil Z)))))) ” 
  &&  “ (first_2 <> 0) ” 
  &&  “ (first_2 <> linklist_pre) ”
  &&  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
  **  (xizi_dllseg first linklist_pre first_2 prev before )
  **  ((&((first_2)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> next)
  **  ((&((first_2)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> prev)
  **  (xizi_dllseg next first_2 linklist_pre last todo )
) \/
(
forall (linklist_pre: Z) (nodes: (@list Z)) (last_2: Z) (first_2: Z) (tmp_node: Z) (linklist_length: Z) (done_2: (@list Z)) (todo_2: (@list Z)) (next_2: Z) (l0: (@list Z)) (PreH1 : (todo_2 = (cons (first_2) (l0)))) (PreH2 : (first_2 <> linklist_pre)) (PreH3 : (nodes = (app (done_2) (todo_2)))) (PreH4 : (linklist_pre <> 0)) (PreH5 : (linklist_length = (Zlength (done_2)))) (PreH6 : ((Zlength (nodes)) = ((Zlength (done_2)) + (Zlength (todo_2)) ))) (PreH7 : ((xizi_double_link_size (nodes)) <= 4294967295)) (PreH8 : (done_2 = (@nil Z))) (PreH9 : (tmp_node = linklist_pre)) ,
  (xizi_dllseg next_2 first_2 linklist_pre last_2 l0 )
  **  ((&((tmp_node)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first_2)
|--
  EX (first: Z)  (before: (@list Z))  (todo: (@list Z)) ,
  “ (nodes = (app ((app (before) ((cons (first_2) ((@nil Z)))))) (todo))) ” 
  &&  “ (linklist_pre <> 0) ” 
  &&  “ ((unsigned_last_nbits ((linklist_length + 1 )) (32)) = (Zlength ((app (before) ((cons (first_2) ((@nil Z)))))))) ” 
  &&  “ ((Zlength (nodes)) = ((Zlength ((app (before) ((cons (first_2) ((@nil Z))))))) + (Zlength (todo)) )) ” 
  &&  “ ((xizi_double_link_size (nodes)) <= 4294967295) ” 
  &&  “ (first_2 <> 0) ” 
  &&  “ (first_2 <> linklist_pre) ”
  &&  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  (xizi_dllseg first linklist_pre first_2 linklist_pre before )
  **  (xizi_dllseg next_2 first_2 linklist_pre last_2 todo )
).

Definition xizi_double_link_len_return_wit_1 := 
(
forall (linklist_pre: Z) (nodes: (@list Z)) (next: Z) (prev: Z) (last: Z) (first: Z) (before: (@list Z)) (tmp_node: Z) (linklist_length: Z) (done: (@list Z)) (todo: (@list Z)) (PreH1 : (next = linklist_pre)) (PreH2 : (nodes = (app (done) (todo)))) (PreH3 : (linklist_pre <> 0)) (PreH4 : (linklist_length = (Zlength (done)))) (PreH5 : ((Zlength (nodes)) = ((Zlength (done)) + (Zlength (todo)) ))) (PreH6 : ((xizi_double_link_size (nodes)) <= 4294967295)) (PreH7 : (done = (app (before) ((cons (tmp_node) ((@nil Z))))))) (PreH8 : (tmp_node <> 0)) (PreH9 : (tmp_node <> linklist_pre)) ,
  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
  **  (xizi_dllseg first linklist_pre tmp_node prev before )
  **  ((&((tmp_node)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> next)
  **  ((&((tmp_node)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> prev)
  **  (xizi_dllseg next tmp_node linklist_pre last todo )
|--
  “ (linklist_length = (xizi_double_link_size (nodes))) ”
  &&  (xizi_dll linklist_pre nodes )
) \/
(
forall (linklist_pre: Z) (nodes: (@list Z)) (next: Z) (prev: Z) (last: Z) (first: Z) (before: (@list Z)) (tmp_node: Z) (linklist_length: Z) (done: (@list Z)) (todo: (@list Z)) (PreH1 : (next = linklist_pre)) (PreH2 : (nodes = (app (done) (todo)))) (PreH3 : (linklist_pre <> 0)) (PreH4 : (linklist_length = (Zlength (done)))) (PreH5 : ((Zlength (nodes)) = ((Zlength (done)) + (Zlength (todo)) ))) (PreH6 : ((xizi_double_link_size (nodes)) <= 4294967295)) (PreH7 : (done = (app (before) ((cons (tmp_node) ((@nil Z))))))) (PreH8 : (tmp_node <> 0)) (PreH9 : (tmp_node <> linklist_pre)) ,
  (xizi_dllseg first linklist_pre tmp_node prev before )
  **  ((&((tmp_node)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> next)
  **  ((&((tmp_node)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> prev)
  **  (xizi_dllseg next tmp_node linklist_pre last todo )
|--
  “ (linklist_length = (xizi_double_link_size (nodes))) ”
  &&  (xizi_dllseg first linklist_pre linklist_pre last nodes )
).

Definition xizi_double_link_len_return_wit_1_split_goal_1 := 
forall (linklist_pre: Z) (nodes: (@list Z)) (next: Z) (prev: Z) (last: Z) (first: Z) (before: (@list Z)) (tmp_node: Z) (linklist_length: Z) (done: (@list Z)) (todo: (@list Z)) (PreH1 : (next = linklist_pre)) (PreH2 : (nodes = (app (done) (todo)))) (PreH3 : (linklist_pre <> 0)) (PreH4 : (linklist_length = (Zlength (done)))) (PreH5 : ((Zlength (nodes)) = ((Zlength (done)) + (Zlength (todo)) ))) (PreH6 : ((xizi_double_link_size (nodes)) <= 4294967295)) (PreH7 : (done = (app (before) ((cons (tmp_node) ((@nil Z))))))) (PreH8 : (tmp_node <> 0)) (PreH9 : (tmp_node <> linklist_pre)) ,
  (xizi_dllseg first linklist_pre tmp_node prev before )
  **  ((&((tmp_node)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> next)
  **  ((&((tmp_node)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> prev)
  **  (xizi_dllseg next tmp_node linklist_pre last todo )
|--
  “ (linklist_length = (xizi_double_link_size (nodes))) ”
.

Definition xizi_double_link_len_return_wit_1_split_goal_spatial := 
forall (linklist_pre: Z) (nodes: (@list Z)) (next: Z) (prev: Z) (last: Z) (first: Z) (before: (@list Z)) (tmp_node: Z) (linklist_length: Z) (done: (@list Z)) (todo: (@list Z)) (PreH1 : (next = linklist_pre)) (PreH2 : (nodes = (app (done) (todo)))) (PreH3 : (linklist_pre <> 0)) (PreH4 : (linklist_length = (Zlength (done)))) (PreH5 : ((Zlength (nodes)) = ((Zlength (done)) + (Zlength (todo)) ))) (PreH6 : ((xizi_double_link_size (nodes)) <= 4294967295)) (PreH7 : (done = (app (before) ((cons (tmp_node) ((@nil Z))))))) (PreH8 : (tmp_node <> 0)) (PreH9 : (tmp_node <> linklist_pre)) ,
  (xizi_dllseg first linklist_pre tmp_node prev before )
  **  ((&((tmp_node)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> next)
  **  ((&((tmp_node)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> prev)
  **  (xizi_dllseg next tmp_node linklist_pre last todo )
|--
  (xizi_dllseg first linklist_pre linklist_pre last nodes )
.

Definition xizi_double_link_len_return_wit_2 := 
(
forall (linklist_pre: Z) (nodes: (@list Z)) (last: Z) (first: Z) (tmp_node: Z) (linklist_length: Z) (done: (@list Z)) (todo: (@list Z)) (PreH1 : (first = linklist_pre)) (PreH2 : (nodes = (app (done) (todo)))) (PreH3 : (linklist_pre <> 0)) (PreH4 : (linklist_length = (Zlength (done)))) (PreH5 : ((Zlength (nodes)) = ((Zlength (done)) + (Zlength (todo)) ))) (PreH6 : ((xizi_double_link_size (nodes)) <= 4294967295)) (PreH7 : (done = (@nil Z))) (PreH8 : (tmp_node = linklist_pre)) ,
  ((&((tmp_node)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
  **  (xizi_dllseg first linklist_pre linklist_pre last todo )
|--
  “ (linklist_length = (xizi_double_link_size (nodes))) ”
  &&  (xizi_dll linklist_pre nodes )
) \/
(
forall (linklist_pre: Z) (nodes: (@list Z)) (last: Z) (first: Z) (tmp_node: Z) (linklist_length: Z) (done: (@list Z)) (todo: (@list Z)) (PreH1 : (first = linklist_pre)) (PreH2 : (nodes = (app (done) (todo)))) (PreH3 : (linklist_pre <> 0)) (PreH4 : (linklist_length = (Zlength (done)))) (PreH5 : ((Zlength (nodes)) = ((Zlength (done)) + (Zlength (todo)) ))) (PreH6 : ((xizi_double_link_size (nodes)) <= 4294967295)) (PreH7 : (done = (@nil Z))) (PreH8 : (tmp_node = linklist_pre)) ,
  ((&((tmp_node)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  (xizi_dllseg first linklist_pre linklist_pre last todo )
|--
  EX (first_2: Z) ,
  “ (linklist_length = (xizi_double_link_size (nodes))) ”
  &&  (xizi_dllseg first_2 linklist_pre linklist_pre last nodes )
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first_2)
).

Definition xizi_double_link_len_partial_solve_wit_1 := 
forall (linklist_pre: Z) (nodes: (@list Z)) (last: Z) (first: Z) (tmp_node: Z) (linklist_length: Z) (done: (@list Z)) (todo: (@list Z)) (PreH1 : (nodes = (app (done) (todo)))) (PreH2 : (linklist_pre <> 0)) (PreH3 : (linklist_length = (Zlength (done)))) (PreH4 : ((Zlength (nodes)) = ((Zlength (done)) + (Zlength (todo)) ))) (PreH5 : ((xizi_double_link_size (nodes)) <= 4294967295)) (PreH6 : (done = (@nil Z))) (PreH7 : (tmp_node = linklist_pre)) ,
  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
  **  (xizi_dllseg first linklist_pre linklist_pre last todo )
|--
  “ (nodes = (app (done) (todo))) ” 
  &&  “ (linklist_pre <> 0) ” 
  &&  “ (linklist_length = (Zlength (done))) ” 
  &&  “ ((Zlength (nodes)) = ((Zlength (done)) + (Zlength (todo)) )) ” 
  &&  “ ((xizi_double_link_size (nodes)) <= 4294967295) ” 
  &&  “ (done = (@nil Z)) ” 
  &&  “ (tmp_node = linklist_pre) ”
  &&  ((&((tmp_node)  # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr  |-> first)
  **  ((&((linklist_pre)  # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr  |-> last)
  **  (xizi_dllseg first linklist_pre linklist_pre last todo )
.

Module Type VC_Correct.

Include xizi_double_link_Strategy_Correct.

Axiom proof_of_xizi_double_link_len_safety_wit_1 : xizi_double_link_len_safety_wit_1.
Axiom proof_of_xizi_double_link_len_entail_wit_1 : xizi_double_link_len_entail_wit_1.
Axiom proof_of_xizi_double_link_len_entail_wit_2_1 : xizi_double_link_len_entail_wit_2_1.
Axiom proof_of_xizi_double_link_len_entail_wit_2_2 : xizi_double_link_len_entail_wit_2_2.
Axiom proof_of_xizi_double_link_len_return_wit_1 : xizi_double_link_len_return_wit_1.
Axiom proof_of_xizi_double_link_len_return_wit_2 : xizi_double_link_len_return_wit_2.
Axiom proof_of_xizi_double_link_len_partial_solve_wit_1 : xizi_double_link_len_partial_solve_wit_1.

End VC_Correct.
