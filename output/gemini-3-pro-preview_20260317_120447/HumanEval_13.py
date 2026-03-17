
def precondition(args):
    if len(args) != 2:
        return False
    a, b = args
    return isinstance(a, int) and isinstance(b, int)

def postcondition(args, output):
    if not isinstance(output, int) or output < 0:
        return False
    a, b = args
    a_abs, b_abs = abs(a), abs(b)
    
    if a == 0 and b == 0:
        return output == 0
    
    # Check if it is a common divisor
    if output == 0: # GCD is only 0 if both a and b are 0
        return False
    if a % output != 0 or b % output != 0:
        return False
    
    # Check if it is the greatest common divisor
    # Any common divisor must be less than or equal to the output
    limit = max(a_abs, b_abs)
    for i in range(output + 1, limit + 1):
        if a % i == 0 and b % i == 0:
            return False
            
    return True

def _impl(a: int, b: int) -> int:
    """Return a greatest common divisor of two integers a and b
    1
    5"""
    def query_gcd(a: int, b: int) -> int:
        return a if b == 0 else query_gcd(b, a % b)
    return query_gcd(a, b)    

def greatest_common_divisor(a: int, b: int) -> int:
    _input = (a, b)
    assert precondition(_input)
    _output = _impl(a, b)
    assert postcondition(_input, _output)
    return _output
