From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import DLLSupplement.
Local Open Scope sac.
Local Open Scope Z_scope.
Require Import Goal.
Module Proofs.

Lemma proof_of_add_return_wit_1 : Goal.add_return_wit_1.
Proof.
  unfold Goal.add_return_wit_1.
  intros; subst.
  Left.
  entailer!.
  all: unfold Dll.
  all: Right.
  all: entailer!.
  all: Exists 0.
  all: Exists 0.
  all: cbn [DLLLeft DLLRight].
  all: entailer!.
Qed.

End Proofs.
