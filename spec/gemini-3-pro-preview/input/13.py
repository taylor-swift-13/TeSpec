import math

def greatest_common_divisor_spec(a, b, result):
    """
    Checks if result is the greatest common divisor of a and b.
    In Coq, Z.gcd always returns a non-negative integer.
    Python's math.gcd also returns a non-negative integer.
    """
    return result == math.gcd(a, b)
