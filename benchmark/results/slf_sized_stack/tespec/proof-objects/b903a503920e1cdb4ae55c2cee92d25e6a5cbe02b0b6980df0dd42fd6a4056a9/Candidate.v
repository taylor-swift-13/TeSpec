From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_top_precondition_wit_1 : Goal.top_precondition_wit_1.
Proof.
  unfold Goal.top_precondition_wit_1.
  exists (@nil Z), 0%Z, 8192%Z, 4096%Z.
  (* Unresolved: exhibit a concrete state satisfying the separated UInt
     store at 4096, Ptr store at 4100, Int store at 8192, and Ptr store
     at 8196, with respective values 1, 8192, 0, and 0.
     The empty state does not satisfy these stores. *)
Abort.

End Proofs.
