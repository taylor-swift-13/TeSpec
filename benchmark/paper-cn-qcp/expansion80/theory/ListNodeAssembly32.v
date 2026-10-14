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
