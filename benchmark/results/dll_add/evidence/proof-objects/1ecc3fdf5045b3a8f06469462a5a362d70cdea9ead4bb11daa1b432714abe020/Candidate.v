From SimpleC.Verification Require Import VCPrelude.
Require Import ExecutionGoal DLLSupplement FiniteEntryHeap.
Import naive_C_Rules.
Import ListNotations.
Local Open Scope sac.
Local Open Scope Z_scope.

(* Each word lists its bytes in the runtime's big-endian order.  The
   parentheses follow the left-associated separating conjunctions. *)
Definition actual_current_bytes : list (Z * Z) :=
  (entry_word 4096 0 0 0 10 ++ entry_word 4100 0 0 32 0) ++
  entry_word 4104 0 0 48 0.

Definition actual_left_bytes : list (Z * Z) :=
  ((entry_word 8192 0 0 0 30 ++ entry_word 8196 0 0 0 0) ++
   entry_word 8200 0 0 16 0) ++ [].

Definition actual_last_bytes : list (Z * Z) :=
  ((entry_word 16384 0 0 0 40 ++ entry_word 16392 0 0 0 0) ++
   entry_word 16388 0 0 48 0) ++ [].

Definition actual_right_bytes : list (Z * Z) :=
  ((entry_word 12288 0 0 0 20 ++ entry_word 12296 0 0 64 0) ++
   entry_word 12292 0 0 16 0) ++ actual_last_bytes.

Definition actual_entry_bytes : list (Z * Z) :=
  (actual_current_bytes ++ actual_left_bytes) ++ actual_right_bytes.

(* Split only the displayed finite lists; no extensional equality of memory
   functions is needed.  Each disjointness goal concerns concrete addresses. *)
Ltac actual_separate :=
  lazymatch goal with
  | |- (?P ** ?Q) (entry_state (entry_mem (?byteListLeft ++ ?byteListRight))) =>
      eapply entry_mem_sep with (l := byteListLeft) (r := byteListRight);
      [ cbn; intuition lia
      | | ]
  end.

Ltac actual_word :=
  lazymatch goal with
  | |- (naive_C_Rules.store_int _ _) _ =>
      unfold naive_C_Rules.store_int;
      split;
      [ vm_compute; intuition discriminate
      | apply entry_word_store; reflexivity ]
  | |- (naive_C_Rules.store_ptr _ _) _ =>
      unfold naive_C_Rules.store_ptr;
      split;
      [ vm_compute; intuition discriminate
      | apply entry_word_store; reflexivity ]
  end.

Lemma actual_current_heap :
  (4096 # Int |-> 10 ** 4100 # Ptr |-> 8192 **
   4104 # Ptr |-> 12288)
    (entry_state (entry_mem actual_current_bytes)).
Proof.
  unfold actual_current_bytes.
  actual_separate.
  - actual_separate; actual_word.
  - actual_word.
Qed.

Lemma actual_left_heap :
  DLLLeft 8192 4096 [30]
    (entry_state (entry_mem actual_left_bytes)).
Proof.
  cbn [DLLLeft].
  split; [unfold naive_C_Rules.coq_prop; lia |].
  exists 0.
  unfold actual_left_bytes.
  actual_separate.
  - actual_separate.
    + actual_separate; actual_word.
    + actual_word.
  - split; [reflexivity | apply entry_state_emp].
Qed.

Lemma actual_last_heap :
  DLLRight 16384 12288 [40]
    (entry_state (entry_mem actual_last_bytes)).
Proof.
  cbn [DLLRight].
  split; [unfold naive_C_Rules.coq_prop; lia |].
  exists 0.
  unfold actual_last_bytes.
  actual_separate.
  - actual_separate.
    + actual_separate; actual_word.
    + actual_word.
  - split; [reflexivity | apply entry_state_emp].
Qed.

Lemma actual_right_heap :
  DLLRight 12288 4096 [20; 40]
    (entry_state (entry_mem actual_right_bytes)).
Proof.
  cbn [DLLRight].
  split; [unfold naive_C_Rules.coq_prop; lia |].
  exists 16384.
  unfold actual_right_bytes.
  actual_separate.
  - actual_separate.
    + actual_separate; actual_word.
    + actual_word.
  - exact actual_last_heap.
Qed.

Lemma actual_entry_heap :
  (4096 # Int |-> 10 ** 4100 # Ptr |-> 8192 **
   4104 # Ptr |-> 12288 ** DLLLeft 8192 4096 [30] **
   DLLRight 12288 4096 [20; 40])
    (entry_state (entry_mem actual_entry_bytes)).
Proof.
  unfold actual_entry_bytes.
  actual_separate.
  - actual_separate.
    + exact actual_current_heap.
    + exact actual_left_heap.
  - exact actual_right_heap.
Qed.

Theorem resolved_add_precondition_wit_1 : ExecutionGoal.add_precondition_wit_1.
Proof.
  unfold ExecutionGoal.add_precondition_wit_1.
  exists [20; 40], [30], 12288, 8192, 10, 7, 7, 4096.
  intro Hfalse.
  apply (Hfalse (entry_state (entry_mem actual_entry_bytes))).
  left.
  repeat split; try reflexivity; try lia.
  - change (4096 <> 0); lia.
  - exact actual_entry_heap.
Qed.
Print Assumptions resolved_add_precondition_wit_1.
