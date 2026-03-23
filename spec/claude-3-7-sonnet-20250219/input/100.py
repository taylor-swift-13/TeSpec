def make_a_pile_spec(n, res):
    """
    Definition make_a_pile_spec (n : nat) (res : list nat) : Prop :=
      n > 0 /\
      length res = n /\
      (forall i, i < n -> nth i res 0 = n + 2 * i).
    """
    # n > 0
    if not (isinstance(n, int) and n > 0):
        return False
    
    # length res = n
    if not (isinstance(res, list) and len(res) == n):
        return False
    
    # forall i, i < n -> nth i res 0 = n + 2 * i
    # Since len(res) == n, for all i < n, nth i res 0 is simply res[i].
    for i in range(n):
        if res[i] != n + 2 * i:
            return False
            
    return True
