Require Import Goal.
From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import DLLSupplement.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function singleton -----*)


Lemma original_return_entailment :
(
forall (e___tespec_entry: Z) (element_pre: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (element_pre = 1)) (PreH3 : (e___tespec_entry = 1)) (PreH4 : (element_pre = e___tespec_entry)) (PreH5 : (( &( "element_spec_463" ) ) = 4096)) (PreH6 : (( &( "n_spec_474" ) ) = 8192)) (PreH7 : (0 <= retval)) (PreH8 : (retval <= UINT_MAX)) (PreH9 : (retval = 12288)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> element_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (retval + 8)) # Ptr  |-> 0)
|--
  (Dll retval (@nil Z) e___tespec_entry (@nil Z) )
) .
Proof.
  intros e element retval Hnz Helt He Hsame Hs1 Hs2 Hlo Hhi Hret.
  rewrite Hsame.
  unfold Dll.
  eapply derivable1_trans.
  2: apply derivable1_orp_intros2.
  apply coq_prop_andp_right.
  2: exact Hnz.
  eapply (derivable1s_exp_r _ _ (0 : Z)).
  eapply (derivable1s_exp_r _ _ (0 : Z)).
  cbn [DLLLeft DLLRight].
  assert (Hempty : emp |-- “ (0 : Z) = 0 ” && emp).
  { apply coq_prop_andp_right.
    - apply derivable1_refl.
    - reflexivity. }
  first
    [ solve
        [ eapply sepcon_cancel_end;
          [ eapply sepcon_cancel_end;
            [ apply derivable1_refl | exact Hempty ]
          | exact Hempty ] ]
    | solve
        [ apply derivable1_sepcon_mono;
          [ apply derivable1_refl
          | apply derivable1_sepcon_mono;
            [ apply derivable1_refl
            | apply sepcon_cancel_res_emp;
              eapply sepcon_cancel_end; exact Hempty ] ] ] ].

Qed.

Module Proofs.

Lemma proof_of_singleton_return_wit_1 : Goal.singleton_return_wit_1.
Proof.
  exact (or_introl original_return_entailment).
Qed.

End Proofs.
