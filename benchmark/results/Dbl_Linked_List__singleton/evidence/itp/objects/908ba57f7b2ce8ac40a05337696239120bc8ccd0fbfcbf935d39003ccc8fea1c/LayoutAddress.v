From Coq Require Import ZArith String List Lia.
From SimpleC.SL Require Import CNotation.
Local Open Scope Z_scope.

Inductive layout_type :=
| Lprimitive (bytes : Z)
| Laggregate (id : nat)
| Larray (element : layout_type) (length : Z)
| Lpointer.
Record field_record := { fl_offset : Z; fl_type : layout_type }.
Record layout_env := {
  lookup_type : front_end_type -> option layout_type;
  lookup_size : nat -> option Z;
  lookup_field : nat -> string -> option field_record;
  pointer_bytes : Z
}.
Definition positive_size (n : Z) : option Z := if 0 <? n then Some n else None.
Fixpoint size_type (env : layout_env) (t : layout_type) : option Z :=
  match t with
  | Lprimitive n => positive_size n
  | Laggregate id => match lookup_size env id with
      | Some n => positive_size n | None => None end
  | Larray e n => match size_type env e with
      | Some s => if 0 <? n then Some (s * n) else None | None => None end
  | Lpointer => positive_size (pointer_bytes env)
  end.
Definition address_value := (Z * layout_type)%type.
Definition field_step (env : layout_env) (v : address_value) (name : string)
  : option address_value :=
  match snd v with
  | Laggregate id => match lookup_field env id name with
      | Some f => Some (fst v + fl_offset f, fl_type f) | None => None end
  | _ => None
  end.
Definition pointer_step (env : layout_env) (v : address_value) (index : Z)
  : option address_value :=
  match size_type env (snd v) with
  | Some s => Some (fst v + index * s, snd v) | None => None end.
Definition array_step (env : layout_env) (v : address_value) (index : Z)
  : option address_value :=
  match snd v with
  | Larray e _ => match size_type env e with
      | Some s => Some (fst v + index * s, e) | None => None end
  | _ => None
  end.
Fixpoint eval_r (env : layout_env) (r : rvalue_expr) : option address_value :=
  match r with
  | RE_const p t => match lookup_type env t with
      | Some t' => Some (p,t') | None => None end
  | RE_add_pi p i => match eval_r env p with
      | Some v => pointer_step env v i | None => None end
  | RE_sub_pi p i => match eval_r env p with
      | Some v => pointer_step env v (-i) | None => None end
  | RE_addr_of l => eval_l env l
  end
with eval_l (env : layout_env) (l : lvalue_expr) : option address_value :=
  match l with
  | LE_var _ => None
  | LE_arrow_field r name => match eval_r env r with
      | Some v => field_step env v name | None => None end
  | LE_dot_field l name => match eval_l env l with
      | Some v => field_step env v name | None => None end
  | LE_array_subst l i => match eval_l env l with
      | Some v => array_step env v i | None => None end
  end.

Lemma size_type_positive : forall env t n,
  size_type env t = Some n -> 0 < n.
Proof.
  intros env t. induction t; simpl; intros n H;
  unfold positive_size in *.
  - destruct (0 <? bytes) eqn:E; inversion H; subst. now apply Z.ltb_lt.
  - destruct (lookup_size env id) as [s|]; try discriminate.
    destruct (0 <? s) eqn:E; inversion H; subst. now apply Z.ltb_lt.
  - destruct (size_type env t) as [s|] eqn:E; try discriminate.
    destruct (0 <? length) eqn:F; inversion H; subst.
    specialize (IHt s eq_refl). apply Z.ltb_lt in F. nia.
  - destruct (0 <? pointer_bytes env) eqn:E; inversion H; subst. now apply Z.ltb_lt.
Qed.

Lemma eval_arrow_field : forall env r base id name f,
  eval_r env r = Some (base,Laggregate id) ->
  lookup_field env id name = Some f ->
  eval_l env (LE_arrow_field r name) = Some (base + fl_offset f,fl_type f).
Proof. intros. cbn. rewrite H. cbn. rewrite H0. reflexivity. Qed.
Lemma eval_dot_field : forall env l base id name f,
  eval_l env l = Some (base,Laggregate id) ->
  lookup_field env id name = Some f ->
  eval_l env (LE_dot_field l name) = Some (base + fl_offset f,fl_type f).
