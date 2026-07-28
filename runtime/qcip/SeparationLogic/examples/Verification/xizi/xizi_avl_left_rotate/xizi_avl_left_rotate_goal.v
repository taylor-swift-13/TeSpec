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
Require Import
      SimpleC.EE.Verification.xizi.xizi_avl_left_rotate.xizi_avl_left_rotate_lib.
Local Open Scope sac.

(*----- Function xizi_avl_left_rotate -----*)

Definition xizi_avl_left_rotate_return_wit_1 := 
(
forall (avl_node_pre: Z) (before: addr_avl_tree) (c: addr_avl_tree) (b: addr_avl_tree) (a: addr_avl_tree) (right_height: Z) (right_data: Z) (root_height: Z) (root_data: Z) (far_right_addr: Z) (middle_addr: Z) (right_addr: Z) (left_addr: Z) (PreH1 : (avl_node_pre <> 0)) (PreH2 : (right_addr <> 0)) (PreH3 : (before = (avl_node_model (avl_node_pre) (root_data) (root_height) (a) ((avl_node_model (right_addr) (right_data) (right_height) (b) (c)))))) ,
  ((&((avl_node_pre)  # "AvlNode" ->ₛ "data")) # Int  |-> root_data)
  **  ((&((avl_node_pre)  # "AvlNode" ->ₛ "height")) # UInt  |-> root_height)
  **  ((&((avl_node_pre)  # "AvlNode" ->ₛ "left")) # Ptr  |-> left_addr)
  **  ((&((avl_node_pre)  # "AvlNode" ->ₛ "right")) # Ptr  |-> middle_addr)
  **  (store_addr_avl left_addr a )
  **  ((&((right_addr)  # "AvlNode" ->ₛ "data")) # Int  |-> right_data)
  **  ((&((right_addr)  # "AvlNode" ->ₛ "height")) # UInt  |-> right_height)
  **  ((&((right_addr)  # "AvlNode" ->ₛ "left")) # Ptr  |-> avl_node_pre)
  **  ((&((right_addr)  # "AvlNode" ->ₛ "right")) # Ptr  |-> far_right_addr)
  **  (store_addr_avl middle_addr b )
  **  (store_addr_avl far_right_addr c )
|--
  “ (right_addr = right_addr) ” 
  &&  “ (avl_left_rotation before (avl_node_model (right_addr) (right_data) (right_height) ((avl_node_model (avl_node_pre) (root_data) (root_height) (a) (b))) (c)) ) ”
  &&  ((&((avl_node_pre)  # "AvlNode" ->ₛ "data")) # Int  |-> root_data)
  **  ((&((avl_node_pre)  # "AvlNode" ->ₛ "height")) # UInt  |-> root_height)
  **  ((&((avl_node_pre)  # "AvlNode" ->ₛ "left")) # Ptr  |-> left_addr)
  **  ((&((avl_node_pre)  # "AvlNode" ->ₛ "right")) # Ptr  |-> middle_addr)
  **  (store_addr_avl left_addr a )
  **  ((&((right_addr)  # "AvlNode" ->ₛ "data")) # Int  |-> right_data)
  **  ((&((right_addr)  # "AvlNode" ->ₛ "height")) # UInt  |-> right_height)
  **  ((&((right_addr)  # "AvlNode" ->ₛ "left")) # Ptr  |-> avl_node_pre)
  **  ((&((right_addr)  # "AvlNode" ->ₛ "right")) # Ptr  |-> far_right_addr)
  **  (store_addr_avl middle_addr b )
  **  (store_addr_avl far_right_addr c )
) \/
(
forall (avl_node_pre: Z) (before: addr_avl_tree) (c: addr_avl_tree) (b: addr_avl_tree) (a: addr_avl_tree) (right_height: Z) (right_data: Z) (root_height: Z) (root_data: Z) (far_right_addr: Z) (middle_addr: Z) (right_addr: Z) (left_addr: Z) (PreH1 : (avl_node_pre <> 0)) (PreH2 : (right_addr <> 0)) (PreH3 : (before = (avl_node_model (avl_node_pre) (root_data) (root_height) (a) ((avl_node_model (right_addr) (right_data) (right_height) (b) (c)))))) ,
  (store_addr_avl left_addr a )
  **  (store_addr_avl middle_addr b )
  **  (store_addr_avl far_right_addr c )
|--
  “ (avl_left_rotation before (avl_node_model (right_addr) (right_data) (right_height) ((avl_node_model (avl_node_pre) (root_data) (root_height) (a) (b))) (c)) ) ”
  &&  (store_addr_avl left_addr a )
  **  (store_addr_avl middle_addr b )
  **  (store_addr_avl far_right_addr c )
).

Definition xizi_avl_left_rotate_return_wit_1_split_goal_1 := 
forall (avl_node_pre: Z) (before: addr_avl_tree) (c: addr_avl_tree) (b: addr_avl_tree) (a: addr_avl_tree) (right_height: Z) (right_data: Z) (root_height: Z) (root_data: Z) (far_right_addr: Z) (middle_addr: Z) (right_addr: Z) (left_addr: Z) (PreH1 : (avl_node_pre <> 0)) (PreH2 : (right_addr <> 0)) (PreH3 : (before = (avl_node_model (avl_node_pre) (root_data) (root_height) (a) ((avl_node_model (right_addr) (right_data) (right_height) (b) (c)))))) ,
  (store_addr_avl left_addr a )
  **  (store_addr_avl middle_addr b )
  **  (store_addr_avl far_right_addr c )
|--
  “ (avl_left_rotation before (avl_node_model (right_addr) (right_data) (right_height) ((avl_node_model (avl_node_pre) (root_data) (root_height) (a) (b))) (c)) ) ”
.

Definition xizi_avl_left_rotate_return_wit_1_split_goal_spatial := 
forall (avl_node_pre: Z) (before: addr_avl_tree) (c: addr_avl_tree) (b: addr_avl_tree) (a: addr_avl_tree) (right_height: Z) (right_data: Z) (root_height: Z) (root_data: Z) (far_right_addr: Z) (middle_addr: Z) (right_addr: Z) (left_addr: Z) (PreH1 : (avl_node_pre <> 0)) (PreH2 : (right_addr <> 0)) (PreH3 : (before = (avl_node_model (avl_node_pre) (root_data) (root_height) (a) ((avl_node_model (right_addr) (right_data) (right_height) (b) (c)))))) ,
  (store_addr_avl left_addr a )
  **  (store_addr_avl middle_addr b )
  **  (store_addr_avl far_right_addr c )
|--
  (store_addr_avl left_addr a )
  **  (store_addr_avl middle_addr b )
  **  (store_addr_avl far_right_addr c )
.

Module Type VC_Correct.


Axiom proof_of_xizi_avl_left_rotate_return_wit_1 : xizi_avl_left_rotate_return_wit_1.

End VC_Correct.
