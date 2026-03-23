import math

def _orig_gcd_spec(a: int, b: int, output: int) -> bool:
    return output == math.gcd(a, b)

def gcd_spec(a, b, output):
    return bool(_orig_gcd_spec(a, b, output))
