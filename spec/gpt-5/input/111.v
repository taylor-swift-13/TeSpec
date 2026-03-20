Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Lists.List.
Require Import Coq.Init.Datatypes.
Require Import Coq.Init.Nat.
Require Import Coq.Arith.PeanoNat.

Definition space_char : ascii := Ascii.ascii_of_nat 32.

Fixpoint nospace (s : string) : Prop :=
  match s with
  | EmptyString => True
  | String a s' => a <> space_char /\ nospace s'
  end.

Fixpoint join_space (l : list string) : string :=
  match l with
  | nil => EmptyString
  | x :: nil => x
  | x :: xs => String.append x (String.append (String space_char EmptyString) (join_space xs))
  end.

Fixpoint occ (x : string) (l : list string) : nat :=
  match l with
  | nil => 0
  | y :: ys => if string_dec y x then S (occ x ys) else occ x ys
  end.

Definition histogram_spec (test : string) (ans : list (string * nat)) : Prop :=
  (test = EmptyString /\ ans = nil) \/
  (test <> EmptyString /\
   exists tokens : list string,
     Forall nospace tokens /\
     test = join_space tokens /\
     exists m : nat,
       exists s0 : string,
         s0 <> EmptyString /\ In s0 tokens /\ m = occ s0 tokens /\
         (forall s : string, s <> EmptyString /\ In s tokens -> occ s tokens <= m) /\
         NoDup (map (@fst string nat) ans) /\
         (forall s n, In (s, n) ans -> n = m /\ s <> EmptyString /\ occ s tokens = m) /\
         (forall s : string, s <> EmptyString /\ occ s tokens = m -> In (s, m) ans)).