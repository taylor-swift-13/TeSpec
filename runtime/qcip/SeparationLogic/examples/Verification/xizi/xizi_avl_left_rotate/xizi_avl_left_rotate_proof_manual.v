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
From SimpleC.EE.Verification.xizi.xizi_avl_left_rotate Require Import xizi_avl_left_rotate_goal.
From SimpleC.EE.Verification.xizi.xizi_avl_left_rotate Require Import xizi_avl_left_rotate_proof_auto.
Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
Require Import
      SimpleC.EE.Verification.xizi.xizi_avl_left_rotate.xizi_avl_left_rotate_lib.
Local Open Scope sac.

Lemma proof_of_xizi_avl_left_rotate_return_wit_1 : xizi_avl_left_rotate_return_wit_1.
Proof.
  aggressive_pre_process.
  dump_pre_spatial.
  unfold avl_left_rotation.
  exists avl_node_pre, right_addr, root_data, root_height,
    right_data, right_height, a, b, c.
  split.
  - exact PreH3.
  - reflexivity.
Qed.
