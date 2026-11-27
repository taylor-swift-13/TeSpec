From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_push_precondition_wit_1 : Goal.push_precondition_wit_1.
Proof.
  unfold Goal.push_precondition_wit_1.
  exists (cons 1 (@nil Z)).
  exists INT_MIN.
  exists 8192.
  exists 4096.
  exists INT_MIN.
  intro Hunsat.
  (* Unresolved: construct a concrete separating state containing
     UInt(4096,1), Ptr(4100,8192), Int(8192,1), Ptr(8196,0),
     then instantiate Hunsat on that state with p_size = 1.
     The empty state does not satisfy this spatial assertion. *)
Abort.

End Proofs.
