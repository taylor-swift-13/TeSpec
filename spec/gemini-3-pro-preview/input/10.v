
Require Import Coq.Lists.List.
Import ListNotations.

Section PalindromeSpec.
  Variable A : Type.

  Definition is_palindrome (l : list A) : Prop :=
    l = rev l.

  Definition make_palindrome_spec (s : list A) (res : list A) : Prop :=
    exists (p q : list A),
      s = p ++ q /\
      is_palindrome q /\
      res = s ++ rev p /\
      (forall (p' q' : list A),
         s = p' ++ q' -> is_palindrome q' -> length p <= length p').

End PalindromeSpec.
