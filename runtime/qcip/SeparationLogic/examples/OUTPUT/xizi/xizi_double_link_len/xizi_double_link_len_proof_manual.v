Require Import Coq.ZArith.ZArith.
Require Import Coq.Bool.Bool.
Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Lists.List.
Require Import Coq.Classes.RelationClasses.
Require Import Coq.Classes.Morphisms.
Require Import Coq.micromega.Psatz.
Require Import Coq.Sorting.Permutation.
From AUXLib Require Import int_auto Axioms Feq Idents ListLib VMap.
Require Import SetsClass.SetsClass. Import SetsNotation.
From SimpleC.SL Require Import Mem SeparationLogic.
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_len Require Import xizi_double_link_len_goal.
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_len Require Import xizi_double_link_len_proof_auto.
Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
From QCIPLib.xizi.xizi_double_link_common Require Import xizi_double_link_lib.
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_len Require Import xizi_double_link_len_lib.
Local Open Scope sac.

Lemma proof_of_xizi_double_link_len_entail_wit_1 : xizi_double_link_len_entail_wit_1.
Proof.
  pre_process.
  sep_apply_l_atomic (xizi_dll_open linklist_pre nodes).
  Intros first last.
  Exists last first (@nil Z) nodes.
  unfold xizi_dll_links, XiziDLL.links.
  unfold xizi_double_link_size in *.
  entailer!.
Qed.

