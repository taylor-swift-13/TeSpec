
Require Import List.
Require Import Sorting.
Require Import Permutation.
Require Import Arith.
Require Import Lia.

Import ListNotations.

Definition is_sorted (l : list nat) : Prop :=
  forall i j, i < j -> j < length l -> 
    nth i l 0 <= nth j l 0.

Definition no_duplicates (l : list nat) : Prop :=
  NoDup l.

Definition all_elements_from (result original : list nat) : Prop :=
  forall x, In x result <-> In x original.

Definition unique_spec (l : list nat) (result : list nat) : Prop :=
  is_sorted result /\
  no_duplicates result /\
  all_elements_from result l.
