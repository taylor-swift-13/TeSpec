From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_main_entail_wit_7 : Goal.main_entail_wit_7.
Proof.
  unfold Goal.main_entail_wit_7.
  left.
  first
    [ solve [IntArray_split; entailer!]
    | solve [entailer!]
    | solve [eapply IntArray.full_split with (i := 0); simpl; try reflexivity; try lia; entailer!]
    | solve [unfold IntArray.full, IntArray.missing_i; simpl; entailer!]
    ].
Qed.

End Proofs.
