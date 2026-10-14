Require Import Coq.ZArith.ZArith Coq.micromega.Lia.
Local Open Scope Z_scope.

(* Necessary numeric condition of vmemmap_l_wf's previous-link clause.
   In the concrete offset=0 fixtures, the physical address equals the
   observed native address. Pointer equality also implies address equality. *)
Definition link_necessary (start finish header previous : Z) : Prop :=
  previous = header \/ start <= previous < finish.

Theorem cleared_link_violates_necessary_condition : forall start finish header,
  0 < start -> header <> 0 -> ~ link_necessary start finish header 0.
Proof. intros start finish header Hstart Hheader [H|H]; lia. Qed.

(* Remaining alignment, ownership/provenance and neighbouring-node clauses
   are arbitrary here. The contradiction precedes those conjuncts. *)
Definition previous_clause (start finish header header_next self previous : Z)
    (remaining : Z -> Prop) : Prop :=
  (previous = header /\ header_next = self) \/
  (start <= previous < finish /\ remaining previous).

Theorem previous_clause_requires_link : forall start finish header header_next self previous remaining,
  previous_clause start finish header header_next self previous remaining ->
  link_necessary start finish header previous.
Proof. intros. unfold previous_clause, link_necessary in *. tauto. Qed.

Theorem cleared_root_refutes_previous_clause : forall start finish header header_next self remaining,
  0 < start -> header <> 0 ->
  ~ previous_clause start finish header header_next self 0 remaining.
Proof.
  intros start finish header header_next self remaining Hstart Hheader Hclause.
  apply (cleared_link_violates_necessary_condition start finish header Hstart Hheader).
  now apply (previous_clause_requires_link start finish header header_next self 0 remaining).
Qed.

Definition root_guard (start finish physical refs order : Z) : Prop :=
  start <= physical < finish /\ refs = 0 /\ order <> 255.

Theorem observed_extracted_root_is_guarded : forall start finish physical order,
  start <= physical < finish -> 0 <= order <= 3 ->
  root_guard start finish physical 0 order.
Proof. intros. unfold root_guard. repeat split; lia. Qed.

Print Assumptions cleared_root_refutes_previous_clause.
Print Assumptions observed_extracted_root_is_guarded.

Theorem extracted_root_refutes_unexcluded_pool_clause :
  forall start finish (guard : Z -> Prop)
    (header header_next self previous : Z -> Z)
    (remaining : Z -> Z -> Prop) root,
  0 < start -> guard root -> header root <> 0 -> previous root = 0 ->
  ~ (forall page, guard page ->
     previous_clause start finish (header page) (header_next page)
       (self page) (previous page) (remaining page)).
Proof.
  intros start finish guard header header_next self previous remaining root
    Hstart Hguard Hheader Hprevious Hpool.
  specialize (Hpool root Hguard). rewrite Hprevious in Hpool.
  exact (cleared_root_refutes_previous_clause start finish (header root)
    (header_next root) (self root) (remaining root) Hstart Hheader Hpool).
Qed.

Print Assumptions extracted_root_refutes_unexcluded_pool_clause.
