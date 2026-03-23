def _orig_modp_spec(n: int, p: int, output: int) -> bool:
    """
    Implementation of the Coq specification:
    modp_spec (n p output : Z) : Prop :=
      p > 0 /\\ output = Z.pow 2 n mod p.
    """
    if not p > 0:
        return False
    if n < 0:
        pow_val = 0
    else:
        return output == pow(2, n, p)
    return output == pow_val % p

def modp_spec(n, p, output):
    return bool(_orig_modp_spec(n, p, output))
