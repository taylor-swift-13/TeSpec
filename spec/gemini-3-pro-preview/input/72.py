def sum_list(l):
    """
    Definition sum_list (l : list Z) : Z :=
      fold_right Z.add 0 l.
    """
    return sum(l)

def _orig_will_it_fly_spec(q, w, output):
    """
    Definition will_it_fly_spec (q : list Z) (w : Z) (output : bool) : Prop :=
      output = true <-> (q = rev q /\\ sum_list q <= w).
    """
    is_palindrome = q == q[::-1]
    is_light_enough = sum_list(q) <= w
    return output == (is_palindrome and is_light_enough)

def will_it_fly_spec(q, w, output):
    return bool(_orig_will_it_fly_spec(q, w, output))
