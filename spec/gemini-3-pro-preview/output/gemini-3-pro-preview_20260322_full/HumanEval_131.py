def digits_spec(n: int, res: int) -> bool:
    if n < 0:
        return False
    if n == 0:
        return res == 0
    
    odds = [int(d) for d in str(n) if int(d) % 2 != 0]
    
    if not odds:
        expected_res = 0
    else:
        expected_res = 1
        for d in odds:
            expected_res *= d
            
    return res == expected_res

def _impl(n):
    has_odd, prod = False, 1
    for ch in str(n):
        if int(ch) % 2 == 1:
            has_odd = True
            prod *= int(ch)
    return 0 if not has_odd else prod

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(digits_spec(*input, output))

def digits(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
