def modp_spec(n: int, p: int, res: int) -> bool:
    """
    Implementation of the Coq specification:
    modp_spec (n p res : Z) : Prop :=
      p > 0 /\ res = Z.pow 2 n mod p.
    """
    # Condition: p > 0
    if not (p > 0):
        return False
    
    # Coq's Z.pow a b behavior:
    # If b > 0, it is a^b.
    # If b = 0, it is 1.
    # If b < 0, it is 0.
    if n < 0:
        pow_val = 0
    else:
        # For n >= 0, Z.pow 2 n is 2**n
        # We use Python's pow(base, exp, mod) for efficiency with large integers
        # which calculates (base**exp) % mod.
        return res == pow(2, n, p)
    
    # If n < 0, pow_val is 0, so we check if res == 0 % p
    return res == (pow_val % p)
