Require Import Goal.
From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import DLLSupplement.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function singleton -----*)


Lemma original_return_entailment :
(
forall (e___tespec_entry: Z) (element_pre: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (element_pre = (-1))) (PreH3 : (e___tespec_entry = (-1))) (PreH4 : (element_pre = e___tespec_entry)) (PreH5 : (( &( "element_spec_463" ) ) = 4096)) (PreH6 : (( &( "n_spec_474" ) ) = 8192)) (PreH7 : (0 <= retval)) (PreH8 : (retval <= UINT_MAX)) (PreH9 : (retval = 12288)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> element_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (retval + 8)) # Ptr  |-> 0)
|--
  (Dll retval (@nil Z) e___tespec_entry (@nil Z) )
) .
Proof.
  intros e___tespec_entry element_pre retval
    PreH1 PreH2 PreH3 PreH4 PreH5 PreH6 PreH7 PreH8 PreH9.
  rewrite PreH4.
  unfold Dll.
  eapply derivable1_trans; [ | apply derivable1_orp_intros2 ].
  apply coq_prop_andp_right; [ | exact PreH1 ].
  apply exp_right_exists. exists 0.
  apply exp_right_exists. exists 0.
  cbn [DLLLeft DLLRight].
  assert (Hnil : emp |-- “ (0 = 0) ” && emp).
  {
    apply coq_prop_andp_right.
    - apply derivable1_refl.
    - reflexivity.
  }
  first
    [ apply sepcon_cancel_end;
      [ apply sepcon_cancel_end;
        [ apply derivable1_refl | exact Hnil ]
      | exact Hnil ]
    | apply derivable1_sepcon_mono;
      [ apply derivable1_refl
      | apply derivable1_sepcon_mono;
        [ apply derivable1_refl
        | apply sepcon_cancel_res_emp;
          apply sepcon_cancel_end; exact Hnil ] ] ].

Qed.

Module Proofs.

Lemma proof_of_singleton_return_wit_1 : Goal.singleton_return_wit_1.
Proof.
  exact (or_introl original_return_entailment).
Qed.

End Proofs.
