From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

(* Both disjuncts require a UInt cell from TT && emp.
   The empty state satisfies the antecedent but contains no such cell.
   The original target is therefore left unresolved pending refutation. *)
Lemma proof_of_main_entail_wit_1 : Goal.main_entail_wit_1.
Proof. Abort.

End Proofs.
