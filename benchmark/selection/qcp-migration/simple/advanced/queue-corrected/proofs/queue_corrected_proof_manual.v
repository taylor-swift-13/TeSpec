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
Require Import queue_corrected_goal.

Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Local Open Scope sac.

Lemma segment_append_cell : forall f p n l x, p<>0 ->
 sllseg f p l ** &(p # "list" ->ₛ "data") # Int |-> x ** &(p # "list" ->ₛ "next") # Ptr |-> n |-- sllseg f n (app l (cons x nil)).
Proof. intros; transitivity (sllseg f p l ** sllseg p n (cons x nil)); [sep_apply (sllseg_len1 p x n H); entailer!|apply sllseg_sllseg]. Qed.
Lemma segment_unfold_nonempty : forall f b l, f<>b -> sllseg f b l |-- EX a:Z, EX tl:list Z, EX y:Z,
 “l=a::tl” && “f<>0” && &(f # "list" ->ₛ "data") # Int |-> a ** &(f # "list" ->ₛ "next") # Ptr |-> y ** sllseg y b tl.
Proof. intros; destruct l as [|a tl]; cbn [sllseg]; [entailer!|]. Intros; Intros y; Exists a tl y; entailer!. Qed.
Lemma segment_fold_cons : forall f b a tl y, f<>0 ->
 &(f # "list" ->ₛ "data") # Int |-> a ** &(f # "list" ->ₛ "next") # Ptr |-> y ** sllseg y b tl |-- sllseg f b (a::tl).
Proof. intros; cbn [sllseg]; Exists y; entailer!. Qed.
Lemma proof_of_push_induction_return_wit_1 : push_induction_return_wit_1.
Proof. unfold push_induction_return_wit_1; left; intros; subst l; cbn [app sllseg]; Exists y; entailer!. Qed.
Lemma proof_of_push_induction_return_wit_2 : push_induction_return_wit_2.
Proof. unfold push_induction_return_wit_2; left; intros; sep_apply segment_append_cell; entailer!. Qed.
