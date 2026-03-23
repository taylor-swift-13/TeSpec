from fractions import Fraction

def median_spec(l, m):
    n = len(l)
    if n == 0:
        return False
    
    sl = sorted(l)
    mid = n // 2
    
    if n % 2 != 0:
        expected = Fraction(sl[mid])
    else:
        expected = Fraction(sl[mid - 1] + sl[mid], 2)
        
    return m == expected

def _impl(l: list):
    sorted_l = sorted(l)
    if len(l) % 2 == 1:
        return sorted_l[len(l) // 2]
    else:
        return (sorted_l[len(l) // 2 - 1] + sorted_l[len(l) // 2]) / 2

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(median_spec(*input, output))

def median(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
