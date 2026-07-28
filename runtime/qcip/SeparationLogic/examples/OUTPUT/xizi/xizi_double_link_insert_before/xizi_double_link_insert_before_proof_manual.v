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
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_insert_before Require Import xizi_double_link_insert_before_goal.
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_insert_before Require Import xizi_double_link_insert_before_proof_auto.
Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
From QCIPLib.xizi.xizi_double_link_common Require Import xizi_double_link_lib.
Local Open Scope sac.

Lemma proof_of_xizi_double_link_insert_before_entail_wit_1 : xizi_double_link_insert_before_entail_wit_1.
Proof.
  assert (Hlinks_neq__dll_insert_before_split_splice : forall a an ap b bn bp,
    XiziDLL.links a an ap ** XiziDLL.links b bn bp |-- “ a <> b ”).
  { intros. destruct (Z.eq_dec a b) as [Heq | Hneq].
    - subst a.
      assert (Hswap__dll_insert_before_split_splice :
        XiziDLL.links b an ap |--
        (&(b # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> ap) **
        (&(b # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> an)).
      { unfold XiziDLL.links. entailer!. }
      sep_apply Hswap__dll_insert_before_split_splice.
      unfold XiziDLL.links.
      sep_apply (dup_store_ptr
        (&(b # "SysDoubleLinklistNode" ->ₛ "node_next")) an bn).
      entailer!.
    - entailer!. }
  assert (Hfocus__dll_insert_before_split_splice :
    forall stop stop_next stop_prev node previous last prefix prev target suffix,
      XiziDLL.links stop stop_next stop_prev **
      XiziDLL.dllseg node previous stop last (prefix ++ prev :: target :: suffix) |--
      EX before next,
        “ prev <> NULL ” && “ prev <> stop ” && “ target <> stop ” &&
        XiziDLL.links stop stop_next stop_prev **
        XiziDLL.dllseg node previous prev before prefix **
        XiziDLL.links prev target before **
        XiziDLL.links target next prev **
        XiziDLL.dllseg next target stop last suffix).
  { intros stop stop_next stop_prev node previous last prefix.
    revert node previous.
    induction prefix as [| expected prefix IH];
      intros node previous prev target suffix.
    - simpl. unfold XiziDLL.dllseg at 1. simpl.
      Intros after_prev. Intros.
      unfold XiziDLL.dllseg at 1. simpl.
      Intros next. Intros.
      subst node. subst after_prev.
      Exists previous next. simpl. entailer!.
    - simpl. unfold XiziDLL.dllseg at 1. simpl.
      Intros next_first. Intros.
      fold (XiziDLL.dllseg next_first node stop last
        (prefix ++ prev :: target :: suffix)).
      sep_apply (IH next_first node prev target suffix).
      Intros before next.
      prop_apply_p (Hlinks_neq__dll_insert_before_split_splice
        node next_first previous prev target before).
      Intros_p Hnodeprev.
      Exists before next.
      unfold XiziDLL.dllseg at 1. simpl. Exists next_first. entailer!. }
  assert (Hfresh_two__dll_insert_before_split_splice :
    forall fresh a an ap b bn bp,
      (&(fresh # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |->_) **
      (&(fresh # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |->_) **
      XiziDLL.links a an ap ** XiziDLL.links b bn bp
      |-- “ fresh <> a /\ fresh <> b ”).
  { intros. destruct (Z.eq_dec fresh a) as [Heq | Hneqa].
    - subst fresh.
      assert (Hswap_undef__dll_insert_before_split_splice :
        (&(a # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |->_) **
        (&(a # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |->_) |--
        (&(a # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |->_) **
        (&(a # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |->_)).
      { entailer!. }
      assert (Hopen_link__dll_insert_before_split_splice :
        XiziDLL.links a an ap |--
        (&(a # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> an) **
        (&(a # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> ap)).
      { unfold XiziDLL.links. entailer!. }
      sep_apply Hswap_undef__dll_insert_before_split_splice.
      sep_apply Hopen_link__dll_insert_before_split_splice.
      sep_apply (store_ptr_undef_store_ptr
        (&(a # "SysDoubleLinklistNode" ->ₛ "node_next")) an).
      sep_apply (dup_undef_store_ptr
        (&(a # "SysDoubleLinklistNode" ->ₛ "node_next"))).
      entailer!.
    - destruct (Z.eq_dec fresh b) as [Heq | Hneqb].
      + subst fresh.
        assert (Hswap_undef__dll_insert_before_split_splice :
          (&(b # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |->_) **
          (&(b # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |->_) |--
          (&(b # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |->_) **
          (&(b # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |->_)).
        { entailer!. }
        assert (Hopen_link__dll_insert_before_split_splice :
          XiziDLL.links b bn bp |--
          (&(b # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> bn) **
          (&(b # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> bp)).
        { unfold XiziDLL.links. entailer!. }
        sep_apply Hswap_undef__dll_insert_before_split_splice.
        sep_apply Hopen_link__dll_insert_before_split_splice.
        sep_apply (store_ptr_undef_store_ptr
          (&(b # "SysDoubleLinklistNode" ->ₛ "node_next")) bn).
        sep_apply (dup_undef_store_ptr
          (&(b # "SysDoubleLinklistNode" ->ₛ "node_next"))).
        entailer!.
      + entailer!. }
  assert (Hfresh_one__dll_insert_before_split_splice : forall fresh a an ap,
    (&(fresh # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |->_) **
    (&(fresh # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |->_) **
    XiziDLL.links a an ap |-- “ fresh <> a ”).
  { intros. destruct (Z.eq_dec fresh a) as [Heq | Hneq].
    - subst fresh.
      assert (Hswap_undef__dll_insert_before_split_splice :
        (&(a # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |->_) **
        (&(a # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |->_) |--
        (&(a # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |->_) **
        (&(a # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |->_)).
      { entailer!. }
      assert (Hopen_link__dll_insert_before_split_splice :
        XiziDLL.links a an ap |--
        (&(a # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> an) **
        (&(a # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> ap)).
      { unfold XiziDLL.links. entailer!. }
      sep_apply Hswap_undef__dll_insert_before_split_splice.
      sep_apply Hopen_link__dll_insert_before_split_splice.
      sep_apply (store_ptr_undef_store_ptr
        (&(a # "SysDoubleLinklistNode" ->ₛ "node_next")) an).
      sep_apply (dup_undef_store_ptr
        (&(a # "SysDoubleLinklistNode" ->ₛ "node_next"))).
      entailer!.
    - entailer!. }
  assert (Hfresh_three__dll_insert_before_split_splice :
    forall fresh a an ap b bn bp c cn cp,
      (&(fresh # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |->_) **
      (&(fresh # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |->_) **
      XiziDLL.links a an ap ** XiziDLL.links b bn bp ** XiziDLL.links c cn cp
      |-- “ fresh <> a /\ fresh <> b /\ fresh <> c ”).
  { intros. destruct (Z.eq_dec fresh a) as [Heq | Hneqa].
    - subst fresh.
      prop_apply_p (Hfresh_one__dll_insert_before_split_splice a a an ap).
      Intros_p Hfalse. contradiction.
    - destruct (Z.eq_dec fresh b) as [Heq | Hneqb].
      + subst fresh.
        assert (Hrotate__dll_insert_before_split_splice :
          XiziDLL.links a an ap ** XiziDLL.links b bn bp **
          XiziDLL.links c cn cp |--
          XiziDLL.links b bn bp ** XiziDLL.links a an ap **
          XiziDLL.links c cn cp).
        { entailer!. }
        sep_apply Hrotate__dll_insert_before_split_splice.
        prop_apply_p (Hfresh_one__dll_insert_before_split_splice b b bn bp).
        Intros_p Hfalse. contradiction.
      + destruct (Z.eq_dec fresh c) as [Heq | Hneqc].
        * subst fresh.
          assert (Hrotate__dll_insert_before_split_splice :
            XiziDLL.links a an ap ** XiziDLL.links b bn bp **
            XiziDLL.links c cn cp |--
            XiziDLL.links c cn cp ** XiziDLL.links a an ap **
            XiziDLL.links b bn bp).
          { entailer!. }
          sep_apply Hrotate__dll_insert_before_split_splice.
          prop_apply_p (Hfresh_one__dll_insert_before_split_splice c c cn cp).
          Intros_p Hfalse. contradiction.
        * entailer!. }
  pre_process.
  induction prefix using List.rev_ind.
  - simpl.
    sep_apply xizi_dll_nonempty.
    Intros next last.
    prop_apply_p (Hfresh_two__dll_insert_before_split_splice linklist_node_pre
      head linklist_pre last linklist_pre next head).
    Intros_p Hfresh.
    Left. Exists last next last head.
    unfold xizi_dll_links, XiziDLL.links. entailer!.
  - simpl.
    sep_apply xizi_dll_open. Intros first last.
    replace (prefix +:: x ++ linklist_pre :: suffix)
      with (prefix ++ x :: linklist_pre :: suffix)
      by (rewrite <- List.app_assoc; reflexivity).
    unfold xizi_dll_links, xizi_dllseg.
    fold (XiziDLL.links head first last).
    fold (XiziDLL.dllseg first head head last
      (prefix ++ x :: linklist_pre :: suffix)).
    sep_apply_L
      (XiziDLL.links head first last ::
       XiziDLL.dllseg first head head last
         (prefix ++ x :: linklist_pre :: suffix) :: nil)
      (Hfocus__dll_insert_before_split_splice head first last first head last
        prefix x linklist_pre suffix).
    Intros before_prev next.
    prop_apply_p (Hfresh_three__dll_insert_before_split_splice
      linklist_node_pre head first last x linklist_pre before_prev
      linklist_pre next x).
    Intros_p Hfresh.
    Right. Exists first prefix last next before_prev x.
    unfold XiziDLL.links. entailer!.
Qed.

Lemma proof_of_xizi_double_link_insert_before_return_wit_1 : xizi_double_link_insert_before_return_wit_1.
Proof.
  assert (Hlinks_neq__dll_insert_before_split_splice : forall a an ap b bn bp,
    XiziDLL.links a an ap ** XiziDLL.links b bn bp |-- “ a <> b ”).
  { intros. destruct (Z.eq_dec a b) as [Heq | Hneq].
    - subst a.
      assert (Hswap__dll_insert_before_split_splice :
        XiziDLL.links b an ap |--
        (&(b # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> ap) **
        (&(b # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> an)).
      { unfold XiziDLL.links. entailer!. }
      sep_apply Hswap__dll_insert_before_split_splice.
      unfold XiziDLL.links.
      sep_apply (dup_store_ptr
        (&(b # "SysDoubleLinklistNode" ->ₛ "node_next")) an bn).
      entailer!.
    - entailer!. }
  assert (Happ__dll_insert_before_split_splice :
    forall stop stop_next stop_prev node prev mid before last prefix suffix,
      XiziDLL.links stop stop_next stop_prev **
      XiziDLL.dllseg node prev mid before prefix **
      XiziDLL.dllseg mid before stop last suffix |--
      XiziDLL.links stop stop_next stop_prev **
      XiziDLL.dllseg node prev stop last (prefix ++ suffix)).
  { intros stop stop_next stop_prev node prev mid before last prefix.
    revert node prev.
    induction prefix as [| expected prefix IH]; intros node prev suffix.
    - unfold XiziDLL.dllseg at 1.
      simpl. Intros. destruct H as [Hnode Hprev].
      subst node; subst prev. entailer!.
    - unfold XiziDLL.dllseg at 1.
      simpl. Intros next0. Intros.
      fold (XiziDLL.dllseg next0 node mid before prefix).
      fold (XiziDLL.dllseg mid before stop last suffix).
      sep_apply_L
        (XiziDLL.links stop stop_next stop_prev ::
         XiziDLL.dllseg next0 node mid before prefix ::
         XiziDLL.dllseg mid before stop last suffix :: nil)
        (IH next0 node suffix).
      unfold XiziDLL.dllseg at 1. simpl. Exists next0.
      prop_apply_p (Hlinks_neq__dll_insert_before_split_splice
        stop stop_next stop_prev node next0 prev).
      Intros_p Hstopnode. entailer!. }
  assert (Happ_xizi__dll_insert_before_split_splice :
    forall stop stop_next stop_prev node prev mid before last prefix suffix,
      XiziDLL.links stop stop_next stop_prev **
      xizi_dllseg node prev mid before prefix **
      XiziDLL.dllseg mid before stop last suffix |--
      XiziDLL.links stop stop_next stop_prev **
      XiziDLL.dllseg node prev stop last (prefix ++ suffix)).
  { exact Happ__dll_insert_before_split_splice. }
  assert (Htwo__dll_insert_before_split_splice :
    forall stop stop_next stop_prev prev before node target next0 last suffix,
      prev <> NULL -> node <> NULL -> target <> NULL -> target <> stop ->
      prev <> stop -> node <> stop ->
      XiziDLL.links prev node before **
      (&(target # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> next0) **
      (&(target # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> node) **
      xizi_dllseg next0 target stop last suffix **
      (&(node # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> target) **
      (&(node # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> prev) **
      (&(stop # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> stop_next) **
      (&(stop # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> stop_prev) |--
      XiziDLL.links stop stop_next stop_prev **
      XiziDLL.dllseg prev before stop last (prev :: node :: target :: suffix)).
  { intros stop stop_next stop_prev prev before node target next0 last suffix
      Hprev0 Hnode0 Htarget0 Htargetstop Hprevstop Hnodestop.
    unfold XiziDLL.dllseg at 1. simpl. Exists node.
    simpl. Exists target. Exists next0. unfold XiziDLL.links. entailer!. }
  left. intros. subst prefix.
  unfold xizi_dll. Exists first last.
  fold (XiziDLL.links prev linklist_node_pre before_prev).
  sep_apply (Htwo__dll_insert_before_split_splice head first last prev
    before_prev linklist_node_pre linklist_pre next last suffix
    PreH8 PreH4 PreH2 PreH3 PreH9 PreH5).
  sep_apply (Happ_xizi__dll_insert_before_split_splice head first last first head
    prev before_prev last prefix0
    (prev :: linklist_node_pre :: linklist_pre :: suffix)).
  rewrite <- List.app_assoc. simpl. entailer!.
Qed.

Lemma proof_of_xizi_double_link_insert_before_return_wit_2 : xizi_double_link_insert_before_return_wit_2.
Proof.
  left.
  intros.
  subst prefix prev before_prev linklist_pre.
  unfold xizi_dll.
  Exists linklist_node_pre last.
  unfold xizi_dll_links.
  unfold xizi_dllseg, XiziDLL.dllseg at 1.
  simpl. Exists first. entailer!.
  unfold xizi_dllseg, XiziDLL.dllseg at 1.
  simpl. Exists next. entailer!.
  unfold XiziDLL.links. entailer!.
Qed.
