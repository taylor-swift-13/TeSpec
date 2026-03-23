import math

def _orig_greatest_common_divisor_spec(a, b, output):
    """
    Checks if output is the greatest common divisor of a and b.
    In Coq, Z.gcd always returns a non-negative integer.
    Python's math.gcd also returns a non-negative integer.
    """
    return output == math.gcd(a, b)

def greatest_common_divisor_spec(a, b, output):
    return bool(_orig_greatest_common_divisor_spec(a, b, output))
