Require Import Coq.ZArith.ZArith.
Require Export SimpleC.EE.QCP_demos_human.bst_lib.
Local Open Scope Z_scope.
Fixpoint tree_size (t : tree) : Z :=
  match t with
  | empty => 0
  | make_tree l _ _ r => 1 + tree_size l + tree_size r
  end.
