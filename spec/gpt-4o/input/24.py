def _orig_largest_divisor_spec(n, output):

    def coq_mod(a, b):
        if b == 0:
            return a
        return a % b
    cond1 = output < n and coq_mod(n, output) == 0
    if not cond1:
        return False
    for x in range(n):
        if coq_mod(n, x) == 0:
            if not x <= output:
                return False
    return True

def largest_divisor_spec(n, output):
    return bool(_orig_largest_divisor_spec(n, output))
