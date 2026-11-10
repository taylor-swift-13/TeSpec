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
  intros lr ll q p h e element n retval
    Hn Hnonnull Helement Hn' He Hh Hll Hlr Hp Hq Hsame
    Hn'' Hll' Hlr' Haddrn Haddre Haddrnew Hlo Hhi Hret.
  subst n element e retval.
  eapply naive_C_Rules.derivable1_trans.
  2: apply naive_C_Rules.derivable1_orp_intros1.
  entailer!.
  unfold Dll.
  eapply naive_C_Rules.derivable1_trans.
  2: apply naive_C_Rules.derivable1_orp_intros2.
  Exists 0 0.
  unfold DLLLeft, DLLRight.
  entailer!.
Qed.

End Proofs.
