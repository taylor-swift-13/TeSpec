
Require Import List.
Require Import ZArith.
Require Import Sorting.

Definition common_spec (l1 : list Z) (l2 : list Z) (result : list Z) : Prop :=
  exists common_set : list Z,
    NoDup common_set /\
    (forall x : Z, In x common_set <-> (In x l1 /\ In x l2)) /\
    StronglySorted Z.lt common_set /\
    result = common_set.
