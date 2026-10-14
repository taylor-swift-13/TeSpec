(* Explicit standard list representation for the QCP 32-bit ABI.
   The importing client must bind struct list = { int data; list *next; }
   to offsets 0 and 4. This module adds no field-layout axioms. *)
Require Import Coq.ZArith.ZArith Coq.Lists.List.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import Logic.LogicGenerator.demo932.Interface.
Import naive_C_Rules.
Import ListNotations.
Local Open Scope Z_scope.
Local Open Scope sac.
Fixpoint sll32 (p : Z) (values : list Z) :=
  match values with
  | [] => “ p = 0 ” && emp
  | element :: tail => “ p <> 0 ” && EX next : Z,
      store_int p element ** store_ptr (p + 4) next ** sll32 next tail
  end.

Fixpoint sllseg32 (p endp : Z) (values : list Z) :=
  match values with
  | [] => “ p = endp ” && emp
  | element :: tail => “ p <> 0 ” && EX next : Z,
      store_int p element ** store_ptr (p + 4) next ** sllseg32 next endp tail
  end.
Fixpoint sllbseg32 (slot endslot : Z) (values : list Z) :=
  match values with
  | [] => “ slot = endslot ” && emp
  | element :: tail => EX node : Z, “ node <> 0 ” &&
      store_ptr slot node ** store_int node element ** sllbseg32 (node + 4) endslot tail
  end.
