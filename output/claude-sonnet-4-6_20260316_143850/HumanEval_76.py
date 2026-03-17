
def precondition(args):
    if len(args) != 2:
        return False
    x, n = args
    if not isinstance(x, (int, float)) or not isinstance(n, (int, float)):
        return False
    if x != int(x) or n != int(n):
        return False
    x, n = int(x), int(n)
    if x < 1:
        return False
    if n < 1:
        return False
    return True


def postcondition(args, output):
    if not isinstance(output, bool):
        return False
    x, n = int(args[0]), int(args[1])
    # Verify the result makes logical sense
    if n == 1:
        # 1**k = 1, so only x==1 should be true
        if x == 1:
            return output == True
        else:
            return output == False
    if x == 1:
        # n**0 = 1 for any n, so should be true
        return output == True
    # For n > 1 and x > 1, check if x is a power of n
    import math
    log_val = math.log(x) / math.log(n)
    rounded = round(log_val)
    is_power = abs(n ** rounded - x) < 0.5
    return output == is_power

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
