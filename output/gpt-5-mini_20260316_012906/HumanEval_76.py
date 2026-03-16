
import math

def _is_number(x):
    if isinstance(x, bool):
        return False
    return isinstance(x, (int, float))

def precondition(input):
    # input is expected to be a tuple of two positional arguments (x, n)
    if not isinstance(input, tuple):
        return False
    if len(input) != 2:
        return False
    x, n = input
    if not (_is_number(x) and _is_number(n)):
        return False
    # check finite for floats
    if isinstance(x, float) and not math.isfinite(x):
        return False
    if isinstance(n, float) and not math.isfinite(n):
        return False
    return True

def postcondition(input, output):
    # output must be boolean
    if not isinstance(output, bool):
        return False
    # if precondition fails, don't attempt further strict checks
    if not precondition(input):
        return True
    x, n = input
    # helper for numerical closeness
    def close(a, b):
        try:
            return math.isclose(a, b, rel_tol=1e-9, abs_tol=1e-12)
        except Exception:
            return False

    # quick rules for trivial bases
    # handle n == 1: only x == 1 is a power (1**k == 1 for any integer k)
    if n == 1:
        holds = close(x, 1)
        return output == holds

    # n == -1: powers alternate between 1 and -1
    if n == -1:
        holds = close(x, 1) or close(x, -1)
        return output == holds

    # n == 0: python treats 0**0 == 1; for k>=1, 0**k == 0
    if n == 0:
        # Accept python semantics: 0**0 == 1
        holds = close(x, 0) or close(x, 1)
        return output == holds

    # sign compatibility: if n > 0 then n**k >= 0 for k>=0
    # when x is negative and n > 0, impossible
    try:
        # Determine search bounds for exponent k (non-negative integers)
        abs_n = abs(n)
        abs_x = abs(x)
    except Exception:
        return False

    # If x is 0, check whether some k yields 0: only possible when n == 0 (handled) or when n==0 -> done
    # For other n, n**k == 0 has no solution for integer k>=0
    if close(x, 0) and not close(n, 0):
        holds = False
        return output == holds

    # reasonable cap for search
    MAX_K_CAP = 2000

    # compute an adaptive max_k
    max_k = 1000
    try:
        if abs_n > 1 and abs_x >= 1:
            # estimate via logs
            # protect against domain errors
            log_est = math.log(max(abs_x, 1e-300)) / math.log(abs_n)
            est_k = int(math.floor(log_est)) + 5
            max_k = min(MAX_K_CAP, max(0, est_k))
        elif abs_n > 1 and abs_x < 1:
            # n^k grows, only small k (0 or 1) could match a small x
            max_k = 10
        elif 0 < abs_n < 1:
            # fractional base, powers shrink toward 0; search more exponents
            max_k = min(MAX_K_CAP, 200)
        else:
            max_k = min(MAX_K_CAP, 500)
    except Exception:
        max_k = min(MAX_K_CAP, 1000)

    # ensure non-negative range
    max_k = max(0, int(max_k))
    found = False

    # If n is positive and x is negative, impossible for non-negative integer exponent
    if n > 0 and x < 0:
        found = False
    else:
        for k in range(0, max_k + 1):
            try:
                val = n ** k
            except Exception:
                # overflow or other error; stop searching further
                break
            if close(val, x):
                found = True
                break
            # early stopping: if abs_n > 1 and abs(val) > abs_x and abs_x >= 1, further k will only increase magnitude
            if abs_n > 1 and abs_x >= 1:
                try:
                    if abs(val) > abs_x:
                        break
                except Exception:
                    pass

    return output == found

def _impl(x, n):
    """Your task is to write a function that returns true if a number x is a simple
    power of n and false in other cases.
    x is a simple power of n if n**int=x
    For example:
    is_simple_power(1, 4) => true
    is_simple_power(2, 2) => true
    is_simple_power(8, 2) => true
    is_simple_power(3, 2) => false
    is_simple_power(3, 1) => false
    is_simple_power(5, 3) => false"""
    if x == 1: return True
    if n == 0: return x == 0
    if n == 1: return x == 1
    if n == -1: return abs(x) == 1
    p = n
    while abs(p) <= abs(x):
        if p == x: return True
        p = p * n
    return False

def is_simple_power(x, n):
    _input = (x, n)
    assert precondition(_input)
    _output = _impl(x, n)
    assert postcondition(_input, _output)
    return _output
