def is_sorted(l):
    return all(l[i] <= l[i+1] for i in range(len(l) - 1))

def median_spec(l, result):
    if len(l) == 0:
        return False
    
    sorted_l = sorted(l)
    n = len(sorted_l)
    
    if n % 2 == 1:
        expected = sorted_l[n // 2]
    else:
        expected = (sorted_l[n // 2 - 1] + sorted_l[n // 2]) / 2.0
        
    return result == expected

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
