From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Ltac array_finish fuel :=
  first
    [ solve [entailer!]
    | solve [reflexivity]
    | solve [lia]
    | lazymatch fuel with
      | O => fail 1
      | S ?rest =>
        first
          [ solve [progress cbn; array_finish rest]
          | solve [progress (entailer!); array_finish rest]
          | match goal with
            | |- ?lhs |-- ?rhs =>
              multimatch rhs with
              | context [?f ?x] =>
                is_const f;
                tryif (match lhs with context [f] => idtac end)
                then fail
                else solve [progress unfold f; array_finish rest]
              end
            end
          | multimatch goal with
            | |- context [?f ?x] =>
              is_const f;
              solve [progress unfold f; array_finish rest]
            end
          ]
      end
    ].

Lemma proof_of_init_array2_entail_wit_1 : Goal.init_array2_entail_wit_1.
Proof.
  unfold Goal.init_array2_entail_wit_1.
  left.
  unfold CharArray.full.
  array_finish constr:(12%nat).
Qed.

Lemma proof_of_init_array2_entail_wit_2 : Goal.init_array2_entail_wit_2.
Proof.
  unfold Goal.init_array2_entail_wit_2.
  right.
  unfold CharArray.undef_full.
  array_finish constr:(12%nat).
Qed.

Lemma proof_of_init_array2_return_wit_1 : Goal.init_array2_return_wit_1.
Proof.
  unfold Goal.init_array2_return_wit_1.
  left.
  intros p_pre n_pre PreH1 PreH2 PreH3 PreH4 PreH5 PreH6.
  subst p_pre; subst n_pre.
  replace (4096 + 0 * sizeof(CHAR)) with 4096 by ring.
  Exists (repeat_Z 0 1).
  destruct proof_of_init_array2_entail_wit_1 as [H | H]; exact H.
Qed.

End Proofs.
