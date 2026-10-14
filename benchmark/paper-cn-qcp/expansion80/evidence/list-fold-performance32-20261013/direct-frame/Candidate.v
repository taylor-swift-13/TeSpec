Require Import Coq.ZArith.ZArith Coq.Lists.List.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import SimpleC.EE.QCP_demos_human.sll_layout32.
Import naive_C_Rules ListNotations.
Local Open Scope Z_scope.
Local Open Scope sac.

Theorem node_and_tail_form_list : forall p element next tail,
  p <> 0 ->
  (store_int p element ** store_ptr (p + 4) next) ** sll32 next tail
  |-- sll32 p (element :: tail).
Proof. intros. cbn [sll32]. Exists next. entailer!. Qed.

Require Import Coq.ZArith.ZArith Coq.micromega.Lia.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import SimpleC.EE.QCP_demos_human.sll_layout32.
Import naive_C_Rules.
Local Open Scope Z_scope.
Local Open Scope sac.

Lemma empty_list_tail32 : emp |-- sll32 0 nil.
Proof. cbn [sll32]. entailer!. Qed.

(* Build a list from its existing tail. Field addresses identify nodes even
   when every node carries the same value. The assembly lemma is embedded
   before this tactic by the certificate generator. *)
Ltac fold_one_list_node :=
  match goal with
  | |- ?lhs |-- _ =>
    match lhs with
    | context[sll32 ?next ?tail] =>
      match lhs with
      | context[store_ptr ?address ?target] =>
        constr_eq target next;
        match lhs with
        | context[store_int ?p ?element] =>
          unify address (p + 4);
          let nonnull := fresh "nonnull" in
          assert (nonnull : p <> 0) by lia;
          sep_apply (node_and_tail_form_list p element next tail nonnull);
          clear nonnull; idtac "folded node" p
        end
      end
    end
  end.

Ltac prove_folded_list_return :=
  intros; subst;
  match goal with
  | |- ?lhs |-- _ =>
    eapply derivable1_trans;
    [ exact (sepcon_cancel_res_emp lhs (sll32 0 nil) empty_list_tail32) | ]
  end;
  repeat fold_one_list_node;
  entailer!.

Require Import Goal.
Lemma return_checked : Goal.length_return_wit_1.
Proof. unfold Goal.length_return_wit_1. prove_folded_list_return. Qed.
