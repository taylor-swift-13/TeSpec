Require Import Coq.ZArith.ZArith.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import SimpleC.EE.QCP_demos_human.sll_layout32.
Import naive_C_Rules.
Local Open Scope Z_scope.
Local Open Scope sac.

(* Introduce logical pointer witnesses, never the model witnesses of sepcon.
   Failure leaves an unproved goal; no theorem or verdict is admitted here. *)
Ltac prove_flat_list_vc :=
  intros;
  cbn [sll32];
  repeat match goal with
  | |- ?lhs |-- _ => lazymatch lhs with
      | context[@naive_C_Rules.exp Z ?f] =>
          let name := fresh "next" in Intros name
      end
  end;
  subst;
  repeat (Exists _);
  entailer!;
  try (cbn [Z.add Pos.add Pos.add_carry Pos.succ]; entailer!).
