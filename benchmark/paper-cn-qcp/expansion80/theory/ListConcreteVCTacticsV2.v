Require Import Coq.ZArith.ZArith.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import SimpleC.EE.QCP_demos_human.sll_layout32.
Import naive_C_Rules.
Local Open Scope Z_scope.
Local Open Scope sac.

(* Choose each existential pointer from its actual next-field resource.
   Payload equality does not identify a node when data values repeat. *)
Ltac pointer_witness_from_fields :=
  match goal with
  | |- ?lhs |-- ?rhs =>
    match rhs with
    | context[@naive_C_Rules.exp Z ?f] =>
      let marker := fresh "field_marker" in
      pose (marker := (0 : Z));
      let body := eval cbn beta in (f marker) in
      match body with
      | context[store_ptr ?address ?link] =>
        constr_eq link marker;
        match lhs with
        | context[store_ptr ?actual ?target] =>
            unify address actual; clear marker; Exists target
        end
      end
    end
  end.
Ltac prove_flat_list_vc :=
  intros; cbn [sll32];
  repeat match goal with
  | |- ?lhs |-- _ => lazymatch lhs with
      | context[@naive_C_Rules.exp Z ?f] => let name := fresh "next" in Intros name
      end
  end;
  subst; repeat pointer_witness_from_fields;
  entailer!; try (cbn [Z.add Pos.add Pos.add_carry Pos.succ]; entailer!).

