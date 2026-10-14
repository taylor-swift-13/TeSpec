(* Explicit tree representation for struct tree's ABI32 field offsets.
   The tree datatype and size function are the original suite definitions. *)
Require Export TreeMeasure.
Require Import Coq.ZArith.ZArith.
Require Import Coq.Strings.String.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import Logic.LogicGenerator.demo932.Interface.
Import naive_C_Rules.
Local Open Scope Z_scope.
Local Open Scope string_scope.
Local Open Scope sac.

Fixpoint store_tree32 (p : Z) (t : tree) : Assertion :=
  match t with
  | empty => “ p = 0 ” && emp
  | make_tree l k v r =>
      “ p <> 0 ” && “ INT_MIN <= k <= INT_MAX ” &&
      EX pl pr : Z,
        store_int p k ** store_int (p + 4) v **
        store_ptr (p + 8) pl ** store_ptr (p + 12) pr **
        store_tree32 pl l ** store_tree32 pr r
  end.

Theorem store_tree32_corresponds_under_field_layout :
  (forall p, &(p # "tree" ->ₛ "key") = p) ->
  (forall p, &(p # "tree" ->ₛ "value") = p + 4) ->
  (forall p, &(p # "tree" ->ₛ "left") = p + 8) ->
  (forall p, &(p # "tree" ->ₛ "right") = p + 12) ->
  forall t p, store_tree p t --||-- store_tree32 p t.
Proof.
  intros Hkey Hvalue Hleft Hright t.
  induction t as [| l IHl k v r IHr]; intro p.
  - cbn [store_tree store_tree32]. split; apply derivable1_refl.
  - cbn [store_tree store_tree32].
    rewrite Hkey, Hvalue, Hleft, Hright. split.
    + Intros pl pr. Exists pl pr.
      sep_apply (proj1 (IHl pl)).
      sep_apply (proj1 (IHr pr)). entailer!.
    + Intros pl pr. Exists pl pr.
      sep_apply (proj2 (IHl pl)).
      sep_apply (proj2 (IHr pr)). entailer!.
Qed.

Print Assumptions store_tree32_corresponds_under_field_layout.
