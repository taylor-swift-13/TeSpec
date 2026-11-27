Require Import Goal.
Module Proofs.

(* The empty heap satisfies TT && emp but cannot contain the required UInt cell. Both disjuncts therefore fail. *)
Lemma proof_of_main_entail_wit_1 : Goal.main_entail_wit_1.
Proof. Abort.

End Proofs.
