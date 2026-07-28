Require Import Coq.ZArith.ZArith.
Require Import Coq.Lists.List.
Require Import Coq.Strings.String.
Require Import Coq.micromega.Psatz.
From AUXLib Require Import int_auto Axioms Feq Idents ListLib VMap.
Require Import SetsClass.SetsClass. Import SetsNotation.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import Logic.LogicGenerator.demo932.Interface.

Local Open Scope Z_scope.
Local Open Scope sets.
Import ListNotations.
Local Open Scope list.
Local Open Scope string_scope.

Import naive_C_Rules.
Local Open Scope sac.

(** * Generic singly-linked-list model

    This section is layout-independent.  [storeA] describes the ownership
    carried by one node, while the recursive predicates only describe list
    shape.  Keep these declarations public: generated proofs unfold them
    directly. *)

Definition sll_link (struct_name next_field: string) (x y: addr): Assertion :=
  &(x # struct_name ->ₛ next_field) # Ptr |-> y.

Fixpoint generic_sll
  {A: Type}
  (storeA: addr -> addr -> A -> Assertion)
  (x: addr)
  (l: list A): Assertion :=
  match l with
  | nil => “ x = NULL ” && emp
  | a :: l0 =>
      “ x <> NULL ” &&
      EX y: addr,
        storeA x y a **
        generic_sll storeA y l0
  end.

Fixpoint generic_sllseg
  {A: Type}
  (storeA: addr -> addr -> A -> Assertion)
  (x y: addr)
  (l: list A): Assertion :=
  match l with
  | nil => “ x = y ” && emp
  | a :: l0 =>
      “ x <> NULL ” &&
      EX z: addr,
        storeA x z a **
        generic_sllseg storeA z y l0
  end.

Fixpoint generic_sll_to_target
  {A: Type}
  (storeA: addr -> addr -> A -> Assertion)
  (x y: addr)
  (l: list A): Assertion :=
  match l with
  | nil => “ x = y ” && emp
  | a :: l0 =>
      “ x <> NULL ” &&
      “ x <> y ” &&
      EX z: addr,
        storeA x z a **
        generic_sll_to_target storeA z y l0
  end.

Fixpoint generic_sll_not_target
  {A: Type}
  (storeA: addr -> addr -> A -> Assertion)
  (x y: addr)
  (l: list A): Assertion :=
  match l with
  | nil => “ x = NULL ” && emp
  | a :: l0 =>
      “ x <> NULL ” &&
      “ x <> y ” &&
      EX z: addr,
        storeA x z a **
        generic_sll_not_target storeA z y l0
  end.

Definition generic_sll_head
  {A: Type}
  (storeA: addr -> addr -> A -> Assertion)
  (store_head: addr -> addr -> Assertion)
  (head: addr)
  (l: list A): Assertion :=
  “ head <> NULL ” &&
  EX first: addr,
    store_head head first **
    generic_sll storeA first l.

Definition sll_addr_store (struct_name next_field: string)
  (x y p: addr): Assertion :=
  “ x = p ” && sll_link struct_name next_field x y.

Definition sll_head_store (struct_name next_field: string)
  (x y: addr): Assertion :=
  sll_link struct_name next_field x y.

(** * Optional layout functor

    This functor is retained as part of the public compatibility surface.
    The concrete Xizi predicates below use the same generic definitions
    directly so that their established names remain unchanged. *)

Module Type SLL_LAYOUT.
  Parameter Inline struct_name : string.
  Parameter Inline next_field : string.
End SLL_LAYOUT.

Module SLLLib (Layout : SLL_LAYOUT).

  Import Layout.

  Definition addr_node_store : addr -> addr -> addr -> Assertion :=
    sll_addr_store struct_name next_field.

  Definition head_store : addr -> addr -> Assertion :=
    sll_head_store struct_name next_field.

  Definition sll : addr -> list addr -> Assertion :=
    generic_sll addr_node_store.

  Definition sllseg : addr -> addr -> list addr -> Assertion :=
    generic_sllseg addr_node_store.

  Definition sll_to_target : addr -> addr -> list addr -> Assertion :=
    generic_sll_to_target addr_node_store.

  Definition sll_not_target : addr -> addr -> list addr -> Assertion :=
    generic_sll_not_target addr_node_store.

  Definition sll_head : addr -> list addr -> Assertion :=
    generic_sll_head addr_node_store head_store.

End SLLLib.

(** * Xizi [SingleLinklistNode] instantiation *)

Definition xizi_struct_name : string := "SingleLinklistNode".
Definition xizi_next_field : string := "node_next".

Definition xizi_addr_node_store : addr -> addr -> addr -> Assertion :=
  sll_addr_store xizi_struct_name xizi_next_field.

Definition xizi_head_store : addr -> addr -> Assertion :=
  sll_head_store xizi_struct_name xizi_next_field.

Definition xizi_sll : addr -> list addr -> Assertion :=
  generic_sll xizi_addr_node_store.

Definition xizi_sllseg : addr -> addr -> list addr -> Assertion :=
  generic_sllseg xizi_addr_node_store.

Definition xizi_sll_to_target : addr -> addr -> list addr -> Assertion :=
  generic_sll_to_target xizi_addr_node_store.

Definition xizi_sll_not_target : addr -> addr -> list addr -> Assertion :=
  generic_sll_not_target xizi_addr_node_store.

Definition xizi_sll_head : addr -> list addr -> Assertion :=
  generic_sll_head xizi_addr_node_store xizi_head_store.

Definition xizi_sll_node (node: addr): Assertion :=
  “ node <> NULL ” &&
  &(node # xizi_struct_name ->ₛ xizi_next_field) # Ptr |->_.

Definition xizi_sll_first_value (l: list addr): addr :=
  match l with
  | nil => NULL
  | first :: _ => first
  end.

Definition xizi_sll_tail_value
  (l: list addr) (default: addr): addr :=
  last l default.

Fixpoint xizi_sll_next_value (l: list addr) (node: addr): addr :=
  match l with
  | nil => NULL
  | current :: suffix =>
      if Z.eq_dec current node
      then xizi_sll_first_value suffix
      else xizi_sll_next_value suffix node
  end.

(** * Head and standalone-node views *)

Lemma xizi_sll_head_nil_node: forall node,
  xizi_sll_head node nil |-- xizi_sll_node node.
Proof.
  intros.
  unfold xizi_sll_head, generic_sll_head, xizi_head_store,
    sll_head_store, sll_link, xizi_sll_node.
  Intros next.
  unfold xizi_sll, generic_sll.
  simpl.
  unfold xizi_struct_name, xizi_next_field.
  sep_apply store_ptr_undef_store_ptr.
  entailer!.
Qed.

Lemma xizi_sll_head_from_cons: forall head l,
  xizi_sll head (head :: l) |--
  xizi_sll_head head l.
Proof.
  intros head l.
  unfold xizi_sll at 1.
  simpl.
  unfold xizi_addr_node_store, sll_addr_store, sll_link,
    xizi_sll_head, generic_sll_head, xizi_head_store,
    sll_head_store, xizi_struct_name, xizi_next_field.
  Intros first.
  Intros.
  Exists first.
  entailer!.
Qed.

(** * Whole-list construction and decomposition *)

Lemma xizi_sll_zero: forall x l,
  x = NULL ->
  xizi_sll x l |-- “ l = nil ” && emp.
Proof.
  intros.
  destruct l.
  - entailer!.
  - unfold xizi_sll.
    simpl.
    Intros y.
    entailer!.
Qed.

Lemma xizi_sll_not_zero: forall x l,
  x <> NULL ->
  xizi_sll x l |--
    EX y l0,
      “ l = x :: l0 ” &&
      &(x # xizi_struct_name ->ₛ xizi_next_field) # Ptr |-> y **
      xizi_sll y l0.
Proof.
  intros.
  destruct l as [| d l0].
  - unfold xizi_sll.
    simpl.
    Intros.
    subst.
    tauto.
  - unfold xizi_sll.
    simpl.
    unfold xizi_addr_node_store, sll_addr_store, sll_link,
      xizi_struct_name, xizi_next_field.
    Intros y.
    Intros.
    subst d.
    Exists y l0.
    entailer!.
Qed.

Lemma xizi_sll_first_value_eq: forall x l,
  xizi_sll x l |-- “ x = xizi_sll_first_value l ”.
Proof.
  intros x l.
  destruct l as [| first rest].
  - unfold xizi_sll, generic_sll, xizi_sll_first_value.
    simpl.
    entailer!.
  - unfold xizi_sll, generic_sll, xizi_sll_first_value.
    simpl.
    unfold xizi_addr_node_store, sll_addr_store, sll_link.
    Intros next.
    entailer!.
Qed.

Lemma xizi_sll_next_value_app: forall prefix node suffix,
  ~ In node prefix ->
  xizi_sll_next_value (app prefix (node :: suffix)) node =
  xizi_sll_first_value suffix.
Proof.
  induction prefix as [| current prefix IH];
    intros node suffix Hnotin.
  - simpl.
    destruct (Z.eq_dec node node); [reflexivity | congruence].
  - simpl in Hnotin |- *.
    destruct (Z.eq_dec current node) as [Heq | Hneq].
    + subst current.
      exfalso.
      apply Hnotin.
      left.
      reflexivity.
    + apply IH.
      intro Hin.
      apply Hnotin.
      right.
      exact Hin.
Qed.

Lemma xizi_sll_tail_value_app_last: forall prefix node default,
  xizi_sll_tail_value (app prefix (node :: nil)) default = node.
Proof.
  intros prefix node default.
  unfold xizi_sll_tail_value.
  apply last_last.
Qed.

Lemma xizi_sll_member_split: forall root l node,
  In node l ->
  xizi_sll root l |--
  EX prefix suffix next,
    “ l = app prefix (node :: suffix) /\
      ~ In node prefix /\
      node <> NULL ” &&
    xizi_sllseg root node prefix **
    &(node # xizi_struct_name ->ₛ xizi_next_field) # Ptr |-> next **
    xizi_sll next suffix.
Proof.
  intros root l.
  revert root.
  induction l as [| current suffix IH];
    intros root node Hin.
  - inversion Hin.
  - unfold xizi_sll at 1.
    simpl.
    unfold xizi_addr_node_store, sll_addr_store, sll_link,
      xizi_struct_name, xizi_next_field.
    Intros current_next.
    Intros.
    subst current.
    fold xizi_sll.
    destruct (Z.eq_dec root node) as [Heq | Hneq].
    + subst node.
      Exists nil suffix current_next.
      unfold xizi_sllseg.
      simpl.
      entailer!.
    + assert (Hin_suffix: In node suffix).
      {
        destruct Hin as [Heq | Hin_suffix].
        - congruence.
        - exact Hin_suffix.
      }
      match goal with
      | |- _ |-- ?R =>
          change (
            &(root # "SingleLinklistNode" ->ₛ "node_next") # Ptr |->
              current_next **
            xizi_sll current_next suffix
            |-- R)
      end.
      sep_apply (IH current_next node Hin_suffix).
      Intros prefix tail node_next.
      destruct H0 as [Hlist [Hnotin Hnode_nonnull]].
      Exists (root :: prefix) tail node_next.
      unfold xizi_sllseg at 2.
      simpl.
      fold xizi_sllseg.
      Exists current_next.
      unfold xizi_addr_node_store, sll_addr_store, sll_link,
        xizi_struct_name, xizi_next_field.
      entailer!.
      * now rewrite Hlist.
      * intros [Heq | Hin_prefix].
        -- apply Hneq; exact Heq.
        -- apply Hnotin; exact Hin_prefix.
Qed.

Lemma xizi_sll_split_app_node:
  forall root prefix node suffix,
    xizi_sll root (app prefix (node :: suffix)) |--
    EX next,
      “ node <> NULL ” &&
      xizi_sllseg root node prefix **
      &(node # xizi_struct_name ->ₛ xizi_next_field) # Ptr |-> next **
      xizi_sll next suffix.
Proof.
  intros root prefix.
  revert root.
  induction prefix as [| current prefix IH];
    intros root node suffix.
  - simpl.
    unfold xizi_sll at 1.
    simpl.
    unfold xizi_addr_node_store, sll_addr_store, sll_link,
      xizi_struct_name, xizi_next_field.
    Intros next.
    Intros.
    subst node.
    Exists next.
    unfold xizi_sllseg.
    simpl.
    entailer!.
  - simpl.
    unfold xizi_sll at 1.
    simpl.
    unfold xizi_addr_node_store, sll_addr_store, sll_link,
      xizi_struct_name, xizi_next_field.
    Intros current_next.
    Intros.
    subst current.
    fold xizi_sll.
    match goal with
    | |- _ |-- ?R =>
        change (
          &(root # "SingleLinklistNode" ->ₛ "node_next") # Ptr |->
            current_next **
          xizi_sll current_next (app prefix (node :: suffix))
          |-- R)
    end.
    sep_apply (IH current_next node suffix).
    Intros next.
    Exists next.
    unfold xizi_sllseg at 2.
    simpl.
    fold xizi_sllseg.
    Exists current_next.
    unfold xizi_addr_node_store, sll_addr_store, sll_link,
      xizi_struct_name, xizi_next_field.
    entailer!.
Qed.

Lemma xizi_sll_split_app_target:
  forall root prefix node suffix,
    xizi_sll root (app prefix (node :: suffix)) |--
    EX next,
      “ node <> NULL ” &&
      xizi_sll_to_target root node prefix **
      &(node # xizi_struct_name ->ₛ xizi_next_field) # Ptr |-> next **
      xizi_sll next suffix.
Proof.
  intros root prefix.
  revert root.
  induction prefix as [| current prefix IH];
    intros root node suffix.
  - simpl.
    unfold xizi_sll at 1.
    simpl.
    unfold xizi_addr_node_store, sll_addr_store, sll_link,
      xizi_struct_name, xizi_next_field.
    Intros next.
    Intros.
    subst node.
    Exists next.
    unfold xizi_sll_to_target.
    simpl.
    entailer!.
  - simpl.
    unfold xizi_sll at 1.
    simpl.
    unfold xizi_addr_node_store, sll_addr_store, sll_link,
      xizi_struct_name, xizi_next_field.
    Intros current_next.
    Intros.
    subst current.
    fold xizi_sll.
    match goal with
    | |- _ |-- ?R =>
        change (
          &(root # "SingleLinklistNode" ->ₛ "node_next") # Ptr |->
            current_next **
          xizi_sll current_next (app prefix (node :: suffix))
          |-- R)
    end.
    sep_apply (IH current_next node suffix).
    Intros next.
    Exists next.
    unfold xizi_sll_to_target at 2.
    simpl.
    fold xizi_sll_to_target.
    Exists current_next.
    unfold xizi_addr_node_store, sll_addr_store, sll_link,
      xizi_struct_name, xizi_next_field.
    entailer!.
Qed.

Lemma xizi_sll_head_split_target:
  forall head first prefix node suffix,
    head <> NULL ->
    xizi_sll first (app prefix (node :: suffix)) **
    &(head # xizi_struct_name ->ₛ xizi_next_field) # Ptr |-> first |--
    “ head <> node ” &&
    “ node <> NULL ” &&
    xizi_sll_to_target head node (head :: prefix) **
    &(node # xizi_struct_name ->ₛ xizi_next_field) # Ptr |->
      xizi_sll_first_value suffix **
    xizi_sll (xizi_sll_first_value suffix) suffix.
Proof.
  intros head first prefix node suffix Hhead.
  sep_apply
    (xizi_sll_split_app_target first prefix node suffix).
  Intros next.
  prop_apply (xizi_sll_first_value_eq next suffix).
  Intros.
  subst next.
  unfold xizi_sll_to_target at 2.
  simpl.
  fold xizi_sll_to_target.
  Exists first.
  unfold xizi_addr_node_store, sll_addr_store, sll_link,
    xizi_struct_name, xizi_next_field.
  entailer!.
Qed.

Lemma xizi_sll_cons: forall x y l,
  x <> NULL ->
  &(x # xizi_struct_name ->ₛ xizi_next_field) # Ptr |-> y **
  xizi_sll y l |--
  xizi_sll x (x :: l).
Proof.
  intros.
  unfold xizi_sll.
  simpl.
  unfold xizi_addr_node_store, xizi_struct_name, xizi_next_field,
    sll_addr_store, sll_link.
  Exists y.
  entailer!.
Qed.

Lemma xizi_sll_len1: forall x y,
  x <> NULL ->
  y = NULL ->
  &(x # xizi_struct_name ->ₛ xizi_next_field) # Ptr |-> y |--
  xizi_sll x [x].
Proof.
  intros.
  subst y.
  unfold xizi_sll.
  simpl.
  unfold xizi_addr_node_store, xizi_struct_name, xizi_next_field,
    sll_addr_store, sll_link.
  Exists NULL.
  entailer!.
Qed.

(** * Segment construction and decomposition *)

Lemma xizi_sllseg_len1: forall x y,
  x <> NULL ->
  &(x # xizi_struct_name ->ₛ xizi_next_field) # Ptr |-> y |--
  xizi_sllseg x y [x].
Proof.
  intros.
  unfold xizi_sllseg.
  simpl.
  unfold xizi_addr_node_store, xizi_struct_name, xizi_next_field,
    sll_addr_store, sll_link.
  Exists y.
  entailer!.
Qed.

Lemma xizi_sllseg_not_same: forall x y l,
  x <> y ->
  xizi_sllseg x y l |--
    EX z l0,
      “ l = x :: l0 ” &&
      &(x # xizi_struct_name ->ₛ xizi_next_field) # Ptr |-> z **
      xizi_sllseg z y l0.
Proof.
  intros.
  destruct l as [| d l0].
  - unfold xizi_sllseg.
    simpl.
    Intros.
    subst.
    tauto.
  - unfold xizi_sllseg.
    simpl.
    unfold xizi_addr_node_store, sll_addr_store, sll_link,
      xizi_struct_name, xizi_next_field.
    Intros z.
    Intros.
    subst d.
    Exists z l0.
    entailer!.
Qed.

Lemma xizi_sllseg_zero_nonzero: forall y l,
  y <> NULL ->
  xizi_sllseg NULL y l |-- “ False ”.
Proof.
  intros.
  destruct l as [| d l0].
  - unfold xizi_sllseg.
    simpl.
    Intros.
    subst y.
    tauto.
  - unfold xizi_sllseg.
    simpl.
    Intros z0.
    entailer!.
Qed.

Lemma xizi_sllseg_start_not_zero: forall x y l,
  y <> NULL ->
  xizi_sllseg x y l |-- “ x <> NULL ”.
Proof.
  intros.
  destruct l as [| d l0].
  - unfold xizi_sllseg.
    simpl.
    Intros.
    subst x.
    entailer!.
  - unfold xizi_sllseg.
    simpl.
    Intros z.
    entailer!.
Qed.

(** * Target-bounded list views *)

Lemma xizi_sll_to_target_not_same: forall x y l,
  x <> y ->
  xizi_sll_to_target x y l |--
    EX z l0,
      “ l = x :: l0 ” &&
      &(x # xizi_struct_name ->ₛ xizi_next_field) # Ptr |-> z **
      xizi_sll_to_target z y l0.
Proof.
  intros.
  destruct l as [| d l0].
  - unfold xizi_sll_to_target.
    simpl.
    Intros.
    subst.
    tauto.
  - unfold xizi_sll_to_target.
    simpl.
    unfold xizi_addr_node_store, sll_addr_store, sll_link,
      xizi_struct_name, xizi_next_field.
    Intros z.
    Intros.
    subst d.
    Exists z l0.
    entailer!.
Qed.

Lemma xizi_sll_to_target_same: forall x l,
  xizi_sll_to_target x x l |--
  “ l = nil ” && emp.
Proof.
  intros.
  destruct l as [| d l0].
  - unfold xizi_sll_to_target.
    simpl.
    Intros.
    entailer!.
  - unfold xizi_sll_to_target.
    simpl.
    Intros z0.
    entailer!.
Qed.

Lemma xizi_sll_to_target_zero_nonzero: forall y l,
  y <> NULL ->
  xizi_sll_to_target NULL y l |-- “ False ”.
Proof.
  intros.
  destruct l as [| d l0].
  - unfold xizi_sll_to_target.
    simpl.
    Intros.
    subst y.
    tauto.
  - unfold xizi_sll_to_target.
    simpl.
    Intros z0.
    entailer!.
Qed.

Lemma xizi_sll_not_target_not_zero: forall x y l,
  x <> NULL ->
  xizi_sll_not_target x y l |--
    EX z l0,
      “ l = x :: l0 ” &&
      “ x <> y ” &&
      &(x # xizi_struct_name ->ₛ xizi_next_field) # Ptr |-> z **
      xizi_sll_not_target z y l0.
Proof.
  intros.
  destruct l as [| d l0].
  - unfold xizi_sll_not_target.
    simpl.
    Intros.
    subst.
    tauto.
  - unfold xizi_sll_not_target.
    simpl.
    unfold xizi_addr_node_store, sll_addr_store, sll_link,
      xizi_struct_name, xizi_next_field.
    Intros z.
    Intros.
    subst d.
    Exists z l0.
    entailer!.
Qed.

Lemma xizi_sll_not_target_zero: forall y l,
  xizi_sll_not_target NULL y l |-- “ l = nil ” && emp.
Proof.
  intros.
  destruct l as [| d l0].
  - unfold xizi_sll_not_target.
    simpl.
    Intros.
    entailer!.
  - unfold xizi_sll_not_target.
    simpl.
    Intros z0.
    entailer!.
Qed.

Lemma xizi_sll_not_target_same_nonzero: forall x l,
  x <> NULL ->
  xizi_sll_not_target x x l |-- “ False ”.
Proof.
  intros.
  destruct l as [| d l0].
  - unfold xizi_sll_not_target.
    simpl.
    Intros.
    tauto.
  - unfold xizi_sll_not_target.
    simpl.
    Intros z0.
    entailer!.
Qed.

Lemma xizi_sll_not_target_sll: forall x y l,
  xizi_sll_not_target x y l |-- xizi_sll x l.
Proof.
  intros.
  revert x; induction l as [| d l0 IH]; intros.
  - unfold xizi_sll_not_target, xizi_sll.
    simpl.
    Intros.
    entailer!.
  - unfold xizi_sll_not_target at 1.
    unfold xizi_sll at 1.
    simpl.
    fold xizi_sll_not_target.
    fold xizi_sll.
    Intros z.
    Exists z.
    sep_apply IH.
    entailer!.
Qed.

(** * Segment composition *)

Lemma xizi_sllseg_sllseg: forall x y z l1 l2,
  xizi_sllseg x y l1 ** xizi_sllseg y z l2 |--
  xizi_sllseg x z (l1 ++ l2).
Proof.
  intros.
  revert x; induction l1; intros.
  - unfold xizi_sllseg at 1.
    simpl.
    Intros.
    subst x.
    entailer!.
  - unfold xizi_sllseg at 1.
    unfold xizi_sllseg at 2.
    simpl.
    fold xizi_sllseg.
    Intros z0.
    Exists z0.
    sep_apply IHl1.
    entailer!.
Qed.

Lemma xizi_sllseg_sll: forall x y l1 l2,
  xizi_sllseg x y l1 ** xizi_sll y l2 |--
  xizi_sll x (l1 ++ l2).
Proof.
  intros.
  revert x; induction l1; intros.
  - unfold xizi_sllseg at 1.
    simpl.
    Intros.
    subst x.
    entailer!.
  - unfold xizi_sllseg at 1.
    unfold xizi_sll at 2.
    simpl.
    fold xizi_sllseg.
    fold xizi_sll.
    Intros z0.
    Exists z0.
    sep_apply IHl1.
    entailer!.
Qed.

Lemma xizi_sllseg_0_sll: forall x l,
  xizi_sllseg x 0 l |--
  xizi_sll x l.
Proof.
  intros.
  revert x; induction l; intros.
  - unfold xizi_sllseg, xizi_sll.
    simpl.
    Intros.
    subst x.
    entailer!.
  - unfold xizi_sllseg, xizi_sll.
    simpl.
    fold xizi_sllseg.
    fold xizi_sll.
    Intros z0.
    Exists z0.
    sep_apply IHl.
    entailer!.
Qed.

(** * Length and address-space bounds *)

Lemma xizi_sll_length: forall x l,
  xizi_sll x l |-- store_align4_n (Zlength l).
Proof.
  intros x l.
  revert x.
  induction l; intros x.
  - unfold xizi_sll, generic_sll.
    simpl.
    unfold store_align4_n.
    Exists nil.
    simpl.
    split_pure_spatial;
      [ Intros_p Hnil; cancel
      | dump_pre_spatial;
        split;
        [ rewrite Zlength_nil; reflexivity
        | constructor ] ].
  - unfold xizi_sll, generic_sll at 1.
    simpl.
    unfold xizi_addr_node_store, sll_addr_store, sll_link.
    Intros y.
    Intros.
    subst a.
    fold xizi_sll.
    replace (Zlength (x :: l)) with (1 + Zlength l)
      by (rewrite Zlength_cons; lia).
    sep_apply
      (store_ptr_align4
        (&(x # xizi_struct_name ->ₛ xizi_next_field)) y).
    fold xizi_sll.
    sep_apply (IHl y).
    sep_apply (store_align4_merge 1 (Zlength l)).
    cancel (store_align4_n (1 + Zlength l)).
Qed.

Lemma xizi_sll_length_max: forall x l,
  xizi_sll x l |--
  “ Zlength l <= Int.max_unsigned / 4 + 1 ”.
Proof.
  intros x l.
  sep_apply (xizi_sll_length x l).
  prop_apply store_align4_n_valid.
  Intros.
  dump_pre_spatial.
  exact H.
Qed.

Lemma xizi_sllseg_node_sll_length_max:
  forall first node next l1 l2,
    node <> NULL ->
    xizi_sllseg first node l1 **
    &(node # xizi_struct_name ->ₛ xizi_next_field) # Ptr |-> next **
    xizi_sll next l2 |--
    “ Zlength (l1 ++ node :: l2) <= Int.max_unsigned / 4 + 1 ”.
Proof.
  intros.
  sep_apply (xizi_sll_cons node next l2); [ | exact H ].
  sep_apply (xizi_sllseg_sll first node l1 (node :: l2)).
  prop_apply (xizi_sll_length_max first (l1 ++ node :: l2)).
  Intros.
  dump_pre_spatial.
  exact H1.
Qed.

Lemma xizi_sll_loop_length_max:
  forall head first node next l1 l2,
    node <> NULL ->
    &(node # xizi_struct_name ->ₛ xizi_next_field) # Ptr |-> next **
    xizi_sll next l2 **
    &(head # xizi_struct_name ->ₛ xizi_next_field) # Ptr |-> first **
    xizi_sllseg first node l1 |--
    “ Zlength (l1 ++ node :: l2) <= Int.max_unsigned / 4 + 1 ”.
Proof.
  intros.
  sep_apply (xizi_sll_cons node next l2); [ | exact H ].
  sep_apply (xizi_sllseg_sll first node l1 (node :: l2)).
  prop_apply (xizi_sll_length_max first (l1 ++ node :: l2)).
  Intros.
  dump_pre_spatial.
  exact H1.
Qed.
