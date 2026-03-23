def modp_spec(n: int, p: int, result: int) -> bool:
    if n < 0:
        # In Coq, 2^n = 0 for n < 0. 0 mod p = 0 for any p.
        val = 0
    elif p == 0:
        # In Coq's ZArith, a mod 0 = a.
        val = 2 ** n
    elif p > 0:
        # Standard modular exponentiation for positive modulus.
        val = pow(2, n, p)
    else:
        # For p < 0, Coq's Z.modulo result r satisfies p < r <= 0.
        # Python's pow(2, n, abs(p)) gives a remainder r' in [0, abs(p)).
        # We adjust r' to the range (p, 0] to match Coq's floored division remainder.
        r_abs = pow(2, n, abs(p))
        val = r_abs + p if r_abs != 0 else 0
    return result == val
