
def precondition(input):
    n, m = input
    return isinstance(n, int) and isinstance(m, int) and n > 0 and m > 0

def postcondition(input, output):
    n, m = input
    if n > m:
        return output == -1
    
    avg = (n + m) / 2
    expected_val = int(round(avg))
    expected_bin = bin(expected_val)
    
    return output == expected_bin

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
