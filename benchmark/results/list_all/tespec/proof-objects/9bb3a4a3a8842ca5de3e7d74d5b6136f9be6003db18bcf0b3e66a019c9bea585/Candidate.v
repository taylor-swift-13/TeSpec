From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_cons_precondition_wit_1 : Goal.IntList_cons_precondition_wit_1.
Proof.
  unfold Goal.IntList_cons_precondition_wit_1.
  exists (@nil Z), 7, 7, 0.
  intro H.
  hnf in H.
  match type of H with
  | forall h : ?T, ?P h -> _ =>
      assert (Hex : exists h : T, P h) by
        (eexists; cbn [sll]; repeat split; reflexivity);
      destruct Hex as [h Hh];
      exact (H h Hh)
  end.
Qed.

End Proofs.
