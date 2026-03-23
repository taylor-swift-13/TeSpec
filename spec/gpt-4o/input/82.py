import math

def is_prime_spec(a: int, output: bool) -> bool:
    if a < 0:
        a = 0

    lt_2 = (a < 2)
    sqrt_a = math.isqrt(a)
    seq_len = sqrt_a - 1 if sqrt_a >= 1 else 0

    exists_divisible = False
    for x in range(2, 2 + seq_len):
        if a % x == 0:
            exists_divisible = True
            break

    expected = not (lt_2 or exists_divisible)
    return output == expected

def _orig_prime_length_spec(string: list, output: bool) -> bool:
    return is_prime_spec(len(string), output)

def prime_length_spec(string, output):
    return bool(_orig_prime_length_spec(string, output))
