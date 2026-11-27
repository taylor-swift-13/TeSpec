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
    Hback Hretval Hx Hq Hl Hx0 Hxx0 Hf Hb Hdecomp Hlo Hhi.
  assert (Hcontents :
    app l (cons x0 nil) =
    app (app pre (cons last nil)) (cons x nil)).
  { rewrite <- Hdecomp. rewrite Hxx0. reflexivity. }
  apply orp_right2.
  Exists x retval f (app pre (cons last nil)).
  entailer!.
Qed.

Lemma proof_of_IntQueue_push_induction_precondition_wit_1 : Goal.IntQueue_push_induction_precondition_wit_1.
Proof.
Abort.

End Proofs.
