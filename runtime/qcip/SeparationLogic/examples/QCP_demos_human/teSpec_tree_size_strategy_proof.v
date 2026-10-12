Require Import Coq.ZArith.ZArith.
Require Import Coq.Bool.Bool.
Require Import Coq.Lists.List.
Require Import Coq.Strings.String.
Require Import Coq.micromega.Psatz.
From SimpleC.SL Require Import SeparationLogic.
From SimpleC.EE.QCP_demos_human Require Import teSpec_tree_size_strategy_goal.
Import naive_C_Rules.
Require Import SimpleC.EE.QCP_demos_human.bst_lib.
Import get_right_most.
Local Open Scope Z_scope.
Local Open Scope sac.
Local Open Scope string.

Lemma teSpec_tree_size_strategy6_correctness : teSpec_tree_size_strategy6.
Proof.
  pre_process_default.
  simpl.
  Intros l.
  Intros r.
  Exists l.
  Exists r.
  entailer!.
  rewrite <- elim_wand_emp_emp.
  cancel.
Qed.

Lemma teSpec_tree_size_strategy7_correctness : teSpec_tree_size_strategy7.
Proof.
  pre_process_default.
  simpl.
  entailer!.
Qed.
