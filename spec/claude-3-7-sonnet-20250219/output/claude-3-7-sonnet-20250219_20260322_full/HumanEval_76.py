def is_simple_power_spec(x: int, n: int, b: bool) -> bool:
    """
    Python implementation of the Coq definition is_simple_power_spec.
    Returns True if b matches the condition specified in the Coq code.
    """
    
    # The condition is:
    # (x = 1) \/ 
    # (n = 0 /\ x = 0) \/ 
    # (n = 1 /\ x = 1) \/ 
    # (n = -1 /\ (x = 1 \/ x = -1)) \/
    # exists k : Z, (0 <= k) /\ (abs(n^k) <= abs(x)) /\ (n^k = x)

    condition = False

    # Check the explicit disjunctions first
    if x == 1:
        condition = True
    elif n == 0 and x == 0:
        condition = True
    elif n == 1 and x == 1:
        condition = True
    elif n == -1 and (x == 1 or x == -1):
        condition = True
    else:
        # Check the existential part: exists k >= 0 s.t. n^k = x
        # Note: if n^k = x, then abs(n^k) <= abs(x) is trivially satisfied.
        
        if n == 0:
            # 0^0 = 1 (in Coq Z.pow), 0^k = 0 for k > 0
            if x == 1 or x == 0:
                condition = True
        elif n == 1:
            # 1^k = 1 for all k >= 0
            if x == 1:
                condition = True
        elif n == -1:
            # (-1)^k is 1 or -1
            if x == 1 or x == -1:
                condition = True
        else:
            # Case |n| > 1 or n < -1
            # We search for k >= 0 such that n^k == x.
            # Since |n| > 1, |n^k| grows, so we only need to check until |n^k| > |x|.
            # If x is 0, and |n| > 1, n^k is never 0.
            if x != 0:
                k = 0
                while True:
                    try:
                        val = n ** k
                    except OverflowError:
                        # If numbers get too large for Python's power, 
                        # they certainly exceed abs(x)
                        break
                    
                    if val == x:
                        condition = True
                        break
                    
                    # If |n^k| exceeds |x|, no further k will satisfy n^k = x
                    if abs(val) > abs(x):
                        break
                    k += 1

    return b == condition

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
