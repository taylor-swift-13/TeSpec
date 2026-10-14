Require Import Coq.ZArith.ZArith Coq.Lists.List Coq.Bool.Bool.
Import ListNotations.

Fixpoint distinct_addresses (addresses : list Z) : bool :=
  match addresses with
  | [] => true
  | address :: tail =>
      negb (existsb (Z.eqb address) tail) && distinct_addresses tail
  end.

Theorem distinct_addresses_sound : forall addresses,
  distinct_addresses addresses = true -> NoDup addresses.
Proof.
  induction addresses as [|address tail IH]; intro Hcheck.
  - constructor.
  - cbn in Hcheck. apply andb_true_iff in Hcheck.
    destruct Hcheck as [Habsent Htail]. apply negb_true_iff in Habsent.
    constructor.
    + intro Hin.
      assert (Hpresent : existsb (Z.eqb address) tail = true).
      { apply existsb_exists. exists address. split; [exact Hin|apply Z.eqb_refl]. }
      rewrite Hpresent in Habsent. discriminate.
    + apply IH. exact Htail.
Qed.

Print Assumptions distinct_addresses_sound.
