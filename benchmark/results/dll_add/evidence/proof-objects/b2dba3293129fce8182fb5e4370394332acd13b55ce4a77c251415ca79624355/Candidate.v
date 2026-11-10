From SimpleC.Verification Require Import VCPrelude.
Require Import ExecutionGoal DLLSupplement FiniteEntryHeap.
Import naive_C_Rules.
Import ListNotations.
Local Open Scope sac.
Local Open Scope Z_scope.

(* Big-endian words, grouped in the same order as the spatial assertions.
   The outside links are null; the two inside links point back to 4096. *)
Definition interior_left_bytes : list (Z * Z) :=
  ((entry_word 8192 0 0 0 30 ++ entry_word 8196 0 0 0 0) ++
    entry_word 8200 0 0 16 0) ++ [].

Definition interior_right_bytes : list (Z * Z) :=
  ((entry_word 12288 0 0 0 20 ++ entry_word 12296 0 0 0 0) ++
    entry_word 12292 0 0 16 0) ++ [].

Definition interior_entry_bytes : list (Z * Z) :=
  (((entry_word 4096 0 0 0 10 ++ entry_word 4100 0 0 32 0) ++
     entry_word 4104 0 0 48 0) ++ interior_left_bytes) ++
    interior_right_bytes.

(* Only closed address/range checks and the supplied word constructor. *)
Ltac interior_int_store :=
  unfold naive_C_Rules.store_int;
  split;
  [ cbv; intuition discriminate
  | apply entry_word_store; reflexivity ].

Ltac interior_ptr_store :=
  unfold naive_C_Rules.store_ptr;
  split;
  [ cbv; intuition discriminate
  | apply entry_word_store; reflexivity ].

Lemma interior_left_heap :
  DLLLeft 8192 4096 [30]
    (entry_state (entry_mem interior_left_bytes)).
Proof.
  change (8192 <> 0 /\ exists q : Z,
    ((8192 + 0) # Int |-> 30 **
     (8192 + 4) # Ptr |-> q **
     (8192 + 8) # Ptr |-> 4096 ** DLLLeft q 8192 [])
      (entry_state (entry_mem interior_left_bytes))).
  split; [lia |].
  exists 0.
  unfold interior_left_bytes.
  eapply entry_mem_sep with
    (l := (entry_word 8192 0 0 0 30 ++ entry_word 8196 0 0 0 0) ++
          entry_word 8200 0 0 16 0) (r := []).
  - cbn; intuition lia.
  - eapply entry_mem_sep with
      (l := entry_word 8192 0 0 0 30 ++ entry_word 8196 0 0 0 0)
      (r := entry_word 8200 0 0 16 0).
    + cbn; intuition lia.
    + eapply entry_mem_sep with
        (l := entry_word 8192 0 0 0 30)
        (r := entry_word 8196 0 0 0 0).
      * cbn; intuition lia.
      * interior_int_store.
      * interior_ptr_store.
    + interior_ptr_store.
  - change (0 = 0 /\ emp (entry_state empty_mem)).
    split; [reflexivity | apply entry_state_emp].
Qed.

Lemma interior_right_heap :
  DLLRight 12288 4096 [20]
    (entry_state (entry_mem interior_right_bytes)).
Proof.
  change (12288 <> 0 /\ exists q : Z,
    ((12288 + 0) # Int |-> 20 **
     (12288 + 8) # Ptr |-> q **
     (12288 + 4) # Ptr |-> 4096 ** DLLRight q 12288 [])
      (entry_state (entry_mem interior_right_bytes))).
  split; [lia |].
  exists 0.
  unfold interior_right_bytes.
  eapply entry_mem_sep with
    (l := (entry_word 12288 0 0 0 20 ++ entry_word 12296 0 0 0 0) ++
          entry_word 12292 0 0 16 0) (r := []).
  - cbn; intuition lia.
  - eapply entry_mem_sep with
      (l := entry_word 12288 0 0 0 20 ++ entry_word 12296 0 0 0 0)
      (r := entry_word 12292 0 0 16 0).
    + cbn; intuition lia.
    + eapply entry_mem_sep with
        (l := entry_word 12288 0 0 0 20)
        (r := entry_word 12296 0 0 0 0).
      * cbn; intuition lia.
      * interior_int_store.
      * interior_ptr_store.
    + interior_ptr_store.
  - change (0 = 0 /\ emp (entry_state empty_mem)).
    split; [reflexivity | apply entry_state_emp].
Qed.

Lemma interior_entry_heap :
  ((4096 + 0) # Int |-> 10 **
   (4096 + 4) # Ptr |-> 8192 **
   (4096 + 8) # Ptr |-> 12288 **
   DLLLeft 8192 4096 [30] ** DLLRight 12288 4096 [20])
    (entry_state (entry_mem interior_entry_bytes)).
Proof.
  unfold interior_entry_bytes.
  eapply entry_mem_sep with
    (l := ((entry_word 4096 0 0 0 10 ++ entry_word 4100 0 0 32 0) ++
            entry_word 4104 0 0 48 0) ++ interior_left_bytes)
    (r := interior_right_bytes).
  - cbn; intuition lia.
  - eapply entry_mem_sep with
      (l := (entry_word 4096 0 0 0 10 ++ entry_word 4100 0 0 32 0) ++
            entry_word 4104 0 0 48 0)
      (r := interior_left_bytes).
    + cbn; intuition lia.
    + eapply entry_mem_sep with
        (l := entry_word 4096 0 0 0 10 ++ entry_word 4100 0 0 32 0)
        (r := entry_word 4104 0 0 48 0).
      * cbn; intuition lia.
      * eapply entry_mem_sep with
          (l := entry_word 4096 0 0 0 10)
          (r := entry_word 4100 0 0 32 0).
        -- cbn; intuition lia.
        -- interior_int_store.
        -- interior_ptr_store.
      * interior_ptr_store.
    + exact interior_left_heap.
  - exact interior_right_heap.
Qed.

Theorem resolved_add_precondition_wit_1 : ExecutionGoal.add_precondition_wit_1.
Proof.
  unfold ExecutionGoal.add_precondition_wit_1.
  exists [20], [30], 12288, 8192, 10, 7, 7, 4096.
  intro Hfalse.
  apply (Hfalse (entry_state (entry_mem interior_entry_bytes))).
  left.
  repeat first [exact interior_entry_heap | reflexivity | split | lia].
  unfold naive_C_Rules.coq_prop; lia.
Qed.
Print Assumptions resolved_add_precondition_wit_1.
