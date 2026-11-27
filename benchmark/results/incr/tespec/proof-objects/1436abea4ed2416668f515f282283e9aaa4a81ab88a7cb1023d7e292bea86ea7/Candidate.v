Require Import Goal.
From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_incr_return_wit_1 : ~ Goal.incr_return_wit_1.
Proof.
  (* Unresolved: requires a concrete nonempty heap satisfying the integer cell,
     together with the semantic fact that this heap does not satisfy emp. *)
Abort.

End Proofs.
