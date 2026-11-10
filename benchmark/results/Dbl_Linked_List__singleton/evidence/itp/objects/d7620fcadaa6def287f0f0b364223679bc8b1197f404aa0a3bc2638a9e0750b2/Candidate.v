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
  refine (SeparationLogic.naive_C_Rules.derivable1_trans _ _ _ _ _).
  2: { exact (SeparationLogic.naive_C_Rules.derivable1_orp_intros2 _ _). }
  refine (coq_prop_andp_right _ _ _ _ PreH1).
  refine (SeparationLogic.naive_C_Rules.derivable1s_exp_r _ _ 0 _).
  refine (SeparationLogic.naive_C_Rules.derivable1s_exp_r _ _ 0 _).
  unfold DLLLeft, DLLRight.
  assert (Hempty : emp |-- “ (0 = 0) ” && emp).
  {
    refine (coq_prop_andp_right _ _ _ _ eq_refl).
    exact (SeparationLogic.naive_C_Rules.derivable1_refl _).
  }
  let rec finish :=
    first
      [ exact (SeparationLogic.naive_C_Rules.derivable1_refl _)
      | exact Hempty
      | refine (sepcon_cancel_end _ _ _ _ _); [ finish | finish ]
      | refine (SeparationLogic.naive_C_Rules.derivable1_sepcon_mono
          _ _ _ _ _ _); [ finish | finish ] ]
  in solve [ finish ].

Qed.

Module Proofs.

Lemma proof_of_singleton_return_wit_1 : Goal.singleton_return_wit_1.
Proof.
  exact (or_introl original_return_entailment).
Qed.

End Proofs.
