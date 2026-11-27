From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_IntList_append2_precondition_wit_1 : Goal.IntList_append2_precondition_wit_1.
Proof.
  unfold Goal.IntList_append2_precondition_wit_1.
  exists (cons 1 (@nil Z)), (@nil Z), 0%Z, 16384%Z.
  (* Unresolved: construct a concrete state satisfying the singleton list
     at 16384, with Int value 1 at 16384 and Ptr value 0 at 16388,
     and use that state to contradict the assumed entailment to False.
     The empty state does not satisfy this instantiated assertion. *)
Abort.

End Proofs.
