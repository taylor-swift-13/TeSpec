From Coq Require Import ZArith List Bool.
Import ListNotations.
Definition witness_heap (p:nat) : option (Z * nat) :=
 match p with 1 => Some (1%Z,2%nat) | 2 => Some (2%Z,3%nat) | 3 => Some (3%Z,2%nat) | _ => None end.
Fixpoint guarded_values (fuel f b:nat) : option (list Z) :=
 if Nat.eqb f b then Some [] else
 match fuel with
 | 0 => None
 | S k => match witness_heap f with
   | None => None
   | Some (v,nxt) => if Nat.eqb nxt 0 then None else
     match guarded_values k nxt b with None => None | Some tl => Some (v::tl) end
   end
 end.
Lemma owned_nodes_distinct : NoDup [1%nat;2%nat;3%nat].
Proof. repeat constructor; simpl; intuition congruence. Qed.
Lemma original_entry_graph : guarded_values 3 1 3 = Some [1%Z;2%Z].
Proof. reflexivity. Qed.
Lemma original_alias_preconditions : 1%nat <> 2%nat /\ 2%nat <> 0%nat.
Proof. split; discriminate. Qed.
Lemma original_exit_graph : guarded_values 3 1 2 = Some [1%Z].
Proof. reflexivity. Qed.
Theorem original_postcondition_refuted : guarded_values 3 1 2 <> Some ([1%Z;2%Z] ++ [3%Z]).
Proof. discriminate. Qed.
