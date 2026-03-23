def is_sorted(l):
    """
    Definition is_sorted (l : list R) : Prop :=
      forall i j, (i < j < length l)%nat -> nth i l 0 <= nth j l 0.
    """
    for i in range(len(l) - 1):
        if l[i] > l[i+1]:
            return False
    return True

def median_spec(l, result):
    """
    Definition median_spec (l : list R) (result : R) : Prop :=
      l <> [] /\
      exists sorted_l : list R,
        Permutation l sorted_l /\
        is_sorted sorted_l /\
        length sorted_l = length l /\
        ((Nat.odd (length l) = true /\
          result = nth (length l / 2) sorted_l 0) \/
         (Nat.even (length l) = true /\
          result = (nth (length l / 2 - 1) sorted_l 0 + nth (length l / 2) sorted_l 0) / 2)).
    """
    if not l:
        return False

    sorted_l = sorted(l)
    n = len(l)

    if n % 2 != 0:
        # Odd case: result is the middle element
        expected = sorted_l[n // 2]
        return result == expected
    else:
        # Even case: result is the average of the two middle elements
        val1 = sorted_l[n // 2 - 1]
        val2 = sorted_l[n // 2]
        expected = (val1 + val2) / 2.0
        return result == expected