Proof. intros. cbn. rewrite H. cbn. rewrite H0. reflexivity. Qed.
Lemma eval_nested_field : forall env r base id outer_name outer inner_id inner_name inner,
  eval_r env r = Some (base,Laggregate id) ->
  lookup_field env id outer_name = Some outer -> fl_type outer = Laggregate inner_id ->
  lookup_field env inner_id inner_name = Some inner ->
  eval_l env (LE_dot_field (LE_arrow_field r outer_name) inner_name) =
    Some (base + fl_offset outer + fl_offset inner,fl_type inner).
Proof.
  intros. cbn. rewrite H. cbn. rewrite H0. cbn. rewrite H1. cbn. rewrite H2. reflexivity.
Qed.
Lemma eval_array_index : forall env l base e length i s,
  eval_l env l = Some (base,Larray e length) -> size_type env e = Some s ->
  eval_l env (LE_array_subst l i) = Some (base + i*s,e).
Proof. intros. cbn. rewrite H. cbn. rewrite H0. reflexivity. Qed.
Lemma eval_pointer_add : forall env r base t i s,
  eval_r env r = Some (base,t) -> size_type env t = Some s ->
  eval_r env (RE_add_pi r i) = Some (base + i*s,t).
Proof. intros. cbn. rewrite H. unfold pointer_step. cbn. rewrite H0. reflexivity. Qed.
Lemma eval_pointer_sub : forall env r base t i s,
  eval_r env r = Some (base,t) -> size_type env t = Some s ->
  eval_r env (RE_sub_pi r i) = Some (base - i*s,t).
Proof. intros. cbn. rewrite H. unfold pointer_step. cbn. rewrite H0. f_equal. f_equal. ring. Qed.

(* Relational semantics over the supplied layout environment. There is no
   evaluator premise in these rules: subexpressions are related recursively. *)
Inductive denotes_r (env : layout_env) : rvalue_expr -> address_value -> Prop :=
| DR_const : forall p t u, lookup_type env t = Some u ->
    denotes_r env (RE_const p t) (p,u)
| DR_add : forall r i v w, denotes_r env r v -> pointer_step env v i = Some w ->
    denotes_r env (RE_add_pi r i) w
| DR_sub : forall r i v w, denotes_r env r v -> pointer_step env v (-i) = Some w ->
    denotes_r env (RE_sub_pi r i) w
| DR_addr : forall l v, denotes_l env l v -> denotes_r env (RE_addr_of l) v
with denotes_l (env : layout_env) : lvalue_expr -> address_value -> Prop :=
| DL_arrow : forall r name v w, denotes_r env r v -> field_step env v name = Some w ->
    denotes_l env (LE_arrow_field r name) w
| DL_dot : forall l name v w, denotes_l env l v -> field_step env v name = Some w ->
    denotes_l env (LE_dot_field l name) w
| DL_array : forall l i v w, denotes_l env l v -> array_step env v i = Some w ->
    denotes_l env (LE_array_subst l i) w.

Theorem eval_r_sound : forall env r v, eval_r env r = Some v -> denotes_r env r v
with eval_l_sound : forall env l v, eval_l env l = Some v -> denotes_l env l v.
Proof.
  - intros env r. destruct r; intros v H; cbn in H.
    + destruct (lookup_type env t) eqn:E; inversion H; subst. constructor. exact E.
    + destruct (eval_r env r) eqn:E; try discriminate. eapply DR_add; eauto.
    + destruct (eval_r env r) eqn:E; try discriminate. eapply DR_sub; eauto.
    + apply DR_addr. eapply eval_l_sound; eauto.
  - intros env l. destruct l; intros v H; cbn in H; try discriminate.
    + destruct (eval_r env p) eqn:E; try discriminate. eapply DL_arrow; eauto.
    + destruct (eval_l env l) eqn:E; try discriminate. eapply DL_array; eauto.
    + destruct (eval_l env l) eqn:E; try discriminate. eapply DL_dot; eauto.
Qed.
Print Assumptions size_type_positive.
Print Assumptions eval_arrow_field.
Print Assumptions eval_dot_field.
Print Assumptions eval_nested_field.
Print Assumptions eval_array_index.
Print Assumptions eval_pointer_add.
Print Assumptions eval_pointer_sub.
Print Assumptions eval_r_sound.
Print Assumptions eval_l_sound.
