def make_a_pile_spec(n, pile):
    if len(pile) != n:
        return False
    for i in range(n):
        if pile[i] != n + 2 * i:
            return False
    return True
