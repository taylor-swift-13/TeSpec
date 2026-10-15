Require Import ConcreteCell ExecutionGoal.
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
Local Open Scope sac.



Theorem entry_cell : (4096 # UInt |-> (4294967295)) (st (cell 255 255 255 255)).
Proof.
  unfold store_uint; split.
  - change (isvalidptr_int 4096 /\ 4294967295 >= 0 /\ 4294967295 <= Int.max_unsigned).
    vm_compute; repeat split; congruence.
  - unfold store_4byte.
    exists 255, 255, 255, 255; split.
    + change (merge_int 255 255 255 255 4294967295).
      vm_compute; repeat split; congruence.
    + exists (st (single_byte_mem 4096 255)), (st (tail1 255 255 255)).
      split; [apply st_join; apply join0|].
      split; [apply byte_at|].
      exists (st (single_byte_mem 4097 255)), (st (tail2 255 255)).
      split; [apply st_join; apply join1|].
      split; [apply byte_at|].
      exists (st (single_byte_mem 4098 255)), (st (single_byte_mem 4099 255)).
      split; [apply st_join; apply join2|].
      split; apply byte_at.
Qed.
Theorem exit_cell : (4096 # UInt |-> (0)) (st (cell 0 0 0 0)).
Proof.
  unfold store_uint; split.
  - change (isvalidptr_int 4096 /\ 0 >= 0 /\ 0 <= Int.max_unsigned).
    vm_compute; repeat split; congruence.
  - unfold store_4byte.
    exists 0, 0, 0, 0; split.
    + change (merge_int 0 0 0 0 0).
      vm_compute; repeat split; congruence.
    + exists (st (single_byte_mem 4096 0)), (st (tail1 0 0 0)).
      split; [apply st_join; apply join0|].
      split; [apply byte_at|].
      exists (st (single_byte_mem 4097 0)), (st (tail2 0 0)).
      split; [apply st_join; apply join1|].
      split; [apply byte_at|].
      exists (st (single_byte_mem 4098 0)), (st (single_byte_mem 4099 0)).
      split; [apply st_join; apply join2|].
      split; apply byte_at.
Qed.
Theorem refute_incr_return_wit_1_split_goal_spatial : ~ ExecutionGoal.incr_return_wit_1_split_goal_spatial.
Proof.
  unfold ExecutionGoal.incr_return_wit_1_split_goal_spatial.
  intro H.
  assert (Hwrap : unsigned_last_nbits (4294967295 + 1) 32 = 0) by reflexivity.
  assert (Hmax : 4294967295 = UINT_MAX) by reflexivity.
  assert (Hlo : 0 <= 4294967295) by lia.
  assert (Hhi : 4294967295 <= UINT_MAX) by (change (4294967295 <= 4294967295); lia).
  assert (Houtlo : unsigned_last_nbits (4294967295 + 1) 32 >= 0) by (rewrite Hwrap; lia).
  assert (Houthi : unsigned_last_nbits (4294967295 + 1) 32 <= UINT_MAX) by (rewrite Hwrap; change (0 <= 4294967295); lia).
  specialize (H 4096 4294967295 Houthi Houtlo eq_refl Hmax Hlo Hhi).
  rewrite Hwrap in H.
  specialize (H (st (cell 0 0 0 0)) exit_cell).
  destruct H as [_ Hemp].
  exact (cell_not_emp 0 0 0 0 Hemp).
Qed.
Theorem refute_incr_return_wit_1 : ~ ExecutionGoal.incr_return_wit_1.
Proof.
  unfold ExecutionGoal.incr_return_wit_1.
  intros [H | H].
  - assert (Hmax : 4294967295 = UINT_MAX) by reflexivity.
    assert (Hlo : 0 <= 4294967295) by lia.
    assert (Hhi : 4294967295 <= UINT_MAX) by (change (4294967295 <= 4294967295); lia).
    specialize (H 4096 4294967295 eq_refl Hmax Hlo Hhi).
    change ((4096 # UInt |-> 0) |-- TT && emp) in H.
    specialize (H (st (cell 0 0 0 0)) exit_cell).
    destruct H as [_ Hemp].
    exact (cell_not_emp 0 0 0 0 Hemp).
  - assert (Hmax : 4294967295 = UINT_MAX) by reflexivity.
    assert (Hlo : 0 <= 4294967295) by lia.
    assert (Hhi : 4294967295 <= UINT_MAX) by (change (4294967295 <= 4294967295); lia).
    assert (Houtlo : unsigned_last_nbits (4294967295 + 1) 32 >= 0) by (change (0 >= 0); lia).
    assert (Houthi : unsigned_last_nbits (4294967295 + 1) 32 <= UINT_MAX) by (change (0 <= 4294967295); lia).
    specialize (H 4096 4294967295 Houthi Houtlo eq_refl Hmax Hlo Hhi).
    change ((4096 # UInt |-> 0) |-- TT && emp) in H.
    specialize (H (st (cell 0 0 0 0)) exit_cell).
    destruct H as [_ Hemp].
    exact (cell_not_emp 0 0 0 0 Hemp).
Qed.
Theorem entry_sat : ExecutionGoal.incr_precondition_wit_1.
Proof.
  unfold ExecutionGoal.incr_precondition_wit_1.
  exists 4096, 4294967295.
  intro H.
  assert (Hin :
    ( “ (4096 = 4096) ” && “ (4294967295 = UINT_MAX) ”
      && “ (0 <= 4294967295) ” && “ (4294967295 <= UINT_MAX) ”
      && (4096 # UInt |-> 4294967295)) (st (cell 255 255 255 255))).
  { split.
    - split.
      + split.
        * split.
          -- change (4096 = 4096); reflexivity.
          -- change (4294967295 = UINT_MAX); reflexivity.
        * change (0 <= 4294967295); lia.
      + change (4294967295 <= 4294967295); lia.
    - exact entry_cell. }
  exact (H (st (cell 255 255 255 255)) Hin).
Qed.
Print Assumptions entry_cell.
Print Assumptions exit_cell.
Print Assumptions refute_incr_return_wit_1_split_goal_spatial.
Print Assumptions refute_incr_return_wit_1.
Print Assumptions entry_sat.
