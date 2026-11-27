From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_IntQueue_pop_precondition_wit_1 : Goal.IntQueue_pop_precondition_wit_1.
Proof.
  unfold Goal.IntQueue_pop_precondition_wit_1.
  exists (cons 0 (cons INT_MIN (@nil Z))).
  exists INT_MAX.
  exists 4096.
  (* Unresolved: construct a concrete heap satisfying the first disjunct.
     Existential witnesses, in order:
       last = INT_MIN, b = 8208, t = 8200, h = 8192,
       pre = cons 0 (@nil Z).
     The required allocated field addresses are pairwise disjoint:
       4096, 4100, 8192, 8196, 8200, 8204, 8208, 8212.
     The empty model does not satisfy this assertion. *)
Abort.

End Proofs.
