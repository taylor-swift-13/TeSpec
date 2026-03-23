def sum_odd_in_even_pos_aux(l, idx):
    """
    Fixpoint sum_odd_in_even_pos_aux (l : list nat) (idx : nat) : nat :=
      match l with
      | [] => 0
      | h::t => (if (Nat.even idx) && negb (Nat.even h) then h else 0) + sum_odd_in_even_pos_aux t (S idx)
      end.
    """
    # Iterative implementation to ensure execution on concrete inputs without recursion depth issues
    result = 0
    current_idx = idx
    for h in l:
        # (Nat.even idx) && negb (Nat.even h)
        if (current_idx % 2 == 0) and (h % 2 != 0):
            result += h
        current_idx += 1
    return result

def sum_odd_in_even_pos_impl(l):
    """
    Definition sum_odd_in_even_pos_impl (l : list nat) : nat := sum_odd_in_even_pos_aux l 0.
    """
    return sum_odd_in_even_pos_aux(l, 0)

def problem_121_pre(l):
    """
    Definition problem_121_pre (l : list nat) : Prop := l <> [].
    """
    return l != []

def problem_121_spec(l, output):
    """
    Definition problem_121_spec (l : list nat) (output : nat) : Prop :=
      output = sum_odd_in_even_pos_impl l.
    """
    return output == sum_odd_in_even_pos_impl(l)
