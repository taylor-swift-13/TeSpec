import math

def _orig_greatest_common_divisor_spec(a: int, b: int, g: int) -> bool:
    return abs(g) == math.gcd(a, b)

def greatest_common_divisor_spec(a, b, output):
    return bool(_orig_greatest_common_divisor_spec(a, b, output))
