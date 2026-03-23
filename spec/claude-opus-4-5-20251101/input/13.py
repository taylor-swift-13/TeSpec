import math

def greatest_common_divisor_spec(a: int, b: int, result: int) -> bool:
    """
    Checks if the given result is the greatest common divisor of a and b.
    In Coq, Z.gcd always returns a non-negative integer.
    In Python, math.gcd also returns a non-negative integer.
    """
    return result == math.gcd(a, b)
