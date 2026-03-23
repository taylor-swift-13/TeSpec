import math

def _orig_greatest_common_divisor_spec(a: int, b: int, output: int) -> bool:
    """
    Checks if the given output is the greatest common divisor of a and b.
    In Coq, Z.gcd always returns a non-negative integer.
    In Python, math.gcd also returns a non-negative integer.
    """
    return output == math.gcd(a, b)

def greatest_common_divisor_spec(a, b, output):
    return bool(_orig_greatest_common_divisor_spec(a, b, output))
