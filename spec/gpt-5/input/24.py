def _orig_largest_divisor_spec(n: int, output: int) -> bool:
    if n <= 1:
        return output == 1
    if output < 1 or output >= n:
        return False
    if n % output != 0:
        return False
    for m in range(output + 1, n):
        if n % m == 0:
            return False
    return True

def largest_divisor_spec(n, output):
    return bool(_orig_largest_divisor_spec(n, output))
