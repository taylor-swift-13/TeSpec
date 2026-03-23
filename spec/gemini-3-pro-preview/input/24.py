def _orig_largest_divisor_spec(n, output):

    def divides(a, b):
        if a == 0:
            return b == 0
        return b % a == 0
    if not divides(output, n):
        return False
    if not output < n:
        return False
    upper_bound = n
    if n > 1:
        upper_bound = n // 2 + 1
    for k in range(output + 1, upper_bound):
        if divides(k, n):
            return False
    return True

def largest_divisor_spec(n, output):
    return bool(_orig_largest_divisor_spec(n, output))
