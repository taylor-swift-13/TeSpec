Require Import Goal.
From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import DLLSupplement.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function singleton -----*)


Lemma original_return_entailment :
(
forall (e___tespec_entry: Z) (element_pre: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (element_pre = (-100))) (PreH3 : (e___tespec_entry = (-100))) (PreH4 : (element_pre = e___tespec_entry)) (PreH5 : (( &( "element_spec_463" ) ) = 4096)) (PreH6 : (( &( "n_spec_474" ) ) = 8192)) (PreH7 : (0 <= retval)) (PreH8 : (retval <= UINT_MAX)) (PreH9 : (retval = 12288)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> element_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (retval + 8)) # Ptr  |-> 0)
|--
  (Dll retval (@nil Z) e___tespec_entry (@nil Z) )
) .
Proof.
  intros e___tespec_entry element_pre retval Hnonzero
    Helement Hentry Hsame Hstack_element Hstack_n Hlower Hupper Hretval.
  subst element_pre.
  subst e___tespec_entry.
  subst retval.
  unfold Dll.
  refine (derivable1_trans _ _ _ _ (derivable1_orp_intros2 _ _)).
  refine (coq_prop_andp_right _ _ _ _ Hnonzero).
  refine (derivable1s_exp_r _ _ (0 : Z) _).
  refine (derivable1s_exp_r _ _ (0 : Z) _).
  cbn [DLLLeft DLLRight].
  let rec close_heap :=
    solve
      [ exact (derivable1_refl _)
      | refine (coq_prop_andp_right _ _ _ _ eq_refl); close_heap
      | refine (sepcon_cancel_res_emp _ _ _); close_heap
      | refine (derivable1_sepcon_mono _ _ _ _ _ _);
          [ close_heap | close_heap ]
      | refine (sepcon_cancel_end _ _ _ _ _);
          [ close_heap | close_heap ] ]
  in close_heap.

Qed.

Module Proofs.

Lemma proof_of_singleton_return_wit_1 : Goal.singleton_return_wit_1.
Proof.
  exact (or_introl original_return_entailment).
Qed.

End Proofs.
