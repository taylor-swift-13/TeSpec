def largest_divisor_spec(n, result):
    def coq_mod(a, b):
        if b == 0:
            return a
        return a % b

    cond1 = (result < n) and (coq_mod(n, result) == 0)
    if not cond1:
        return False

    for x in range(n):
        if coq_mod(n, x) == 0:
            if not (x <= result):
                return False

    return True
