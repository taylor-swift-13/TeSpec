def is_simple_power_spec(x, n, result):
    """
    Implements the specification:
    result = true <-> exists (k : Z), (0 <= k)%Z /\ (n ^ k = x)%Z
    
    Returns True if 'result' correctly indicates whether 'x' is a non-negative power of 'n'.
    """
    # Determine if there exists an integer k >= 0 such that n^k = x
    is_power = False
    
    if x == 1:
        # n^0 = 1 for any integer n
        is_power = True
    elif n == 0:
        # Powers of 0 are 1 (k=0) and 0 (k>=1).
        # x=1 is handled above.
        is_power = (x == 0)
    elif n == 1:
        # Powers of 1 are always 1.
        # x=1 is handled above.
        is_power = False
    elif n == -1:
        # Powers of -1 are 1 (even k) and -1 (odd k).
        # x=1 is handled above.
        is_power = (x == -1)
    elif x == 0:
        # If |n| >= 2, n^k is never 0.
        is_power = False
    else:
        # General case: |n| >= 2 and x != 1 and x != 0.
        # We generate powers p = n^1, n^2, ... until |p| >= |x|.
        p = n
        abs_x = abs(x)
        abs_p = abs(p)
        
        while abs_p < abs_x:
            p *= n
            abs_p = abs(p)
            
        is_power = (p == x)

    return result == is_power

def _impl(x, n):
    if x == 1: return True
    if n == 0: return x == 0
    if n == 1: return x == 1
    if n == -1: return abs(x) == 1
    p = n
    while abs(p) <= abs(x):
        if p == x: return True
        p = p * n
    return False

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(is_simple_power_spec(*input, output))

def is_simple_power(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
