def sign(x):
    if x < 0:
        return -1
    elif x > 0:
        return 1
    else:
        return 0

def abs(x):
    if x < 0:
        return -x
    else:
        return x

def sum_magnitudes(arr):
    res = 0
    for x in arr:
        res += abs(x)
    return res

def product_signs(arr):
    res = 1
    for x in arr:
        res *= sign(x)
    return res

def contains_zero(arr):
    for x in arr:
        if x == 0:
            return True
    return False

def prod_signs_spec(arr, result):
    if len(arr) == 0:
        return result is None
    else:
        if contains_zero(arr):
            return result == 0
        else:
            return result == (sum_magnitudes(arr) * product_signs(arr))

def _impl(arr):
    if arr == []: return None
    if 0 in arr: return 0
    s, sgn = 0, 1
    for x in arr:
        s += abs(x)
        sgn *= (x // abs(x))
    return s * sgn

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(prod_signs_spec(*input, output))

def prod_signs(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
