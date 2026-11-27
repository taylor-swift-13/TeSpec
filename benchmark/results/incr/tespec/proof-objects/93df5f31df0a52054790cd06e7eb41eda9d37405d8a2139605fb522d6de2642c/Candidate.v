From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

(* A UInt cell occupies memory, whereas TT && emp requires an empty heap.
   Both disjuncts therefore demand a false entailment. *)
Lemma proof_of_incr_return_wit_1 : Goal.incr_return_wit_1.
Proof. Abort.

End Proofs.
