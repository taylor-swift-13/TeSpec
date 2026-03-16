
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 2:
        return False
    n, m = input
    return isinstance(n, int) and isinstance(m, int)

def postcondition(input, output):
    if not precondition(input):
        return False
    n, m = input
    if n > m:
        return output == -1
    s = n + m
    if s % 2 == 0:
        rounded = s // 2
    else:
        k = s // 2
        # tie-to-even rounding for .5 cases
        if k % 2 == 0:
            rounded = k
        else:
            rounded = k + 1
    expected = bin(rounded)
    return output == expected

def _impl(n, m):
    """You are given two positive integers n and m, and your task is to compute the
    average of the integers from n through m (including n and m). 
    Round the answer to the nearest integer and convert that to binary.
    If n is greater than m, return -1.
    Example:
    rounded_avg(1, 5) => "0b11"
    rounded_avg(7, 5) => -1
    rounded_avg(10, 20) => "0b1111"
    rounded_avg(20, 33) => "0b11010""""
    if n > m: return -1
    avg = round((n + m) / 2)
    return bin(avg)

def rounded_avg(n, m):
    _input = (n, m)
    assert precondition(_input)
    _output = _impl(n, m)
    assert postcondition(_input, _output)
    return _output
