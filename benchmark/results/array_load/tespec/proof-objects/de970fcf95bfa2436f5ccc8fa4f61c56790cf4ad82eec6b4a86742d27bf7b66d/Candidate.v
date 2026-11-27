From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_main_entail_wit_7 : Goal.main_entail_wit_7.
Proof.
  unfold Goal.main_entail_wit_7.
  left.
  first
    [ solve [apply IntArray.full_split; lia]
    | replace ( &( "a_spec_393" ) ) with
        (( &( "a_spec_393" ) ) + (0 * sizeof(INT))) at 2 by lia;
      first
        [ solve [apply IntArray.full_split; lia]
        | solve [eapply IntArray.full_split; simpl; lia]
        | unfold IntArray.full, IntArray.missing_i; simpl; entailer! ]
    ].
Qed.

End Proofs.
