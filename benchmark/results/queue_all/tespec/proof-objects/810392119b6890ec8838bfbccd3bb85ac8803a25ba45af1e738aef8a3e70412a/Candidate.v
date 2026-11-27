From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Require Import TeSpecLayout_5b48e99c1f6bafd5808d7dbb.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntQueue_push_induction_return_wit_1 : Goal.IntQueue_push_induction_return_wit_1.
Proof.
  unfold Goal.IntQueue_push_induction_return_wit_1.
  intros l x0 f b last pre x q retval
    PreH1 PreH2 PreH3 PreH4 PreH5 PreH6
    PreH7 PreH8 PreH9 PreH10 PreH11 PreH12.
  rewrite <- PreH7.
  rewrite PreH10.
  match goal with
  | |- ?P |-- ?Q || ?R =>
      assert (Hright : P |-- R);
      [ | exact (fun s hs => or_intror (Hright s hs)) ]
  end.
  Exists x retval f (app pre (cons last nil)).
  entailer!.
Qed.

Lemma proof_of_IntQueue_push_induction_precondition_wit_1 : Goal.IntQueue_push_induction_precondition_wit_1.
Proof.
Abort.

End Proofs.
