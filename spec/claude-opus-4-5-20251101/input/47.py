def is_sorted(l):
    """
    Definition is_sorted (l : list R) : Prop :=
      forall i j, (i < j < length l)%nat -> nth i l 0 <= nth j l 0.
    """
    for i in range(len(l) - 1):
        if l[i] > l[i+1]:
            return False
    return True

def _orig_median_spec(l, output):
    """
    Definition median_spec (l : list R) (output : R) : Prop :=
      l <> [] /      exists sorted_l : list R,
        Permutation l sorted_l /        is_sorted sorted_l /        length sorted_l = length l /        ((Nat.odd (length l) = true /          output = nth (length l / 2) sorted_l 0) \\/
         (Nat.even (length l) = true /          output = (nth (length l / 2 - 1) sorted_l 0 + nth (length l / 2) sorted_l 0) / 2)).
    """
    if not l:
        return False
    sorted_l = sorted(l)
    n = len(l)
    if n % 2 != 0:
        expected = sorted_l[n // 2]
        return output == expected
    else:
        val1 = sorted_l[n // 2 - 1]
        val2 = sorted_l[n // 2]
        expected = (val1 + val2) / 2.0
        return output == expected

def median_spec(l, output):
    return bool(_orig_median_spec(l, output))
