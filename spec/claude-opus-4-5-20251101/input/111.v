
Require Import Coq.Strings.String.
Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Require Import Coq.FSets.FMapList.
Require Import Coq.Structures.OrderedTypeEx.

Import ListNotations.

Module StringMap := FMapList.Make(String_as_OT).

Definition string_map := StringMap.t Z.

Definition split_string (s : string) (sep : string) : list string := [].

Definition count_occurrences (words : list string) : string_map :=
  fold_left (fun m w =>
    match StringMap.find w m with
    | Some c => StringMap.add w (c + 1)%Z m
    | None => StringMap.add w 1%Z m
    end
  ) words (StringMap.empty Z).

Definition max_count (m : string_map) : Z :=
  StringMap.fold (fun _ v acc => Z.max v acc) m 0%Z.

Definition filter_max (m : string_map) (mx : Z) : string_map :=
  StringMap.fold (fun k v acc =>
    if (v =? mx)%Z then StringMap.add k v acc else acc
  ) m (StringMap.empty Z).

Definition maps_equal (m1 m2 : string_map) : Prop :=
  forall k, StringMap.find k m1 = StringMap.find k m2.

Definition histogram_spec (test : string) (result : string_map) : Prop :=
  (test = EmptyString -> maps_equal result (StringMap.empty Z)) /\
  (test <> EmptyString ->
    let words := filter (fun w => negb (String.eqb w EmptyString)) (split_string test " ") in
    let count := count_occurrences words in
    let mx := max_count count in
    let expected := filter_max count mx in
    maps_equal result expected /\
    (forall k v, StringMap.find k result = Some v -> v = mx) /\
    (forall k v, StringMap.find k count = Some v -> v = mx -> StringMap.find k result = Some v)).
