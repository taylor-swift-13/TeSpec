Require Import Goal.
From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import DLLSupplement.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function singleton -----*)


Lemma original_return_entailment :
(
forall (e___tespec_entry: Z) (element_pre: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (element_pre = 0)) (PreH3 : (e___tespec_entry = 0)) (PreH4 : (element_pre = e___tespec_entry)) (PreH5 : (( &( "element_spec_463" ) ) = 4096)) (PreH6 : (( &( "n_spec_474" ) ) = 8192)) (PreH7 : (0 <= retval)) (PreH8 : (retval <= UINT_MAX)) (PreH9 : (retval = 12288)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> element_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (retval + 8)) # Ptr  |-> 0)
|--
  (Dll retval (@nil Z) e___tespec_entry (@nil Z) )
) .
Proof.
  intros e___tespec_entry element_pre retval
    PreH1 PreH2 PreH3 PreH4 PreH5 PreH6 PreH7 PreH8 PreH9.
  subst element_pre.
  subst e___tespec_entry.
  subst retval.
  unfold Dll.
  eapply derivable1_trans.
  2: apply derivable1_orp_intros2.
  apply coq_prop_andp_right.
  2: exact PreH1.
  eapply derivable1s_exp_r with (x := (0 : Z)).
  eapply derivable1s_exp_r with (x := (0 : Z)).
  cbn [DLLLeft DLLRight].
  let rec close_heap :=
    first
      [ solve [apply derivable1_refl]
      | solve [apply coq_prop_andp_right;
               [close_heap | reflexivity]]
      | solve [apply derivable1_sepcon_mono; close_heap]
      | solve [eapply sepcon_cancel_end; [close_heap | close_heap]] ] in
  close_heap.

Qed.

Module Proofs.

Lemma proof_of_singleton_return_wit_1 : Goal.singleton_return_wit_1.
Proof.
  exact (or_introl original_return_entailment).
Qed.

End Proofs.
