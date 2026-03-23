import math

def greatest_common_divisor_spec(a: int, b: int, g: int) -> bool:
    return abs(g) == math.gcd(a, b)
