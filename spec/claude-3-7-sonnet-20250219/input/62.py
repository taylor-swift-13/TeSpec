def derivative_spec(xs, ds):
    def nth(n, l, default):
        if 0 <= n < len(l):
            return l[n]
        return default

    # length ds = pred (length xs)
    # pred 0 = 0, pred (S n) = n
    if len(ds) != max(0, len(xs) - 1):
        return False

    # forall i : nat, 1 <= i < length xs -> nth i ds 0 = nth i xs 0 * i
    for i in range(1, len(xs)):
        if nth(i, ds, 0) != nth(i, xs, 0) * i:
            return False

    return True
