From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_pop_precondition_wit_1 : Goal.pop_precondition_wit_1.
Proof.
  unfold Goal.pop_precondition_wit_1.
  exists (@nil Z), INT_MIN, 8192, 4096.
  intro Hunsat.
  (* Unresolved: exhibit a concrete state satisfying the separating
     conjunction of UInt(4096,1), Ptr(4100,8192),
     Int(8192,INT_MIN), and Ptr(8196,0).
     Instantiate the assertion's p_size with 1 and the singleton
     list's successor with 0, then apply Hunsat to that state.
     The concrete empty state does not satisfy these stores. *)
Abort.

End Proofs.
