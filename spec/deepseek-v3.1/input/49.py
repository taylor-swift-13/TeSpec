def _orig_modp_spec(n, p, output):
    """
    Implements the Coq specification:
    Definition modp_spec (n : Z) (p : Z) (output : Z) : Prop :=
      p > 1 -> output = (2 ^ n) mod p.
    """
    if p > 1:
        if n < 0:
            expected = 0
        else:
            expected = pow(2, n, p)
        return output == expected
    else:
        return True

def modp_spec(n, p, output):
    return bool(_orig_modp_spec(n, p, output))
