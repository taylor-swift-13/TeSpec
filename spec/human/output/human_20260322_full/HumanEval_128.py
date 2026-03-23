def problem_128_pre(arr):
    return True

def problem_128_spec(arr, output):
    if len(arr) == 0:
        return output is None
    
    sum_mags = sum(abs(x) for x in arr)
    
    prod_sgs = 1
    for x in arr:
        if x > 0:
            prod_sgs *= 1
        elif x < 0:
            prod_sgs *= -1
        else:
            prod_sgs *= 0
            
    expected = sum_mags * prod_sgs
    return output == expected

def _impl(arr):
    if arr == []: return None
    if 0 in arr: return 0
    s, sgn = 0, 1
    for x in arr:
        s += abs(x)
        sgn *= (x // abs(x))
    return s * sgn

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_128_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_128_spec(*input, output))

def prod_signs(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
