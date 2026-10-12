From Coq Require Import ZArith List.

(* An unused existential cannot be erased merely because its variable does
   not occur in the body. The witness type may have no inhabitants. *)
Definition witness_assertion {A Heap : Type} (P : Heap -> Prop) : Heap -> Prop :=
  fun h => exists _ : A, P h.

Theorem unused_witness_iff {A Heap : Type} (P : Heap -> Prop) h :
  @witness_assertion A Heap P h <-> (inhabited A /\ P h).
Proof.
  split.
  - intros [a HP]. split; [exact (inhabits a) | exact HP].
  - intros [[a] HP]. exists a; exact HP.
Qed.

Theorem inhabited_witness_elimination {A Heap : Type}
    (HA : inhabited A) (P : Heap -> Prop) h :
  @witness_assertion A Heap P h <-> P h.
Proof. rewrite unused_witness_iff. tauto. Qed.

Theorem empty_witness_refutes_assertion {A Heap : Type}
    (HA : forall a : A, False) (P : Heap -> Prop) h :
  ~ @witness_assertion A Heap P h.
Proof. intros [a HP]. exact (HA a). Qed.

Theorem self_equality_preserves_existential {A Heap : Type}
    (P : A -> Heap -> Prop) h :
  (exists a, P a h) <-> (exists a, a = a /\ P a h).
Proof.
  split; intros [a H]; exists a.
  - split; [reflexivity | exact H].
  - exact (proj2 H).
Qed.

Theorem witness_assertion_nonempty_iff {A Heap : Type} (P : Heap -> Prop) :
  (exists h, @witness_assertion A Heap P h) <->
  (inhabited A /\ exists h, P h).
Proof.
  split.
  - intros [h [a HP]]. split; [exact (inhabits a) | exists h; exact HP].
  - intros [[a] [h HP]]. exists h, a; exact HP.
Qed.

Theorem integer_unused_witness_elimination {Heap : Type} (P : Heap -> Prop) h :
  @witness_assertion Z Heap P h <-> P h.
Proof. apply inhabited_witness_elimination. exact (inhabits 0%Z). Qed.

Theorem list_unused_witness_elimination {A Heap : Type} (P : Heap -> Prop) h :
  @witness_assertion (list A) Heap P h <-> P h.
Proof. apply inhabited_witness_elimination. exact (inhabits (@nil A)). Qed.

Print Assumptions unused_witness_iff.
Print Assumptions inhabited_witness_elimination.
Print Assumptions empty_witness_refutes_assertion.
Print Assumptions self_equality_preserves_existential.
Print Assumptions witness_assertion_nonempty_iff.
Print Assumptions integer_unused_witness_elimination.
Print Assumptions list_unused_witness_elimination.
