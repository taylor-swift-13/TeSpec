
def precondition(input_args):
    if not isinstance(input_args, tuple) or len(input_args) != 2:
        return False
    x, n = input_args
    return isinstance(x, int) and isinstance(n, int)

def postcondition(input_args, output):
    if not isinstance(output, bool):
        return False
    x, n = input_args
    
    if x == 1:
        # n**0 is 1 for any n (including 0 in Python)
        expected = True
    elif n == 1:
        # 1**k is always 1. Since x != 1 here, it's False.
        expected = False
    elif n == 0:
        # 0**0 is 1, 0**k (k>0) is 0.
        expected = (x == 0)
    elif n == -1:
        # (-1)**k is 1 or -1.
        expected = (x == -1)
    else:
        # For |n| > 1, we check if x is a power n**k for k >= 0
        found = False
        if x != 0:
            # Check if x and n have compatible signs for powers
            # or just iterate since we are in a postcondition.
            val = 1
            # Limit iterations to prevent infinite loops if logic is wrong, 
            # but mathematically |n**k| grows.
            for k in range(1000):
                if val == x:
                    found = True
                    break
                val *= n
                if abs(val) > abs(x) and abs(n) > 1:
                    break
                if val == 0: # Should not happen given n != 0
                    break
        expected = found

    return output == expected

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
