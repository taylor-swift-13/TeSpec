Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Require Import Coq.micromega.Lia.
Require Import AUXLib.ListLib.
Require Import Coq.Strings.String.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import Logic.LogicGenerator.demo932.Interface.

Import ListNotations.
Import naive_C_Rules.
Local Open Scope Z_scope.
Local Open Scope list.
Local Open Scope string_scope.
Local Open Scope sac.

(** Forward-link ownership for a prefix: every logical node owns its [prev]
    field and the predecessor owns the [next] field pointing to it. *)
Fixpoint xizi_dllseg_shift
  (prev last : addr) (nodes : list addr) : Assertion :=
  match nodes with
  | nil => “ prev = last ” && emp
  | node :: rest =>
      “ node <> NULL ” &&
      &(node # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> prev **
      &(prev # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> node **
      xizi_dllseg_shift node last rest
  end.

(** Reverse-boundary ownership for a suffix: every logical node owns its
    [next] field and the successor owns the [prev] field pointing back. *)
Fixpoint xizi_dllseg_shift_rev
  (node stop : addr) (nodes : list addr) : Assertion :=
  match nodes with
  | nil => “ node = stop ” && emp
  | expected :: rest =>
      “ node = expected ” &&
      “ node <> NULL ” &&
      “ node <> stop ” &&
      EX next : addr,
        &(node # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> next **
        &(next # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> node **
        xizi_dllseg_shift_rev next stop rest
  end.
