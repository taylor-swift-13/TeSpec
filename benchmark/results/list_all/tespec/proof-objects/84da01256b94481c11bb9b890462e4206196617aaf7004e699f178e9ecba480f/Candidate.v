From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_rev_precondition_wit_1 : Goal.IntList_rev_precondition_wit_1.
Proof.
  unfold Goal.IntList_rev_precondition_wit_1.
  exists (@nil Z), 0.
  intro H.
  cbv in H.
  let rec empty_model :=
    first [ solve [exact (fun _ => None)]
          | solve [exact nil]
          | solve [exact tt]
          | solve [exact 0%Z]
          | solve [constructor; empty_model] ] in
  lazymatch type of H with
  | forall h : ?T, _ =>
      let h := constr:((ltac:(empty_model)) : T) in
      specialize (H h)
  end.
  cbv in H.
  firstorder congruence.
Qed.

End Proofs.
