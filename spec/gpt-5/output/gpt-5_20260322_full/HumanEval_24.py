import math

def largest_divisor_spec(n: int, res: int) -> bool:
    if n <= 1:
        return res == 1
    
    if res < 1 or res >= n:
        return False
    if n % res != 0:
        return False
        
    smallest_factor = n
    for i in range(2, math.isqrt(n) + 1):
        if n % i == 0:
            smallest_factor = i
            break
            
    expected_res = n // smallest_factor if smallest_factor != n else 1
    return res == expected_res

def _impl(n: int) -> int:
    for i in range(2, n):
        if n % i == 0: return n // i
    return 1

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(largest_divisor_spec(*input, output))

def largest_divisor(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
