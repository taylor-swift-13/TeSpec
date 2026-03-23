def _orig_make_a_pile_spec(n, output):
    """
    Definition make_a_pile_spec (n : nat) (output : list nat) : Prop :=
      n > 0 /      length output = n /      (forall i, i < n -> nth i output 0 = n + 2 * i).
    """
    if not (isinstance(n, int) and n > 0):
        return False
    if not (isinstance(output, list) and len(output) == n):
        return False
    for i in range(n):
        if output[i] != n + 2 * i:
            return False
    return True

def make_a_pile_spec(n, output):
    return bool(_orig_make_a_pile_spec(n, output))
