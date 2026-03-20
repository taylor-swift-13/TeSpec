
Require Import Coq.Lists.List.
Require Import Coq.Reals.Reals.
Import ListNotations.
Open Scope R_scope.

Definition rescale_to_unit_spec (numbers : list R) (result : list R) : Prop :=
  exists (mi ma : R),
    (In mi numbers /\ forall x, In x numbers -> mi <= x) /\
    (In ma numbers /\ forall x, In x numbers -> x <= ma) /\
    ma <> mi /\
    result = map (fun x => (x - mi) * (1 / (ma - mi))) numbers.
