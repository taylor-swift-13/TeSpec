
Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Lists.List.
Require Import Coq.Arith.Arith.
Require Import Coq.Bool.Bool.
Import ListNotations.

(* Helper to convert string to list of ascii characters *)
Fixpoint string_to_list (s : string) : list ascii :=
  match s with
  | EmptyString => []
  | String c s' => c :: string_to_list s'
  end.

(* Definitions for bracket characters *)
Definition LBracket : ascii := ascii_of_nat 91. (* '[' *)
Definition RBracket : ascii := ascii_of_nat 93. (* ']' *)

(* Inductive predicate defining a balanced bracket sequence and its nesting depth *)
Inductive balanced_depth : list ascii -> nat -> Prop :=
| bal_empty : balanced_depth [] 0
| bal_concat : forall s1 s2 d1 d2,
    balanced_depth s1 d1 -> 
    balanced_depth s2 d2 ->
    balanced_depth (s1 ++ s2) (max d1 d2)
| bal_nest : forall s d,
    balanced_depth s d ->
    balanced_depth (LBracket :: s ++ [RBracket]) (S d).

(* Definition of a contiguous substring *)
Definition is_substring (sub s : list ascii) : Prop :=
  exists prefix suffix, s = prefix ++ sub ++ suffix.

(* The main specification for the is_nested function *)
Definition is_nested_spec (string : string) (result : bool) : Prop :=
  let chars := string_to_list string in
  result = true <-> 
  (exists sub d, is_substring sub chars /\ balanced_depth sub d /\ d >= 2).
