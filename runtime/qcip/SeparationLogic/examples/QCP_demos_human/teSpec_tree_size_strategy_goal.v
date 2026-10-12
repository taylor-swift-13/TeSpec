Require Import Coq.ZArith.ZArith.
Require Import Coq.Bool.Bool.
Require Import Coq.Lists.List.
Require Import Coq.Strings.String.
Require Import Coq.micromega.Psatz.
From SimpleC.SL Require Import SeparationLogic.
Import naive_C_Rules.
Require Import SimpleC.EE.QCP_demos_human.bst_lib.
Import get_right_most.
Local Open Scope Z_scope.
Local Open Scope sac.
Local Open Scope string.

Definition teSpec_tree_size_strategy6 :=
  forall (p : Z) (tl : tree) (v : Z) (trr : tree) (k : Z),
    TT &&
    emp **
    ((store_tree p ( make_tree tl k v trr)))
    |--
    EX (l : Z) (r : Z),
      (
      TT &&
      (“ (p <> 0) ”) &&
      emp **
      ((poly_store FET_int &( ((p)) # "tree" ->ₛ "key") k)) **
      ((poly_store FET_int &( ((p)) # "tree" ->ₛ "value") v)) **
      ((poly_store FET_ptr &( ((p)) # "tree" ->ₛ "left") l)) **
      ((poly_store FET_ptr &( ((p)) # "tree" ->ₛ "right") r)) **
      ((store_tree l tl)) **
      ((store_tree r trr))
      ) ** (
      TT &&
      emp -*
      TT &&
      emp
      ).

Definition teSpec_tree_size_strategy7 :=
  forall (p : Z),
    TT &&
    emp **
    ((store_tree p ( empty)))
    |--
    (
    TT &&
    (“ (p = 0) ”) &&
    emp
    ) ** (
    TT &&
    emp -*
    TT &&
    emp
    ).

Module Type teSpec_tree_size_Strategy_Correct.

  Axiom teSpec_tree_size_strategy6_correctness : teSpec_tree_size_strategy6.
  Axiom teSpec_tree_size_strategy7_correctness : teSpec_tree_size_strategy7.

End teSpec_tree_size_Strategy_Correct.
