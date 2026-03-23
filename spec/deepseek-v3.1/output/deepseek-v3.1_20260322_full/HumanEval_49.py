def modp_spec(n, p, result):
    """
    Implements the Coq specification:
    Definition modp_spec (n : Z) (p : Z) (result : Z) : Prop :=
      p > 1 -> result = (2 ^ n) mod p.
    """
    # The Coq spec is an implication: p > 1 -> result = (2 ^ n) mod p.
    # In logic, A -> B is equivalent to (not A) or B.
    if p > 1:
        # In Coq's ZArith, Z.pow a b is defined as:
        # - 1 if b = 0
        # - a^b if b > 0
        # - 0 if b < 0
        if n < 0:
            # (2 ^ n) where n < 0 is 0 in Coq.
            # 0 mod p where p > 1 is 0.
            expected = 0
        else:
            # (2 ^ n) mod p for n >= 0 and p > 1.
            # Python's pow(base, exp, mod) is an efficient way to calculate (base**exp) % mod.
            expected = pow(2, n, p)
        
        return result == expected
    else:
        # If p <= 1, the condition (p > 1) is false, making the implication vacuously true.
        return True

def _impl(n: int, p: int):
    res, x = 1, 2
    while n != 0:
        if n % 2 == 1:
            res = res * x % p
        x = x * x % p
        n //= 2
    return res % p

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(modp_spec(*input, output))

def modp(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
