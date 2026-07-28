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
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_insert_after Require Import xizi_double_link_insert_after_goal.
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_insert_after Require Import xizi_double_link_insert_after_proof_auto.
Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
From QCIPLib.xizi.xizi_double_link_common Require Import xizi_double_link_lib.
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_insert_after Require Import xizi_double_link_insert_after_lib.
Local Open Scope sac.

Lemma proof_of_xizi_double_link_insert_after_entail_wit_1 : xizi_double_link_insert_after_entail_wit_1.
Proof.
  pre_process.
  assert (Hlinksneq : forall a an ap b bn bp,
    xizi_dll_links a an ap ** xizi_dll_links b bn bp |-- “ a <> b ”).
  {
    intros.
    destruct (Z.eq_dec a b) as [Heq | Hneq].
    - subst b.
      unfold xizi_dll_links, XiziDLL.links.
      transitivity (
        (((&(a # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr |-> an) **
         ((&(a # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr |-> bn)) **
        (((&(a # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr |-> ap) **
         ((&(a # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr |-> bp))).
      + entailer!.
      + sep_apply_l_atomic
          (dup_store_ptr (&(a # "SysDoubleLinklistNode" ->ₛ "node_next")) an bn).
        entailer!.
    - entailer!.
  }
  assert (Hsplit : forall prefix first prev anchor stop last suffix,
    xizi_dllseg first prev stop last (prefix ++ anchor :: suffix) |--
    EX anchor_prev anchor_next,
      xizi_dllseg first prev anchor anchor_prev prefix **
      xizi_dll_links anchor anchor_next anchor_prev **
      xizi_dllseg anchor_next anchor stop last suffix).
  {
    induction prefix as [| p prefix IH]; intros.
    - unfold xizi_dllseg, XiziDLL.dllseg; simpl.
      Intros next.
      Intros.
      subst first.
      Exists prev next.
      entailer!.
    - unfold xizi_dllseg, XiziDLL.dllseg; simpl.
      Intros next.
      Intros.
      subst first.
      fold XiziDLL.dllseg.
      fold xizi_dllseg.
      sep_apply_l_atomic (IH next p anchor stop last suffix).
      Intros anchor_prev anchor_next.
      fold xizi_dll_links.
      prop_apply_p (Hlinksneq p next prev anchor anchor_next anchor_prev).
      Intros_p Hpanchor.
      Exists anchor_prev anchor_next.
      Exists next.
      entailer!.
  }
  sep_apply_l_atomic (xizi_dll_open head (nodes_before ++ linklist_pre :: nodes_after)).
  Intros first last.
  sep_apply_l_atomic
    (Hsplit nodes_before first head linklist_pre head last nodes_after).
  Intros old_prev old_next.
  destruct nodes_after as [| next_node rest].
  - unfold xizi_dllseg, XiziDLL.dllseg; simpl.
    Intros.
    destruct H as [Hnext Hlast].
    subst old_next; subst last.
    Left.
    Exists old_prev first.
    unfold xizi_dll_links, XiziDLL.links.
    entailer!.
  - unfold xizi_dllseg, XiziDLL.dllseg; simpl.
    Intros next_next.
    Intros.
    subst old_next.
    Right.
    Exists next_next old_prev last first next_node rest.
    unfold xizi_dll_links, XiziDLL.links.
    entailer!.
Qed.

Lemma proof_of_xizi_double_link_insert_after_return_wit_1 : xizi_double_link_insert_after_return_wit_1.
Proof.
  pre_process.
  assert (Hlinksneq : forall a an ap b bn bp,
    xizi_dll_links a an ap ** xizi_dll_links b bn bp |-- “ a <> b ”).
  {
    intros.
    destruct (Z.eq_dec a b) as [Heq | Hneq].
    - subst b.
      unfold xizi_dll_links, XiziDLL.links.
      transitivity (
        (((&(a # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr |-> an) **
         ((&(a # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr |-> bn)) **
        (((&(a # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr |-> ap) **
         ((&(a # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr |-> bp))).
      + entailer!.
      + sep_apply_l_atomic
          (dup_store_ptr (&(a # "SysDoubleLinklistNode" ->ₛ "node_next")) an bn).
        entailer!.
    - entailer!.
  }
  assert (Hheadneq3 : forall h hf hl a an ap i inext ip o onext op,
    xizi_dll_links h hf hl ** xizi_dll_links a an ap **
    xizi_dll_links i inext ip ** xizi_dll_links o onext op |--
    “ a <> h /\ i <> h /\ o <> h ”).
  {
    intros.
    destruct (Z.eq_dec a h) as [Ha | Ha].
    - subst a.
      sep_apply_l_atomic (Hlinksneq h hf hl h an ap).
      entailer!.
    - destruct (Z.eq_dec i h) as [Hi | Hi].
      + subst i.
        transitivity (
          xizi_dll_links h hf hl ** xizi_dll_links h inext ip **
          (xizi_dll_links a an ap ** xizi_dll_links o onext op)).
        * entailer!.
        * sep_apply_l_atomic (Hlinksneq h hf hl h inext ip).
          entailer!.
      + destruct (Z.eq_dec o h) as [Ho | Ho].
        * subst o.
          transitivity (
            xizi_dll_links h hf hl ** xizi_dll_links h onext op **
            (xizi_dll_links a an ap ** xizi_dll_links i inext ip)).
          -- entailer!.
          -- sep_apply_l_atomic (Hlinksneq h hf hl h onext op).
             entailer!.
        * entailer!.
  }
  assert (Hinsert : forall prefix head0 sentinelfirst first0 prev0 last0 anchor oldprev inserted
      oldnext nextnext rest0,
    anchor <> NULL -> inserted <> NULL -> oldnext <> NULL ->
    xizi_dll_links head0 sentinelfirst last0 **
    xizi_dllseg first0 prev0 anchor oldprev prefix **
    xizi_dll_links anchor inserted oldprev **
    xizi_dll_links inserted oldnext anchor **
    xizi_dll_links oldnext nextnext inserted **
    xizi_dllseg nextnext oldnext head0 last0 rest0 |--
    xizi_dll_links head0 sentinelfirst last0 **
    xizi_dllseg first0 prev0 head0 last0
      (prefix ++ anchor :: inserted :: oldnext :: rest0)).
  {
    induction prefix as [| p prefix IH]; intros.
    - prop_apply_p
        (Hheadneq3 head0 sentinelfirst last0 anchor inserted oldprev
          inserted oldnext anchor oldnext nextnext inserted).
      Intros_p Hheadneq.
      destruct Hheadneq as [Hanchorhead [Hinserthead Holdnexthead]].
      unfold xizi_dllseg, XiziDLL.dllseg; simpl.
      Intros.
      destruct H2 as [Hfirst Hprev].
      subst first0; subst oldprev.
      Exists inserted oldnext nextnext.
      unfold xizi_dll_links.
      entailer!.
    - unfold xizi_dllseg, XiziDLL.dllseg; simpl.
      Intros next.
      Intros.
      subst first0.
      fold XiziDLL.links; fold xizi_dll_links.
      prop_apply_p (Hlinksneq head0 sentinelfirst last0 p next prev0).
      Intros_p Hphead.
      Exists next.
      fold XiziDLL.dllseg; fold xizi_dllseg.
      transitivity (
        (xizi_dll_links head0 sentinelfirst last0 **
         xizi_dllseg next p anchor oldprev prefix **
         xizi_dll_links anchor inserted oldprev **
         xizi_dll_links inserted oldnext anchor **
         xizi_dll_links oldnext nextnext inserted **
         xizi_dllseg nextnext oldnext head0 last0 rest0) **
        xizi_dll_links p next prev0).
      + entailer!.
      + sep_apply_l_atomic
          (IH head0 sentinelfirst next p last0 anchor oldprev inserted oldnext nextnext rest0
            H H0 H1).
        entailer!.
  }
  subst nodes_after.
  unfold xizi_double_link_insert_after_nodes.
  transitivity (
    xizi_dll_links head first last **
    xizi_dllseg first head linklist_pre old_prev nodes_before **
    xizi_dll_links linklist_pre linklist_node_pre old_prev **
    xizi_dll_links linklist_node_pre old_next linklist_pre **
    xizi_dll_links old_next next_next linklist_node_pre **
    xizi_dllseg next_next old_next head last rest).
  - unfold xizi_dll_links, XiziDLL.links; entailer!.
  - sep_apply_l_atomic
      (Hinsert nodes_before head first first head last linklist_pre old_prev
        linklist_node_pre old_next next_next rest PreH2 PreH3 PreH4).
    sep_apply_r_atomic
      (xizi_dll_close head first last
        (nodes_before ++ linklist_pre :: linklist_node_pre :: old_next :: rest)).
    entailer!.
Qed.

Lemma proof_of_xizi_double_link_insert_after_return_wit_2 : xizi_double_link_insert_after_return_wit_2.
Proof.
  pre_process.
  assert (Hlinksneq : forall a an ap b bn bp,
    xizi_dll_links a an ap ** xizi_dll_links b bn bp |-- “ a <> b ”).
  {
    intros.
    destruct (Z.eq_dec a b) as [Heq | Hneq].
    - subst b.
      unfold xizi_dll_links, XiziDLL.links.
      transitivity (
        (((&(a # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr |-> an) **
         ((&(a # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr |-> bn)) **
        (((&(a # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr |-> ap) **
         ((&(a # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr |-> bp))).
      + entailer!.
      + sep_apply_l_atomic
          (dup_store_ptr (&(a # "SysDoubleLinklistNode" ->ₛ "node_next")) an bn).
        entailer!.
    - entailer!.
  }
  assert (Hheadneq2 : forall h hf hl a an ap i inext ip,
    xizi_dll_links h hf hl ** xizi_dll_links a an ap **
    xizi_dll_links i inext ip |-- “ a <> h /\ i <> h ”).
  {
    intros.
    destruct (Z.eq_dec a h) as [Ha | Ha].
    - subst a.
      sep_apply_l_atomic (Hlinksneq h hf hl h an ap).
      entailer!.
    - destruct (Z.eq_dec i h) as [Hi | Hi].
      + subst i.
        transitivity (
          xizi_dll_links h hf hl ** xizi_dll_links h inext ip **
          xizi_dll_links a an ap).
        * entailer!.
        * sep_apply_l_atomic (Hlinksneq h hf hl h inext ip).
          entailer!.
      + entailer!.
  }
  assert (Hinsert : forall prefix head0 sentinelfirst first0 prev0 anchor
      oldprev inserted,
    anchor <> NULL -> inserted <> NULL ->
    xizi_dll_links head0 sentinelfirst inserted **
    xizi_dllseg first0 prev0 anchor oldprev prefix **
    xizi_dll_links anchor inserted oldprev **
    xizi_dll_links inserted head0 anchor |--
    xizi_dll_links head0 sentinelfirst inserted **
    xizi_dllseg first0 prev0 head0 inserted
      (prefix ++ anchor :: inserted :: nil)).
  {
    induction prefix as [| p prefix IH]; intros.
    - prop_apply_p
        (Hheadneq2 head0 sentinelfirst inserted anchor inserted oldprev
          inserted head0 anchor).
      Intros_p Hheadneq.
      destruct Hheadneq as [Hanchorhead Hinserthead].
      unfold xizi_dllseg, XiziDLL.dllseg; simpl.
      Intros.
      destruct H1 as [Hfirst Hprev].
      subst first0; subst oldprev.
      Exists inserted head0.
      unfold xizi_dll_links.
      entailer!.
    - unfold xizi_dllseg, XiziDLL.dllseg; simpl.
      Intros next.
      Intros.
      subst first0.
      fold XiziDLL.links; fold xizi_dll_links.
      prop_apply_p (Hlinksneq head0 sentinelfirst inserted p next prev0).
      Intros_p Hphead.
      Exists next.
      fold XiziDLL.dllseg; fold xizi_dllseg.
      transitivity (
        (xizi_dll_links head0 sentinelfirst inserted **
         xizi_dllseg next p anchor oldprev prefix **
         xizi_dll_links anchor inserted oldprev **
         xizi_dll_links inserted head0 anchor) **
        xizi_dll_links p next prev0).
      + entailer!.
      + sep_apply_l_atomic
          (IH head0 sentinelfirst next p anchor oldprev inserted H H0).
        entailer!.
  }
  subst nodes_after.
  unfold xizi_double_link_insert_after_nodes.
  transitivity (
    xizi_dll_links head first linklist_node_pre **
    xizi_dllseg first head linklist_pre old_prev nodes_before **
    xizi_dll_links linklist_pre linklist_node_pre old_prev **
    xizi_dll_links linklist_node_pre head linklist_pre).
  - unfold xizi_dll_links, XiziDLL.links; entailer!.
  - sep_apply_l_atomic
      (Hinsert nodes_before head first first head linklist_pre old_prev
        linklist_node_pre PreH2 PreH3).
    sep_apply_r_atomic
      (xizi_dll_close head first linklist_node_pre
        (nodes_before ++ linklist_pre :: linklist_node_pre :: nil)).
    entailer!.
Qed.