Lemma proof_of_xizi_double_link_len_entail_wit_2_1 : xizi_double_link_len_entail_wit_2_1.
Proof.
  pre_process.
  assert (Hlinks_distinct : forall a nxt head next after current,
    xizi_dll_links a nxt head ** xizi_dll_links next after current |--
    “ a <> next ”).
  {
    intros.
    unfold xizi_dll_links, XiziDLL.links.
    set_String_name.
    poly_store_unfold.
    repeat sep_apply store_ptr_undef_store_ptr.
    unfold undef_store_ptr.
    Intros_p Hv1.
    Intros_p Hv2.
    Intros_p Hv3.
    Intros_p Hv4.
    sepcon_assoc_change.
    prop_apply_p (store_4byte_valid
      &(a # "SysDoubleLinklistNode" ->ₛ "node_next")
      &(next # "SysDoubleLinklistNode" ->ₛ "node_next")).
    Intros.
    dump_pre_spatial.
    intro Hsame; subst next; lia.
  }
  assert (Hseg_nonnull : forall node prev stop last nodes0,
    node <> stop -> xizi_dllseg node prev stop last nodes0 |--
    “ node <> 0 ”).
  {
    intros node prev stop last nodes0 Hneq.
    destruct nodes0 as [|a rest].
    - unfold xizi_dllseg, XiziDLL.dllseg; simpl.
      Intros. destruct H. contradiction.
    - unfold xizi_dllseg, XiziDLL.dllseg; simpl.
      Intros next0. Intros.
      dump_pre_spatial. unfold NULL in *. assumption.
  }
  assert (Hextend : forall first0 head current prev0 before next after,
    current <> 0 -> current <> next ->
    xizi_dllseg first0 head current prev0 before **
    (xizi_dll_links current next prev0 **
     xizi_dll_links next after current) |--
    xizi_dllseg first0 head next current (before ++ (current :: nil))%list **
    xizi_dll_links next after current).
  {
    intros first0 head current prev0 before.
    induction before as [|a rest IH] in first0, head |- *;
      intros next after Hnull Hneq.
    - unfold xizi_dllseg, XiziDLL.dllseg; simpl.
      Intros.
      destruct H as [Hfirst Hprev].
      subst first0; subst head.
      Exists next.
      entailer!.
    - unfold xizi_dllseg, XiziDLL.dllseg at 1.
      simpl.
      Intros nxt.
      Intros.
      subst first0.
      fold (xizi_dllseg nxt a current prev0 rest).
      fold (xizi_dll_links a nxt head).
      prop_apply_p (Hlinks_distinct a nxt head next after current).
      Intros_p Hane.
      unfold xizi_dllseg, XiziDLL.dllseg at 1.
      simpl.
      Exists nxt.
      split_pure_spatial.
      + cancel (xizi_dll_links a nxt head).
        unfold xizi_dllseg, XiziDLL.dllseg in IH.
        transitivity
          (xizi_dllseg nxt a current prev0 rest **
           (xizi_dll_links current next prev0 **
            xizi_dll_links next after current)).
        * entailer!.
        * exact (IH nxt a next after Hnull Hneq).
      + entailer!.
  }
  prop_apply_p (Hseg_nonnull next_2 tmp_node linklist_pre last_2 todo_2 PreH1).
  Intros_p Hnextnonzero.
  sep_apply_l_atomic
    (xizi_dllseg_unfold next_2 tmp_node linklist_pre last_2 todo_2 PreH1).
  Intros next rest.
  pose proof (Hlinks_distinct tmp_node next_2 prev_2 next_2 next tmp_node) as Hd.
  unfold xizi_dll_links, XiziDLL.links in Hd.
  prop_apply_p Hd.
  Intros_p Htmpnext.
  fold (xizi_dll_links tmp_node next_2 prev_2).
  fold (xizi_dll_links next_2 next tmp_node).
  fold (xizi_dll_links linklist_pre first_2 last_2).
  transitivity
    ((xizi_dllseg first_2 linklist_pre tmp_node prev_2 before_2 **
      (xizi_dll_links tmp_node next_2 prev_2 **
       xizi_dll_links next_2 next tmp_node)) **
      (xizi_dllseg next next_2 linklist_pre last_2 rest **
       xizi_dll_links linklist_pre first_2 last_2)).
  - entailer!.
    unfold xizi_dll_links, XiziDLL.links.
    entailer!.
  - transitivity
      ((xizi_dllseg first_2 linklist_pre next_2 tmp_node
          (before_2 ++ (tmp_node :: nil))%list **
        xizi_dll_links next_2 next tmp_node) **
       (xizi_dllseg next next_2 linklist_pre last_2 rest **
        xizi_dll_links linklist_pre first_2 last_2)).
    + cancel (xizi_dllseg next next_2 linklist_pre last_2 rest).
      cancel (xizi_dll_links linklist_pre first_2 last_2).
      exact (Hextend first_2 linklist_pre tmp_node prev_2 before_2
        next_2 next PreH8 Htmpnext).
    + Exists next tmp_node last_2 first_2 done_2
        (done_2 ++ (next_2 :: nil))%list rest.
      unfold xizi_double_link_size in *.
      split_pure_spatial.
      * unfold xizi_dll_links, XiziDLL.links.
        entailer!.
        rewrite PreH7.
        entailer!.
      * split_pures; dump_pre_spatial; subst;
          rewrite ?Zlength_app, ?Zlength_cons, ?Zlength_nil in *;
          try rewrite unsigned_last_nbits_eq; simpl in *; try lia.
      all: try reflexivity.
      all: try rewrite app_assoc; try reflexivity.
      all: try (replace (Z.pow_pos 2 32) with 4294967296 by reflexivity;
        pose proof (Zlength_nonneg rest); lia).
      all: try lia.
      all: try (repeat rewrite app_assoc; reflexivity).
      all: try (change (0 <= Zlength before_2 + 1 + 1 < 4294967296);
        pose proof (Zlength_nonneg before_2);
        pose proof (Zlength_nonneg rest); lia).
      all: try (rewrite <- app_assoc; reflexivity).
      all: try (unfold Z.succ; lia).
      all: try (change (((before_2 ++ (tmp_node :: nil)) ++ (next_2 :: rest))%list =
        ((((before_2 ++ (tmp_node :: nil)) ++ (next_2 :: nil)) ++ rest)%list));
        rewrite <- app_assoc; reflexivity).
      all: try (change (((before_2 +:: tmp_node) ++ (next_2 :: rest))%list =
        (((before_2 +:: tmp_node) +:: next_2) ++ rest)%list);
        rewrite <- app_assoc; reflexivity).
      all: try (rewrite <- (app_assoc (before_2 +:: tmp_node)
        (next_2 :: nil)%list rest);
        reflexivity).
      all: change (Zlength before_2 + 1 + (Zlength rest + 1) =
        Zlength before_2 + 1 + 1 + Zlength rest); lia.
Qed.

Lemma proof_of_xizi_double_link_len_entail_wit_2_2 : xizi_double_link_len_entail_wit_2_2.
Proof.
  pre_process.
  assert (Hseg_nonnull : forall node prev stop last nodes0,
    node <> stop -> xizi_dllseg node prev stop last nodes0 |--
    “ node <> 0 ”).
  {
    intros node prev stop last nodes0 Hneq.
    destruct nodes0 as [|a rest].
    - unfold xizi_dllseg, XiziDLL.dllseg; simpl.
      Intros. destruct H. contradiction.
    - unfold xizi_dllseg, XiziDLL.dllseg; simpl.
      Intros next0. Intros.
      dump_pre_spatial. unfold NULL in *. assumption.
  }
  prop_apply_p (Hseg_nonnull first_2 linklist_pre linklist_pre last_2 todo_2 PreH1).
  Intros_p Hfirstnonzero.
  sep_apply_l_atomic
    (xizi_dllseg_unfold first_2 linklist_pre linklist_pre last_2 todo_2 PreH1).
  Intros next rest.
  subst tmp_node.
  Exists next linklist_pre last_2 first_2 (@nil Z) (first_2 :: nil)%list rest.
  unfold xizi_double_link_size in *.
  split_pure_spatial.
  - unfold xizi_dllseg, XiziDLL.dllseg; simpl.
    unfold xizi_dll_links, XiziDLL.links.
    entailer!.
  - split_pures; dump_pre_spatial; subst;
      rewrite ?Zlength_app, ?Zlength_cons, ?Zlength_nil in *;
      try rewrite unsigned_last_nbits_eq; simpl in *; try lia.
    all: try reflexivity.
    all: try (change (0 <= 1 < 4294967296); lia).
    all: try (change (Z.succ (Zlength rest) = 1 + Zlength rest);
      change (Zlength rest + 1 = 1 + Zlength rest); lia).
Qed.

Lemma proof_of_xizi_double_link_len_return_wit_1 : xizi_double_link_len_return_wit_1.
Proof.
  assert (Hlinks_distinct : forall a nxt head next after current,
    xizi_dll_links a nxt head ** xizi_dll_links next after current |--
    “ a <> next ”).
  {
    intros.
    unfold xizi_dll_links, XiziDLL.links.
    set_String_name.
    poly_store_unfold.
    repeat sep_apply store_ptr_undef_store_ptr.
    unfold undef_store_ptr.
    Intros_p Hv1.
    Intros_p Hv2.
    Intros_p Hv3.
    Intros_p Hv4.
    sepcon_assoc_change.
    prop_apply_p (store_4byte_valid
      &(a # "SysDoubleLinklistNode" ->ₛ "node_next")
      &(next # "SysDoubleLinklistNode" ->ₛ "node_next")).
    Intros.
    dump_pre_spatial.
    intro Hsame; subst next; lia.
  }
  assert (Hextend : forall first0 head current prev0 before next after,
    current <> 0 -> current <> next ->
    xizi_dllseg first0 head current prev0 before **
    (xizi_dll_links current next prev0 **
     xizi_dll_links next after current) |--
    xizi_dllseg first0 head next current (before ++ (current :: nil))%list **
    xizi_dll_links next after current).
  {
    intros first0 head current prev0 before.
    induction before as [|a rest IH] in first0, head |- *;
      intros next after Hnull Hneq.
    - unfold xizi_dllseg, XiziDLL.dllseg; simpl.
      Intros.
      destruct H as [Hfirst Hprev].
      subst first0; subst head.
      Exists next.
      entailer!.
    - unfold xizi_dllseg, XiziDLL.dllseg at 1.
      simpl.
      Intros nxt.
      Intros.
      subst first0.
      fold (xizi_dllseg nxt a current prev0 rest).
      fold (xizi_dll_links a nxt head).
      prop_apply_p (Hlinks_distinct a nxt head next after current).
      Intros_p Hane.
      unfold xizi_dllseg, XiziDLL.dllseg at 1.
      simpl.
      Exists nxt.
      split_pure_spatial.
      + cancel (xizi_dll_links a nxt head).
        unfold xizi_dllseg, XiziDLL.dllseg in IH.
        transitivity
          (xizi_dllseg nxt a current prev0 rest **
           (xizi_dll_links current next prev0 **
            xizi_dll_links next after current)).
        * entailer!.
        * exact (IH nxt a next after Hnull Hneq).
      + entailer!.
  }
  unfold xizi_double_link_len_return_wit_1.
  left.
  intros.
  subst next.
  destruct todo as [|a rest].
  - unfold xizi_dllseg, XiziDLL.dllseg at 2; simpl.
    Intros.
    destruct H as [_ Hlast].
    subst last.
    subst nodes; subst done.
    rewrite app_nil_r in *.
    split_pure_spatial.
    + transitivity
        (xizi_dllseg first linklist_pre tmp_node prev before **
          (xizi_dll_links tmp_node linklist_pre prev **
           xizi_dll_links linklist_pre first tmp_node)).
      * unfold xizi_dll_links, XiziDLL.links.
        entailer!.
      * transitivity
          (xizi_dllseg first linklist_pre linklist_pre tmp_node
             (before ++ (tmp_node :: nil))%list **
           xizi_dll_links linklist_pre first tmp_node).
        -- exact (Hextend first linklist_pre tmp_node prev before
             linklist_pre first PreH8 PreH9).
        -- transitivity
             (xizi_dll_links linklist_pre first tmp_node **
               xizi_dllseg first linklist_pre linklist_pre tmp_node
                 (before ++ (tmp_node :: nil))%list).
           ++ entailer!.
           ++ apply xizi_dll_close.
    + unfold xizi_double_link_size in *.
      entailer!.
  - unfold xizi_dllseg, XiziDLL.dllseg at 2; simpl.
    Intros nxt.
    Intros.
    entailer!.
Qed.

Lemma proof_of_xizi_double_link_len_return_wit_2 : xizi_double_link_len_return_wit_2.
Proof.
  unfold xizi_double_link_len_return_wit_2.
  left.
  intros.
  subst first; subst tmp_node; subst done.
  destruct todo as [|a rest].
  - unfold xizi_dllseg, XiziDLL.dllseg; simpl.
    Intros.
    destruct H as [_ Hlast].
    subst last.
    subst nodes.
    split_pure_spatial.
    + unfold xizi_dll_links, XiziDLL.links.
      entailer!.
      apply xizi_dll_empty_rev.
    + unfold xizi_double_link_size in *.
      simpl in *.
      subst linklist_length; simpl.
      entailer!.
  - unfold xizi_dllseg, XiziDLL.dllseg; simpl.
    Intros nxt.
    Intros.
    entailer!.
Qed.
