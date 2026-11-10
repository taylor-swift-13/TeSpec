From SimpleC.Verification Require Import VCPrelude.
Require Import ExecutionGoal DLLSupplement FiniteEntryHeap.
Import naive_C_Rules.
Import ListNotations.
Local Open Scope sac.
Local Open Scope Z_scope.

(* The current node and its single predecessor, in big-endian byte order. *)
Definition candidate_current_bytes : list (Z * Z) :=
  (entry_word 4096 0 0 0 10 ++ entry_word 4100 0 0 32 0) ++
  entry_word 4104 0 0 0 0.

Definition candidate_previous_bytes : list (Z * Z) :=
  (entry_word 8192 0 0 0 30 ++ entry_word 8196 0 0 0 0) ++
  entry_word 8200 0 0 16 0.

Definition candidate_entry_bytes : list (Z * Z) :=
  candidate_current_bytes ++ candidate_previous_bytes.

Ltac candidate_disjoint :=
  cbn; intuition lia.

Ltac candidate_store :=
  lazymatch goal with
  | |- naive_C_Rules.store_int _ _ _ =>
      unfold naive_C_Rules.store_int
  | |- naive_C_Rules.store_ptr _ _ _ =>
      unfold naive_C_Rules.store_ptr
  end;
  split;
  [ cbv; intuition discriminate
  | apply entry_word_store; reflexivity ].

Lemma candidate_current_heap :
  ((4096 + 0) # Int |-> 10 **
   (4096 + 4) # Ptr |-> 8192 **
   (4096 + 8) # Ptr |-> 0)
    (entry_state (entry_mem candidate_current_bytes)).
Proof.
  eapply entry_mem_sep with
    (l := entry_word 4096 0 0 0 10 ++ entry_word 4100 0 0 32 0)
    (r := entry_word 4104 0 0 0 0).
  - candidate_disjoint.
  - eapply entry_mem_sep with
      (l := entry_word 4096 0 0 0 10)
      (r := entry_word 4100 0 0 32 0).
    + candidate_disjoint.
    + candidate_store.
    + candidate_store.
  - candidate_store.
Qed.

Lemma candidate_previous_heap :
  DLLLeft 8192 4096 [30]
    (entry_state (entry_mem candidate_previous_bytes)).
Proof.
  split; [unfold naive_C_Rules.coq_prop; lia |].
  exists 0.
  eapply entry_mem_sep with (l := candidate_previous_bytes) (r := []).
  - candidate_disjoint.
  - eapply entry_mem_sep with
      (l := entry_word 8192 0 0 0 30 ++ entry_word 8196 0 0 0 0)
      (r := entry_word 8200 0 0 16 0).
    + candidate_disjoint.
    + eapply entry_mem_sep with
        (l := entry_word 8192 0 0 0 30)
        (r := entry_word 8196 0 0 0 0).
      * candidate_disjoint.
      * candidate_store.
      * candidate_store.
    + candidate_store.
  - change (0 = 0 /\ emp (entry_state empty_mem)).
    split; [reflexivity | apply entry_state_emp].
Qed.

Lemma candidate_entry_heap :
  ((4096 + 0) # Int |-> 10 **
   (4096 + 4) # Ptr |-> 8192 **
   (4096 + 8) # Ptr |-> 0 **
   DLLLeft 8192 4096 [30] **
   DLLRight 0 4096 [])
    (entry_state (entry_mem candidate_entry_bytes)).
Proof.
  eapply entry_mem_sep with (l := candidate_entry_bytes) (r := []).
  - candidate_disjoint.
  - eapply entry_mem_sep with
      (l := candidate_current_bytes) (r := candidate_previous_bytes).
    + candidate_disjoint.
    + exact candidate_current_heap.
    + exact candidate_previous_heap.
  - change (0 = 0 /\ emp (entry_state empty_mem)).
    split; [reflexivity | apply entry_state_emp].
Qed.

Theorem resolved_add_precondition_wit_1 : ExecutionGoal.add_precondition_wit_1.
Proof.
  unfold ExecutionGoal.add_precondition_wit_1.
  exists [], [30], 0, 8192, 10, 7, 7, 4096.
  intro Hfalse.
  apply (Hfalse (entry_state (entry_mem candidate_entry_bytes))).
  left.
  repeat apply conj; try reflexivity; try discriminate;
    try (change (4096 <> 0); lia); exact candidate_entry_heap.
Qed.
Print Assumptions resolved_add_precondition_wit_1.
