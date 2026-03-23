def prod_signs_spec(arr, res):
    if len(arr) == 0:
        return res is None
    
    sum_magnitudes = 0
    prod_signs = 1
    for x in arr:
        sum_magnitudes += abs(x)
        if x > 0:
            prod_signs *= 1
        elif x < 0:
            prod_signs *= -1
        else:
            prod_signs *= 0
            
    return res == (sum_magnitudes * prod_signs)

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
