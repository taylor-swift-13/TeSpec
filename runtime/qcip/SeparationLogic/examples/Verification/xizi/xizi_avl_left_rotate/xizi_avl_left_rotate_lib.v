Require Import Coq.Lists.List.
Require Import Coq.Strings.String.
Require Import Coq.ZArith.ZArith.
Require Import Coq.micromega.Lia.
Require Import AUXLib.ListLib.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import Logic.LogicGenerator.demo932.Interface.

Import ListNotations.
Import naive_C_Rules.
Local Open Scope Z_scope.
Local Open Scope sac.
Local Open Scope string_scope.

(** An AVL tree model whose constructor records the physical address, payload,
    and cached height of every node.  No balance or height-correctness property
    is built into the model: the rotation primitive does not update heights. *)
Inductive addr_avl_tree : Type :=
  | avl_empty : addr_avl_tree
  | avl_node_model :
      addr -> Z -> Z -> addr_avl_tree -> addr_avl_tree -> addr_avl_tree.

Definition avl_root_addr (t : addr_avl_tree) : addr :=
  match t with
  | avl_empty => NULL
  | avl_node_model p _ _ _ _ => p
  end.

(** Recursive, address-labelled ownership of an [AvlNode] tree. *)
Fixpoint store_addr_avl (p : addr) (t : addr_avl_tree) : Assertion :=
  match t with
  | avl_empty =>
      “ p = NULL ” && emp
  | avl_node_model node data height left_tree right_tree =>
      “ p = node /\ node <> NULL ” &&
      &(node # "AvlNode" ->ₛ "data") # Int |-> data **
      &(node # "AvlNode" ->ₛ "height") # UInt |-> height **
      &(node # "AvlNode" ->ₛ "left") # Ptr |-> avl_root_addr left_tree **
      &(node # "AvlNode" ->ₛ "right") # Ptr |-> avl_root_addr right_tree **
      store_addr_avl (avl_root_addr left_tree) left_tree **
      store_addr_avl (avl_root_addr right_tree) right_tree
  end.

(** Exact mathematical effect of one pointer-level left rotation.  The same
    node addresses, payloads, cached heights, and subtrees occur on both sides. *)
Definition avl_left_rotation
    (before after : addr_avl_tree) : Prop :=
  exists root promoted root_data root_height right_data right_height a b c,
    before =
      avl_node_model root root_data root_height a
        (avl_node_model promoted right_data right_height b c) /\
    after =
      avl_node_model promoted right_data right_height
        (avl_node_model root root_data root_height a b) c.
