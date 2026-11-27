Require Import Goal.
Module Proofs.

(* Unresolved refutation: instantiate both disjuncts with
   old___tespec_entry = UINT_MAX and p_pre = 4096.
   The resulting UInt points-to assertion describes a nonempty heap,
   whereas TT && emp requires an empty heap. A formal proof still
   requires the concrete heap model and its points-to lemmas. *)
Lemma proof_of_incr_return_wit_1 : ~ Goal.incr_return_wit_1.
Proof. Abort.

End Proofs.
