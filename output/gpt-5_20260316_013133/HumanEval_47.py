
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    if len(l) == 0:
        return False
    try:
        sl = sorted(l)
    except Exception:
        return False
    if len(sl) % 2 == 0:
        a = sl[len(sl) // 2 - 1]
        b = sl[len(sl) // 2]
        try:
            _ = (a + b) / 2
        except Exception:
            return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    l = input[0]
    try:
        sl = sorted(l)
    except Exception:
        return False
    n = len(sl)
    if n == 0:
        return output is None
    import math
    def num_equal(a, b):
        try:
            if isinstance(a, float) and math.isnan(a):
                return isinstance(b, float) and math.isnan(b)
        except Exception:
            pass
        if a == b:
            return True
        try:
            af = float(a)
            bf = float(b)
        except Exception:
            return False
        return math.isclose(af, bf, rel_tol=1e-9, abs_tol=1e-9)
    if n % 2 == 1:
        expected = sl[n // 2]
        return num_equal(output, expected)
    else:
        a = sl[n // 2 - 1]
        b = sl[n // 2]
        try:
            expected = (a + b) / 2
        except Exception:
            return False
        return num_equal(output, expected)

def _impl(l: list):
    """Return median of elements in the list l.
    3
    15.0"""
    sorted_l = sorted(l)
    if len(l) % 2 == 1:
        return sorted_l[len(l) // 2]
    else:
        return (sorted_l[len(l) // 2 - 1] + sorted_l[len(l) // 2]) / 2

def median(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
