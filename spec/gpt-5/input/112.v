Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.

Fixpoint rev_string_acc (s acc : string) : string :=
  match s with
  | String.EmptyString => acc
  | String.String ch rest => rev_string_acc rest (String.String ch acc)
  end.

Definition rev_string (s : string) : string :=
  rev_string_acc s String.EmptyString.

Inductive CharIn : ascii -> string -> Prop :=
| CharIn_here : forall ch rest, CharIn ch (String.String ch rest)
| CharIn_there : forall ch ch' rest, CharIn ch rest -> CharIn ch (String.String ch' rest).

Inductive Filtered : string -> string -> string -> Prop :=
| Filtered_nil : forall c, Filtered String.EmptyString c String.EmptyString
| Filtered_skip : forall ch s c ss, CharIn ch c -> Filtered s c ss -> Filtered (String.String ch s) c ss
| Filtered_keep : forall ch s c ss, ~ CharIn ch c -> Filtered s c ss -> Filtered (String.String ch s) c (String.String ch ss).

Definition reverse_delete_spec (s c : string) (out : string * bool) : Prop :=
  exists ss b,
    Filtered s c ss /\
    ((b = true /\ ss = rev_string ss) \/ (b = false /\ ss <> rev_string ss)) /\
    out = (ss, b).