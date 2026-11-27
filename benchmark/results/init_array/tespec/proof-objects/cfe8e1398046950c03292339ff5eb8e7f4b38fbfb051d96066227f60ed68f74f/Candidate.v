From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Ltac assertion_head t :=
  lazymatch t with
  | ?f ?x => assertion_head f
  | _ => t
  end.

Ltac spatial_occurs a p :=
  first [ constr_eq a p
        | lazymatch p with
          | ?p1 ** ?p2 => first [spatial_occurs a p1 | spatial_occurs a p2]
          | ?p1 && ?p2 => first [spatial_occurs a p1 | spatial_occurs a p2]
          end ].

Ltac expose_array_leaf lhs t :=
  first [ spatial_occurs t lhs; fail 1
        | lazymatch t with
          | ?p ** ?q => first [expose_array_leaf lhs p | expose_array_leaf lhs q]
          | ?p && ?q => first [expose_array_leaf lhs p | expose_array_leaf lhs q]
          | emp => fail
          | TT => fail
          | “ ?p ” => fail
          | (?p # Char |-> ?v) => fail
          | (?p # Char |->_) => fail
          | _ => let f := assertion_head t in
                 is_const f;
                 progress unfold f
          end ].

Ltac finish_arrays fuel :=
  first [solve [entailer!]
        | lazymatch fuel with
          | S ?n =>
              match goal with
              | |- ?p |-- ?q => expose_array_leaf p q
              end;
              cbn;
              finish_arrays n
          end ].

Lemma proof_of_init_array2_entail_wit_1 : Goal.init_array2_entail_wit_1.
Proof.
  unfold Goal.init_array2_entail_wit_1.
  right.
  finish_arrays 32%nat.
Qed.

Lemma proof_of_init_array2_entail_wit_2 : Goal.init_array2_entail_wit_2.
Proof.
  unfold Goal.init_array2_entail_wit_2.
  left.
  finish_arrays 32%nat.
Qed.

Lemma proof_of_init_array2_entail_wit_3 : Goal.init_array2_entail_wit_3.
Proof.
  unfold Goal.init_array2_entail_wit_3.
  left.
  finish_arrays 32%nat.
Qed.

Lemma proof_of_init_array2_entail_wit_4 : Goal.init_array2_entail_wit_4.
Proof.
  unfold Goal.init_array2_entail_wit_4.
  left.
  finish_arrays 32%nat.
Qed.

Lemma proof_of_init_array2_entail_wit_5 : Goal.init_array2_entail_wit_5.
Proof.
  unfold Goal.init_array2_entail_wit_5.
  left.
  finish_arrays 32%nat.
Qed.

Lemma proof_of_init_array2_entail_wit_6 : Goal.init_array2_entail_wit_6.
Proof.
  unfold Goal.init_array2_entail_wit_6.
  left.
  finish_arrays 32%nat.
Qed.

Lemma proof_of_init_array2_entail_wit_7 : Goal.init_array2_entail_wit_7.
Proof.
  unfold Goal.init_array2_entail_wit_7.
  left.
  finish_arrays 32%nat.
Qed.

Lemma proof_of_init_array2_entail_wit_8 : Goal.init_array2_entail_wit_8.
Proof.
  unfold Goal.init_array2_entail_wit_8.
  left.
  finish_arrays 32%nat.
Qed.

Lemma proof_of_init_array2_entail_wit_9 : Goal.init_array2_entail_wit_9.
Proof.
  unfold Goal.init_array2_entail_wit_9.
  right.
  finish_arrays 32%nat.
Qed.

Lemma proof_of_init_array2_return_wit_1 : Goal.init_array2_return_wit_1.
Proof.
  unfold Goal.init_array2_return_wit_1.
  left.
  intros p_pre n_pre PreH1 PreH2 PreH3 PreH4 PreH5 PreH6 PreH7 PreH8 PreH9 PreH10 PreH11 PreH12 PreH13 PreH14.
  subst p_pre; subst n_pre.
  Exists (repeat_Z 0 8).
  cbn.
  finish_arrays 32%nat.
Qed.

End Proofs.
