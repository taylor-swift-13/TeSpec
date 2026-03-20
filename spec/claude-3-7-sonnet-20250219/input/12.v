
Require Import Coq.Strings.String.
Require Import Coq.Lists.List.
Import ListNotations.

Definition longest_spec (strings : list string) (result : option string) : Prop :=
  match strings, result with
  | [], None => True
  | _, Some s =>
      In s strings /\
      (forall s', In s' strings -> String.length s' <= String.length s) /\
      (forall prefix, In prefix strings -> String.length prefix = String.length s -> s = prefix \/ 
        (exists after prefix', strings = prefix :: after /\ prefix' = s /\ In prefix after -> False))
  | _, None => strings = [] (* only None if input empty *)
  end.
