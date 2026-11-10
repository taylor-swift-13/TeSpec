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
  intros.
  rewrite PreH11.
  (* Select the postcondition branch justified by n_pre = 0. *)
  rewrite <- SimpleC.SL.SeparationLogic.naive_C_Rules.derivable1_orp_intros1.
  entailer!.
  unfold DLLSupplement.Dll.
  (* retval is nonzero; its empty left and right lists use null links. *)
  rewrite <- SimpleC.SL.SeparationLogic.naive_C_Rules.derivable1_orp_intros2.
  entailer!.
  Exists (0 : Z) (0 : Z).
  cbn [DLLSupplement.DLLLeft DLLSupplement.DLLRight].
  entailer!.
Qed.

End Proofs.
