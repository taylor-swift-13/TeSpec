
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 2:
        return False
    n, m = input
    # require integer (but exclude booleans) and non-negative (allow zero)
    if not (isinstance(n, int) and not isinstance(n, bool)):
        return False
    if not (isinstance(m, int) and not isinstance(m, bool)):
        return False
    if n < 0 or m < 0:
        return False
    return True

def postcondition(input, output):
    # If precondition does not hold, we do not check postcondition here.
    if not precondition(input):
        return True
    n, m = input
    # If n > m, function should return integer -1
    if n > m:
        return isinstance(output, int) and output == -1
    # Compute expected rounded average using exact arithmetic with ties to even
    s = n + m
    if s % 2 == 0:
        expected = s // 2
    else:
        k = s // 2  # floor((n+m)/2)
        # For x.5, round to nearest even integer:
        if k % 2 == 0:
            expected = k
        else:
            expected = k + 1
    expected_str = bin(expected)
    return isinstance(output, str) and output == expected_str

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
