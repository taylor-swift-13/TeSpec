
def precondition(input):
    if len(input) != 2:
        return False
    n, m = input
    # Both n and m should be positive integers
    if not isinstance(n, int) or not isinstance(m, int):
        return False
    if isinstance(n, bool) or isinstance(m, bool):
        return False
    if n <= 0 or m <= 0:
        return False
    return True

def postcondition(input, output):
    n, m = input
    
    # If n > m, output should be -1
    if n > m:
        return output == -1
    
    # Otherwise, output should be a binary string
    if not isinstance(output, str):
        return False
    
    # Output should start with "0b"
    if not output.startswith("0b"):
        return False
    
    # The rest should be valid binary digits
    binary_part = output[2:]
    if len(binary_part) == 0:
        return False
    if not all(c in '01' for c in binary_part):
        return False
    
    # Compute expected result
    total = sum(range(n, m + 1))
    count = m - n + 1
    avg = total / count
    rounded_avg = round(avg)
    expected = bin(rounded_avg)
    
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
