
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    n, m = input
    return isinstance(n, int) and isinstance(m, int) and n >= 1 and m >= 1

def postcondition(input, output):
    if not (isinstance(input, tuple) and len(input) == 2):
        return False
    n, m = input
    if not (isinstance(n, int) and isinstance(m, int)):
        return False
    if n > m:
        return output == -1
    s = n + m
    if s % 2 == 0:
        r = s // 2
    else:
        k = s // 2
        r = k if (k % 2 == 0) else (k + 1)
    return isinstance(output, str) and output == bin(r)

def _impl(n, m):
    """You are given two positive integers n and m, and your task is to compute the
    average of the integers from n through m (including n and m). 
    Round the answer to the nearest integer and convert that to binary.
    If n is greater than m, return -1.
    Example:
    rounded_avg(1, 5) => "0b11"
    rounded_avg(7, 5) => -1
    rounded_avg(10, 20) => "0b1111"
    rounded_avg(20, 33) => "0b11010"
    """
    if n > m: return -1
    avg = round((n + m) / 2)
    return bin(avg)

def rounded_avg(n, m):
    _input = (n, m)
    assert precondition(_input)
    _output = _impl(n, m)
    assert postcondition(_input, _output)
    return _output
